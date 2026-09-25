# xTras: verified facilities

xTras 1.4.2 (release `{2014,10,30}`) is the compatibility baseline. `VarL` and `CollectTensors` are in `xAct`xTras``; `VarD` is in `xAct`xTensor`` and is extended by xTras. Do not label all three as xTras-owned merely because xTras makes the workflow available.

- `CollectTensors[expr]` collects tensorial terms; it is documented as analogous to `Collect` without manually listing every tensor.
- `VarD[field, covd][L]` is a variational derivative with integration by parts. It compares scalar Lagrangians modulo divergences; it does not return the discarded divergence current.
- `VarL[g[-a,-b]][L]` performs the metric variation of the metric-volume density and divides by the volume factor afterwards. It necessarily assumes a treatment of boundary terms and does not identify a complete variational boundary term.

The action template evaluates `VarL[g[-a,-b]][RicciScalarCD[]]` and compares, after expanding Einstein, against `-EinsteinCD[a,b]`; on the tested version it returns zero. This establishes only the declared convention and formal integration-by-parts result, not a completed variational principle with a specified boundary term.

For explicit covariant integration by parts, a boundary-current audit, or a reduced action with a nontrivial measure, read `covariant-action-reduction.md`.

Official references: [xTras documentation PDF](https://xact.es/Documentation/English/xTras.pdf), [metric-variations tutorial](https://xact.es/xTras/documentation/tutorial/MetricVariations.html), and [CollectTensors documentation](https://xact.es/Documentation/English/xTras.pdf).
