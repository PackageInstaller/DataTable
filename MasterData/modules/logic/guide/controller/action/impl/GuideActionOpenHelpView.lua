-- chunkname: @modules/logic/guide/controller/action/impl/GuideActionOpenHelpView.lua

module("modules.logic.guide.controller.action.impl.GuideActionOpenHelpView", package.seeall)

local GuideActionOpenHelpView = class("GuideActionOpenHelpView", BaseGuideAction)

function GuideActionOpenHelpView:onStart(context)
	GuideActionOpenHelpView.super.onStart(self, context)

	local p = {}

	p.openFromGuide = true
	p.guideId = self.guideId
	p.stepId = self.stepId
	p.viewParam = tonumber(self.actionParam)
	p.matchAllPage = true

	ViewMgr.instance:openView(ViewName.HelpView, p)
	self:onDone(true)
end

return GuideActionOpenHelpView
