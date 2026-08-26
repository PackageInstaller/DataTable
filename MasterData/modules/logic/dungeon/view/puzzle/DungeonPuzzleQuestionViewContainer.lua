-- chunkname: @modules/logic/dungeon/view/puzzle/DungeonPuzzleQuestionViewContainer.lua

module("modules.logic.dungeon.view.puzzle.DungeonPuzzleQuestionViewContainer", package.seeall)

local DungeonPuzzleQuestionViewContainer = class("DungeonPuzzleQuestionViewContainer", BaseViewContainer)

function DungeonPuzzleQuestionViewContainer:buildViews()
	return {
		DungeonPuzzleQuestionView.New(),
		TabViewGroup.New(1, "#go_btns")
	}
end

function DungeonPuzzleQuestionViewContainer:buildTabViews(tabContainerId)
	return {
		NavigateButtonsView.New({
			true,
			true,
			false
		})
	}
end

return DungeonPuzzleQuestionViewContainer
