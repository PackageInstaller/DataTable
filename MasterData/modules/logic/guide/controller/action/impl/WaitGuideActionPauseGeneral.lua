-- chunkname: @modules/logic/guide/controller/action/impl/WaitGuideActionPauseGeneral.lua

module("modules.logic.guide.controller.action.impl.WaitGuideActionPauseGeneral", package.seeall)

local WaitGuideActionPauseGeneral = class("WaitGuideActionPauseGeneral", BaseGuideAction)

function WaitGuideActionPauseGeneral:onStart(context)
	WaitGuideActionPauseGeneral.super.onStart(self, context)

	local arr = string.split(self.actionParam, "#")
	local arg = arr[1]

	self._pauseName = arg
	self._pauseEvent = GuideEvent[arg]

	GuideController.instance:registerCallback(self._pauseEvent, self._triggerPause, self)
end

function WaitGuideActionPauseGeneral:_triggerPause(guideParam)
	guideParam[self._pauseName] = true

	GuideController.instance:unregisterCallback(self._pauseEvent, self._triggerPause, self)
	self:onDone(true)
end

function WaitGuideActionPauseGeneral:clearWork()
	GuideController.instance:unregisterCallback(self._pauseEvent, self._triggerPause, self)
end

return WaitGuideActionPauseGeneral
