verbosity=0

err() {
  echo ERROR: $* >&2
}

info() {
  [[ ${verbosity} -ge 1 ]] && echo INFO: $* || :
}

debug() {
  [[ ${verbosity} -ge 2 ]] && echo DEBUG: $* || :
}

finish() {
  if [[ $? -eq 0 ]]; then
    info OK
  else
    err One or more failures
  fi
}

trap finish EXIT

git_dir="$(git rev-parse --show-toplevel)"
if ! [[ "$(pwd)" = "${git_dir}" ]]; then
  err Please run these scripts from the root of the repo
  exit 1
fi
