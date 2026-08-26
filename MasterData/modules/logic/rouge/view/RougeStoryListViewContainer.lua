-- chunkname: @modules/logic/rouge/view/RougeStoryListViewContainer.lua

module("modules.logic.rouge.view.RougeStoryListViewContainer", package.seeall)

local RougeStoryListViewContainer = class("RougeStoryListViewContainer", BaseViewContainer)

function RougeStoryListViewContainer:buildViews()
	local views = {}

	table.insert(views, RougeStoryListView.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))

	return views
end

function RougeStoryListViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			self.navigateView
		}
	end
end

return RougeStoryListViewContainer
