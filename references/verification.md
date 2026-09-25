# Verification and scale control

Use two independent checks chosen for the claim: free-index/variance and symmetry checks; trace/dimension checks; Bianchi or covariant-conservation identities; flat, weak-field, background, or zero-perturbation limits; a known metric; or an independent abstract/component route.

Before expensive work, test a smaller dimension, lower perturbation order, or representative component. Exploit symmetries before expansion. Measure time and monitor expression size; store named intermediate results. Do not indiscriminately apply `Expand` or `FullSimplify`, and do not component-expand or numeric-substitute earlier than needed.

Report an unavailable check as unavailable, with its reason (version, resources, missing assumptions, or FrontEnd dependency) and the next action needed to perform it.

## Debugging order

Check the kernel and authorization first, then package loading, symbol context, stale definitions, definition order, index legality, abstract versus basis indices, and remaining unevaluated expressions or messages. Reproduce the failure in a fresh kernel with the smallest input before comparing it with an official example or investigating version differences. Never delete a failing term solely to make the output clean.

## Project-specific checks

Extend this list for the theory being studied. A useful local check should fail when a relevant sign, normalization, gauge assumption, boundary term, or background equation is changed incorrectly. Keep those domain-specific checks in the research project when they contain unpublished assumptions or data; promote only broadly reusable checks into this Skill.
