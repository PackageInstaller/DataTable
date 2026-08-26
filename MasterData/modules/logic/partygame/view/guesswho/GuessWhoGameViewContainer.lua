-- chunkname: @modules/logic/partygame/view/guesswho/GuessWhoGameViewContainer.lua

module("modules.logic.partygame.view.guesswho.GuessWhoGameViewContainer", package.seeall)

local GuessWhoGameViewContainer = class("GuessWhoGameViewContainer", PartyGameCommonViewContainer)

function GuessWhoGameViewContainer:getGameView()
	local views = {}

	table.insert(views, GuessWhoGameView.New())

	return views
end

function GuessWhoGameViewContainer:getTabViewRootName()
	return "#go_topleft"
end

return GuessWhoGameViewContainer
