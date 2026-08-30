---
name: argument-sample
description: Demonstrates the skill arguments feature — $ARGUMENTS, $ARGUMENTS[N] / $N, and named arguments declared via the arguments frontmatter field
disable-model-invocation: true
argument-hint: [first] [second]
arguments: [first, second]
---

1. Print "step-1 all arguments (\$ARGUMENTS): $ARGUMENTS"

2. Print "step-2 first positional argument (\$ARGUMENTS[0] / \$0): $0"

3. Print "step-3 second positional argument (\$ARGUMENTS[1] / \$1): $1"

4. Print "step-4 named argument \$first (declared via `arguments: [first, second]` in the frontmatter): $first"

5. Print "step-5 named argument \$second (declared via `arguments: [first, second]` in the frontmatter): $second"

