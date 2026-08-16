class Rootbroker < Formula
  desc "Human-approved root command broker for local AI agents"
  homepage "https://github.com/Chang-LL/rootbroker"
  version "0.1.0-alpha.1"
  license "MIT"

  depends_on :linux

  on_intel do
    url "https://github.com/Chang-LL/rootbroker/releases/download/v0.1.0-alpha.1/rootbroker_v0.1.0-alpha.1_linux_amd64.tar.gz"
    sha256 "302138aa0cd846f97782a4f747d904f1bdc742ce7d5a1a9898ca97a6d0f727a7"
  end

  on_arm do
    url "https://github.com/Chang-LL/rootbroker/releases/download/v0.1.0-alpha.1/rootbroker_v0.1.0-alpha.1_linux_arm64.tar.gz"
    sha256 "307de40016846b8328d5285fb0b58e9958458a53f99705fde31adb022d865a99"
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"rootbroker"
    (bin/"rootbroker-admin").write <<~SH
      #!/bin/sh
      exec "#{libexec}/rootbroker" rootbroker-admin "$@"
    SH
    (bin/"rootbroker-admin").chmod 0755
    (bin/"rootbroker-setup").write <<~SH
      #!/bin/sh
      exec "#{libexec}/install.sh" --rootbroker-bin "#{libexec}/rootbroker" "$@"
    SH
    (bin/"rootbroker-setup").chmod 0755
  end

  def caveats
    <<~EOS
      The formula installs files without configuring a root service.
      Review the installed documentation, then run rootbroker-setup with sudo.
    EOS
  end

  test do
    assert_match "rootbroker v#{version}", shell_output("#{bin}/rootbroker version")
  end
end
