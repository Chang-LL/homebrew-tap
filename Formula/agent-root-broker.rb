class AgentRootBroker < Formula
  desc "Human-approved sudo/root broker for local AI agents"
  homepage "https://github.com/Chang-LL/agent-root-broker"
  version "0.1.0-alpha.3"
  license "MIT"

  depends_on :linux

  on_intel do
    url "https://github.com/Chang-LL/agent-root-broker/releases/download/v0.1.0-alpha.3/rootbroker_v0.1.0-alpha.3_linux_amd64.tar.gz"
    sha256 "c4c078bf3002a10b239b0a23644be105ac220009ce8766cdd03f34c565ca5edb"
  end

  on_arm do
    url "https://github.com/Chang-LL/agent-root-broker/releases/download/v0.1.0-alpha.3/rootbroker_v0.1.0-alpha.3_linux_arm64.tar.gz"
    sha256 "5dfe9005fb76f546aad2dcbeb6830a057b50e68fc38a846515dd0325693614d1"
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
