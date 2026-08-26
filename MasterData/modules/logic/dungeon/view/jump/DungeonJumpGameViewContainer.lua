-- chunkname: @modules/logic/dungeon/view/jump/DungeonJumpGameViewContainer.lua

module("modules.logic.dungeon.view.jump.DungeonJumpGameViewContainer", package.seeall)

local DungeonJumpGameViewContainer = class("DungeonJumpGameViewContainer", BaseViewContainer)

function DungeonJumpGameViewContainer:buildViews()
	self._gameView = DungeonJumpGameView.New()

	return {
		self._gameView,
		TabViewGroup.New(1, "#go_topleft")
	}
end

function DungeonJumpGameViewContainer:buildTabViews(tabContainerId)
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

function DungeonJumpGameViewContainer:overrideCloseFunc()
	GameFacade.showMessageBox(MessageBoxIdDefine.Activity130PuzzleExit, MsgBoxEnum.BoxType.Yes_No, self.closeFunc, nil, nil, self)
end

function DungeonJumpGameViewContainer:closeFunc()
	local curCellIdx = self._gameView:getCurCellIdx()

	DungeonJumpGameController.instance:sandStatData(DungeonMazeEnum.resultStat[3], curCellIdx)
	DungeonJumpGameController.instance:ClearProgress()
	self:closeThis()
end

function DungeonJumpGameViewContainer:onClickHome()
	local curCellIdx = self._gameView:getCurCellIdx()

	DungeonJumpGameController.instance:sandStatData(DungeonMazeEnum.resultStat[3], curCellIdx)
	NavigateButtonsView.homeClick()
end

return DungeonJumpGameViewContainer
