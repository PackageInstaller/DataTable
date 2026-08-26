-- chunkname: @modules/logic/partygame/view/snatchterritory/SnatchTerritoryGameViewContainer.lua

module("modules.logic.partygame.view.snatchterritory.SnatchTerritoryGameViewContainer", package.seeall)

local SnatchTerritoryGameViewContainer = class("SnatchTerritoryGameViewContainer", SceneGameCommonViewContainer)

function SnatchTerritoryGameViewContainer:getGameView()
	return {
		SnatchTerritoryGameView.New()
	}
end

return SnatchTerritoryGameViewContainer
