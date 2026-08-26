-- chunkname: @modules/logic/guide/controller/action/impl/GuideActionEnablePress.lua

module("modules.logic.guide.controller.action.impl.GuideActionEnablePress", package.seeall)

local GuideActionEnablePress = class("GuideActionEnablePress", BaseGuideAction)

function GuideActionEnablePress:ctor(guideId, stepId, actionParam)
	GuideActionEnablePress.super.ctor(self, guideId, stepId, actionParam)

	self._isEnable = actionParam == "1"
end

function GuideActionEnablePress:onStart(context)
	GuideActionEnablePress.super.onStart(self, context)
	GuideViewMgr.instance:enablePress(self._isEnable)
	self:onDone(true)
end

return GuideActionEnablePress
