-- chunkname: @modules/logic/rouge/view/RougeRewardNoticeViewContainer.lua

module("modules.logic.rouge.view.RougeRewardNoticeViewContainer", package.seeall)

local RougeRewardNoticeViewContainer = class("RougeRewardNoticeViewContainer", BaseViewContainer)

function RougeRewardNoticeViewContainer:buildViews()
	local views = {}

	table.insert(views, RougeRewardNoticeView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function RougeRewardNoticeViewContainer:buildTabViews(tabContainerId)
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

return RougeRewardNoticeViewContainer
