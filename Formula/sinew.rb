class Sinew < Formula
  desc "macOS menu bar replacement with notch-aware layouts and hot-reload config"
  homepage "https://github.com/dungle-scrubs/sinew"
  url "https://github.com/dungle-scrubs/sinew/archive/refs/tags/sinew-v0.6.9.tar.gz"
  sha256 "c9d19db1d653ed1ca2735d16a19abb4b4ebac76c3c847ba91454aaf32995a4e8"
  license "MIT"


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
