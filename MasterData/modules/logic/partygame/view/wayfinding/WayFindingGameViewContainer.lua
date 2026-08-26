-- chunkname: @modules/logic/partygame/view/wayfinding/WayFindingGameViewContainer.lua

module("modules.logic.partygame.view.wayfinding.WayFindingGameViewContainer", package.seeall)

local WayFindingGameViewContainer = class("WayFindingGameViewContainer", SceneGameCommonViewContainer)

function WayFindingGameViewContainer:getGameView()
	return {
		WayFindingGameView.New()
	}
end

return WayFindingGameViewContainer
