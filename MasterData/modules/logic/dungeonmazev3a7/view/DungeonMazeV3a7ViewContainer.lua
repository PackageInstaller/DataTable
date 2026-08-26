-- chunkname: @modules/logic/dungeonmazev3a7/view/DungeonMazeV3a7ViewContainer.lua

module("modules.logic.dungeonmazev3a7.view.DungeonMazeV3a7ViewContainer", package.seeall)

local DungeonMazeV3a7ViewContainer = class("DungeonMazeV3a7ViewContainer", BaseViewContainer)

function DungeonMazeV3a7ViewContainer:buildViews()
	return {
		TabViewGroup.New(1, "#go_topleft"),
		DungeonMazeV3a7WordEffectView.New(),
		DungeonMazeV3a7View.New()
	}
end

function DungeonMazeV3a7ViewContainer:buildTabViews(tabContainerId)
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

function DungeonMazeV3a7ViewContainer:overrideCloseFunc()
	GameFacade.showMessageBox(MessageBoxIdDefine.Activity130PuzzleExit, MsgBoxEnum.BoxType.Yes_No, self.closeFunc, nil, nil, self)
end

function DungeonMazeV3a7ViewContainer:closeFunc()
	local curCell = DungeonMazeV3a7Model.instance:getCurCellData()
	local chaosValue = DungeonMazeV3a7Model.instance:getChaosValue()

	DungeonMazeV3a7Controller.instance:sandStatData(DungeonMazeV3a7Enum.resultStat[3], curCell.cellId, chaosValue)
	DungeonMazeV3a7Model.instance:ClearProgress()
	self:closeThis()
end

function DungeonMazeV3a7ViewContainer:onClickHome()
	local curCell = DungeonMazeV3a7Model.instance:getCurCellData()
	local chaosValue = DungeonMazeV3a7Model.instance:getChaosValue()

	DungeonMazeV3a7Controller.instance:sandStatData(DungeonMazeV3a7Enum.resultStat[3], curCell.cellId, chaosValue)
	NavigateButtonsView.homeClick()
end

return DungeonMazeV3a7ViewContainer
