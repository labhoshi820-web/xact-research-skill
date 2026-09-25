# Covariant action reduction and explicit integration by parts

Use this reference for quadratic actions, higher-derivative perturbations, or any calculation that needs both a compact bulk Lagrangian and an explicit boundary/divergence term.

## Keep the three objects distinct

For a scalar Lagrangian on a metric-compatible background, record

\[
L_{\mathrm{raw}}=L_{\mathrm{bulk}}+\nabla_a J^a.
\]

`VarD[field, CD][L]` implements the integrations by parts needed for an Euler derivative. `VarL[metric][L]` additionally accounts for the metric volume density. Neither function reconstructs `J^a`. Do not infer an explicit boundary term merely because two `VarD` results agree.

Perform one integration-by-parts step as

\[
A\nabla_aB=-(\nabla_aA)B+\nabla_a(AB),
\]

and update `Lbulk` and `J` in the same operation. Do not delete the divergence. Use fresh dummy indices (`ReplaceDummies`) when forming or accumulating currents.

## Audit a proposed reduction

After declaring the relevant tensors and assigning a candidate scalar `Lraw`, `Lbulk`, and vector `J[a]`, use a problem-specific normalization function such as:

```wl
canon[expr_] := ToCanonical @ ContractMetric @ ReplaceDummies[expr];

boundaryResidual = canon[Lraw - Lbulk - CD[-a][J[a]]];
eulerResidual = canon @ VarD[h[-a, -b], CD][Lraw - Lbulk];
```

Require `boundaryResidual === 0` before claiming that the displayed current is correct. Require `eulerResidual === 0` before claiming that the two bulk representatives give the same field equation. Adapt the differentiated field and its index variance to the actual calculation. `eulerResidual === 0` alone establishes only equivalence modulo a divergence.

Do not pass a density to `VarD` as though it were a scalar. Use `VarL` for a metric variation of the metric-volume density, or keep the density/measure convention explicit and compare like with like.

## Preserve the measure during dimensional reduction

Covariant integration by parts uses the full compatible volume form. After a harmonic or dimensional reduction, keep every residual weight in the reduced measure. For example,

\[
w A D_a B=D_a(wAB)-B D_a(wA),
\]

so a factor such as an areal-radius weight is differentiated as well. Do not first drop `w` and then apply an unweighted one- or two-dimensional integration by parts.

## Order operations deliberately

For each selected term, move a chosen outer derivative, canonicalize, and only then decide whether covariant derivatives should be commuted. Commuting derivatives produces curvature terms; a Ricci-flat condition removes Ricci contractions, not a general Riemann tensor. Apply background field equations only after extracting the intended perturbative coefficient or variation, unless the calculation explicitly defines a background-restricted functional.

For a large expression, split by perturbative order, derivative order, or tensor sector before normalizing. A useful local sequence is `ReplaceDummies`, `ContractMetric`, then `ToCanonical`. Apply `CollectTensors` only after the tensor basis and assumptions are fixed. Avoid whole-expression `Expand` or `FullSimplify` unless a small trial establishes that they are safe.

## Use independent checks

Pair the two audits above with a check that is not another symbolic rewrite of the same expression: vary the selected bulk representative and compare to an independently derived linearized equation, evaluate representative components after the abstract check, or test a limit with known behavior. Record whether a comparison uses scalar Lagrangians, coordinate densities, or reduced densities; these are not interchangeable.
