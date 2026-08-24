class AgentRootBroker < Formula
  desc "Human-approved sudo/root broker for local AI agents"
  homepage "https://github.com/Chang-LL/agent-root-broker"
  version "0.1.0-alpha.7"
  license "MIT"

  depends_on :linux

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Chang-LL/agent-root-broker/releases/download/v0.1.0-alpha.7/rootbroker_v0.1.0-alpha.7_linux_arm64.tar.gz"
      sha256 "d25ef20974ccc0cff77636de9a1a1415c86dca6c228d257b2a4d95c5d66e6ccb"
    else
      url "https://github.com/Chang-LL/agent-root-broker/releases/download/v0.1.0-alpha.7/rootbroker_v0.1.0-alpha.7_linux_amd64.tar.gz"
      sha256 "8598bdce7fb19f2b132be91cf209388ca9a437d64121a25f2d374c2c36b27c46"
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
