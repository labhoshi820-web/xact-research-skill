(* Compatibility baseline: xCoba 0.8.6. Polar-coordinate origin is a coordinate singularity. *)
Needs["xAct`xCoba`"];

DefManifold[M2, 2, {a, b, c, d}];
DefMetric[1, g[-a, -b], CD];
DefChart[polar, M2, {0, 1}, {r[], theta[]}];
metricComponents = CTensor[{{1, 0}, {0, r[]^2}}, {-polar, -polar}];
MetricCompute[metricComponents, polar, "Ricci"[-1, -1], CVSimplify -> Simplify, Verbose -> False];
metricCD = CovDOfMetric[metricComponents];
ricciComponents = ComponentArray[ToBasis[polar][Ricci[metricCD][-a, -b]]] // ToValues;
Print["Ricci components (expected zero away from coordinate-domain assumptions): ", ricciComponents];
If[ricciComponents =!= 0, Print["Verification incomplete: inspect chart domain and messages."]; Abort[]];
Exit[];
