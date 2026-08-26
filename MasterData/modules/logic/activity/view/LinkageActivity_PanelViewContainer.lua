-- chunkname: @modules/logic/activity/view/LinkageActivity_PanelViewContainer.lua

module("modules.logic.activity.view.LinkageActivity_PanelViewContainer", package.seeall)

local LinkageActivity_PanelViewContainer = class("LinkageActivity_PanelViewContainer", LinkageActivity_BaseViewContainer)

function LinkageActivity_PanelViewContainer:buildViews()
	local views = {}

	self._view = LinkageActivity_PanelView.New()

	table.insert(views, self._view)

	return views
end

function LinkageActivity_PanelViewContainer:view()
	return self._view
end

return LinkageActivity_PanelViewContainer
