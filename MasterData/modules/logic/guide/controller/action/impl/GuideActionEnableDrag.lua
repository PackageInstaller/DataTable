-- chunkname: @modules/logic/guide/controller/action/impl/GuideActionEnableDrag.lua

module("modules.logic.guide.controller.action.impl.GuideActionEnableDrag", package.seeall)

local GuideActionEnableDrag = class("GuideActionEnableDrag", BaseGuideAction)

function GuideActionEnableDrag:ctor(guideId, stepId, actionParam)
	GuideActionEnableDrag.super.ctor(self, guideId, stepId, actionParam)

	self._isEnable = actionParam == "1"
end

function GuideActionEnableDrag:onStart(context)
	GuideActionEnableDrag.super.onStart(self, context)
	GuideViewMgr.instance:enableDrag(self._isEnable)
	self:onDone(true)
end

return GuideActionEnableDrag
