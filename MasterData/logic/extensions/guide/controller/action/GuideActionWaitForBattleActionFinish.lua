-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/controller/action/GuideActionWaitForBattleActionFinish.lua

module("logic.extensions.guide.controller.action.GuideActionWaitForBattleActionFinish", package.seeall)

local M = class("GuideActionWaitForBattleActionFinish", BaseGuideAction)

function M:ctor(guideId, stepId, guideStepCO)
	M.super.ctor(self, guideId, stepId, guideStepCO)
end

function M:onEnter(context)
	if ViewMgr.instance:isOpen(ViewName.GuideView) then
		ViewMgr.instance:close(ViewName.GuideView)
	end

	if ViewMgr.instance:isOpen(ViewName.ImageGuide) then
		ViewMgr.instance:close(ViewName.ImageGuide)
	end

	ViewBlockMgr.instance:blockClick(true, ViewBlockKey.Guide)
	BattleDispatcher:addEventListener(BattleEventType.OnEntitySteppedFinish, self._OnEntitySteppedFinish, self)
	M.super.onEnter(self, context)
end

function M:onExit()
	BattleDispatcher:removeEventListener(BattleEventType.OnEntitySteppedFinish, self._OnEntitySteppedFinish, self)
	M.super.onExit(self)
end

function M:_OnEntitySteppedFinish(key)
	self:_delayCheckCamera()
end

function M:_delayCheckCamera()
	removetimer(self._delayCheckCamera, self)
	ViewBlockMgr.instance:blockClick(false, ViewBlockKey.Guide)
	self:onDone(WorkResult.Succeed)
end

return M
