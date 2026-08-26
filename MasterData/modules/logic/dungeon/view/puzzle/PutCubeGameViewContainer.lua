-- chunkname: @modules/logic/dungeon/view/puzzle/PutCubeGameViewContainer.lua

module("modules.logic.dungeon.view.puzzle.PutCubeGameViewContainer", package.seeall)

local PutCubeGameViewContainer = class("PutCubeGameViewContainer", BaseViewContainer)

function PutCubeGameViewContainer:buildViews()
	return {
		TabViewGroup.New(1, "#go_btns"),
		PutCubeGameView.New()
	}
end

function PutCubeGameViewContainer:buildTabViews(tabContainerId)
	return {
		NavigateButtonsView.New({
			true,
			true,
			false
		})
	}
end

return PutCubeGameViewContainer
