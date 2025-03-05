############################################################
# Take all host sections in tailscale and offer them for
# completion as hosts (e.g. for ssh, rsync, scp and the like)
if ((( $+commands[tailscale] ) && ( $+commands[jq] ))); then
  _tailscale_status=$(tailscale status --json)
  _tailscale_state=$(echo $_tailscale_status | jq -r '.BackendState')
  if [[ "Running" == "$_tailscale_state" ]]; then
    _tailscale_suffix=$(echo $_tailscale_status | jq -r '.MagicDNSSuffix')
    zstyle -a ':completion:*:hosts' hosts _tailscale_hosts
    # Do we have a MagicDNS suffix?
    if [ -z "$_tailscale_suffix" ]; then
      _tailscale_hosts+=($(echo $_tailscale_status | jq -r '[.Peer | to_entries[] | .value.DNSName | join(" ")]'))
    else
      _tailscale_hosts+=($(echo $_tailscale_status | jq -r "[.Peer | to_entries[] | .value.DNSName | sub(\".$_tailscale_suffix\"; \"\")] | join(\" \")"))
    fi
    zstyle ':completion:*:hosts' hosts $_tailscale_hosts
    unset _tailscale_hosts
    unset _tailscale_suffix
  fi
  unset _tailscale_state
  unset _tailscale_status
fi

