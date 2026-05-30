class Vtunnel < Formula
  desc "Pleasant local tunnels powered by Cloudflare Tunnel"
  homepage "https://github.com/valent1d/vtunnel"
  version "0.1.0-beta.2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/valent1d/vtunnel/releases/download/v0.1.0-beta.2/vtunnel_v0.1.0-beta.2_darwin_arm64.tar.gz"
      sha256 "37326a1f23f954154cfb3b221d033f7d04a20276da6c018d2b7088ba238fcf9f"
    else
      url "https://github.com/valent1d/vtunnel/releases/download/v0.1.0-beta.2/vtunnel_v0.1.0-beta.2_darwin_amd64.tar.gz"
      sha256 "08363b9c33edc8bca1b9e4211a3c3c65b1569fa4a051545f7dfa952ccaf40fc1"
    end
  end

  depends_on "cloudflared"

  def install
    bin.install "vtunnel"
  end

  def caveats
    <<~EOS
      To start using vtunnel, run:
        vtunnel onboarding
    EOS
  end

  test do
    assert_match "vtunnel", shell_output("#{bin}/vtunnel --version")
  end
end
