-- chunkname: @modules/logic/partygame/view/woodenman/WoodenManGameViewContainer.lua

module("modules.logic.partygame.view.woodenman.WoodenManGameViewContainer", package.seeall)

local WoodenManGameViewContainer = class("WoodenManGameViewContainer", SceneGameCommonViewContainer)

function WoodenManGameViewContainer:getGameView()
	return {
		WoodenManGameView.New()
	}
end

return WoodenManGameViewContainer
