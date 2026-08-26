-- chunkname: @modules/logic/versionactivity3_4/chg/view/V3a4_Chg_GameViewContainer.lua

module("modules.logic.versionactivity3_4.chg.view.V3a4_Chg_GameViewContainer", package.seeall)

local V3a4_Chg_GameViewContainer = class("V3a4_Chg_GameViewContainer", ChgViewBaseContainer)
local kTabContainerId_NavigateButtonsView = 1

function V3a4_Chg_GameViewContainer:buildViews()
	self._mainView = V3a4_Chg_GameView.New()

	return {
		self._mainView,
		TabViewGroup.New(1, "#go_topleft")
	}
end

function V3a4_Chg_GameViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == kTabContainerId_NavigateButtonsView then
		self._navigateButtonsView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		self._navigateButtonsView:setOverrideClose(self._overrideClose, self)

		return {
			self._navigateButtonsView
		}
	end
end

function V3a4_Chg_GameViewContainer:_overrideClose()
	GameFacade.showMessageBox(MessageBoxIdDefine.Act176PuzzleMazeQuitGame, MsgBoxEnum.BoxType.Yes_No, self._endYesCallback, nil, nil, self, nil, nil)
end

function V3a4_Chg_GameViewContainer:_endYesCallback()
	self:closeThis()
	self:trackExit()
end

function V3a4_Chg_GameViewContainer:onContainerDestroy()
	self:triggerPlayLoopSFX(false)
	self:dragContext():clear()
	V3a4_Chg_GameViewContainer.super.onContainerDestroy(self)
end

function V3a4_Chg_GameViewContainer:mapMO()
	return ChgBattleModel.instance:mapMO()
end

function V3a4_Chg_GameViewContainer:dragContext()
	return ChgBattleModel.instance:dragContext()
end

function V3a4_Chg_GameViewContainer:trackMO()
	return ChgBattleModel.instance:trackMO()
end

function V3a4_Chg_GameViewContainer:restart()
	ChgBattleModel.instance:restart()
end

function V3a4_Chg_GameViewContainer:restartRound(...)
	ChgBattleModel.instance:restartRound(...)
end

function V3a4_Chg_GameViewContainer:completeGame(isWin, callback, cbObj)
	if not isWin then
		self:showV3a4_Chg_ResultView()
	else
		ChgController.instance:completeGame(callback, cbObj)
	end
end

function V3a4_Chg_GameViewContainer:elementId()
	return ChgBattleModel.instance:elementId()
end

function V3a4_Chg_GameViewContainer:mapSize()
	return self:mapMO():mapSize()
end

function V3a4_Chg_GameViewContainer:vertexRowCol()
	return self:mapMO():vertexRowCol()
end

function V3a4_Chg_GameViewContainer:curRoundMO()
	return self:mapMO():curRoundMO()
end

function V3a4_Chg_GameViewContainer:roundNowAndMax()
	return self:mapMO():curRound(), self:mapMO():roundCount()
end

function V3a4_Chg_GameViewContainer:setRound(...)
	self:mapMO():setRound(...)
end

function V3a4_Chg_GameViewContainer:getObj(key)
	return self:curRoundMO():getObj(key)
end

function V3a4_Chg_GameViewContainer:startObj()
	return (self:curRoundMO():startObj())
end

function V3a4_Chg_GameViewContainer:startItem()
	local mapObj = self:startObj()

	return self:getItemByKey(mapObj:key())
end

function V3a4_Chg_GameViewContainer:endItemList()
	local list = {}
	local mapObjList = self:curRoundMO():endObjList()

	for _, mapObj in ipairs(mapObjList) do
		table.insert(list, self:getItemByKey(mapObj:key()))
	end

	return list
end

function V3a4_Chg_GameViewContainer:getItemByKey(key)
	return self._mainView:getItemByKey(key)
end

function V3a4_Chg_GameViewContainer:getLineItemAPosByKey(key)
	return self._mainView:getLineItemAPosByKey(key)
end

function V3a4_Chg_GameViewContainer:distBetweenVertV2()
	return self._mainView:distBetweenVertV2()
end

function V3a4_Chg_GameViewContainer:doRestart(...)
	return self._mainView:doRestart(...)
end

function V3a4_Chg_GameViewContainer:setEnergy(...)
	return self:mapMO():setEnergy(...)
end

function V3a4_Chg_GameViewContainer:curEnergy()
	return self:mapMO():curEnergy()
end

function V3a4_Chg_GameViewContainer:maxEnergy()
	return self:mapMO():maxEnergy()
end

function V3a4_Chg_GameViewContainer:addEnergyBeginRound()
	return self:mapMO():addEnergyBeginRound()
end

function V3a4_Chg_GameViewContainer:v3a4_spriteName()
	return self:mapMO():v3a4_spriteName()
end

function V3a4_Chg_GameViewContainer:clampKey(...)
	return self:mapMO():clampKey(...)
end

function V3a4_Chg_GameViewContainer:calcEnergy01(num)
	num = num or self:curEnergy()

	return GameUtil.saturate(num / self:maxEnergy())
end

function V3a4_Chg_GameViewContainer:calcEnergy(num01)
	return math.floor(GameUtil.saturate(num01) * self:maxEnergy())
end

function V3a4_Chg_GameViewContainer:addVisit(...)
	return self:curRoundMO():addVisit(...)
end

function V3a4_Chg_GameViewContainer:addVisitByLine(...)
	return self:curRoundMO():addVisitByLine(...)
end

function V3a4_Chg_GameViewContainer:isVisited(...)
	return self:curRoundMO():isVisited(...)
end

function V3a4_Chg_GameViewContainer:getGroupListByGroupId(...)
	return self:curRoundMO():getGroupListByGroupId(...)
end

function V3a4_Chg_GameViewContainer:gameStartDesc()
	return luaLang(string.format("v3a4_chg_gameview_%s", self:elementId()))
end

function V3a4_Chg_GameViewContainer:triggerPlayLoopSFX(bool)
	if bool then
		AudioMgr.instance:trigger(AudioEnum3_4.Chg.play_ui_bulaochun_cheng_connet_loop)
	else
		AudioMgr.instance:trigger(AudioEnum3_4.Chg.stop_ui_bulaochun_cheng_connet_loop)
	end
end

return V3a4_Chg_GameViewContainer
