-- chunkname: @modules/logic/matchgame/outside/map/MatchGameMapViewContainer.lua

module("modules.logic.matchgame.outside.map.MatchGameMapViewContainer", package.seeall)

local MatchGameMapViewContainer = class("MatchGameMapViewContainer", BaseViewContainer)

function MatchGameMapViewContainer:buildViews()
	return {
		MatchGameMapView.New(),
		MatchGameLevelView.New(),
		MatchGameMapDetailView.New(),
		TabViewGroup.New(1, "#go_topleft")
	}
end

function MatchGameMapViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			self._navigateButtonView
		}
	end
end

return MatchGameMapViewContainer
