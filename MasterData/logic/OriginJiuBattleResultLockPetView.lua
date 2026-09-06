-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originjiu/view/OriginJiuBattleResultLockPetView.lua

module("logic.extensions.originjiu.view.OriginJiuBattleResultLockPetView", package.seeall)

local OriginJiuBattleResultLockPetView = class("OriginJiuBattleResultLockPetView", ViewComponent)

function OriginJiuBattleResultLockPetView:buildUI()
	OriginJiuBattleResultLockPetView.super.buildUI(self)

	self._tagReach = self:getGo("detail/tagReach")
	self._txtDetail = self:getTxt("detail/txt")
	self._btnSure = self:getGo("btnSure")
	self._btnAgain = self:getGo("btnAgain")
	self._btnClose = self:getGo("btnClose")

	local petScrView = self:getGo("petCol/scrView")
	local petScrCell = self:getGo("petCol/scrCell")

	self._petScrollerList = ScrollerList.create(petScrView, petScrCell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))
	self._tagEmpty = self:getGo("petCol/tagEmpty")
end

function OriginJiuBattleResultLockPetView:bindEvents()
	OriginJiuBattleResultLockPetView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
end

function OriginJiuBattleResultLockPetView:unbindEvents()
	OriginJiuBattleResultLockPetView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
end

function OriginJiuBattleResultLockPetView:onEnter()
	OriginJiuBattleResultLockPetView.super.onEnter(self)

	local params = self:getOpenParam() or {}
	local msg = GameUtil.pbToTable(params[1]) or {}

	self._activityId = msg.activityId
	self._modelId = msg.modelId
	self._phaseId = msg.phaseId
	self._isWin = checkbool(msg.isWin)
	self._lockPetRaceIds = msg.lockPetRaceIds or {}

	self:_onUpdate()
end

function OriginJiuBattleResultLockPetView:onExit()
	OriginJiuBattleResultLockPetView.super.onExit(self)
	self._petScrollerList:dispose()
end

function OriginJiuBattleResultLockPetView:_onUpdate()
	GameUtil.SetActive(self._tagReach, self._isWin)

	self._txtDetail.text = "击败所有敌人"

	self._petScrollerList:reloadData(self._lockPetRaceIds)
	GameUtil.SetActive(self._tagEmpty, #self._lockPetRaceIds == 0)
end

function OriginJiuBattleResultLockPetView:_updatePetCell(view, cell, raceId, tag)
	local mainGo = cell.gameObject
	local itemGo = goutil.findChild(mainGo, "item")
	local proxy = MaterialMgr.setCell(MatType.Pet, raceId, itemGo)

	if proxy then
		proxy.binder:setClickCallBack(nil)
	end
end

function OriginJiuBattleResultLockPetView:_clearPetCell(cell)
	local mainGo = cell.gameObject
	local itemGo = goutil.findChild(mainGo, "item")

	MaterialMgr.resetAll(itemGo)
end

function OriginJiuBattleResultLockPetView:_onClickBtnSure()
	self:close()
	BattleController.instance:endBattle()
end

return OriginJiuBattleResultLockPetView
