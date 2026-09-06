-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/view/ShowDownBattleResutlView.lua

module("logic.extensions.showdown.view.ShowDownBattleResutlView", package.seeall)

local ShowDownBattleResutlView = class("ShowDownBattleResutlView", ViewComponent)

function ShowDownBattleResutlView:ctor()
	ShowDownBattleResutlView.super.ctor(self)
end

function ShowDownBattleResutlView:bindEvents()
	ShowDownBattleResutlView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
end

function ShowDownBattleResutlView:unbindEvents()
	ShowDownBattleResutlView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function ShowDownBattleResutlView:buildUI()
	ShowDownBattleResutlView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")

	local cellGo = self:getGo("cell")
	local tableviewGo = self:getGo("tableview")

	self._tableview = ScrollerList.create(tableviewGo, cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._empty = self:getGo("goEmpty")
end

function ShowDownBattleResutlView:onEnter()
	ShowDownBattleResutlView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = checkint(params[1])
	self._stepId = params[2]
	self._teamId = params[3]
	self._otherTeamId = params[4]
	self._showVideo = checkbool(params[5])
	self._roundId = ShowDownController.instance:getRoundIdByStep(self._activityId, self._stepId)

	ShowDownController.instance:sendPM_ShowDown_GetBattleRecordsReq(self._activityId, self._stepId, self._teamId, self._otherTeamId)
	self.addGEvent(self, GlobalNotify.HandlePM_ShowDown_GetBattleRecordsRes, self._refreshDetailTableview, self)
	self.addGEvent(self, GlobalNotify.HandlePM_ShowDown_GetGroupMatchBattleDetailRes, self._handleShowBattleDetail, self)
	self.addGEvent(self, GlobalNotify.HandlePM_ShowDownQualify_GetQualifyBattleVideoRes, self._handlePM_ShowDownQualify_GetQualifyBattleVideoRes, self)
	self:_refreshDetailTableview()
	self.addGEvent(self, GlobalNotify.HandlePM_ShowDown_GetBattleRecordsError, self._handleGetBattleRecordsError, self)
end

function ShowDownBattleResutlView:onExit()
	ShowDownBattleResutlView.super.onExit(self)
	self._tableview:dispose()
end

function ShowDownBattleResutlView:_refreshDetailTableview()
	local mo = ShowDownController.instance:getShowDownMo(self._activityId)

	if mo then
		local records = mo:getLastInquireBattleRecords() or {}

		self._tableview:reloadData(records)
		goutil.setActive(self._empty, #records <= 0)
	end
end

function ShowDownBattleResutlView:_updateCell(view, cellGo, data)
	local isWin = false
	local leftData, rightData
	local record1 = data:getTeamBattleRecord(0)
	local record2 = data:getTeamBattleRecord(1)

	if record1:getTeamId() == self._teamId then
		leftData = record1
		rightData = record2
		isWin = data:isWin(0)
	else
		leftData = record2
		rightData = record1
		isWin = data:isWin(1)
	end

	local battleId = data:getBattleId()
	local result = data:getResult()
	local leftHeadInfo = leftData:getHeadInfo()

	if leftHeadInfo then
		if not leftHeadInfo.userId then
			local leftUserId = ""
			local cell = self:_clearCell(cellGo)

			if result == ShowDownEnum.BattleRecordResult_Draw then
				cell.imgResult:SetState(1)
			else
				cell.imgResult:SetState(isWin and 2 or 0)
			end

			local time = GameUtil.time2date(data:getRecordTimeStamp())

			cell.txtTime.text = string.format("%d月%d日  %02d:%02d", time.month, time.day, time.hour, time.min)

			GameUtil.addClickHandler(cell.btnData, GameUtil.handler(self._onClickData, self, data, leftUserId))
			GameUtil.addClickHandler(cell.btnVideo, GameUtil.handler(self._onClickPlayVideo, self, battleId, leftUserId))

			local headInfo = leftData:getHeadInfo()

			if headInfo and headInfo.userId then
				HeadItemController.instance:setHeadCellByInfo(cell.leftPart.head, headInfo)

				cell.leftPart.txtName.text = headInfo.userName
			else
				HeadItemController.instance:setMyHeadCell(cell.headIcon)

				cell.leftPart.txtName.text = RoleModel.instance:getUserName()
			end

			cell.leftPart.txtBuff.text = leftData:getBuffId()

			local buffCfg = ShowDownConfig.instance:getBuffData(self._activityId, self._roundId, leftData:getBuffId())
			local path = ShowDownController.instance:getBuffIconPath(self._activityId, self._roundId, leftData:getBuffId())

			if not string.nilorempty(path) and cell.leftPart.iconBuff then
				uGuiUtil.setSpriteToImage(cell.leftPart.iconBuff, uGuiUtil.SpriteType.BigBg, path)
			end

			cell.rightPart.txtName.text = rightData:getHeadInfo().userName
			cell.rightPart.txtBuff.text = rightData:getBuffId()
			path = ShowDownController.instance:getBuffIconPath(self._activityId, self._roundId, rightData:getBuffId())

			if not string.nilorempty(path) and cell.rightPart.iconBuff then
				uGuiUtil.setSpriteToImage(cell.rightPart.iconBuff, uGuiUtil.SpriteType.BigBg, path)
			end

			HeadItemController.instance:setHeadCellByInfo(cell.rightPart.head, rightData:getHeadInfo())
		end
	end
end

function ShowDownBattleResutlView:_clearCell(cellGo)
	local cell = {}

	cell.go = cellGo
	cell.btnData = goutil.findChild(cell.go, "btnData")
	cell.btnVideo = goutil.findChild(cell.go, "btnVideo")

	GameUtil.rmClickHandler(cell.btnData)

	cell.txtTime = goutil.findChildTextComponent(cell.go, "txtTime")
	cell.imgResult = goutil.findChildComponent(cell.go, "imgResult", "UIImageSpriteChange")

	goutil.setActive(cell.btnData, not self._showVideo)
	goutil.setActive(cell.btnVideo, self._showVideo)

	local part = {}

	part.go = goutil.findChild(cell.go, "left")
	part.head = goutil.findChild(part.go, "head")

	HeadItemController.instance:resetHeadCell(part.head)

	part.txtName = goutil.findChildTextComponent(part.go, "txtName")
	part.txtBuff = goutil.findChildTextComponent(part.go, "buffIcon/txt")
	part.iconBuff = goutil.findChild(part.go, "buffIcon/icon")

	uGuiUtil.clearImage(part.iconBuff)

	cell.leftPart = part
	part = {
		go = goutil.findChild(cell.go, "right")
	}
	part.head = goutil.findChild(part.go, "head")

	HeadItemController.instance:resetHeadCell(part.head)

	part.txtName = goutil.findChildTextComponent(part.go, "txtName")
	part.txtBuff = goutil.findChildTextComponent(part.go, "buffIcon/txt")
	part.iconBuff = goutil.findChild(part.go, "buffIcon/icon")

	uGuiUtil.clearImage(part.iconBuff)

	cell.rightPart = part

	return cell
end

function ShowDownBattleResutlView:_onClickData(data, leftUserId)
	local battleId = checkint(data:getBattleId())

	self._leftUserId = leftUserId

	ShowDownController.instance:sendPM_ShowDown_GetGroupMatchBattleDetailReq(battleId)
end

function ShowDownBattleResutlView:_onClickPlayVideo(battleId, leftUserId)
	self._leftUserId = leftUserId

	ShowDownController.instance:sendPM_ShowDownQualify_GetQualifyBattleVideoReq(battleId)
end

function ShowDownBattleResutlView:_handleShowBattleDetail(msg)
	local info = GameUtil.pbToTable(msg)
	local detail = info.detail

	if detail and checkint(detail.teamBPlayerId) == checkint(self._leftUserId) then
		detail.teamBPlayerId = detail.teamAPlayerId
		detail.teamAPlayerId = detail.teamBPlayerId
		detail.teamBStatistics = detail.teamAStatistics
		detail.teamAStatistics = detail.teamBStatistics
	end

	BattleModel.instance:setLeftTeamId(0)
	BattleStatisticsDataModel.instance:onBtlEndRes(detail)
	UIStateManager.instance:open(ViewName.BattleStatics)
end

function ShowDownBattleResutlView:_handlePM_ShowDownQualify_GetQualifyBattleVideoRes(msg)
	if msg.battleResult then
		UIJumper.instance:clear()
		UIJumper.instance:pushOneStack(ViewName.ShowDownMainView, nil, self._activityId)
		ShowDownController.instance:playFightRecord(self._activityId, msg.battleResult, self._leftUserId)
	end
end

function ShowDownBattleResutlView:_handleGetBattleRecordsError(status)
	if status == -526 then
		FloatWordMgr.instance:show("战斗记录已过期")
	end
end

return ShowDownBattleResutlView
