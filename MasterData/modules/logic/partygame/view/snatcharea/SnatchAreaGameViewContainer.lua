-- chunkname: @modules/logic/partygame/view/snatcharea/SnatchAreaGameViewContainer.lua

module("modules.logic.partygame.view.snatcharea.SnatchAreaGameViewContainer", package.seeall)

local SnatchAreaGameViewContainer = class("SnatchAreaGameViewContainer", SceneGameCommonViewContainer)

function SnatchAreaGameViewContainer:getGameView()
	return {
		SnatchAreaGameView.New(),
		SnatchAreaGameMapView.New(),
		SnatchAreaGamePlayerView.New(),
		SnatchAreaGameJoystickView.New(),
		SnatchAreaGamePlayerRankView.New(),
		SnatchAreaGameRoundView.New()
	}
end

return SnatchAreaGameViewContainer
