class Vtunnel < Formula
  desc "Pleasant local tunnels powered by Cloudflare Tunnel"
  homepage "https://github.com/valent1d/vtunnel"
  version "0.1.0-beta.6"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/valent1d/vtunnel/releases/download/v0.1.0-beta.6/vtunnel_v0.1.0-beta.6_darwin_arm64.tar.gz"
      sha256 "171fc24976de71e3fa35da7a99c56e6b09f04966bf4b899e1fcfdb2e5858b69b"
    else
      url "https://github.com/valent1d/vtunnel/releases/download/v0.1.0-beta.6/vtunnel_v0.1.0-beta.6_darwin_amd64.tar.gz"
      sha256 "05a56e4fcc2f1f635ab1fe107edc162e535123dabb966358b6a34f948f65cad8"
    end
  end

  depends_on "cloudflared"

  def install
    bin.install "vtunnel"
  end

  def caveats
    config_dir = ENV["XDG_CONFIG_HOME"] || File.expand_path("~/.config")
    config_file = File.join(config_dir, "vtunnel", "config.yml")
    # Only nudge users who have not finished onboarding yet, so the hint shows
    # on a fresh install but stays out of the way on every later upgrade.
    return if File.exist?(config_file)

    <<~EOS

      ────────────────────────────────────────────────
        vtunnel is installed — one step left!

        Run the guided setup:

            vtunnel onboarding
      ────────────────────────────────────────────────
    EOS
  end

  test do
    assert_match "vtunnel", shell_output("#{bin}/vtunnel --version")
  end
end
