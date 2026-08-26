-- chunkname: @modules/logic/rouge/view/RougeIllustrationDetailViewContainer.lua

module("modules.logic.rouge.view.RougeIllustrationDetailViewContainer", package.seeall)

local RougeIllustrationDetailViewContainer = class("RougeIllustrationDetailViewContainer", BaseViewContainer)

function RougeIllustrationDetailViewContainer:buildViews()
	local views = {}

	table.insert(views, RougeIllustrationDetailView.New())
	table.insert(views, TabViewGroup.New(1, "#go_LeftTop"))

	return views
end

function RougeIllustrationDetailViewContainer:buildTabViews(tabContainerId)
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

return RougeIllustrationDetailViewContainer
