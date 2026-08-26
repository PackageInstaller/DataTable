-- chunkname: @modules/logic/rouge/view/RougeFavoriteViewContainer.lua

module("modules.logic.rouge.view.RougeFavoriteViewContainer", package.seeall)

local RougeFavoriteViewContainer = class("RougeFavoriteViewContainer", BaseViewContainer)

function RougeFavoriteViewContainer:buildViews()
	local views = {}

	table.insert(views, RougeFavoriteView.New())
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))

	return views
end

function RougeFavoriteViewContainer:buildTabViews(tabContainerId)
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

return RougeFavoriteViewContainer
