-- chunkname: @modules/logic/dungeon/view/maze/DungeonMazeViewContainer.lua

module("modules.logic.dungeon.view.maze.DungeonMazeViewContainer", package.seeall)

local DungeonMazeViewContainer = class("DungeonMazeViewContainer", BaseViewContainer)

function DungeonMazeViewContainer:buildViews()
	return {
		TabViewGroup.New(1, "#go_topleft"),
		DungeonMazeWordEffectView.New(),
		DungeonMazeView.New()
	}
end

function DungeonMazeViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		self._navigateButtonView:setOverrideClose(self.overrideCloseFunc, self)
		self._navigateButtonView:setOverrideHome(self.onClickHome, self)

		return {
			self._navigateButtonView
		}
	end
end

function DungeonMazeViewContainer:overrideCloseFunc()
	GameFacade.showMessageBox(MessageBoxIdDefine.Activity130PuzzleExit, MsgBoxEnum.BoxType.Yes_No, self.closeFunc, nil, nil, self)
end

function DungeonMazeViewContainer:closeFunc()
	local curCell = DungeonMazeModel.instance:getCurCellData()
	local chaosValue = DungeonMazeModel.instance:getChaosValue()

	DungeonMazeController.instance:sandStatData(DungeonMazeEnum.resultStat[3], curCell.cellId, chaosValue)
	DungeonMazeModel.instance:ClearProgress()
	self:closeThis()
end

function DungeonMazeViewContainer:onClickHome()
	local curCell = DungeonMazeModel.instance:getCurCellData()
	local chaosValue = DungeonMazeModel.instance:getChaosValue()

	DungeonMazeController.instance:sandStatData(DungeonMazeEnum.resultStat[3], curCell.cellId, chaosValue)
	NavigateButtonsView.homeClick()
end

return DungeonMazeViewContainer
