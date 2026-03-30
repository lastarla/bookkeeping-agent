---
name: bookkeeping
description: 导入账单、检查重复、查询交易、查看汇总，并通过本地 bookkeeping CLI 执行。
metadata: {"openclaw":{"homepage":"https://github.com/lastarla/bookkeeping-skill","requires":{"bins":["bookkeeping"]},"install":[{"id":"brew","kind":"brew","formula":"lastarla/tap/bookkeeping-tool","bins":["bookkeeping"],"label":"Install bookkeeping (Homebrew, macOS)"},{"id":"pipx","kind":"pipx","package":"git+https://github.com/lastarla/bookkeeping-tool.git","bins":["bookkeeping"],"label":"Install bookkeeping (pipx from GitHub)"}]}}
---

# Bookkeeping

Use this skill only when `bookkeeping` is already available on `PATH`.

## Use this skill when

- You want to import a bill attachment or a local bill file
- You want to check whether a bill file was already imported
- You want to query transactions by time range, platform, direction, or category
- You want to view overview, trend, or category summaries
- You want to record a single expense or income from natural language
- You want to set or update a day/month/year expense budget
- You explicitly want to start the local bookkeeping dashboard
- You explicitly want to reset the database

Attachment prerequisite:

- If the user provides a message attachment rather than an already-local file, first obtain a local file path from the OpenClaw attachment download flow, then pass that local path into the bookkeeping CLI

Common high-confidence signals:

- File extension is `.csv` or `.xlsx`
- Filename includes `alipay`, `wx`, `wechat`, `bill`, `账单`, `交易`, or `流水`
- The user mentions `账单`, `流水`, `导入`, `支出`, `收入`, `支付宝`, or `微信`
- The user provides a short natural-language bookkeeping message such as `吃午饭微信20` or `支付宝到账100`
- The user explicitly asks to set, update, or check a day/month/year budget

## Do not use this skill when

- The task is generic Excel or CSV cleanup
- The task is about empty values, duplicate rows, or headers only
- The task is unrelated business analysis such as sales or inventory reports
- The input is an image, PDF, or archive that is outside the current supported scope

## Behavior rules

### Execute directly

Under high confidence, these lower-risk actions can be executed directly:

- Query transactions
- Run `summary overview`, `summary trend`, or `summary category`
- Inspect import batches
- Inspect duplicate imports
- Record a single income or expense when amount, direction, and platform can be inferred with high confidence
- Set or check budgets

### Clarify or confirm first

Ask the minimum follow-up question first when:

- There is a single bill attachment but the request is vague, such as “处理一下”
- The user wants to import, but there are multiple likely bill attachments
- The user asks whether “this file” was imported, but the reference is unclear
- The user wants to start the dashboard, but has not clearly said to start the local service now

### Require strong confirmation

Never do these silently:

- `bookkeeping reset --yes`
- Resetting the database and then re-importing
- Batch processing multiple attachments

## Multiple attachment rules

- If there is exactly one high-confidence bill attachment, continue with that file
- If there are multiple high-confidence bill attachments, list the candidates and ask the user to confirm the scope
- Do not silently import all attachments by default
- In mixed-attachment scenarios, only include high-confidence bill candidates and explain what was excluded

## CLI mapping

Use the local `bookkeeping` CLI as the execution backend.

Attachment handling rule before CLI execution:

- If the user provides a local file path directly, use that file path
- If the user provides a message attachment, first download it through the OpenClaw attachment download flow and use the returned `download.local_path` as `<file>`
- Do not assume the bookkeeping CLI can read remote message attachments directly

CLI mapping:

- Import: `bookkeeping import <file> --json`
- Query: `bookkeeping query --json`
- Overview summary: `bookkeeping summary overview --json`
- Trend summary: `bookkeeping summary trend --json`
- Category summary: `bookkeeping summary category --json`
- Record expense: `bookkeeping record expense --payload <json> --json`
- Record income: `bookkeeping record income --payload <json> --json`
- Set budget: `bookkeeping budget set --scope <scope> --period <period> --amount <amount> --json`
- Check budget: `bookkeeping budget check --scope <scope> --trade-date <date> --json`
- Batch inspection: `bookkeeping inspect batches --json`
- Duplicate inspection: `bookkeeping inspect duplicates --json`
- Dashboard: `bookkeeping serve`
- Reset: `bookkeeping reset --yes`

Prefer `--json` output whenever it is available.

## Category policy for natural-language bookkeeping

When recording a single income or expense from natural language:

- Let the model infer the category, but it must map into a fixed category set
- Do not ask the user to choose a category during the normal happy path
- Do not invent free-form categories outside the fixed set
- If confidence is low, fall back to `其他支出` or `其他收入`

Fixed expense categories:

- `餐饮`
- `交通`
- `日用`
- `购物`
- `娱乐`
- `医疗`
- `住房`
- `教育`
- `其他支出`

Fixed income categories:

- `工资`
- `报销`
- `转账`
- `退款`
- `理财`
- `其他收入`

## Reminder protocol

When the CLI returns bookkeeping results:

- Read `budget_checks` as the full per-scope budget state
- Read `reminders` as the message-ready reminder list for OpenClaw or IM channels
- Each reminder item may include:
  - `type`
  - `scope`
  - `scope_label`
  - `status`
  - `severity`
  - `period_key`
  - `budget_amount`
  - `current_expense`
  - `usage_ratio`
  - `currency`
  - `message`
  - `channel_text`
- Prefer `channel_text` when sending a concise chat message to Feishu, WeChat, or similar IM channels
- If `reminders` is empty, do not create a budget warning message
- If `status` is `unset`, you may gently suggest that the user set a budget
- If `status` is `warning` or `exceeded`, surface the reminder clearly in the reply

## Response rules

- First state the recognized intent
- Then either state the next action or ask the smallest necessary question
- Avoid exposing raw CLI details unless the user is debugging setup issues
- If `bookkeeping` is missing, clearly say that this skill depends on the local CLI
- For installation guidance, treat Homebrew as a macOS path and suggest `pipx install "git+https://github.com/lastarla/bookkeeping-tool.git"` as the cross-platform default
- If the database is empty, ask the user to import bills before running query or summary tasks
- If the user provided an attachment and no local file path exists yet, first obtain `download.local_path` from the attachment download flow before calling the CLI
- If the attachment type is unsupported, say that the skill currently supports only `.csv` and `.xlsx`
- For single-entry bookkeeping, summarize the final structured fields briefly: direction, amount, platform, category, and date
- If there are reminders, append a short budget summary after the bookkeeping result
