(* Compatibility baseline: xTensor 1.3.0. Fresh kernel recommended. *)
Needs["xAct`xTensor`"];

DefManifold[M, 4, {a, b, c, d, e, f}];
DefMetric[-1, g[-a, -b], CD];
DefTensor[V[-a], M];

ricci = RicciCD[-a, -b];
ricciScalar = RicciScalarCD[];
einstein = EinsteinCD[-a, -b];
canonicalEinstein = ToCanonical[ContractMetric[EinsteinToRicci[einstein]]];

(* Four-dimensional trace G^a_a = -R. *)
traceCheck = ToCanonical[ContractMetric[g[a, b] canonicalEinstein /. EinsteinCD[-a, -b] -> einstein] + ricciScalar];
Print["trace check (expected 0): ", traceCheck];
If[traceCheck =!= 0, Print["Verification incomplete: inspect conventions and output."]; Abort[]];
Exit[];
