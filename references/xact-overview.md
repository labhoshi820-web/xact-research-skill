# xAct overview and selection

Local package source and official documentation identify xTensor as the abstract tensor foundation. xCoba extends it with charts, bases, component values, `CTensor`, and `MetricCompute`. xPert is for high-order metric/curvature perturbations and depends on xTensor. xTras is an add-on whose local init also loads xPert, xCoba, Invar, and SymManipulator.

Use the representation matching the question: abstract indices for identities and covariant derivations; coordinate/basis components for a concrete chart; xPert only after the background metric exists; xTras only with its version and boundary/density assumptions explicit. Discover the active package location with `FindFile["xAct`xTensor`"]` after loading it, and inspect `$Path` for xAct entries when package discovery needs debugging. Do not assume a particular user-home or installation directory.

Official index: <https://xact.es/documentation.html>. It links the xTensor reference guide/tutorial, xCoba documentation, xPert documentation, xTras material, course material, and contributed example notebooks.

## Extending the package coverage

The current references cover only the packages exercised by the bundled baseline. Add another xAct package only after recording its purpose, dependencies, active version, source of syntax, a minimal executable example, and at least one meaningful check. Package availability in one local installation is not evidence that every user has the same version or dependency set.
