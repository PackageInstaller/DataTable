-- chunkname: @modules/logic/dungeon/view/puzzle/DungeonPuzzleChangeColorViewContainer.lua

module("modules.logic.dungeon.view.puzzle.DungeonPuzzleChangeColorViewContainer", package.seeall)

local DungeonPuzzleChangeColorViewContainer = class("DungeonPuzzleChangeColorViewContainer", BaseViewContainer)

function DungeonPuzzleChangeColorViewContainer:buildViews()
	local views = {}

	table.insert(views, TabViewGroup.New(1, "#go_btns"))
	table.insert(views, DungeonPuzzleChangeColorView.New())

	return views
end

function DungeonPuzzleChangeColorViewContainer:buildTabViews(tabContainerId)
	return {
		NavigateButtonsView.New({
			true,
			true,
			false
		}, 100)
	}
end

return DungeonPuzzleChangeColorViewContainer
