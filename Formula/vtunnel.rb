class Vtunnel < Formula
  desc "Pleasant local tunnels powered by Cloudflare Tunnel"
  homepage "https://github.com/valent1d/vtunnel"
  version "0.1.0-beta.9"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/valent1d/vtunnel/releases/download/v0.1.0-beta.9/vtunnel_v0.1.0-beta.9_darwin_arm64.tar.gz"
      sha256 "d69d8c31ca93c3818772fd0d4a4706cf229cf007637b60eded64ce588b502ba3"
    else
      url "https://github.com/valent1d/vtunnel/releases/download/v0.1.0-beta.9/vtunnel_v0.1.0-beta.9_darwin_amd64.tar.gz"
      sha256 "5c457eecc388ee882864040c915cb9334e2ff64dc530e1c88c810d976cf06f45"
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
