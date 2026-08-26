-- chunkname: @modules/logic/rouge/view/RougeRewardViewContainer.lua

module("modules.logic.rouge.view.RougeRewardViewContainer", package.seeall)

local RougeRewardViewContainer = class("RougeRewardViewContainer", BaseViewContainer)

function RougeRewardViewContainer:buildViews()
	local views = {}

	table.insert(views, RougeRewardView.New())
	table.insert(views, TabViewGroup.New(1, "#go_LeftTop"))

	return views
end

function RougeRewardViewContainer:buildTabViews(tabContainerId)
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

return RougeRewardViewContainer
