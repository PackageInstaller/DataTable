-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/flow/work/display/WorkUIActive.lua

module("logic.extensions.roguelike.flow.work.display.WorkUIActive", package.seeall)

local M = class("WorkUIActive", WorkBase)

function M:onEnter(context)
	GlobalDispatcher:dispatchEvent(EventType.ROGUE_SHOW_MAP_VIEW_ACTIVE, context.isActive)
	settimer(0.5, function()
		self:onDone(WorkResult.Succeed)
	end, self, false)
end

function M:onExit(isInterrupt)
	return
end

return M
