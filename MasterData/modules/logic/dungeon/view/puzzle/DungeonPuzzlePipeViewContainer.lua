-- chunkname: @modules/logic/dungeon/view/puzzle/DungeonPuzzlePipeViewContainer.lua

module("modules.logic.dungeon.view.puzzle.DungeonPuzzlePipeViewContainer", package.seeall)

local DungeonPuzzlePipeViewContainer = class("DungeonPuzzlePipeViewContainer", BaseViewContainer)

function DungeonPuzzlePipeViewContainer:buildViews()
	return {
		DungeonPuzzlePipeView.New(),
		DungeonPuzzlePipes.New(),
		TabViewGroup.New(1, "#go_btns")
	}
end

function DungeonPuzzlePipeViewContainer:buildTabViews(tabContainerId)
	return {
		NavigateButtonsView.New({
			true,
			true,
			false
		})
	}
end

return DungeonPuzzlePipeViewContainer
