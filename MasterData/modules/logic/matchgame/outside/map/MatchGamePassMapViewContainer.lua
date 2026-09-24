-- chunkname: @modules/logic/matchgame/outside/map/MatchGamePassMapViewContainer.lua

module("modules.logic.matchgame.outside.map.MatchGamePassMapViewContainer", package.seeall)

local MatchGamePassMapViewContainer = class("MatchGamePassMapViewContainer", BaseViewContainer)

function MatchGamePassMapViewContainer:buildViews()
	return {
		MatchGamePassMapView.New()
	}
end

return MatchGamePassMapViewContainer
