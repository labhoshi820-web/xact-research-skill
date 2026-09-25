# xTensor: verified core syntax

xTensor 1.3.0 (release `{2025,12,29}`) is the compatibility baseline. Its package source declares xCore and xPerm dependencies. The following symbols exist in `xAct`xTensor`` and were executed in the abstract template.

- `DefManifold[M, dim, {a,b,...}]` defines a manifold and its tangent bundle.
- `DefMetric[sign, g[-a,-b], CD]` defines a metric and associated Levi-Civita covariant derivative/curvature tensors. The sign is a convention; do not change it silently.
- `DefTensor[T[indices], M]` defines a tensor (a symmetry argument can be supplied when required).
- `ToCanonical[expr]` canonicalizes tensor expressions.
- `ContractMetric[expr]` contracts metrics; choose its placement deliberately.

For a metric-derived `CD`, `RicciCD[-a,-b]`, `RicciScalarCD[]`, and `EinsteinCD[-a,-b]` are created. The abstract template checks the four-dimensional trace after `EinsteinToRicci`, metric contraction, and canonicalization.

Official references: [DefManifold](https://xact.es/Documentation/HTML/HTMLLinks/xTensor/DefManifold.nb.html), [xTensor reference guide](https://xact.es/Documentation/HTML/xTensorRefGuide.nb.html), and [xTras introduction’s xTensor basics](https://xact.es/xTras/documentation/tutorial/Introduction.html). Confirm options with `Options[symbol]` in the running version; do not infer them from this short guide.
