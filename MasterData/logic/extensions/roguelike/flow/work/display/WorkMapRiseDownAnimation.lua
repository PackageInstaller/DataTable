-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/flow/work/display/WorkMapRiseDownAnimation.lua

module("logic.extensions.roguelike.flow.work.display.WorkMapRiseDownAnimation", package.seeall)

local M = class("WorkMapRiseDownAnimation", WorkBase)

function M:onEnter(context)
	local mapMgr = RogueMgr.instance:getMapMgr()

	if mapMgr then
		mapMgr:showMapAnimation(context.isDown, function()
			self:onDone(WorkResult.Succeed)
		end, context.isInSecondRoom)
	else
		settimer(0.8, self._delayFinish, self, false)
	end
end

function M:_delayFinish()
	self:onDone(WorkResult.Succeed)
end

function M:onExit(isInterrupt)
	removetimer(self._delayFinish, self)
end

return M
