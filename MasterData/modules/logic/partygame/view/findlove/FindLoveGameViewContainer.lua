-- chunkname: @modules/logic/partygame/view/findlove/FindLoveGameViewContainer.lua

module("modules.logic.partygame.view.findlove.FindLoveGameViewContainer", package.seeall)

local FindLoveGameViewContainer = class("FindLoveGameViewContainer", PartyGameCommonViewContainer)

function FindLoveGameViewContainer:getGameView()
	return {
		FindLoveGameView.New()
	}
end

return FindLoveGameViewContainer
