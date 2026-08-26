-- chunkname: @modules/logic/sp01/assassin2/outside/view/AssassinMapViewContainer.lua

module("modules.logic.sp01.assassin2.outside.view.AssassinMapViewContainer", package.seeall)

local AssassinMapViewContainer = class("AssassinMapViewContainer", BaseViewContainer)

function AssassinMapViewContainer:buildViews()
	local views = {}

	table.insert(views, TabViewGroup.New(1, "root/#go_topleft"))
	table.insert(views, AssassinMapView.New())

	return views
end

function AssassinMapViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		return {
			NavigateButtonsView.New({
				true,
				true,
				false
			})
		}
	end
end

return AssassinMapViewContainer
