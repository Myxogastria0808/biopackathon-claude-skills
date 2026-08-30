# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Purpose

This is a sample repository for a Biopackathon 2026 talk (session #8: 「スクリプトに落とせない反復作業を Claude に覚えさせる 〜 Skills 入門 〜」). It exists to demonstrate Claude Code **Skills**, not to ship a real Python package. The actual Python code (`src/biopackathon_claude_skills/lib.py`) is a minimal, deliberately trivial example used to demonstrate Sphinx documentation generation from Google-style docstrings.

## Environment setup

The dev shell is provided by Nix (`flake.nix`) via direnv (`.envrc` runs `use flake`), which only provisions `uv`. Python dependency management is handled entirely by `uv`.

```
uv sync
```

Requires Python >= 3.14 (see `pyproject.toml`).

## Common commands

Build the Sphinx docs (reads Google-style docstrings from `src/biopackathon_claude_skills/lib.py` via `sphinx.ext.napoleon`):

```
uv run sphinx-build -b html docs docs/_build
```

Live-preview the docs with auto-rebuild on change:

```
uv run sphinx-autobuild docs docs/_build
```

Run the package's console script (defined in `pyproject.toml` under `[project.scripts]`):

```
uv run biopackathon-claude-skills
```

There is no lint or test setup configured in this repository.

## Architecture

- `src/biopackathon_claude_skills/lib.py` — example module whose Google-style docstrings are the source for generated docs. `docs/index.rst` uses `.. automodule:: biopackathon_claude_skills.lib` with `:members:`, so any public function added here needs a matching Google-style docstring to appear in the built docs.
- `docs/conf.py` — Sphinx config; `sys.path` is patched to point at `../src` so `automodule` can import the package directly from source (no install step needed). Theme is `sphinx_rtd_theme`; napoleon is configured for Google-style (not NumPy-style) docstrings.
- `docs/_build/` — generated output, already present in the tree; regenerate via the sphinx-build command above rather than hand-editing.

