-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/teenchampionking/view/TeenChampionKingBattleResultView.lua

module("logic.extensions.teenchampionking.view.TeenChampionKingBattleResultView", package.seeall)

local TeenChampionKingBattleResultView = class("TeenChampionKingBattleResultView", ViewComponent)

function TeenChampionKingBattleResultView:ctor()
	TeenChampionKingBattleResultView.super.ctor(self)
end

function TeenChampionKingBattleResultView:unbindEvents()
	TeenChampionKingBattleResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function TeenChampionKingBattleResultView:bindEvents()
	TeenChampionKingBattleResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function TeenChampionKingBattleResultView:buildUI()
	TeenChampionKingBattleResultView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")

	local cellGo = self:getGo("cell")
	local tableviewGo = self:getGo("tableview")

	self._tableview = ScrollerList.create(tableviewGo, cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._empty = self:getGo("goEmpty")
end

function TeenChampionKingBattleResultView:onExit()
	TeenChampionKingBattleResultView.super.onExit(self)
	self._tableview:dispose()
end

function TeenChampionKingBattleResultView:onEnter()
	TeenChampionKingBattleResultView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId <= 0 then
		self._activityId = 501001
	end

	self.addGEvent(self, GlobalNotify.PM_TCKGetBattleRecord, self._handleGetInfo, self)
	self.addGEvent(self, GlobalNotify.PM_TCKGetVideoRes, self._handleGetBattleVideo, self)
	self.addGEvent(self, GlobalNotify.PM_TCKGetVideoError, self._handleGetBattleVideoError, self)
	self:_handleGetInfo()
	TeenChampionKingController.instance:getBattleRecord(self._activityId)
end

function TeenChampionKingBattleResultView:_updateCell(view, cell, data)
	local btnVideo = goutil.findChild(cell.gameObject, "btnVideo")

	GameUtil.addClickHandler(btnVideo, GameUtil.handler(self._onClickPlayVideo, self, data.battleId))

	local imgResult = goutil.findChildComponent(cell.gameObject, "imgResult", "UIImageSpriteChange")

	imgResult:SetState(data.isChallengerWin and 0 or 1)

	local txtStep = goutil.findChildTextComponent(cell.gameObject, "txtStep")

	txtStep.text = data.showTxt

	local leftPart = self:_getPlayerPart(goutil.findChild(cell.gameObject, "left"))

	leftPart.txtZdl.text = string.format("战力:<color=#20B376FF>%s</color>", data.myZdl)

	HeadItemController.instance:setMyHeadCell(leftPart.head)

	leftPart.txtName.text = RoleModel.instance:getUserName()

	local rightPart = self:_getPlayerPart(goutil.findChild(cell.gameObject, "right"))

	rightPart.txtZdl.text = string.format("战力:<color=#20B376FF>%s</color>", data.enemyZdl)

	HeadItemController.instance:setHeadCellByInfo(rightPart.head, data.opHeadInfo)

	rightPart.txtName.text = data.opHeadInfo.userName

	local addStore = checknumber(data.incScore)
	local txtAdd = goutil.findChildTextComponent(leftPart.go, "txtAdd")

	txtAdd.text = (data.stepId == TeenChampionKingController.PRELIMINARY or data.stepId == TeenChampionKingController.POINTS_RACE) and string.format("积分:<color=#20B376FF>+%s</color>", addStore) or ""

	local txtStep = goutil.findChildTextComponent(cell.gameObject, "txtStep")

	txtStep.text = TeenChampionKingController.instance:getRoundNameByStepId(self._activityId, data.stepId)
end

function TeenChampionKingBattleResultView:_clearCell(cell)
	local btnVideo = goutil.findChild(cell.gameObject, "btnVideo")

	GameUtil.rmClickHandler(btnVideo)

	local leftPart = self:_getPlayerPart(goutil.findChild(cell.gameObject, "left"))
	local rightPart = self:_getPlayerPart(goutil.findChild(cell.gameObject, "right"))

	HeadItemController.instance:resetHeadCell(leftPart.head)
	HeadItemController.instance:resetHeadCell(rightPart.head)
end

function TeenChampionKingBattleResultView:_handleGetInfo()
	local recordinfo = TeenChampionKingModel.instance:getBattleRecordInfo(self._activityId)

	self._tableview:reloadData((recordinfo or nil) and (recordinfo.recordList or {}))
end

function TeenChampionKingBattleResultView:_getPlayerPart(partGo)
	local partCell = {}

	partCell.go = partGo
	partCell.head = goutil.findChild(partCell.go, "head")
	partCell.txtName = goutil.findChildTextComponent(partCell.go, "txtName")
	partCell.txtZdl = goutil.findChildTextComponent(partCell.go, "txtZdl")

	return partCell
end

function TeenChampionKingBattleResultView:_onClickPlayVideo(battleId)
	if checknumber(battleId) <= 0 then
		TipsFacade.instance:openCommonTips("战斗记录已过期")

		return
	end

	TeenChampionKingController.instance:playBattleVideo(battleId)
end

function TeenChampionKingBattleResultView:_handleGetBattleVideo(handle)
	UIJumper.instance:clear()
	UIJumper.instance:pushOneStack(ViewName.TeenChampionKingMainView, nil)

	if handle then
		handle()
	end
end

function TeenChampionKingBattleResultView:_handleGetBattleVideoError(status)
	if status == -526 or status == -47 then
		TipsFacade.instance:openCommonTips("战斗记录已过期")
	end
end

return TeenChampionKingBattleResultView
