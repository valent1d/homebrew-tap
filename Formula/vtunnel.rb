class Vtunnel < Formula
  desc "Pleasant local tunnels powered by Cloudflare Tunnel"
  homepage "https://github.com/valent1d/vtunnel"
  version "0.1.0-beta.3"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/valent1d/vtunnel/releases/download/v0.1.0-beta.3/vtunnel_v0.1.0-beta.3_darwin_arm64.tar.gz"
      sha256 "4c9e75a3ca565327e1a387b46683b0a01e2291cda9c6d8c2a697c6514d76e3f1"
    else
      url "https://github.com/valent1d/vtunnel/releases/download/v0.1.0-beta.3/vtunnel_v0.1.0-beta.3_darwin_amd64.tar.gz"
      sha256 "8ce87628430bcc16324688ed6dbea7714b3496b1f0c833eb95fef8189366b3cd"
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
