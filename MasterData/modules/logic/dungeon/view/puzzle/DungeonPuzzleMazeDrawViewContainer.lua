-- chunkname: @modules/logic/dungeon/view/puzzle/DungeonPuzzleMazeDrawViewContainer.lua

module("modules.logic.dungeon.view.puzzle.DungeonPuzzleMazeDrawViewContainer", package.seeall)

local DungeonPuzzleMazeDrawViewContainer = class("DungeonPuzzleMazeDrawViewContainer", BaseViewContainer)

function DungeonPuzzleMazeDrawViewContainer:buildViews()
	return {
		DungeonPuzzleMazeDraw.New(),
		DungeonPuzzleMazeDrawView.New(),
		TabViewGroup.New(1, "#go_btns")
	}
end

function DungeonPuzzleMazeDrawViewContainer:buildTabViews(tabContainerId)
	return {
		NavigateButtonsView.New({
			true,
			true,
			false
		})
	}
end

return DungeonPuzzleMazeDrawViewContainer
