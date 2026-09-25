---
name: xact-research
description: "Develop and verify Wolfram Language/xAct calculations for tensor algebra, gravity, action variation, components, and perturbation theory. Use for xTensor, xCoba, xPert, xTras, or Wolfram Engine troubleshooting tied to such research."
---

# xAct research workflow

Produce reproducible symbolic-physics results. A result is provisional until its conventions, executable code, Wolfram messages, and appropriate independent checks are reported.

Resolve every relative path from this `SKILL.md` directory. Read only the references relevant to the request.

## Establish the problem

Record the requested output and any material convention not fixed by the user: dimension, signature, curvature sign, independent fields, torsion/non-metricity, coordinates or basis, perturbation order and gauge, boundary-term treatment, and whether background equations may be used. Ask only when a missing choice would materially change the result; otherwise state the convention selected.

When execution or version-dependent syntax matters:

1. Run `scripts/check-wolfram.sh`.
2. If package availability or versions matter, run `scripts/inspect-xact.wl` through `scripts/run-wolfram.sh`.
3. Use a fresh kernel and a minimal case. Do not redefine objects in an uninspected live session.

## Route the calculation

- **xTensor:** abstract indices, metrics, derivatives, curvature, canonicalization, and field equations. Read `references/xtensor.md`.
- **xPert:** perturbations on a defined background metric. Read `references/xpert.md`.
- **xCoba:** charts, bases, component arrays, and explicit metrics. Read `references/xcoba.md`; prefer an abstract calculation first when useful.
- **xTras:** tensor collection and variational derivatives. Read `references/xtras.md` and confirm functions in the installed version.
- **Engine or package loading:** read `references/wolfram-engine.md`, `references/xact-overview.md`, and, when provenance matters, `references/sources.md`.
- **Explicit boundary currents or reduced actions:** read `references/covariant-action-reduction.md` before reducing the action.
- **Large or delicate calculations:** read `references/verification.md` before expanding expressions.

Adapt the closest file in `assets/templates/` rather than assuming its conventions match the problem.

## Calculate incrementally

Add one definition or transformation at a time and inspect every message. `$Failed`, `$Aborted`, an unevaluated `Needs[...]`, or an error-suspended expression is not success. Do not use `Quiet` to support a success claim.

Verify unfamiliar syntax against the active installation or official documentation. Apply operations deliberately; for example, `ToCanonical[ContractMetric[expr]]` is common but transformation order is problem-dependent. Avoid premature components, numerical substitutions, `Expand`, and `FullSimplify`.

For action reductions, keep the raw expression, chosen bulk representative, and explicit divergence current separate. `VarD` and `VarL` form Euler derivatives but do not reconstruct a discarded current.

## Verify and report

Use at least two checks appropriate to the claim, preferably of different kinds: index/symmetry/dimension checks; a flat, background, or zero-perturbation limit; a Bianchi or conservation identity; a known solution; or an independent abstract/component route.

Report separately:

- conventions and assumptions;
- code and package versions;
- outputs and all relevant messages;
- checks performed and their results;
- interpretation, limitations, and checks not performed.

For large expressions, exploit symmetries, test representative components, time stages, and retain named intermediates. Follow the debugging order in `references/verification.md`; never remove a failing term merely to obtain a clean result.

## Adapt this skill

This repository is a verified starting point, not a universal or finished research protocol. Users may tailor conventions, templates, validation thresholds, package coverage, and reporting style to their field. Preserve the core invariants when adapting it: explicit assumptions, visible messages, version-aware syntax, reproducible code, and independent verification.
