-- chunkname: @modules/logic/partygame/view/puzzle/PuzzleGameViewContainer.lua

module("modules.logic.partygame.view.puzzle.PuzzleGameViewContainer", package.seeall)

local PuzzleGameViewContainer = class("PuzzleGameViewContainer", PartyGameCommonViewContainer)

function PuzzleGameViewContainer:getGameView()
	local views = {}

	table.insert(views, PuzzleGameView.New())

	return views
end

function PuzzleGameViewContainer:getTabViewRootName()
	return "#go_topleft"
end

return PuzzleGameViewContainer
