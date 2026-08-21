--[[
-- added by wsh @ 2017-11-30
-- Logger系统：Lua中所有错误日志输出均使用本脚本接口，以便上报服务器
--]]
---@type Logger
local Logger = BaseClass("Logger")

-- 正式包就没有日志了
local function Log(msg)
	if Config.LuaLoggerOn then
		print(debug.traceback(msg, 2))
	end

	-- if not Authority:GetLogAuth() then
	-- 	return
	-- end
	-- if Config.Debug then
	-- 	print(debug.traceback(msg, 2))
	-- else
	-- 	CS.Logger.Log(debug.traceback(msg, 2))
	-- end
	-- CS.Logger.Log(debug.traceback(msg, 2))
end

-- 正式包就没有日志了
local function LogError(msg)
	-- error(debug.traceback(msg, 2), 2)
	CS.Logger.LogError(debug.traceback(msg, 2))
	-- if not Authority:GetLogAuth() then
	-- 	return
	-- end
	-- if Config.Debug then
	-- 	error(msg, 2)
	-- else
	-- 	CS.Logger.LogError(debug.traceback(msg, 2))
	-- end
	-- CS.Logger.LogError(debug.traceback(msg, 2))
end

local function BattleLog(msg)
	if Config.BattleLogOn and UNITY_EDITOR then
		Log(msg)
	end
end

-- 正式包可以查看，需要权限
local function AuthLog(msg)
	if not Authority:GetLogAuth() then
		return
	end
	print(debug.traceback(msg, 2))
end

-- 重定向event错误处理函数
event_err_handle = function(msg)
	LogError(msg)
end

Logger.Log = Log
Logger.AuthLog = AuthLog
Logger.BattleLog = BattleLog
Logger.LogError = LogError
---@return Logger
return Logger