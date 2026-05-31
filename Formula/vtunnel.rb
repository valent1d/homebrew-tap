class Vtunnel < Formula
  desc "Pleasant local tunnels powered by Cloudflare Tunnel"
  homepage "https://github.com/valent1d/vtunnel"
  version "0.1.0-beta.10"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/valent1d/vtunnel/releases/download/v0.1.0-beta.10/vtunnel_v0.1.0-beta.10_darwin_arm64.tar.gz"
      sha256 "f80d26208bc993cb4df51d238803c5af37b761170fcc823568ed202d9f216fe9"
    else
      url "https://github.com/valent1d/vtunnel/releases/download/v0.1.0-beta.10/vtunnel_v0.1.0-beta.10_darwin_amd64.tar.gz"
      sha256 "16502b381ad9580c2c792723a975e595573369e691ef87c36758184e9f7cabd6"
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
