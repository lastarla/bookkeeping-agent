# 开发说明

## 项目定位
- 这是面向 OpenClaw / ClawHub 的 bookkeeping agent 仓库。
- 本仓库不是账单解析、数据库、Web API 或 dashboard 的实现层；这些能力属于 core 仓库 `bookkeeping-tool`。
- 本仓库负责交付 skill 本身及其平台适配层，例如：`SKILL.md`、`README.md`、`references/`。
- 面向用户的入口是根目录 `README.md`；这里主要记录长期稳定的开发约束与仓库边界。

## 与 core 仓库的关系
- core 仓库：`bookkeeping-tool`
- 本 skill 的执行后端是本地 `bookkeeping` CLI。
- 本仓库不直接 import `bookkeeping_tool` 内部 Python 模块。
- 本仓库不以本地 service / Web API 作为主通道。
- 面向用户时要明确说明：本 skill 依赖本地已可用的 `bookkeeping` 命令。

## 自动触发行为约束
- 本 skill 基于 OpenClaw 的自动触发设计，不以显式点名调用为默认交互模式。
- 自动触发应同时考虑文本、附件和上下文，而不是只看单条命令式表达。
- 通用 CSV / Excel / 表格处理任务不应误触 bookkeeping agent。
- 多附件场景默认不静默批量处理，应先确认目标文件或处理范围。
- `reset` / 清空数据库类动作必须强确认，不能自动执行。
- `serve` / 启动本地 dashboard 不应在隐式触发场景下静默执行。
- 输入不清晰时，优先做最小澄清，不要强行猜测并执行写操作。

## 实现约束
- 不要在本仓库重写账单解析、字段映射、数据库读写、汇总逻辑。
- 不要让脚本直接依赖 core 的内部模块路径。
- 优先把复杂度放在 core CLI，skill 只做意图识别、编排、提示和平台适配。
- 如果需要新增 skill 能力，优先检查 core CLI 是否已有稳定命令；没有的话，先补 core，再补 skill。
- 对机器可读结果的依赖优先走 `--json`；stdout JSON 视为 skill 的主要机器可读协议。

## 文档分工
- `README.md`：面向用户，说明 skill 是什么、依赖什么、怎么安装、会在什么场景自动接手。
- `SKILL.md`：定义平台侧的触发规则、输入类型、行为边界、确认与澄清策略。
- `plan/bookkeeping_skill_plan.md`：记录完整开发规划、设计方案、待决策项与验证口径。
- `.claude/CLAUDE.md`：只记录长期稳定的开发约束，不写阶段性开发计划。

## 文档维护规则
- 不要把 README 写成双仓方案讨论文档。
- 不要在 README 首页保留“待补”“建议目录结构”“以后再做”的占位内容。
- README 中的安装方式必须和当前真实交付状态一致。
- 如果 skill 还没发布到可安装渠道，应明确标注“当前仍在整理/开发中”。
- 若某项内容属于阶段性计划、待办、future 或方案推演，应写入 `plan/*.md`，不要写进这里。

## 提交与忽略
不要提交：
- `.venv/`
- `.env`
- `.env.*`
- `dist/`
- `build/`
- `__pycache__/`
- `*.pyc`
- 本地日志
- IDE 配置
