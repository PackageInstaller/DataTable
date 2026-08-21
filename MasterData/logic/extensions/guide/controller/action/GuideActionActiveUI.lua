-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/controller/action/GuideActionActiveUI.lua

module("logic.extensions.guide.controller.action.GuideActionActiveUI", package.seeall)

local GuideActionActiveUI = class("GuideActionActiveUI", BaseGuideAction)

function GuideActionActiveUI:ctor(guideId, stepId, guideStepCO)
	GuideActionActiveUI.super.ctor(self, guideId, stepId, guideStepCO)
end

function GuideActionActiveUI:onEnter(context)
	GuideActionActiveUI.super.onEnter(self, context)
	GlobalDispatcher:addEventListener(EventType.TRIGGER_NEXT_STEP, self._onTriggerNextStep, self)
	GuideController.instance:openGuideView(self.guideStepCO)
end

function GuideActionActiveUI:onExit()
	GuideActionActiveUI.super.onExit(self)
	GlobalDispatcher:removeEventListener(EventType.TRIGGER_NEXT_STEP, self._onTriggerNextStep, self)
end

function GuideActionActiveUI:_onTriggerNextStep()
	self:onDone(WorkResult.Succeed)
end

return GuideActionActiveUI
