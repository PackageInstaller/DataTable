-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/martialcontest/view/MartialContestQualifyReportView.lua

module("logic.extensions.martialcontest.view.MartialContestQualifyReportView", package.seeall)

local MartialContestQualifyReportView = class("MartialContestQualifyReportView", ViewComponent)

function MartialContestQualifyReportView:ctor()
	MartialContestQualifyReportView.super.ctor(self)
end

function MartialContestQualifyReportView:unbindEvents()
	MartialContestQualifyReportView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function MartialContestQualifyReportView:bindEvents()
	MartialContestQualifyReportView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function MartialContestQualifyReportView:buildUI()
	MartialContestQualifyReportView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")

	local cellGo = self:getGo("cell")
	local tableviewGo = self:getGo("tableview")

	self._tableview = ScrollerList.create(tableviewGo, cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._empty = self:getGo("goEmpty")
	self._txtCombo = goutil.findChildComponent(self.mainGO, "info/txtCombo", ComponentType.UIImgNumeralText)
	self._txtScore = self:getTxt("info/txtScore")
	self._head = self:getGo("info/head")
	self._txtName = self:getTxt("info/txtName")
	self._txtZdl = self:getTxt("info/txtZdl")
end

function MartialContestQualifyReportView:onExit()
	MartialContestQualifyReportView.super.onExit(self)
	self._tableview:dispose()
end

function MartialContestQualifyReportView:onEnter()
	MartialContestQualifyReportView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_MCQualifierRecordsRes, self._refreshView, self)
	self.addGEvent(self, GlobalNotify.PM_MCGetBattleVideoRes, self._handleGetBattleVideo, self)
	self.addGEvent(self, GlobalNotify.PM_MCGetBattleVideoErrorRes, self._handleGetBattleVideoError, self)

	local params = self:getOpenParam()
	local activityId = checknumber(params[1])
	local stepId = checknumber(params[2])

	MartialContestAgent.instance:sendPM_MCQualifierRecordsReq(activityId, stepId)
end

function MartialContestQualifyReportView:_refreshView()
	local params = self:getOpenParam()
	local activityId = checknumber(params[1])
	local stepId = checknumber(params[2])
	local recordNos = MartialContestModel.instance:getRecordNos(activityId, stepId)

	self._tableview:reloadData(recordNos)
	goutil.setActive(self._empty, #recordNos <= 0)

	local maxCombo = 0
	local totalMaxComboScore = 0
	local curCombo = 0
	local totalCurComboScore = 0

	for i, v in ipairs(recordNos) do
		if v.isChallengerWin == true then
			curCombo = curCombo + 1
			totalCurComboScore = totalCurComboScore + v.incScore

			if maxCombo < curCombo then
				maxCombo = curCombo
				totalMaxComboScore = totalCurComboScore
			end
		else
			curCombo = 0
			totalCurComboScore = 0
		end
	end

	maxCombo = MartialContestModel.instance:getHistoryBestWinStreak(activityId, stepId)

	self._txtCombo:SetText(maxCombo)

	self._txtScore.text = langPara("总获得积分：%d", totalMaxComboScore)
	self._txtZdl.text = string.format("战力:<color=#20B376FF>%s</color>", RoleModel.instance:getMaxPower())

	HeadItemController.instance:setMyHeadCell(self._head)

	self._txtName.text = RoleModel.instance:getUserName()
end

function MartialContestQualifyReportView:_updateCell(view, cellGo, data)
	local cell = self:_clearCell(cellGo)

	GameUtil.addClickHandler(cell.btnVideo, GameUtil.handler(self._onClickPlayVideo, self, data.battleId[1]))
	cell.imgResult:SetState(data.isChallengerWin and 0 or 1)

	local challegeDate = GameUtil.time2date(checknumber(data.challnegeTime) / 100)

	cell.txtStep.text = langPara("%02d月%02d日 %02d:%02d", challegeDate.month, challegeDate.day, challegeDate.hour, challegeDate.min)
	cell.leftPart.txtZdl.text = string.format("战力:<color=#20B376FF>%s</color>", data.myZdl)

	HeadItemController.instance:setMyHeadCell(cell.leftPart.head)

	cell.leftPart.txtName.text = RoleModel.instance:getUserName()
	cell.rightPart.txtZdl.text = string.format("战力:<color=#20B376FF>%s</color>", checknumber(data.rightZdl))

	if data.opHeadInfo then
		HeadItemController.instance:setHeadCellByInfo(cell.rightPart.head, data.opHeadInfo, true)

		cell.rightPart.txtName.text = data.opHeadInfo.userName
	else
		HeadItemController.instance:setMyHeadCell(cell.rightPart.head)

		cell.rightPart.txtName.text = RoleModel.instance:getUserName()
	end
end

function MartialContestQualifyReportView:_clearCell(cellGo)
	local cell = {}

	cell.go = cellGo
	cell.btnVideo = goutil.findChild(cell.go, "btnVideo")

	GameUtil.rmClickHandler(cell.btnVideo)

	cell.imgResult = goutil.findChildComponent(cell.go, "imgResult", "UIImageSpriteChange")
	cell.txtStep = goutil.findChildTextComponent(cell.go, "txtStep")
	cell.leftPart = self:_getPlayerPart(goutil.findChild(cell.go, "left"))
	cell.txtAdd = goutil.findChildTextComponent(cell.leftPart.go, "txtAdd")

	HeadItemController.instance:resetHeadCell(cell.leftPart.head)

	cell.rightPart = self:_getPlayerPart(goutil.findChild(cell.go, "right"))

	HeadItemController.instance:resetHeadCell(cell.rightPart.head)

	return cell
end

function MartialContestQualifyReportView:_getPlayerPart(partGo)
	local partCell = {}

	partCell.go = partGo
	partCell.head = goutil.findChild(partCell.go, "head")
	partCell.txtName = goutil.findChildTextComponent(partCell.go, "txtName")
	partCell.txtZdl = goutil.findChildTextComponent(partCell.go, "txtZdl")

	return partCell
end

function MartialContestQualifyReportView:_onClickPlayVideo(battleId)
	if checknumber(battleId) <= 0 then
		TipsFacade.instance:openCommonTips("战斗记录已过期")

		return
	end

	MartialContestAgent.instance:sendPM_MCGetBattleVideoReq(battleId)
end

function MartialContestQualifyReportView:_handleGetBattleVideo(handle)
	UIJumper.instance:clear()
	UIJumper.instance:saveCurStack()

	if handle then
		handle()
	end
end

function MartialContestQualifyReportView:_handleGetBattleVideoError(status)
	if status == -526 or status == -47 then
		TipsFacade.instance:openCommonTips("战斗记录已过期")
	end
end

return MartialContestQualifyReportView
