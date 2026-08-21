-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/controller/action/GuideActionSwipeTo.lua

module("logic.extensions.guide.controller.action.GuideActionSwipeTo", package.seeall)

local GuideActionSwipeTo = class("GuideActionSwipeTo", BaseGuideAction)

function GuideActionSwipeTo:ctor(guideId, stepId, guideStepCO)
	GuideActionSwipeTo.super.ctor(self, guideId, stepId, guideStepCO)
end

function GuideActionSwipeTo:onEnter(context)
	GuideActionSwipeTo.super.onEnter(self, context)
	GlobalDispatcher:addEventListener(EventType.SWIPE_FINISH_EVENT, self._onOperationEnd, self)
	GuideController.instance:openGuideView(self.guideStepCO)
end

function GuideActionSwipeTo:onExit()
	GuideActionSwipeTo.super.onExit(self)
	BattleDispatcher:removeEventListener(EventType.SWIPE_FINISH_EVENT, self._onOperationEnd, self)
end

function GuideActionSwipeTo:_onOperationEnd()
	self:onDone(WorkResult.Succeed)
end

return GuideActionSwipeTo
