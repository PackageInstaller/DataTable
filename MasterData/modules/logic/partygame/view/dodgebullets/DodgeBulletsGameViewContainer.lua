-- chunkname: @modules/logic/partygame/view/dodgebullets/DodgeBulletsGameViewContainer.lua

module("modules.logic.partygame.view.dodgebullets.DodgeBulletsGameViewContainer", package.seeall)

local DodgeBulletsGameViewContainer = class("DodgeBulletsGameViewContainer", SceneGameCommonViewContainer)

function DodgeBulletsGameViewContainer:getGameView()
	return {
		DodgeBulletsGameView.New()
	}
end

return DodgeBulletsGameViewContainer
