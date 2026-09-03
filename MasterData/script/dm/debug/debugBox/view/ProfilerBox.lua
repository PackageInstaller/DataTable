-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/view/ProfilerBox.lua

StartProfiler = class("StartProfiler", DebugViewTemplate, _M)

function StartProfiler:initialize()
	self._viewConfig = {
		{
			title = "",
			name = "result",
			type = "Label"
		}
	}
end

function StartProfiler:onClick(data)
	local tempSchedule

	tempSchedule = LuaScheduler:getInstance():schedule(function()
		LuaScheduler:getInstance():unschedule(tempSchedule)
		self:dispatch(ShowTipEvent({
			tip = "开始记录分析日志"
		}))
		LuaProfilerUtils.startLuaProfiler()
	end, 3, false)
end

EndProfiler = class("EndProfiler", DebugViewTemplate, _M)

function EndProfiler:initialize()
	self._viewConfig = {
		{
			title = "",
			name = "result",
			type = "Label"
		}
	}
end

function EndProfiler:onClick(data)
	LuaProfilerUtils.stopLuaProfiler({
		key = "TestLuaProfiler"
	})
	self:dispatch(ShowTipEvent({
		tip = "结束分析日志已上传至：http://192.168.1.79/logs/"
	}))
end
