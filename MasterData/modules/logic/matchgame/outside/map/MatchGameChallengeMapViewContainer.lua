-- chunkname: @modules/logic/matchgame/outside/map/MatchGameChallengeMapViewContainer.lua

module("modules.logic.matchgame.outside.map.MatchGameChallengeMapViewContainer", package.seeall)

local MatchGameChallengeMapViewContainer = class("MatchGameChallengeMapViewContainer", BaseViewContainer)

function MatchGameChallengeMapViewContainer:buildViews()
	return {
		MatchGameChallengeMapView.New(),
		TabViewGroup.New(1, "#go_topleft")
	}
end

function MatchGameChallengeMapViewContainer:buildTabViews(tabContainerId)
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

return MatchGameChallengeMapViewContainer
