# Sources and verification

## Source priority

Use local package source first, then locally installed notebooks/documentation, then xAct official documentation/tutorials and official papers. The official xAct index is <https://xact.es/documentation.html>. No third-party source was used to establish the listed function syntax.

## Compatibility baseline (rechecked 2026-08-30)

The versions below document one successfully tested environment. They are not installation requirements. Each user should install and authorize a compatible Wolfram environment and rerun the checks locally.

- Wolfram Engine: 15.0.0 for Linux x86-64; command-line execution and local authorization succeeded; `$FrontEnd` was `Null`.
- xTensor: 1.3.0, `{2025,12,29}`; loading, symbol inspection, and the abstract template passed.
- xCoba: 0.8.6, `{2021,2,28}`; loading, symbol inspection, and the polar component template passed.
- xPert: 1.0.6, `{2018,2,28}`; loading, symbol inspection, and the first-order template passed.
- xTras: 1.4.2, `{2014,10,30}`; loading, `VarD`/`VarL`/`CollectTensors`, and the Einstein-Hilbert metric-variation template passed.

All four templates returned their stated zero checks. Package loading can still emit environment-specific messages, including failures of optional accelerators or package-repository warnings. Do not suppress or treat such a run as a clean package load; re-run the inspection on each target machine and report its actual messages.

## Function status

| Function | Local context | Source / minimal run |
| --- | --- | --- |
| `DefManifold`, `DefMetric`, `DefTensor`, `ToCanonical`, `ContractMetric` | `xAct`xTensor`` | local source + abstract template: passed |
| `DefChart`, `CTensor`, `ComponentArray`, `ToValues`, `MetricCompute`, `TensorValues` | `xAct`xCoba`` | local source + component template: passed (TensorValues symbol checked) |
| `DefMetricPerturbation`, `Perturbed`, `ExpandPerturbation` | `xAct`xPert`` | local source + perturbation template: passed |
| `VarD` | `xAct`xTensor`` (extended by xTras) | local xTras source + action template: passed |
| `VarL`, `CollectTensors` | `xAct`xTras`` | local source + action template / symbol check: passed |

## Locating installed documentation and sources

After `Needs`, use `FindFile` on a package context (for example, `FindFile["xAct`xTensor`"]`) to find the active package tree. Look relative to that result for package notebooks and documentation. Installation layouts vary by operating system, Wolfram product, and user configuration, so never rely on a fixed path.

## Limits

The official web pages include older documentation alongside the newer local packages; when they differ, use the local source/runtime and mark the issue version-dependent. Engine-only verification does not establish FrontEnd-only behavior. The templates are minimal checks, not a substitute for research-specific conventions, gauge choices, boundary analysis, or independent physical validation.

The compatibility baseline is a dated observation, not a permanent support guarantee. When adapting or releasing the Skill, rerun the inspection and templates, update the date and versions only from actual output, and retain older claims unless they have been rechecked.
