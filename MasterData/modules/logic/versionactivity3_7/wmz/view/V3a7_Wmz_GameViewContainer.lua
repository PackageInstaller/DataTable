-- chunkname: @modules/logic/versionactivity3_7/wmz/view/V3a7_Wmz_GameViewContainer.lua

module("modules.logic.versionactivity3_7.wmz.view.V3a7_Wmz_GameViewContainer", package.seeall)

local V3a7_Wmz_GameViewContainer = class("V3a7_Wmz_GameViewContainer", WmzViewBaseContainer)

function V3a7_Wmz_GameViewContainer:buildViews()
	self._mainView = V3a7_Wmz_GameView.New()

	return {
		self._mainView,
		TabViewGroup.New(1, "#go_topleft")
	}
end

local kTabContainerId_NavigateButtonsView = 1

function V3a7_Wmz_GameViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == kTabContainerId_NavigateButtonsView then
		local helpId = self:getHelpId()

		self._navigateButtonsView = NavigateButtonsView.New({
			true,
			false,
			helpId ~= nil
		}, helpId)

		self._navigateButtonsView:setOverrideClose(self._overrideClose, self)

		return {
			self._navigateButtonsView
		}
	end
end

function V3a7_Wmz_GameViewContainer:getHelpId()
	return HelpEnum.HelpId.V3a7_Wmz_GameViewHelp
end

function V3a7_Wmz_GameViewContainer:onContainerInit()
	V3a7_Wmz_GameViewContainer.super.onContainerInit(self)
	WmzController.instance:registerCallback(WmzEvent.onGameResultClickQuit, self._onGameResultClickQuit, self)
	WmzController.instance:registerCallback(WmzEvent.onGameResultClickRestart, self._onGameResultClickRestart, self)
end

function V3a7_Wmz_GameViewContainer:_overrideClose()
	GameFacade.showMessageBox(MessageBoxIdDefine.Act176PuzzleMazeQuitGame, MsgBoxEnum.BoxType.Yes_No, self._endYesCallback, nil, nil, self, nil, nil)
end

function V3a7_Wmz_GameViewContainer:_endYesCallback()
	self:trackExit(self:dragContext()._edit_Energy)
	self:closeThis()
end

function V3a7_Wmz_GameViewContainer:onFailed()
	ViewMgr.instance:openView(ViewName.V3a7_Wmz_ResultView)
end

function V3a7_Wmz_GameViewContainer:_onGameResultClickQuit()
	self:trackFailExit(self:dragContext()._edit_Energy)
	self:closeThis()
end

function V3a7_Wmz_GameViewContainer:_onGameResultClickRestart()
	self:trackFailReset(self:dragContext()._edit_Energy)
	self:dragContext():_critical_beforeClear()
	self:mapMO():restart()
	self._mainView:_onGameStart()
end

function V3a7_Wmz_GameViewContainer:onContainerDestroy()
	self:dragContext():clear()
	WmzController.instance:unregisterCallback(WmzEvent.onGameResultClickQuit, self._onGameResultClickQuit, self)
	WmzController.instance:unregisterCallback(WmzEvent.onGameResultClickRestart, self._onGameResultClickRestart, self)
	V3a7_Wmz_GameViewContainer.super.onContainerDestroy(self)
end

function V3a7_Wmz_GameViewContainer:gridSizeV2()
	return self._mainView:gridSizeV2()
end

function V3a7_Wmz_GameViewContainer:gridHalfSizeV2()
	return self._mainView:gridHalfSizeV2()
end

function V3a7_Wmz_GameViewContainer:gridSizeAndHalfV2()
	return self._mainView:gridSizeAndHalfV2()
end

function V3a7_Wmz_GameViewContainer:contentSizeV2()
	return self._mainView:contentSizeV2()
end

function V3a7_Wmz_GameViewContainer:contentHalfSizeV2()
	return self._mainView:contentHalfSizeV2()
end

function V3a7_Wmz_GameViewContainer:contentSizeAndHalfV2()
	return self._mainView:contentSizeAndHalfV2()
end

function V3a7_Wmz_GameViewContainer:viewportSizeV2()
	return self._mainView:viewportSizeV2()
end

function V3a7_Wmz_GameViewContainer:viewportHalfSizeV2()
	return self._mainView:viewportHalfSizeV2()
end

function V3a7_Wmz_GameViewContainer:viewportSizeAndHalfV2()
	return self._mainView:viewportSizeAndHalfV2()
end

function V3a7_Wmz_GameViewContainer:gridXY(...)
	return self._mainView:gridXY(...)
end

function V3a7_Wmz_GameViewContainer:gridCXCY(...)
	return self._mainView:gridCXCY(...)
end

function V3a7_Wmz_GameViewContainer:coordToAPosInContentSpace(...)
	return self._mainView:coordToAPosInContentSpace(...)
end

function V3a7_Wmz_GameViewContainer:screenToGridCoordXY(...)
	return self._mainView:screenToGridCoordXY(...)
end

function V3a7_Wmz_GameViewContainer:getCellItem(...)
	return self._mainView:getCellItem(...)
end

function V3a7_Wmz_GameViewContainer:getTileItem(...)
	return self._mainView:getTileItem(...)
end

function V3a7_Wmz_GameViewContainer:getItemByObj(...)
	return self._mainView:getItemByObj(...)
end

function V3a7_Wmz_GameViewContainer:getSelectedZoneIdx(...)
	return self._mainView:getSelectedZoneIdx(...)
end

function V3a7_Wmz_GameViewContainer:calcCellFlattenIndex(...)
	return self:mapMO():calcCellFlattenIndex(...)
end

function V3a7_Wmz_GameViewContainer:getTile(...)
	return self:mapMO():getTile(...)
end

function V3a7_Wmz_GameViewContainer:getTileIdListByGroup(...)
	return self:mapMO():getTileIdListByGroup(...)
end

function V3a7_Wmz_GameViewContainer:getZoneIdListByGroup(...)
	return self:mapMO():getZoneIdListByGroup(...)
end

function V3a7_Wmz_GameViewContainer:getCell(...)
	return self:mapMO():getCell(...)
end

function V3a7_Wmz_GameViewContainer:episodeId()
	return WmzBattleModel.instance:episodeId()
end

function V3a7_Wmz_GameViewContainer:mapMO()
	return WmzBattleModel.instance:mapMO()
end

function V3a7_Wmz_GameViewContainer:dragContext()
	return WmzBattleModel.instance:dragContext()
end

function V3a7_Wmz_GameViewContainer:trackMO()
	return WmzBattleModel.instance:trackMO()
end

function V3a7_Wmz_GameViewContainer:completeGame(isWin)
	WmzController.instance:completeGame(isWin, self:episodeId())
end

function V3a7_Wmz_GameViewContainer:getGameCO(episodeId)
	return self:mapMO():getGameCO(episodeId or self:episodeId())
end

function V3a7_Wmz_GameViewContainer:getZoneCOList(episodeId)
	return self:mapMO():getZoneCOList(episodeId or self:episodeId())
end

function V3a7_Wmz_GameViewContainer:mapSize()
	return self:mapMO():mapSize()
end

function V3a7_Wmz_GameViewContainer:bValidCoord(...)
	return self:mapMO():bValidCoord(...)
end

function V3a7_Wmz_GameViewContainer:foreachCell(...)
	self:mapMO():foreachCell(...)
end

function V3a7_Wmz_GameViewContainer:foreachTile(...)
	self:mapMO():foreachTile(...)
end

function V3a7_Wmz_GameViewContainer:foreachWire(...)
	self:mapMO():foreachWire(...)
end

function V3a7_Wmz_GameViewContainer:floodfill(...)
	return self:mapMO():floodfill(...)
end

function V3a7_Wmz_GameViewContainer:restartCurZone()
	self:mapMO():restartCurZone()
end

function V3a7_Wmz_GameViewContainer:setClearZoneCnt(...)
	self:mapMO():setClearZoneCnt(...)
end

function V3a7_Wmz_GameViewContainer:zoneClearCurAndMax()
	return self:mapMO():clearZoneCnt(), self:mapMO():zoneCount()
end

function V3a7_Wmz_GameViewContainer:zoneIndex2ZoneId(...)
	return self:mapMO():zoneIndex2ZoneId(...)
end

function V3a7_Wmz_GameViewContainer:getZoneId2Index(...)
	return self:mapMO():getZoneId2Index(...)
end

function V3a7_Wmz_GameViewContainer:curPlayingZoneIndex(...)
	return self:mapMO():curPlayingZoneIndex(...)
end

function V3a7_Wmz_GameViewContainer:curPlayingZoneId(...)
	return self:mapMO():curPlayingZoneId(...)
end

function V3a7_Wmz_GameViewContainer:setEnergy(...)
	self:mapMO():setEnergy(...)
end

function V3a7_Wmz_GameViewContainer:curEnergy()
	return self:mapMO():curEnergy()
end

return V3a7_Wmz_GameViewContainer
