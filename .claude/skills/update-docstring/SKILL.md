---
name: update-docstring
description: Sync Python docstrings with the actual implementation in Google style (napoleon-compatible) — updates Args/Returns/Raises to match current parameters, types, defaults, and exceptions. Use when a docstring is missing, stale, or doesn't match the function's real signature/behavior, or right after editing a function's parameters/return value/error handling.
---

# update-docstring

Update the `docstring` of a Python function, method, or class in Google style so it matches the actual implementation.

## Scope

- The file given as an argument, if one is provided.
- Otherwise, every public function/method/class under `src/**/*.py`.

## Steps

1. Read every Python file under `src/` (not just the target file) before writing any description. The right wording for a function's description can differ depending on whether it's read in isolation or in the context of the rest of the module/package (e.g. how it's called elsewhere, what role it plays relative to sibling functions), so build that context first.
2. For each public function/method/class in the target file, check the real signature (parameter names, type hints, default values, return type hint) and the implementation (which exceptions it can raise).
3. Compare the existing docstring against the implementation and list out any drift:
   - Missing or stale parameters (a parameter exists in the signature but isn't documented, or a documented parameter no longer exists).
   - Mismatched type annotations.
   - Missing mention of default values.
   - Mismatched return type or description.
   - Exceptions the implementation can raise that aren't listed under `Raises`.
4. Rewrite the docstring in Google style (compatible with `sphinx.ext.napoleon`'s `napoleon_google_docstring = True` setting). Section order is `Summary` → (blank line) → `Args` → `Returns` → `Raises`.
   - `Args`: list every parameter from the signature, formatted as `name (type): Description.` Mention what a default value means where relevant.
   - `Returns`: `type: Description.`
   - `Raises`: for each exception the implementation can raise, `ExceptionType: Condition under which it's raised.`
5. Write every description in English, regardless of what language the file's existing docstrings use. Don't invent behavior that can't be verified from the code — base every description only on facts you can confirm from parameter names, types, the branches/conditions in the code, and the file-wide context gathered in step 1.
6. Leave descriptions that already match the implementation untouched; fix only what's actually out of sync. Don't do unrelated reformatting or rewording.
7. After editing, run `uv run sphinx-build -b html docs docs/_build` and confirm it builds without warnings (napoleon emits warnings for syntax it can't parse as Google style).

