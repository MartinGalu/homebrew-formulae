class Gyabai < Formula
  desc ""
  homepage ""
  url "https://github.com/MartinGalu/yabai/releases/download/v1.0.0/gyabai.tar.gz"
  sha256 "c786361dde770f103c73d99803a55d062cdd65089d7bad81ee6b957e18556e9d"
  license ""

  depends_on :macos => :high_sierra

  def clear_env
    ENV.delete("CFLAGS")
    ENV.delete("LDFLAGS")
    ENV.delete("CXXFLAGS")
  end

  def install
    clear_env
    (var/"log/yabai").mkpath

    system "make", "-j1", "install"
    system "codesign", "--force", "-s", "-", "#{buildpath}/bin/yabai"

    bin.install "#{buildpath}/bin/yabai"
  end

  service do
    run "#{opt_bin}/yabai"
    environment_variables PATH: std_service_path_env
    keep_alive true
    process_type :interactive
  end

  test do
    echo "Hi\n"
  end
end
