-- chunkname: @modules/logic/towercompose/view/TowerMainSelectViewContainer.lua

module("modules.logic.towercompose.view.TowerMainSelectViewContainer", package.seeall)

local TowerMainSelectViewContainer = class("TowerMainSelectViewContainer", BaseViewContainer)

function TowerMainSelectViewContainer:buildViews()
	local views = {}

	table.insert(views, TowerMainSelectView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function TowerMainSelectViewContainer:buildTabViews(tabContainerId)
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

return TowerMainSelectViewContainer
