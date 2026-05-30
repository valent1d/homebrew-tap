class Vtunnel < Formula
  desc "Pleasant local tunnels powered by Cloudflare Tunnel"
  homepage "https://github.com/valent1d/vtunnel"
  version "0.1.0-beta.5"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/valent1d/vtunnel/releases/download/v0.1.0-beta.5/vtunnel_v0.1.0-beta.5_darwin_arm64.tar.gz"
      sha256 "c94af9ca6376e289f64a74fc44cff9e7cae52627cd4ed9524fda26ca7b97b8dd"
    else
      url "https://github.com/valent1d/vtunnel/releases/download/v0.1.0-beta.5/vtunnel_v0.1.0-beta.5_darwin_amd64.tar.gz"
      sha256 "5d682cb703cf9f19fd07fa7cb2feafa4f4729773449ff01688201ba137e2bbc9"
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
