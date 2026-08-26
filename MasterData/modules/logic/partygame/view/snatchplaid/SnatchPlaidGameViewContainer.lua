-- chunkname: @modules/logic/partygame/view/snatchplaid/SnatchPlaidGameViewContainer.lua

module("modules.logic.partygame.view.snatchplaid.SnatchPlaidGameViewContainer", package.seeall)

local SnatchPlaidGameViewContainer = class("SnatchPlaidGameViewContainer", SceneGameCommonViewContainer)

function SnatchPlaidGameViewContainer:getGameView()
	return {
		SnatchPlaidGameView.New()
	}
end

return SnatchPlaidGameViewContainer
