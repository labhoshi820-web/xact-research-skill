#!/usr/bin/env bash
set -u

find_command() {
  local candidate path
  for candidate in wolframscript WolframKernel math; do
    if path="$(command -v "$candidate" 2>/dev/null)"; then
      printf '%s\t%s\n' "$candidate" "$path"
    fi
  done
}

redact_path() {
  local value=$1 user_home=${HOME:-}
  if [[ -n "$user_home" && "$value" == "$user_home"* ]]; then
    printf '<HOME>%s' "${value#"$user_home"}"
  else
    printf '%s' "$value"
  fi
}

find_timeout() {
  if command -v timeout >/dev/null 2>&1; then
    command -v timeout
  elif command -v gtimeout >/dev/null 2>&1; then
    command -v gtimeout
  else
    return 1
  fi
}

found="$(find_command)"
if [[ -z "$found" ]]; then
  echo "No wolframscript, WolframKernel, or math command found." >&2
  exit 127
fi

printf '%s\n' "$found" | while IFS=$'\t' read -r name path; do
  printf 'Detected %s: %s\n' "$name" "$(redact_path "$path")"
  "$path" -version 2>&1 || true
done

kernel="${WOLFRAM_KERNEL:-}"
if [[ -z "$kernel" ]]; then
  kernel="$(printf '%s\n' "$found" | awk -F '\t' '$1 == "WolframKernel" || $1 == "math" {print $2; exit}')"
fi
[[ -n "$kernel" && -x "$kernel" ]] || { echo "No executable WolframKernel/math found (set WOLFRAM_KERNEL to override)." >&2; exit 127; }

timeout_cmd="$(find_timeout)" || {
  echo "GNU timeout was not found (install GNU coreutils; on macOS the command may be gtimeout)." >&2
  exit 127
}

echo "Testing WolframKernel (also checks that command-line authorization works):"
"$timeout_cmd" 30s "$kernel" -noprompt -run 'Print[1 + 1]; Print[$Version]; Exit[]'
