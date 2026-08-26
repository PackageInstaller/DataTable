-- chunkname: @modules/logic/versionactivity2_5/challenge/view/repress/Act183RepressViewContainer.lua

module("modules.logic.versionactivity2_5.challenge.view.repress.Act183RepressViewContainer", package.seeall)

local Act183RepressViewContainer = class("Act183RepressViewContainer", BaseViewContainer)

function Act183RepressViewContainer:buildViews()
	local views = {}

	table.insert(views, Act183RepressView.New())

	self.helpView = HelpShowView.New()

	self.helpView:setHelpId(HelpEnum.HelpId.Act183Repress)
	table.insert(views, self.helpView)

	return views
end

return Act183RepressViewContainer
