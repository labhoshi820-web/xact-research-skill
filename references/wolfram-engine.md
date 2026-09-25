# Wolfram Engine execution

Install and authorize Wolfram Engine or Mathematica yourself before using this Skill. Run `scripts/check-wolfram.sh` in that environment. The recorded compatibility baseline used Wolfram Engine 15.0.0 and `wolframscript` 1.14.0; this is a historical reference, not a requirement. Installation paths vary: let the script discover commands on `PATH`, or set `WOLFRAM_KERNEL` to the executable path for an override.

Use `scripts/run-wolfram.sh [-t seconds] file.wl`. It selects `WolframKernel` (or `math`), propagates the kernel exit status, shows stdout/stderr, has a killable timeout, and warns about `$Failed`/`$Aborted`. Do not regard that warning as a proof of failure or success; inspect the expression and messages.

`$FrontEnd` was `Null` under the tested Engine. Batch symbolic calculation, package loads, and the supplied templates need no front end. Notebook-only authoring, interactive documentation rendering, and front-end-dependent functions remain unverified in Engine-only mode.
