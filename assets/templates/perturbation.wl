(* Compatibility baseline: xPert 1.0.6. Do not impose background equations or a gauge before recording them. *)
Needs["xAct`xPert`"];

DefManifold[M, 4, {a, b, c, d, e, f}];
DefMetric[-1, g[-a, -b], CD];
DefMetricPerturbation[g, h, eps];

firstOrderRicciScalar = ExpandPerturbation[Perturbed[RicciScalarCD[], 1]];
firstOrderRicciScalar = ToCanonical[ContractMetric[firstOrderRicciScalar]];
backgroundCheck = ToCanonical[firstOrderRicciScalar /. eps -> 0] - RicciScalarCD[];
Print["first-order expansion: ", firstOrderRicciScalar];
Print["eps -> 0 background check (expected 0): ", backgroundCheck];
If[backgroundCheck =!= 0, Abort[]];
Exit[];
