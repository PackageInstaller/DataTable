-- chunkname: @modules/logic/guide/controller/action/impl/GuideActionEnableClick.lua

module("modules.logic.guide.controller.action.impl.GuideActionEnableClick", package.seeall)

local GuideActionEnableClick = class("GuideActionEnableClick", BaseGuideAction)

function GuideActionEnableClick:ctor(guideId, stepId, actionParam)
	GuideActionEnableClick.super.ctor(self, guideId, stepId, actionParam)

	self._isEnable = actionParam == "1"
end

function GuideActionEnableClick:onStart(context)
	GuideActionEnableClick.super.onStart(self, context)
	GuideViewMgr.instance:enableClick(self._isEnable)
	self:onDone(true)
end

return GuideActionEnableClick
