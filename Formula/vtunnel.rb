class Vtunnel < Formula
  desc "Pleasant local tunnels powered by Cloudflare Tunnel"
  homepage "https://github.com/valent1d/vtunnel"
  version "0.1.0-beta.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/valent1d/vtunnel/releases/download/v0.1.0-beta.11/vtunnel_v0.1.0-beta.11_darwin_arm64.tar.gz"
      sha256 "7d74b75d5bf936af58f3ffd955829e2e2f89c3c0c5b37c5c353655c3121200f0"
    else
      url "https://github.com/valent1d/vtunnel/releases/download/v0.1.0-beta.11/vtunnel_v0.1.0-beta.11_darwin_amd64.tar.gz"
      sha256 "cb344f83ccf91b525c5677fb10790e3a5df449df30f2b57a104523e329808430"
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
