# 开发说明

## 项目定位
- 这是面向 OpenClaw / ClawHub 的 bookkeeping skill 仓库。
- 本仓库不是账单解析与数据库实现层；核心能力依赖同级或已安装的 `bookkeeping_tool`。
- 面向用户的入口是根目录 `README.md`；开发约束、仓库定位、预期结构写在这里。

## 与 core 仓库的关系
- core 仓库：`bookkeeping_tool`
- 本 skill 仓库应优先复用 `bookkeeping` CLI 或 core 暴露的稳定 service，而不是重写账单解析逻辑。
- 面向用户时要明确说明：skill 依赖本地已可用的 `bookkeeping_tool` 或其 CLI。

## 当前状态
- 当前仓库内容较少，README 已有初版定位说明。
- 后续预期会逐步补充 skill 定义、manifest、脚本与示例。
- 在实际 skill 文件尚未齐全前，README 应避免写成过度承诺的发布文档。

## 预期关键文件
后续通常会逐步补充：
- `SKILL.md`
- `manifest.json`
- `scripts/`
- `docs/`
- `examples/`

如果这些文件尚未存在，不要在 README 中写得像已经全部交付完成。

## README 边界
- `README.md` 面向用户：skill 是什么、依赖什么、怎么安装、怎么使用。
- 仓库结构建议、开发计划、脚本约定、待办清单不要堆在 README 首页，优先写到这里或单独开发文档。

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

## 文档维护规则
- 不要把 README 写成双仓方案讨论文档。
- 不要在 README 首页保留“待补”“建议目录结构”“以后再做”的占位内容。
- README 中的安装方式必须和当前真实交付状态一致。
- 如果 skill 还没发布到可安装渠道，应明确标注“当前仍在整理/开发中”或使用保守描述。
