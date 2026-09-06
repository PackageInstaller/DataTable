-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/view/ShowDownEliminateInviteInfoView.lua

module("logic.extensions.showdown.view.ShowDownEliminateInviteInfoView", package.seeall)

local ShowDownEliminateInviteInfoView = class("ShowDownEliminateInviteInfoView", ViewComponent)

function ShowDownEliminateInviteInfoView:ctor()
	ShowDownEliminateInviteInfoView.super.ctor(self)
end

function ShowDownEliminateInviteInfoView:unbindEvents()
	ShowDownEliminateInviteInfoView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function ShowDownEliminateInviteInfoView:bindEvents()
	ShowDownEliminateInviteInfoView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
end

function ShowDownEliminateInviteInfoView:buildUI()
	ShowDownEliminateInviteInfoView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")

	local cellGoInvite = self:getGo("colInvite/cell")
	local tableviewGoInvite = self:getGo("colInvite/tableview")

	self._tableviewInvite = ScrollerList.create(tableviewGoInvite, cellGoInvite, GameUtil.handler(self._updateCellInvite, self), GameUtil.handler(self._clearCellInvite, self))
end

function ShowDownEliminateInviteInfoView:onExit()
	ShowDownEliminateInviteInfoView.super.onExit(self)
	self._tableviewInvite:dispose()
end

function ShowDownEliminateInviteInfoView:onEnter()
	ShowDownEliminateInviteInfoView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	self.addGEvent(self, GlobalNotify.HandlePM_ShowDownTeam_GetMyTeamApplyListRes, self._onGetInfo, self)
	self.addGEvent(self, GlobalNotify.HandlePM_ShowDownTeam_HandleApplyRes, self._onHandleApply, self)
	ShowDownController.instance:sendPM_ShowDownTeam_GetMyTeamApplyListReq(self._activityId)

	self._mo = ShowDownController.instance:getShowDownMo(self._activityId)

	self._mo:setCurHandleApplyInfo(nil)
	self:_onGetInfo()
end

function ShowDownEliminateInviteInfoView:_onGetInfo()
	local applyList = self._mo:getTeamApplyInfos()

	self._tableviewInvite:reloadData(applyList)
end

function ShowDownEliminateInviteInfoView:_onHandleApply()
	local curHandleApplyInfo = self._mo:getCurHandleApplyInfo()

	if curHandleApplyInfo then
		if curHandleApplyInfo.applyState == -1 then
			FloatWordMgr.instance:show(lang("已拒绝"))
		elseif curHandleApplyInfo.applyState == -2 then
			FloatWordMgr.instance:show(lang("未响应"))
		elseif curHandleApplyInfo.applyState == 1 then
			FloatWordMgr.instance:show(lang("已入队"))
		end
	end

	self._mo:setCurHandleApplyInfo(nil)

	local applyList = self._mo:getTeamApplyInfos()
	local dataList = {}

	for _, data in ipairs(applyList) do
		if data.applyState == 0 then
			table.insert(dataList, data)
		end
	end

	self._tableviewInvite:reloadData(dataList)
end

function ShowDownEliminateInviteInfoView:_updateCellInvite(view, cellGo, data)
	local cell = self:_clearCellInvite(cellGo)

	GameUtil.addClickHandler(cell.btnCancel, GameUtil.handler(self._onClickHandleApply, self, data, false))
	GameUtil.addClickHandler(cell.btnSure, GameUtil.handler(self._onClickHandleApply, self, data, true))
	goutil.setActive(cell.btnSure, data.applyState == 0)
	goutil.setActive(cell.btnCancel, data.applyState == 0)

	cell.txtName.text = data.headInfo.userName

	HeadItemController.instance:setHeadCellByInfo(cell.head, data.headInfo)

	cell.txtRecord.text = string.format("战绩：%s胜%s负", data.winCount, data.loseCount)
end

function ShowDownEliminateInviteInfoView:_onClickHandleApply(data, isAccept)
	self._mo:setCurHandleApplyInfo(data)

	data.applyState = isAccept and 0 or -1

	ShowDownController.instance:sendPM_ShowDownTeam_HandleApplyReq(self._activityId, checkint(data.headInfo.userId), isAccept)
end

function ShowDownEliminateInviteInfoView:_clearCellInvite(cellGo)
	local cell = {}

	cell.go = cellGo
	cell.btnCancel = goutil.findChild(cell.go, "btnCancel")
	cell.btnSure = goutil.findChild(cell.go, "btnSure")
	cell.txtName = goutil.findChildTextComponent(cell.go, "txtName")
	cell.txtRecord = goutil.findChildTextComponent(cell.go, "txtRecord")
	cell.head = goutil.findChild(cell.go, "head")

	HeadItemController.instance:resetHeadCell(cell.head)

	cell.tagRejected = goutil.findChild(cell.go, "tagRejected")

	GameUtil.rmClickHandler(cell.btnSure)
	GameUtil.rmClickHandler(cell.btnCancel)

	return cell
end

return ShowDownEliminateInviteInfoView
