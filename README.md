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

## Warning

⚠️ **This lab is for educational and demo video purposes only. Do not use real tokens or sensitive information.**