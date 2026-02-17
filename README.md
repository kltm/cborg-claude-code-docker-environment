# cborg-claude-code-docker-environment
A fallback environment for CBORG and Claude Code.

## Instructions.

`export CBORG_API_KEY="<your-key>"`

```bash
docker build \
  --build-arg USER_ID=$(id -u) \
  --build-arg GROUP_ID=$(id -g) \
  --build-arg USERNAME=$(whoami) \
  -t cborg-claude .
```

`cd` to the directory you want to work in. This will be mounted in the
`/work` diretory in the running docker image.

```bash
docker run --name cborg-claude --network host \
  -v "$(pwd)":/work -w /work \
  -e ANTHROPIC_SMALL_FAST_MODEL=anthropic/claude-haiku \
  -e ANTHROPIC_MODEL=anthropic/claude-sonnet \
  -e ANTHROPIC_BASE_URL=https://api.cborg.lbl.gov \
  -e CBORG_API_KEY \
  -e ANTHROPIC_AUTH_TOKEN="$CBORG_API_KEY" \
  -e DISABLE_NON_ESSENTIAL_MODEL_CALLS=1 \
  -e DISABLE_TELEMETRY=1 \
  -e CLAUDE_CODE_MAX_OUTPUT_TOKENS=8192 \
  -it cborg-claude /bin/bash
```

You will now be able to rejoin this image later on.

Now that you're inside the container, `cd` to `/work` and run
`claude`. 
