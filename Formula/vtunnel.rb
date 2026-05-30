class Vtunnel < Formula
  desc "Pleasant local tunnels powered by Cloudflare Tunnel"
  homepage "https://github.com/valent1d/vtunnel"
  version "0.1.0-beta.4"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/valent1d/vtunnel/releases/download/v0.1.0-beta.4/vtunnel_v0.1.0-beta.4_darwin_arm64.tar.gz"
      sha256 "8efdbc1a2a016e3609289b3a219c1cacb32618600956496618e15520dc411e2a"
    else
      url "https://github.com/valent1d/vtunnel/releases/download/v0.1.0-beta.4/vtunnel_v0.1.0-beta.4_darwin_amd64.tar.gz"
      sha256 "4dbeb710a946e8c974bb47e91beaa212092ecbd19c7e7a329f2107cd8af29654"
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
