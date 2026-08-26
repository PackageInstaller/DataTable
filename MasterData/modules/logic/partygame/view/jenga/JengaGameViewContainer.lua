-- chunkname: @modules/logic/partygame/view/jenga/JengaGameViewContainer.lua

module("modules.logic.partygame.view.jenga.JengaGameViewContainer", package.seeall)

local JengaGameViewContainer = class("JengaGameViewContainer", SceneGameCommonViewContainer)

function JengaGameViewContainer:getGameView()
	return {
		JengaGameView.New()
	}
end

return JengaGameViewContainer
