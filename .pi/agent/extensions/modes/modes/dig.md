---
name: DIG
description: Digitoo account context (michalhonc, JIRA_DIGITOO_*, FIGMA_DIGITOO_TOKEN)
default: off
order: 2
group: account
---

Account context for this session (Digitoo):

- GitHub: use the `michalhonc` account.
- Jira: the API token is in the `JIRA_DIGITOO_API_TOKEN` env variable, with the account email in `JIRA_DIGITOO_API_EMAIL`.
- Figma: the token is in the `FIGMA_DIGITOO_TOKEN` env variable.
- Use conventional commits and mention the Jira ticket in the message so it links to Github and Jira
- Always get user confirmation prior git push
- Never add ai agent commit suffix mentioning the model/harness used for this commit (like co-authored by cursor, authored by claude, etc.)
