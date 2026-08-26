-- chunkname: @modules/logic/versionactivity3_7/towerv3a7/view/TowerV3a7MainViewContainer.lua

module("modules.logic.versionactivity3_7.towerv3a7.view.TowerV3a7MainViewContainer", package.seeall)

local TowerV3a7MainViewContainer = class("TowerV3a7MainViewContainer", BaseViewContainer)

function TowerV3a7MainViewContainer:buildViews()
	local views = {}

	table.insert(views, TowerV3a7MainView.New())
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))

	return views
end

function TowerV3a7MainViewContainer:buildTabViews(tabContainerId)
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

return TowerV3a7MainViewContainer
