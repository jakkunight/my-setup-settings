export PATH=":$PATH"
export RTX_SHELL=zsh
export __RTX_ORIG_PATH="$PATH"

rtx() {
  local command
  command="${1:-}"
  if [ "$#" = 0 ]; then
    command rtx
    return
  fi
  shift

  case "$command" in
  deactivate|s|shell)
    # if argv doesn't contains -h,--help
    if [[ ! " $@ " =~ " --help " ]] && [[ ! " $@ " =~ " -h " ]]; then
      eval "$(command rtx "$command" "$@")"
      return $?
    fi
    ;;
  esac
  command rtx "$command" "$@"
}

_rtx_hook() {
  eval "$(rtx hook-env -s zsh)";
}
typeset -ag precmd_functions;
if [[ -z "${precmd_functions[(r)_rtx_hook]+1}" ]]; then
  precmd_functions=( _rtx_hook ${precmd_functions[@]} )
fi
typeset -ag chpwd_functions;
if [[ -z "${chpwd_functions[(r)_rtx_hook]+1}" ]]; then
  chpwd_functions=( _rtx_hook ${chpwd_functions[@]} )
fi

if [ -z "${_rtx_cmd_not_found:-}" ]; then
    _rtx_cmd_not_found=1
    test -n "$(declare -f command_not_found_handler)" && eval "${_/command_not_found_handler/_command_not_found_handler}"

    function command_not_found_handler() {
        if rtx hook-not-found -s zsh "$1"; then
          _rtx_hook
          "$@"
        elif [ -n "$(declare -f _command_not_found_handler)" ]; then
            _command_not_found_handler "$@"
        else
            echo "zsh: command not found: $1" >&2
            return 127
        fi
    }
fi
