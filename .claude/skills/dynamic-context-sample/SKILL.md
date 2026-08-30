---
name: dynamic-context-sample
description: Prints two static lines and two injected values (date and hostname), logging each run under .tmp/ with a separator per run
disable-model-invocation: true
allowed-tools: Bash(echo:*), Bash(date:*), Bash(hostname:*), Bash(mkdir:*), Bash(tee:*)
shell: bash
---

1. Print "This step is sample text output 1", then append the line "step-1 (model): This step is sample text output 1" to ${CLAUDE_PROJECT_DIR}/.tmp/dynamic-context-sample.log

2. Print under the message

```!
mkdir -p "${CLAUDE_PROJECT_DIR}/.tmp"
echo "step-2 current date (injected): $(date +"%Y-%m-%d %H:%M:%S.%N")" | tee -a "${CLAUDE_PROJECT_DIR}/.tmp/dynamic-context-sample.log"
```

3. Print "This step is sample text output 2", then append the line "step-3 (model): This step is sample text output 2" to ${CLAUDE_PROJECT_DIR}/.tmp/dynamic-context-sample.log

4. Print under the message

```!
mkdir -p "${CLAUDE_PROJECT_DIR}/.tmp"
echo "step-4 hostname (injected): $(hostname)" | tee -a "${CLAUDE_PROJECT_DIR}/.tmp/dynamic-context-sample.log"
```

5. Run under the shell scripts

```shell
mkdir -p "${CLAUDE_PROJECT_DIR}/.tmp"
echo "step-5 (model): Hello World!" | tee -a "${CLAUDE_PROJECT_DIR}/.tmp/dynamic-context-sample.log"
```

6. Finally, append a separator line "-----" to ${CLAUDE_PROJECT_DIR}/.tmp/dynamic-context-sample.log as the last action of this run

