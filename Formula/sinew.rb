class Sinew < Formula
  desc "macOS menu bar replacement with notch-aware layouts and hot-reload config"
  homepage "https://github.com/dungle-scrubs/sinew"
  url "https://github.com/dungle-scrubs/sinew/archive/refs/tags/sinew-v0.6.2.tar.gz"
  sha256 "605129441f3cc9c037f3bbd48f131829badbefb947a94a0257f26fa347276199"
  license "MIT"

  bottle do
    root_url "https://github.com/dungle-scrubs/homebrew-sinew/releases/download/sinew-v0.6.2"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "96be734b6fa7ae56489d17b51dda4f9542fe44e7a001248f989dd879d5480bd4"
  end

  depends_on :macos
  depends_on "rust" => :build

  def install
    system "cargo", "build", "--release"
    bin.install "target/release/sinew"
    bin.install "target/release/sinew-msg" if File.exist?("target/release/sinew-msg")
  end

  service do
    run [opt_bin/"sinew"]
    keep_alive true
    log_path var/"log/sinew.log"
    error_log_path var/"log/sinew.err"
    environment_variables RUST_LOG: "info"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/sinew --version")
  end
end
