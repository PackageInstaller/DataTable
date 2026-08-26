-- chunkname: @modules/logic/rouge2/outside/view/Rouge2_IllustrationDetailViewContainer.lua

module("modules.logic.rouge2.outside.view.Rouge2_IllustrationDetailViewContainer", package.seeall)

local Rouge2_IllustrationDetailViewContainer = class("Rouge2_IllustrationDetailViewContainer", BaseViewContainer)

function Rouge2_IllustrationDetailViewContainer:buildViews()
	local views = {}

	table.insert(views, Rouge2_IllustrationDetailView.New())
	table.insert(views, TabViewGroup.New(1, "#go_LeftTop"))

	return views
end

function Rouge2_IllustrationDetailViewContainer:buildTabViews(tabContainerId)
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

return Rouge2_IllustrationDetailViewContainer
