-- chunkname: @modules/logic/dungeon/view/puzzle/DungeonPuzzleCircuitViewContainer.lua

module("modules.logic.dungeon.view.puzzle.DungeonPuzzleCircuitViewContainer", package.seeall)

local DungeonPuzzleCircuitViewContainer = class("DungeonPuzzleCircuitViewContainer", BaseViewContainer)

function DungeonPuzzleCircuitViewContainer:buildViews()
	return {
		DungeonPuzzleCircuit.New(),
		DungeonPuzzleCircuitView.New()
	}
end

return DungeonPuzzleCircuitViewContainer
