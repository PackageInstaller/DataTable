-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/martialcontest/view/MartialContestScoreReportView.lua

module("logic.extensions.martialcontest.view.MartialContestScoreReportView", package.seeall)

local MartialContestScoreReportView = class("MartialContestScoreReportView", ViewComponent)

function MartialContestScoreReportView:unbindEvents()
	MartialContestScoreReportView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function MartialContestScoreReportView:bindEvents()
	MartialContestScoreReportView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
end

function MartialContestScoreReportView:buildUI()
	MartialContestScoreReportView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._emptyGo = self:getGo("empty")
	self._tablecell = self:getGo("tablecell")
	self._tableview = self:getGo("tableview")
	self._tableList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._txtCombo = goutil.findChildComponent(self.mainGO, "info/txtCombo", ComponentType.UIImgNumeralText)
	self._txtScore = self:getTxt("info/txtScore")
	self._head = self:getGo("info/head")
	self._txtName = self:getTxt("info/txtName")
	self._txtZdl = self:getTxt("info/txtZdl")
end

function MartialContestScoreReportView:onExit()
	MartialContestScoreReportView.super.onExit(self)
end

function MartialContestScoreReportView:onEnter()
	MartialContestScoreReportView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_MCQualifierRecordsRes, self._refreshView, self)

	local params = self:getOpenParam()
	local activityId = checknumber(params[1])
	local stepId = checknumber(params[2])

	MartialContestAgent.instance:sendPM_MCQualifierRecordsReq(activityId, stepId)
end

function MartialContestScoreReportView:_refreshView()
	local params = self:getOpenParam()
	local activityId = checknumber(params[1])
	local stepId = checknumber(params[2])
	local recordNos = MartialContestModel.instance:getRecordNos(activityId, stepId)

	self._tableList:reloadData(recordNos)
	goutil.setActive(self._emptyGo, #recordNos <= 0)

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

function MartialContestScoreReportView:_updateCell(view, cellGo, data)
	local cell = self:_clearCell(cellGo)

	GameUtil.addClickHandler(cell.btnDetail, GameUtil.handler(self._onClickDetail, self, data))
	cell.imgResult:SetState(data.isChallengerWin and 0 or 1)

	local challegeDate = GameUtil.time2date(checkint(data.challnegeTime / 1000))

	cell.txtTime.text = langPara("%02d月%02d日 %02d:%02d", challegeDate.month, challegeDate.day, challegeDate.hour, challegeDate.min)
	cell.leftPart.txtZdl.text = string.format("战力:<color=#20B376FF>%s</color>", checknumber(data.myZdl))

	if data.leftHeadInfo then
		HeadItemController.instance:setHeadCellByInfo(cell.leftPart.head, data.leftHeadInfo, true)

		cell.leftPart.txtName.text = data.leftHeadInfo.userName
	else
		HeadItemController.instance:setMyHeadCell(cell.leftPart.head)

		cell.leftPart.txtName.text = RoleModel.instance:getUserName()
	end

	cell.rightPart.txtZdl.text = string.format("战力:<color=#20B376FF>%s</color>", checknumber(data.rightZdl))

	if data.rightHeadInfo then
		HeadItemController.instance:setHeadCellByInfo(cell.rightPart.head, data.rightHeadInfo, true)

		cell.rightPart.txtName.text = data.rightHeadInfo.userName
	else
		HeadItemController.instance:setMyHeadCell(cell.rightPart.head)

		cell.rightPart.txtName.text = RoleModel.instance:getUserName()
	end
end

function MartialContestScoreReportView:_clearCell(cellGo)
	local cell = {}

	cell.go = cellGo
	cell.btnDetail = goutil.findChild(cell.go, "btnDetail")

	GameUtil.rmClickHandler(cell.btnDetail)

	cell.imgResult = goutil.findChildComponent(cell.go, "imgResult", "UIImageSpriteChange")
	cell.txtTime = goutil.findChildTextComponent(cell.go, "txtTime")
	cell.leftPart = self:_getPlayerPart(goutil.findChild(cell.go, "left"))

	HeadItemController.instance:resetHeadCell(cell.leftPart.head)

	cell.rightPart = self:_getPlayerPart(goutil.findChild(cell.go, "right"))

	HeadItemController.instance:resetHeadCell(cell.rightPart.head)

	return cell
end

function MartialContestScoreReportView:_getPlayerPart(partGo)
	local partCell = {}

	partCell.go = partGo
	partCell.head = goutil.findChild(partCell.go, "head")
	partCell.txtName = goutil.findChildTextComponent(partCell.go, "txtName")
	partCell.txtZdl = goutil.findChildTextComponent(partCell.go, "txtZdl")

	return partCell
end

function MartialContestScoreReportView:_onClickDetail(data)
	local info1 = {
		headInfo = RoleModel.instance:getHeadInfo()
	}
	local info2 = {
		headInfo = data.opHeadInfo
	}

	UIStateManager.instance:push(ViewName.MartialContestScoreReportDetailView, info1, info2, data.recordForm, data)
end

return MartialContestScoreReportView
