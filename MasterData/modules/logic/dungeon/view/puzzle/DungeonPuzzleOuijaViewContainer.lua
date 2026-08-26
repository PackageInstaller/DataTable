-- chunkname: @modules/logic/dungeon/view/puzzle/DungeonPuzzleOuijaViewContainer.lua

module("modules.logic.dungeon.view.puzzle.DungeonPuzzleOuijaViewContainer", package.seeall)

local DungeonPuzzleOuijaViewContainer = class("DungeonPuzzleOuijaViewContainer", BaseViewContainer)

function DungeonPuzzleOuijaViewContainer:buildViews()
	return {
		DungeonPuzzleOuijaView.New(),
		TabViewGroup.New(1, "#go_btns")
	}
end

function DungeonPuzzleOuijaViewContainer:buildTabViews(tabContainerId)
	return {
		NavigateButtonsView.New({
			true,
			true,
			false
		})
	}
end

return DungeonPuzzleOuijaViewContainer
