-- chunkname: @modules/logic/partygame/view/whichmore/WhichMoreGameViewContainer.lua

module("modules.logic.partygame.view.whichmore.WhichMoreGameViewContainer", package.seeall)

local WhichMoreGameViewContainer = class("WhichMoreGameViewContainer", PartyGameCommonViewContainer)

function WhichMoreGameViewContainer:getGameView()
	return {
		WhichMoreGameView.New()
	}
end

return WhichMoreGameViewContainer
