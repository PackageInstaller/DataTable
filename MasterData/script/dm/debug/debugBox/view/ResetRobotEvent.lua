-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/view/ResetRobotEvent.lua

ResetRobotEvent = class("ResetRobotEvent", DebugViewTemplate, _M)

function ResetRobotEvent:initialize()
	self._opType = 263
	self._viewConfig = {
		{
			title = "重置今日全部挂机事件次数",
			name = "ResetRobotEvent",
			type = "Label"
		}
	}
end

ResetBuildQueueEvent = class("ResetBuildQueueEvent", DebugViewTemplate, _M)

function ResetBuildQueueEvent:initialize()
	self._opType = 132
	self._viewConfig = {
		{
			title = "清除队列",
			name = "ResetBuildQueueEvent",
			type = "Label"
		}
	}
end
