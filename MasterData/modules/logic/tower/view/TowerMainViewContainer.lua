-- chunkname: @modules/logic/tower/view/TowerMainViewContainer.lua

module("modules.logic.tower.view.TowerMainViewContainer", package.seeall)

local TowerMainViewContainer = class("TowerMainViewContainer", BaseViewContainer)

function TowerMainViewContainer:buildViews()
	local views = {}

	table.insert(views, TowerMainView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function TowerMainViewContainer:buildTabViews(tabContainerId)
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

return TowerMainViewContainer
