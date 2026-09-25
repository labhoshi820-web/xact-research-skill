# xPert: metric perturbations

xPert 1.0.6 (release `{2018,2,28}`) is the compatibility baseline; it declares xTensor, xPerm, xCore, and ExpressionManipulation dependencies. Verified symbols belong to `xAct`xPert``.

- `DefMetricPerturbation[g, h, eps]` requires an existing metric and defines the metric perturbation tensor and expansion parameter.
- `Perturbed[expr, n]` produces the expansion through order `n` using `$PerturbationParameter`.
- `ExpandPerturbation[expr]` expands perturbation heads, with built-in formulas for common metric curvature tensors.

The template performs a first-order Ricci-scalar expansion and checks that replacing `eps -> 0` recovers the background Ricci scalar. This is a structural check, not a gauge, background-equation, or physical-mode analysis. State those assumptions separately.

Official references: [xPert documentation](https://www.xact.es/Documentation/HTML/xPertDoc.nb.html), [curvature-expansion examples](https://xact.es/Documentation/HTML/HTMLLinks/xPertDoc.nb_5.html), and [xPand xPert example](https://xact.es/Documentation/English/xPand6_Xav.pdf).
