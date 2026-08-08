--- AI 模块常量（与具体战斗框架无关的部分）
local AIConst = {}

--- 默认 AI 脚本逻辑名
AIConst.DEFAULT_AI = "AI_Default"

--- AI 本地日志总开关（落盘 AutoChessAI_Logs + AILog 调试输出；排查时改回 true）
AIConst.ENABLE_AI_LOG = true

--- 实体 cache 键（挂在 AutoChessEntity 上，跨帧保持决策状态）
--- 正在对齐格心，防止重复 AlignToGridCenter
AIConst.CACHE_GRID_ALIGNING = "ai_grid_aligning"
--- 本回合决策锁定的目标 uid
AIConst.CACHE_LOCKED_TARGET = "ai_locked_target"
--- 上一决策格的 X（折返惩罚用）
AIConst.CACHE_LAST_GRID_X = "ai_last_grid_x"
--- 上一决策格的 Y（折返惩罚用）
AIConst.CACHE_LAST_GRID_Y = "ai_last_grid_y"
--- 决策冷却截止时间（Time.time）
AIConst.CACHE_DECISION_COOLDOWN = "ai_decision_cooldown"
--- 真堵死标记（八邻格均无法落脚）
AIConst.CACHE_MOVEMENT_SEALED = "ai_movement_sealed"

return AIConst
