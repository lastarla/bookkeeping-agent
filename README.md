# bookkeeping-skill

一个面向 OpenClaw / ClawHub 的本地记账 skill。

它本身不负责账单解析和数据库实现，而是依赖本地可用的 `bookkeeping_tool`，帮助用户通过 skill 方式完成导入、查询、汇总和启动本地看板等操作。

## 这个 skill 是做什么的

适合这些场景：

- 导入本地账单文件
- 检查某个文件是否已经导入过
- 查询某段时间的交易
- 汇总某个平台或某个人的收支
- 启动本地收支看板
- 清空数据库后重新导入

## 依赖关系

这个仓库依赖 `bookkeeping_tool` 作为核心能力层。

也就是说：

- `bookkeeping_tool` 负责账单解析、SQLite、CLI、Web 服务
- `bookkeeping-skill` 负责 skill 封装与交互体验

如果本地没有可用的 `bookkeeping_tool`，这个 skill 不能独立完成完整工作流。

## 推荐安装方式

推荐先安装 `bookkeeping_tool`，再安装 skill。

### 第一步：安装 core

发布后可通过包管理安装；在仓库阶段，也可以通过 Git 安装：

```bash
pipx install "git+https://github.com/<org>/bookkeeping_tool.git"
```

安装完成后，先确认：

```bash
bookkeeping --help
```

### 第二步：安装 skill

按你的 OpenClaw / ClawHub 使用方式安装本 skill。

如果后续提供正式安装命令，应以实际发布方式为准。

## 怎么使用

准备好本地账单文件后，可以通过自然语言让 skill 帮你完成操作。

例如：

```text
导入 ~/Downloads/example_alipay_2025.csv
```

```text
查询 2025 年支付宝平台的支出
```

```text
启动收支总览
```

```text
清空数据库，然后重新导入 ~/Downloads/example_wx_2025.xlsx
```

```text
检查 ~/Downloads/example_alipay_2025.csv 是否已经导入过
```

## 文件命名建议

为了让 core 正确提取来源信息，建议账单文件名遵循：

- 第一个片段是 `owner`
- 第二个片段是 `platform`

例如：

- `example_alipay_2025.csv`
- `example_wx_2025.xlsx`

## 当前仓库状态

当前仓库主要用于整理 skill 的定位、文档和后续交付内容。

如果你是最终用户，重点关注：

- 先确保本地 `bookkeeping_tool` 可用
- 再按实际发布方式安装本 skill
- 通过自然语言调用 skill 完成记账任务

如果你是开发者，项目定位和开发约束请查看 `.claude/CLAUDE.md`。
