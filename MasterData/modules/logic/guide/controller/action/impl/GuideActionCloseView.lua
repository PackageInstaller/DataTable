-- chunkname: @modules/logic/guide/controller/action/impl/GuideActionCloseView.lua

module("modules.logic.guide.controller.action.impl.GuideActionCloseView", package.seeall)

local GuideActionCloseView = class("GuideActionCloseView", BaseGuideAction)

function GuideActionCloseView:onStart(context)
	GuideActionCloseView.super.onStart(self, context)

	if string.nilorempty(self.actionParam) then
		ViewMgr.instance:closeAllModalViews()
	else
		local viewNames = string.split(self.actionParam, "#")

		for _, viewName in ipairs(viewNames) do
			ViewMgr.instance:closeView(viewName, true)
		end
	end

	self:onDone(true)
end

return GuideActionCloseView
