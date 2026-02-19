class Sinew < Formula
  desc "macOS menu bar replacement with notch-aware layouts and hot-reload config"
  homepage "https://github.com/dungle-scrubs/sinew"
  url "https://github.com/dungle-scrubs/sinew/archive/refs/tags/v0.3.1.tar.gz"
  sha256 "e604bbaee924105a16c949fd2bbd46ece233c9f5a009cf41f86610ff488d83d7"
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
