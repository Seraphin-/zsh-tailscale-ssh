############################################################
# Take all host sections in tailscale and offer them for
# completion as hosts (e.g. for ssh, rsync, scp and the like)
# Note we don't check if tailscale is up since status --json
# returns cached data even if tailscale is not running
if ((( $+commands[tailscale] ) && ( $+commands[jq] ))); then
  _tailscale_status=$(tailscale status --json)
  _tailscale_suffix=$(echo $_tailscale_status | jq -r '.MagicDNSSuffix')
  zstyle -a ':completion:*:hosts' hosts _tailscale_hosts
  # Do we have a MagicDNS suffix?
  if [ -z "$_tailscale_suffix" ]; then
    _tailscale_hosts+=($(tailscale status --json | jq -r '[.Peer | to_entries[] | .value.DNSName | join(" ")'))
  else
    _tailscale_hosts+=($(tailscale status --json | jq -r "[.Peer | to_entries[] | .value.DNSName | sub(\".$_tailscale_suffix\"; \"\")] | join(\" \")"))
  fi
  zstyle ':completion:*:hosts' hosts $_tailscale_hosts
  unset _tailscale_status
  unset _tailscale_suffix
  unset _tailscale_hosts
fi

