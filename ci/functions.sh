# shellcheck shell=bash

################################################################################
# This collection of helper functions is sourced by the ci scripts.
################################################################################

# Defaults.
declare -i VERBOSITY=${VERBOSITY:-1}

. ci/ansi

run() {
  ansi --yellow-intense --newline "[RUN] $*"
  "$@"
}

err() {
  ansi --bold --red --newline "[ERROR] $*"
}

info() {
  ansi --faint --newline "[INFO] $*"
}

pass() {
  ansi --bold --green --newline "[PASS] $*"
  echo
}

warn() {
  ansi --yellow-intense --newline "[WARN] $*"
}

debug() {
  if [[ ${VERBOSITY} -ge 2 ]]; then
    ansi --yellow-intense --newline "[DEBUG] $*"
  fi
}

finish() {
  declare -ri RC=$?

  if [ ${RC} -eq 0 ]; then
    pass "$0 OK"
  else
    err "$0" failed with exit code ${RC}
  fi
}

is_ci() {
  # Are we running in hands-free CI?
  [[ -n "${CIRCLECI:-}" ]]
}

check_top_dir() {
  declare git_dir
  git_dir="$(git rev-parse --show-toplevel)"
  readonly git_dir

  if ! [[ "$PWD" == "${git_dir}" ]]; then
    err Please run these scripts from the root of the repo
    exit 1
  fi
}

# Traps.
# NOTE: In POSIX, beside signals, only EXIT is valid as an event.
#       You must use bash to use ERR.
trap finish EXIT
