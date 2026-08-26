-- chunkname: @modules/logic/towercompose/view/TowerComposeMainViewContainer.lua

module("modules.logic.towercompose.view.TowerComposeMainViewContainer", package.seeall)

local TowerComposeMainViewContainer = class("TowerComposeMainViewContainer", BaseViewContainer)

function TowerComposeMainViewContainer:buildViews()
	local views = {}

	table.insert(views, TowerComposeMainView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function TowerComposeMainViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			self.navigateView
		}
	end
end

return TowerComposeMainViewContainer
