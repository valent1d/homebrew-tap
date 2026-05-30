class Vtunnel < Formula
  desc "Pleasant local tunnels powered by Cloudflare Tunnel"
  homepage "https://github.com/valent1d/vtunnel"
  version "0.1.0-beta.7"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/valent1d/vtunnel/releases/download/v0.1.0-beta.7/vtunnel_v0.1.0-beta.7_darwin_arm64.tar.gz"
      sha256 "b3c8b3d342e29f4501bbb77564143781820368a7fecdb828bb3620004b4dafed"
    else
      url "https://github.com/valent1d/vtunnel/releases/download/v0.1.0-beta.7/vtunnel_v0.1.0-beta.7_darwin_amd64.tar.gz"
      sha256 "652934aacc27f6550ef67ecdddca87ab6cc1027668e2b9f01d1d71e02ff2af42"
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
