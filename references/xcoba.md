# xCoba: components and charts

xCoba 0.8.6 (release `{2021,2,28}`) is the compatibility baseline; its declared dependencies are xTensor, xPerm, xCore, and ExpressionManipulation. Its verified public functions are in `xAct`xCoba``.

- `DefChart[chart, manifold, cnumbers, scalars]` defines coordinate fields and their labels.
- `CTensor[array, {bases...}]` represents an array of components in named bases.
- `MetricCompute[metric, chart, what]` computes requested metric-derived components. A `CTensor` metric obtains its own `CovDOfMetric`; query tensors of that derivative, not an unrelated abstract metric.
- `ComponentArray[expr]` gives component arrays for free basis indices; `ToValues[expr]` replaces stored component values.
- `TensorValues[tensor]` inspects the stored values.

The component template defines a polar chart and a flat metric `diag(1,r^2)`, computes the Ricci tensor using `MetricCompute`, and obtains `0` after `ToBasis`, `ComponentArray`, and `ToValues`. This checks the chart calculation only on its regular coordinate domain; `r=0` is a coordinate singularity, not automatically a curvature singularity.

Official references: [xCoba documentation](https://xact.es/xCoba/), [component-value example](https://xact.es/Documentation/HTML/HTMLLinks/xCobaDoc.nb_23.html), and [ComponentArray version note](https://www.xact.es/Documentation/HTML/HTMLLinks/xCobaDoc.nb_21.html).
