-- chunkname: @modules/logic/guide/controller/action/impl/WaitGuideActionEntityDeadPause.lua

module("modules.logic.guide.controller.action.impl.WaitGuideActionEntityDeadPause", package.seeall)

local WaitGuideActionEntityDeadPause = class("WaitGuideActionEntityDeadPause", BaseGuideAction)

function WaitGuideActionEntityDeadPause:onStart(context)
	WaitGuideActionEntityDeadPause.super.onStart(self, context)
	FightController.instance:registerCallback(FightEvent.OnGuideEntityDeadPause, self._onGuideEntityDeadPause, self)

	self._side = tonumber(self.actionParam)
end

function WaitGuideActionEntityDeadPause:_onGuideEntityDeadPause(guideParam, deadParam)
	local isRightSide = deadParam.side == self._side

	if isRightSide then
		guideParam.OnGuideEntityDeadPause = true

		FightController.instance:unregisterCallback(FightEvent.OnGuideEntityDeadPause, self._onGuideEntityDeadPause, self)
		self:onDone(true)
	end
end

function WaitGuideActionEntityDeadPause:clearWork()
	FightController.instance:unregisterCallback(FightEvent.OnGuideEntityDeadPause, self._onGuideEntityDeadPause, self)
end

return WaitGuideActionEntityDeadPause
