--[[
-- Logger系统：Lua中所有错误日志输出均使用本脚本接口，以便上报服务器
--]]

local Logger = BaseClass("Logger")

local function Log(msg)
	if not GameHelper.IsDebugBuild() then 
		return 
	end
	CS.Debuger.Log(debug.traceback(msg, 2))
end

local function LogError(msg)
	if not GameHelper.IsDebugBuild() then 
		return 
	end
	CS.Debuger.LogError(debug.traceback(msg, 2))
end

local function LogWarning(msg)
	if not GameHelper.IsDebugBuild() then 
		return 
	end
	CS.Debuger.LogWarning(debug.traceback(msg, 2))
end

-- 重定向event错误处理函数
event_err_handle = function(msg)
	LogError(msg)
end

Logger.Log = Log
Logger.LogError = LogError
Logger.LogWarning = LogWarning

return Logger