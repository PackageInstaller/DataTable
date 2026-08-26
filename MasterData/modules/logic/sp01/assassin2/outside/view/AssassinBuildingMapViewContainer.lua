-- chunkname: @modules/logic/sp01/assassin2/outside/view/AssassinBuildingMapViewContainer.lua

module("modules.logic.sp01.assassin2.outside.view.AssassinBuildingMapViewContainer", package.seeall)

local AssassinBuildingMapViewContainer = class("AssassinBuildingMapViewContainer", BaseViewContainer)

function AssassinBuildingMapViewContainer:buildViews()
	local views = {}

	table.insert(views, AssassinBuildingMapView.New())
	table.insert(views, TabViewGroup.New(1, "root/#go_topleft"))

	return views
end

function AssassinBuildingMapViewContainer:buildTabViews(tabContainerId)
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

return AssassinBuildingMapViewContainer
