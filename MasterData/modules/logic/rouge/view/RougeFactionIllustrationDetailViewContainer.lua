-- chunkname: @modules/logic/rouge/view/RougeFactionIllustrationDetailViewContainer.lua

module("modules.logic.rouge.view.RougeFactionIllustrationDetailViewContainer", package.seeall)

local RougeFactionIllustrationDetailViewContainer = class("RougeFactionIllustrationDetailViewContainer", BaseViewContainer)

function RougeFactionIllustrationDetailViewContainer:buildViews()
	local views = {}

	table.insert(views, RougeFactionIllustrationDetailView.New())
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))

	return views
end

function RougeFactionIllustrationDetailViewContainer:buildTabViews(tabContainerId)
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

return RougeFactionIllustrationDetailViewContainer
