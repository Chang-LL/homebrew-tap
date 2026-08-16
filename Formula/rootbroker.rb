class Rootbroker < Formula
  desc "Human-approved root command broker for local AI agents"
  homepage "https://github.com/Chang-LL/rootbroker"
  version "0.1.0-alpha.2"
  license "MIT"

  depends_on :linux

  on_intel do
    url "https://github.com/Chang-LL/rootbroker/releases/download/v0.1.0-alpha.2/rootbroker_v0.1.0-alpha.2_linux_amd64.tar.gz"
    sha256 "048bf51185d64ee9a91888c82023fb55700cf7d2a68e9381ecff8aa6248a71c4"
  end

  on_arm do
    url "https://github.com/Chang-LL/rootbroker/releases/download/v0.1.0-alpha.2/rootbroker_v0.1.0-alpha.2_linux_arm64.tar.gz"
    sha256 "b5e8e657adef5e6c722b402f5663fbf42145db26faa2fc24225f47f4f04e9408"
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
