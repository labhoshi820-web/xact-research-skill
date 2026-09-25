# xAct Research Skill (Codex-first)

English | [日本語](README.md)

This Codex Skill provides a reproducible workflow for tensor calculations with Wolfram Language and xAct. It keeps calculation code, assumptions, conventions, Wolfram messages, and independent checks distinct throughout an analysis. The public repository is named `xact-research-skill`; the invocation name remains `$xact-research`.

This is not an official project of Wolfram Research, the xAct developers, or OpenAI. It does not include Wolfram Engine, Mathematica, or xAct itself. Codex metadata and installation instructions are included. The `SKILL.md`, references, templates, and scripts follow the Agent Skills structure described in the [OpenAI Skills documentation](https://developers.openai.com/api/docs/guides/tools-skills) and may be adapted for AI coding agents that understand a comparable format; verify compatibility in the target agent.

## Capabilities

| Package | Primary use |
| --- | --- |
| xTensor | Abstract indices, metrics, covariant derivatives, curvature, and tensor canonicalization |
| xCoba | Charts, bases, component arrays, and curvature calculations for explicit metrics |
| xPert | Perturbative expansions of metrics and curvature tensors |
| xTras | Tensor collection, action variation, and Euler derivatives |

The bundled templates are minimal examples of abstract tensor algebra, action variation, first-order perturbation theory, and coordinate-component calculations. They do not choose physical assumptions, gauges, boundary conditions, curvature signs, or interpretations for you. A completed symbolic calculation alone does not establish that a physical conclusion is correct.

## Requirements

- A Codex environment that supports Skills
- Wolfram Engine or Mathematica
- xAct
- Bash and GNU `timeout` (`gtimeout` from `brew install coreutils` is also supported on macOS)

Install Wolfram Engine or Mathematica and xAct in your own environment. This repository does not require one specific Wolfram version or license state; after installation, validate the scripts and templates against the environment you use.

WSL is recommended when running the bundled shell scripts on Windows. The Wolfram Language templates can also be run directly in a compatible Wolfram environment.

## Install Wolfram Engine

1. Download the appropriate version for your operating system from [Wolfram Engine](https://www.wolfram.com/engine/). Homebrew is available on macOS, winget on Windows, and an official installer or distribution package on Linux.
2. Review the license terms with your Wolfram ID. After installation, start `wolframscript` to activate the product.
3. Check that the installed kernel is available from the command line:

```bash
./scripts/check-wolfram.sh
```

Free Wolfram Engine is subject to restrictions on permitted use, redistribution, research use, and production use. Do not copy the Engine into this repository. Each user should obtain it from the official source and confirm that their intended use is covered by an appropriate license. See the [Wolfram Engine FAQ](https://www.wolfram.com/engine/faq/) for details.

## Install xAct

1. Download the complete archive from the [official xAct download page](https://xact.es/download.html).
2. Extract the `xAct` directory into an `Applications` directory searched by your Wolfram installation. Query the appropriate user-specific location with:

```bash
wolframscript -code 'FileNameJoin[{$UserBaseDirectory, "Applications"}]'
```

3. Verify that xTensor loads:

```bash
wolframscript -code 'Needs["xAct`xTensor`"]'
```

Do not assume a fixed home-directory layout. The official [xAct Installation Notes](https://www.xact.es/download/install) likewise recommend locating the installation relative to `$UserBaseDirectory` or `$BaseDirectory`.

## Install the Skill

The repository itself is one Skill folder. Clone it into the Codex Skills directory:

```bash
git clone https://github.com/labhoshi820-web/xact-research-skill.git "$HOME/.agents/skills/xact-research"
```

Start a new Codex session, then invoke `$xact-research` explicitly or request a Wolfram/xAct analysis.

Example:

```text
Use $xact-research to calculate the trace of the Einstein tensor in four dimensions and report the conventions and verification results.
```

[SKILL.md](SKILL.md) is the entry point. The Skill loads material from `references/`, `scripts/`, and `assets/templates/` as needed.

## Adapt it to your research

This Skill is a verified starting point, not a finished protocol covering every theory, convention, or research environment. Tailor it to your field and preferences. Useful adaptations include:

- default dimension, metric signature, curvature convention, and index names;
- additional xAct packages and research-specific tensor definitions;
- templates, validation checks, time limits, and reporting format;
- installation paths or metadata for AI coding agents other than Codex.

After modifying the Skill, add a known representative calculation and an independent check. Inspect `$Failed`, `$Aborted`, Wolfram messages, and unevaluated expressions. Keep unpublished calculations and research data in a separate working repository rather than adding them directly to this public Skill.

## Local validation

```bash
./scripts/check-wolfram.sh
./scripts/run-wolfram.sh scripts/inspect-xact.wl

for file in assets/templates/*.wl; do
  ./scripts/run-wolfram.sh -t 120 "$file" || exit $?
done
```

Do not ignore Wolfram messages, `$Failed`, `$Aborted`, or expressions left unevaluated by an error. For example, if the optional external xPerm accelerator is unavailable, the calculation may fall back to a Wolfram Language implementation and still return a final zero check. Record the message and its performance implications separately from the mathematical result.

## Repository layout

```text
xact-research-skill/
├── README.md                Japanese README
├── README.en.md             English README
├── SKILL.md                 Main workflow loaded by Codex
├── agents/openai.yaml       Skill display metadata
├── assets/templates/        Minimal Wolfram Language templates
├── references/              Package- and verification-specific guidance
└── scripts/                 Environment inspection and batch execution
```

## Handling execution logs

The environment-inspection scripts replace known home-directory paths with `<HOME>` or `<USER_BASE>`. Messages emitted by Wolfram or xAct may still contain other local paths. Before sharing logs or screenshots, check for credentials, user names, local paths, and unpublished research data.
