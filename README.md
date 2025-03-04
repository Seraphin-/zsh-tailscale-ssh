# tailscale-ssh plugin

This zsh plugin provides host completion based off `tailscale status`. It automatically strips the MagicDNS suffix, if present.

## Requirements
`tailscale` and `jq` on your `$PATH`.

## Installation with OMZ
```zsh
git clone https://github.com/Seraphin-/zsh-tailscale-ssh "$ZSH_CUSTOM/plugins/tailscale-ssh"
```

Add `tailscale-ssh` to your `plugins` in `$zshrc`.

## License
MIT
