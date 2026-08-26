-- chunkname: @modules/logic/dungeon/view/maze/DungeonMazeResultViewContainer.lua

module("modules.logic.dungeon.view.maze.DungeonMazeResultViewContainer", package.seeall)

local DungeonMazeResultViewContainer = class("DungeonMazeResultViewContainer", BaseViewContainer)

function DungeonMazeResultViewContainer:buildViews()
	return {
		DungeonMazeResultView.New()
	}
end

return DungeonMazeResultViewContainer
