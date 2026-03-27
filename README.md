# Bookkeeping

一个本地记账 skill：导入账单、查重、查询交易、查看汇总，并可启动本地看板。

- 依赖：本地已可用的 `bookkeeping` CLI
- 适用：`.csv` / `.xlsx` 账单文件
- 默认交互：通常会自动识别合适的记账场景；在多附件或意图不清时会先澄清

## 你可以用它做什么

- 导入账单附件或本地账单文件
- 检查某个文件是否已导入（查重）
- 查询某段时间的交易
- 查看概览、趋势、分类汇总
- 用自然语言记录单笔支出或收入
- 设置、修改、检查日 / 月 / 年预算
- 启动本地收支看板
- 清空数据库（需要强确认）

## 安装

### 1) 安装 `bookkeeping` CLI（必需）

macOS 推荐使用 Homebrew：

```bash
brew install lastarla/tap/bookkeeping-tool
```

这里安装的是本地 `bookkeeping` CLI；本仓库提供的是 skill 本体，需放入 OpenClaw 的 skills 目录中使用。

当前使用方式是将本仓库放入 skills 目录后重新开启会话加载，并非通过独立包管理器单独安装 skill。

验证：

```bash
bookkeeping --help
```

### 2) 安装 skill

将本仓库放到 OpenClaw 可发现的 skills 目录中：

```text
<workspace>/skills/bookkeeping-agent/
```

或：

```text
~/.openclaw/skills/bookkeeping-agent/
```

然后启动新的 OpenClaw 会话，让 skill 被重新加载。

## 发布到 ClawHub

如果发布时上传内容只能包含 `SKILL.md` 和 `references/`，不要直接上传仓库根目录。

先执行：

```bash
bash scripts/prepare-clawhub-release.sh
```

执行后会生成可上传目录：

```text
release/
```

该目录下只包含：

- `SKILL.md`
- `references/`

上传这个目录即可。

## 快速开始

上传一个 `.csv` / `.xlsx` 账单文件，然后说：

```text
帮我导入这个账单
```

或者直接问：

```text
看一下 2025 年 3 月支付宝支出概览
```

也支持自然语言单笔记账，例如：

```text
吃午饭微信20
```

```text
支付宝到账100
```

也支持预算设置与提醒，例如：

```text
帮我设置这个月支出预算 1000
```

记账命令执行后，如果 CLI 返回 `reminders`，skill 会优先把其中的预算提醒转成聊天消息，便于后续接飞书、微信等 IM 场景。

## 行为边界（重要）

- 不会把通用 Excel/CSV 清洗任务吸收进来
- 多附件场景不会静默批量导入，通常会先让你确认范围
- `reset` / 清空数据库类动作必须强确认
- 不会在运行时下载或安装任何外部可执行程序

## 参考

- 入口： [SKILL.md](SKILL.md)
- 安装： [references/install.md](references/install.md)
- 示例： [references/quickstart.md](references/quickstart.md)
- 排障： [references/troubleshooting.md](references/troubleshooting.md)
