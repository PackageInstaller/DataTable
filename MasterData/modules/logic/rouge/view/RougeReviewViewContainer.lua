-- chunkname: @modules/logic/rouge/view/RougeReviewViewContainer.lua

module("modules.logic.rouge.view.RougeReviewViewContainer", package.seeall)

local RougeReviewViewContainer = class("RougeReviewViewContainer", BaseViewContainer)

function RougeReviewViewContainer:buildViews()
	local views = {}

	table.insert(views, RougeReviewView.New())
	table.insert(views, RougeScrollAudioView.New("#scroll_view"))
	table.insert(views, TabViewGroup.New(1, "#go_LeftTop"))

	return views
end

function RougeReviewViewContainer:buildTabViews(tabContainerId)
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

return RougeReviewViewContainer
