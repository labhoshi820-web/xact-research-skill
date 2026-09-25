#!/usr/bin/env bash
set -u

usage() { echo "Usage: $0 [-t seconds] file.wl [-- WolframKernel options...]" >&2; exit 64; }
timeout_seconds=300
while getopts ':t:h' opt; do
  case "$opt" in
    t) timeout_seconds="$OPTARG" ;;
    h|*) usage ;;
  esac
done
shift $((OPTIND - 1))
[[ $# -ge 1 ]] || usage
input=$1
shift
[[ -f "$input" ]] || { echo "Input file not found: $input" >&2; exit 66; }
case "$input" in *.wl|*.m) ;; *) echo "Expected a .wl or .m Wolfram Language file: $input" >&2; exit 65;; esac
[[ "$timeout_seconds" =~ ^[1-9][0-9]*$ ]] || { echo "Timeout must be a positive integer." >&2; exit 64; }

kernel="${WOLFRAM_KERNEL:-}"
if [[ -z "$kernel" ]]; then
  for candidate in WolframKernel math; do
    if command -v "$candidate" >/dev/null 2>&1; then kernel="$(command -v "$candidate")"; break; fi
  done
fi
[[ -n "$kernel" && -x "$kernel" ]] || { echo "No executable WolframKernel/math found (set WOLFRAM_KERNEL to override)." >&2; exit 127; }

if command -v timeout >/dev/null 2>&1; then
  timeout_cmd="$(command -v timeout)"
elif command -v gtimeout >/dev/null 2>&1; then
  timeout_cmd="$(command -v gtimeout)"
else
  echo "GNU timeout was not found (install GNU coreutils; on macOS the command may be gtimeout)." >&2
  exit 127
fi

output=$(mktemp) || exit 70
trap 'rm -f "$output"' EXIT HUP INT TERM
set +e
"$timeout_cmd" --kill-after=10s "${timeout_seconds}s" "$kernel" -noprompt -script "$input" "$@" >"$output" 2>&1
status=$?
set -e
cat "$output"
if grep -Eq '\$Failed|\$Aborted' "$output"; then
  echo "Warning: output contains \$Failed or \$Aborted; inspect the result before treating it as success." >&2
fi
if grep -Eq '(^|[[:space:]])[A-Za-z$][A-Za-z0-9$]*::[A-Za-z0-9]+:' "$output"; then
  echo "Warning: output contains Wolfram messages; inspect them before treating the calculation as verified." >&2
fi
if [[ $status -eq 124 || $status -eq 137 ]]; then
  echo "Wolfram process timed out after ${timeout_seconds}s." >&2
fi
exit "$status"
