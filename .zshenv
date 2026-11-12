[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
export SSH_AUTH_SOCK=${SSH_AUTH_SOCK:-/run/user/$UID/gcr/ssh}
