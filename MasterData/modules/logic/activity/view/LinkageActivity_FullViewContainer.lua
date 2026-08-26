-- chunkname: @modules/logic/activity/view/LinkageActivity_FullViewContainer.lua

module("modules.logic.activity.view.LinkageActivity_FullViewContainer", package.seeall)

local LinkageActivity_FullViewContainer = class("LinkageActivity_FullViewContainer", LinkageActivity_BaseViewContainer)

function LinkageActivity_FullViewContainer:buildViews()
	local views = {}

	self._view = LinkageActivity_FullView.New()

	table.insert(views, self._view)

	return views
end

function LinkageActivity_FullViewContainer:view()
	return self._view
end

return LinkageActivity_FullViewContainer
