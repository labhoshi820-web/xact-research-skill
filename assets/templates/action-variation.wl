(* Verified availability: xTras 1.4.2 provides VarL. Boundary terms are discarded by the variational derivative. *)
Needs["xAct`xTras`"];

DefManifold[M, 4, {a, b, c, d, e, f}];
DefMetric[-1, g[-a, -b], CD];

lagrangian = RicciScalarCD[];
metricEuler = ToCanonical[ContractMetric[VarL[g[-a, -b]][lagrangian]]];
(* VarL with respect to g_ab carries upper free indices. *)
expected = ToCanonical[EinsteinToRicci[-EinsteinCD[a, b]]];
check = ToCanonical[metricEuler - expected];
Print["metric Euler derivative: ", metricEuler];
Print["Einstein comparison (expected 0, subject to stated conventions): ", check];
If[check =!= 0, Print["Do not claim equality until normalization/sign and boundary conventions are checked."]];
Exit[];
