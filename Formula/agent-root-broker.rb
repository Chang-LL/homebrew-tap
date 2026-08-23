class AgentRootBroker < Formula
  desc "Human-approved sudo/root broker for local AI agents"
  homepage "https://github.com/Chang-LL/agent-root-broker"
  version "0.1.0-alpha.6"
  license "MIT"

  depends_on :linux

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Chang-LL/agent-root-broker/releases/download/v0.1.0-alpha.6/rootbroker_v0.1.0-alpha.6_linux_arm64.tar.gz"
      sha256 "89561315cbad36a271ee26a2ef397eb7c3eab4edcc1d53d6cc4556e4ceff9b21"
    else
      url "https://github.com/Chang-LL/agent-root-broker/releases/download/v0.1.0-alpha.6/rootbroker_v0.1.0-alpha.6_linux_amd64.tar.gz"
      sha256 "84907fd1619f592e1fffd30947365143bcdc07f497eb418c9e40660b35293e9b"
    end
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
    (bin/"rootbroker-migrate-private-prealpha").write <<~SH
      #!/bin/sh
      exec "#{libexec}/migrate-private-prealpha.sh" "$@"
    SH
    (bin/"rootbroker-migrate-private-prealpha").chmod 0755
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
