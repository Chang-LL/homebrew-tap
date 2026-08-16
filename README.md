# Homebrew tap for rootbroker

This tap publishes the Linux-only [rootbroker](https://github.com/Chang-LL/rootbroker) formula.

```sh
brew install Chang-LL/tap/rootbroker
sudo "$(brew --prefix)/bin/rootbroker-setup" \
  --profile grok \
  --approver-user "$USER" \
  --agent-bin /absolute/path/to/grok
```

Installing the formula does not create accounts or start a root service. Review rootbroker's
documentation and installed setup assets before running the explicit setup command.

Release archives, checksums, SBOMs, and build provenance are published in the main project's
[GitHub Releases](https://github.com/Chang-LL/rootbroker/releases).
