-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/controller/action/GuideActionClickAnyWithPassEvent.lua

module("logic.extensions.guide.controller.action.GuideActionClickAnyWithPassEvent", package.seeall)

local GuideActionClickAnyWithPassEvent = class("GuideActionClickAnyWithPassEvent", BaseGuideAction)

function GuideActionClickAnyWithPassEvent:ctor(guideId, stepId, guideStepCO)
	GuideActionClickAnyWithPassEvent.super.ctor(self, guideId, stepId, guideStepCO)
end

function GuideActionClickAnyWithPassEvent:onEnter(context)
	GuideActionClickAnyWithPassEvent.super.onEnter(self, context)
	GlobalDispatcher:addEventListener(EventType.TRIGGER_NEXT_STEP, self._onTriggerNextStep, self)
	GuideController.instance:openGuideView(self.guideStepCO, self._onClickTarget, self)
end

function GuideActionClickAnyWithPassEvent:onExit()
	GuideActionClickAnyWithPassEvent.super.onExit(self)
	removetimer(self._onDelayDone, self)
	GlobalDispatcher:removeEventListener(EventType.TRIGGER_NEXT_STEP, self._onTriggerNextStep, self)
end

function GuideActionClickAnyWithPassEvent:_onClickTarget()
	settimer(0.01, self._onDelayDone, self, false)
end

function GuideActionClickAnyWithPassEvent:_onTriggerNextStep()
	self:_onDelayDone()
end

function GuideActionClickAnyWithPassEvent:_onDelayDone()
	self:onDone(WorkResult.Succeed)
	GlobalDispatcher:dispatchEvent(EventType.FINISH_GUIDE_STEP)
end

return GuideActionClickAnyWithPassEvent
