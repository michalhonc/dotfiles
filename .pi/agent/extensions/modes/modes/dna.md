---
name: DNA
description: DNAnexus account context (m-honc, JIRA_API_TOKEN, FIGMA_TOKEN)
default: on
order: 1
group: account
---

Account context for this session (DNAnexus):

- GitHub: use the `m-honc` account.
- Jira: the API token is in the `JIRA_API_TOKEN` env variable.
- Figma: the token is in the `FIGMA_TOKEN` env variable.
- Use commit messages in form `[JIRA_TICKET] brief message in plain english`
- Always get user confirmation prior git push
- Never add ai agent commit suffix mentioning the model/harness used for this commit (like co-authored by cursor, authored by claude, etc.)
