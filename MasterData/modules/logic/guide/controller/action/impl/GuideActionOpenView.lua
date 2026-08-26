-- chunkname: @modules/logic/guide/controller/action/impl/GuideActionOpenView.lua

module("modules.logic.guide.controller.action.impl.GuideActionOpenView", package.seeall)

local GuideActionOpenView = class("GuideActionOpenView", BaseGuideAction)

function GuideActionOpenView:onStart(context)
	GuideActionOpenView.super.onStart(self, context)

	local temp = string.split(self.actionParam, "#")
	local viewName = temp[1]
	local p = {}

	p.openFromGuide = true
	p.guideId = self.guideId
	p.stepId = self.stepId
	p.viewParam = not string.nilorempty(temp[2]) and cjson.decode(temp[2]) or nil

	ViewMgr.instance:openView(viewName, p, true)
	self:onDone(true)
end

return GuideActionOpenView
