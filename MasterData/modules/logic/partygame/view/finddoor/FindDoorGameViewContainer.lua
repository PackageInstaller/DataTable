-- chunkname: @modules/logic/partygame/view/finddoor/FindDoorGameViewContainer.lua

module("modules.logic.partygame.view.finddoor.FindDoorGameViewContainer", package.seeall)

local FindDoorGameViewContainer = class("FindDoorGameViewContainer", SceneGameCommonViewContainer)

function FindDoorGameViewContainer:getGameView()
	return {
		FindDoorGameView.New()
	}
end

return FindDoorGameViewContainer
