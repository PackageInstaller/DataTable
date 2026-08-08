---幸存者玩法内日志开关：直接读写 LuaLogger.Enabled，退出玩法时还原进入前的值
---@class SurvivalLog
local SurvivalLog = {}

---进入幸存者玩法前 LuaLogger.Enabled 的快照
SurvivalLog._savedEnabled = nil

---进入幸存者玩法时调用，保存当前日志开关并默认关闭
function SurvivalLog.Enter()
	if SurvivalLog._savedEnabled == nil then
		SurvivalLog._savedEnabled = LuaLogger.Enabled
		LuaLogger.Enabled = false
	end
end

---退出幸存者玩法时调用，还原进入前的日志开关
function SurvivalLog.Restore()
	if SurvivalLog._savedEnabled ~= nil then
		LuaLogger.Enabled = SurvivalLog._savedEnabled
		SurvivalLog._savedEnabled = nil
	end
end

---设置幸存者玩法内日志开关（UI 切换用）
---@param enabled boolean
function SurvivalLog.SetEnabled(enabled)
	LuaLogger.Enabled = enabled == true
end

---@return boolean
function SurvivalLog.IsEnabled()
	return LuaLogger.Enabled
end

return SurvivalLog
