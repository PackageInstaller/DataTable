-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pingame/domadvcopy/DomAdvCopyPinGamePlayResultView.lua

module("logic.extensions.pingame.domadvcopy.DomAdvCopyPinGamePlayResultView", package.seeall)

local DomAdvCopyPinGamePlayResultView = class("DomAdvCopyPinGamePlayResultView", ViewComponent)

function DomAdvCopyPinGamePlayResultView:buildUI()
	DomAdvCopyPinGamePlayResultView.super.buildUI(self)

	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "txtTitle")
	self._txtScore = goutil.findChildTextComponent(self.mainGO, "txtScore")
	self._txtProgress = goutil.findChildTextComponent(self.mainGO, "txtProgress")
	self._container = goutil.findChild(self.mainGO, "prizeCol/container")

	local prizeScrView = goutil.findChild(self.mainGO, "prizeCol/prizeScrView")
	local prizeScrCell = goutil.findChild(self.mainGO, "prizeCol/prizeScrCell")

	self._prizeScrollerList = ScrollerList.create(prizeScrView, prizeScrCell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))

	self._prizeScrollerList:setCenterMode(true)

	self._emptyGo = goutil.findChild(self.mainGO, "prizeCol/emptyGo")
	self._btnSure = goutil.findChild(self.mainGO, "btnSure")
end

function DomAdvCopyPinGamePlayResultView:bindEvents()
	DomAdvCopyPinGamePlayResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
end

function DomAdvCopyPinGamePlayResultView:unbindEvents()
	DomAdvCopyPinGamePlayResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
end

function DomAdvCopyPinGamePlayResultView:onEnter()
	DomAdvCopyPinGamePlayResultView.super.onEnter(self)

	local params = self:getOpenParam() or {}
	local score = params[1]
	local msg = params[2]
	local domAdvParams = params[3]
	local activityId = checknumber(domAdvParams.activityId)
	local blockId = checknumber(domAdvParams.blockId)
	local domAdvMo = DomainAdventureController.instance:getDomAdvMo(activityId)
	local maxProgress = DomainAdventureConfig.instance:getNeedProgress(activityId, blockId)

	self._txtScore.text = score
	self._txtProgress.text = string.format("%s/%s", msg:HasField("block") and domAdvMo:getProgressInBlock(blockId) or msg.incProgress + domAdvMo:getProgressInBlock(blockId), maxProgress)

	local moList = MaterialController.instance:getTempItemsByChangeSetId(msg.changeSetId)
	local prizeList = {}

	if moList then
		for _, mo in pairs(moList) do
			table.insert(prizeList, mo:toString())
		end
	end

	self._prizeScrollerList:reloadData(prizeList)
	GameUtil.SetActive(self._emptyGo, #prizeList <= 0)
end

function DomAdvCopyPinGamePlayResultView:onExit()
	DomAdvCopyPinGamePlayResultView.super.onExit(self)
	self._prizeScrollerList:dispose()
end

function DomAdvCopyPinGamePlayResultView:_updatePrizeCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject

	MaterialMgr.setCellByCfg(prizeStr, mainGo)
end

function DomAdvCopyPinGamePlayResultView:_clearPrizeCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

function DomAdvCopyPinGamePlayResultView:_onClickBtnSure()
	self:close()
	PinGameController.instance:localNotify(PinGameController.CloseGameView, PinGameController.CloseEnum_Success)
end

return DomAdvCopyPinGamePlayResultView
