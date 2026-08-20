# Homebrew tap for Agent Root Broker

This tap publishes the Linux-only
[Agent Root Broker](https://github.com/Chang-LL/agent-root-broker) formula. Add the tap once, then
use the public project name for normal Homebrew operations:

```sh
brew tap Chang-LL/tap
brew install agent-root-broker
sudo "$(brew --prefix)/bin/rootbroker-setup" \
  --profile grok \
  --approver-user "$USER" \
  --agent-bin /absolute/path/to/grok
```

For a one-line install on a host that has not added the tap, use
`brew install Chang-LL/tap/agent-root-broker`. The previous `rootbroker` formula name is retained in
Homebrew's rename metadata, while installed commands remain `rootbroker`, `rootbroker-admin`, and
`rootbroker-setup`.

Installing the formula does not create accounts or start a root service. Review rootbroker's
documentation and installed setup assets before running the explicit setup command.

Release archives, checksums, SBOMs, and build provenance are published in the main project's
[GitHub Releases](https://github.com/Chang-LL/agent-root-broker/releases).

Security reports should follow the main project's
[security policy](https://github.com/Chang-LL/agent-root-broker/security/policy).
