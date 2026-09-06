-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/iceqibugame/view/IceQiBuGameResultView.lua

module("logic.extensions.iceqibugame.view.IceQiBuGameResultView", package.seeall)

local IceQiBuGameResultView = class("IceQiBuGameResultView", ViewComponent)

function IceQiBuGameResultView:ctor()
	IceQiBuGameResultView.super.ctor(self)
end

function IceQiBuGameResultView:buildUI()
	IceQiBuGameResultView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._txtScore = self:getTxt("txtScore")

	local prizeScrView = self:getGo("prizeCol/scrView")
	local prizeScrCell = self:getGo("prizeCol/scrCell")

	self._prizeScrollerList = ScrollerList.create(prizeScrView, prizeScrCell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))

	self._prizeScrollerList:setCenterMode(true)

	self._tagEmpty = self:getGo("prizeCol/tagEmpty")

	GameUtil.SetActive(self._tagEmpty, false)
end

function IceQiBuGameResultView:bindEvents()
	IceQiBuGameResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
end

function IceQiBuGameResultView:unbindEvents()
	IceQiBuGameResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function IceQiBuGameResultView:onEnter()
	IceQiBuGameResultView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = params[1]
	self._score = params[2]
	self._stageId = params[3]
	self._isPass = params[4]
	self._prizeList = {}

	self.addGEvent(self, GlobalNotify.HandlePM_IceQibuGameEndGameRes, self._handlePM_IceQibuGameEndGameRes, self)
	IceQibuGameController.instance:sendPM_IceQibuGameEndGameReq(self._activityId, self._score, self._stageId, self._isPass)
	self:_onUpdate()
end

function IceQiBuGameResultView:onExit()
	IceQiBuGameResultView.super.onExit(self)
	table.clear(self._prizeList)
	self:_onClearPrizeCol()
end

function IceQiBuGameResultView:_handlePM_IceQibuGameEndGameRes(msg)
	table.clear(self._prizeList)

	if msg:HasField("changeSetId") then
		local moList = MaterialController.instance:getItemsByChangeSetId(msg.changeSetId)

		if moList then
			for _, mo in pairs(moList) do
				table.insert(self._prizeList, mo:toString())
			end
		end
	end

	self:_onUpdate()
end

function IceQiBuGameResultView:_onUpdate()
	self._txtScore.text = string.format("%s秒", self._score)

	self:_onUpdatePrizeColUI()
end

function IceQiBuGameResultView:_onUpdatePrizeColUI()
	self._prizeScrollerList:reloadData(self._prizeList)
	GameUtil.SetActive(self._tagEmpty, #self._prizeList == 0)
end

function IceQiBuGameResultView:_onClearPrizeCol()
	self._prizeScrollerList:dispose()
end

function IceQiBuGameResultView:_updatePrizeCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")

	MaterialMgr.setCellByCfg(data, item)
end

function IceQiBuGameResultView:_clearPrizeCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")

	MaterialMgr.resetAll(item)
end

function IceQiBuGameResultView:_onClickClose()
	GlobalDispatcher:dispatch(GlobalNotify.GameSureCloseView)
	self:close()
end

return IceQiBuGameResultView
