class AgentRootBroker < Formula
  desc "Human-approved sudo/root broker for local AI agents"
  homepage "https://github.com/Chang-LL/agent-root-broker"
  version "0.1.0-alpha.8"
  license "MIT"

  depends_on :linux

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Chang-LL/agent-root-broker/releases/download/v0.1.0-alpha.8/rootbroker_v0.1.0-alpha.8_linux_arm64.tar.gz"
      sha256 "92066b7f71aa5c1743c9291128d8478c318056d1527d3bf9c04cfd5f367ac9c5"
    else
      url "https://github.com/Chang-LL/agent-root-broker/releases/download/v0.1.0-alpha.8/rootbroker_v0.1.0-alpha.8_linux_amd64.tar.gz"
      sha256 "cb07de74a36561456e32917e4d511a4286decfaac4534843bb04c23ab07ad8c6"
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
