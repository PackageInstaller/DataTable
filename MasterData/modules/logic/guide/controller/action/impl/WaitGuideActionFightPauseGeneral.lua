-- chunkname: @modules/logic/guide/controller/action/impl/WaitGuideActionFightPauseGeneral.lua

module("modules.logic.guide.controller.action.impl.WaitGuideActionFightPauseGeneral", package.seeall)

local WaitGuideActionFightPauseGeneral = class("WaitGuideActionFightPauseGeneral", BaseGuideAction)

function WaitGuideActionFightPauseGeneral:onStart(context)
	WaitGuideActionFightPauseGeneral.super.onStart(self, context)

	local arr = string.split(self.actionParam, "#")

	self._pauseName = arr[1]
	self._pauseEvent = FightEvent[arr[1]]

	FightController.instance:registerCallback(self._pauseEvent, self._triggerFightPause, self)
end

function WaitGuideActionFightPauseGeneral:_triggerFightPause(guideParam)
	guideParam[self._pauseName] = true

	FightController.instance:unregisterCallback(self._pauseEvent, self._triggerFightPause, self)
	self:onDone(true)
end

function WaitGuideActionFightPauseGeneral:clearWork()
	FightController.instance:unregisterCallback(self._pauseEvent, self._triggerFightPause, self)
end

return WaitGuideActionFightPauseGeneral
