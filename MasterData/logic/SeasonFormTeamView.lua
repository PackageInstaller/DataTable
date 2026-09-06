-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonFormTeamView.lua

module("logic.extensions.season.view.SeasonFormTeamView", package.seeall)

local SeasonFormTeamView = class("SeasonFormTeamView", ViewComponent)

function SeasonFormTeamView:ctor()
	SeasonFormTeamView.super.ctor(self)
end

function SeasonFormTeamView:unbindEvents()
	SeasonFormTeamView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnStart)
	GameUtil.rmClickHandler(self._btnExitTeam)
	GameUtil.rmClickHandler(self._btnExitTeam_2)
	GameUtil.rmClickHandler(self._btnInvite)
	GameUtil.rmClickHandler(self._btnTip)
end

function SeasonFormTeamView:bindEvents()
	SeasonFormTeamView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnStart, self._onClickStart, self)
	GameUtil.addClickHandler(self._btnExitTeam, self._onClickExitTeam, self)
	GameUtil.addClickHandler(self._btnExitTeam_2, self._onClickExitTeam, self)
	GameUtil.addClickHandler(self._btnInvite, self._onClickInvite, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
end

function SeasonFormTeamView:buildUI()
	SeasonFormTeamView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnStart = self:getGo("btnStart")
	self._headIcon1 = self:getGo("info1/headIcon")
	self._readyGo1 = self:getGo("info1/readyGo")
	self._txtName1 = self:getTxt("info1/txtName")
	self._headIcon2 = self:getGo("info2/headIcon")
	self._readyGo2 = self:getGo("info2/readyGo")
	self._txtName2 = self:getTxt("info2/txtName")
	self._btnExitTeam = self:getGo("btnExitTeam")
	self._btnExitTeam_2 = self:getGo("btnExitTeam_2")
	self._btnInvite = self:getGo("btnInvite")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtStart = self:getTxt("btnStart/txt")
	self._inviteTable = self:getGo("inviteTable/tableview")
	self._inviteCell = self:getGo("inviteCell")
end

function SeasonFormTeamView:onExit()
	SeasonFormTeamView.super.onExit(self)
	HeadItemController.instance:resetHeadCell(self._headIcon1)
	HeadItemController.instance:resetHeadCell(self._headIcon2)
	removetimer(self._refreshTimer, self)
end

function SeasonFormTeamView:onEnter()
	SeasonFormTeamView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.SeasonDetermineCreatePveGameMode, self._PM_SMGVEDetermineCreatePveGameModeRes, self)
	self.addGEvent(self, GlobalNotify.handlePM_SMGVEHandleGroupInviteRes, self._PM_SMGVEHandleGroupInviteRes, self)
	self.addGEvent(self, GlobalNotify.handlePM_NotifySMGVESuccessCreateGVERoomRes, self._PM_NotifySMGVESuccessCreateGVERoomRes, self)
	self.addGEvent(self, GlobalNotify.handlePM_SMGVEGroupInfoRes, self.refreshView, self)
	self.addGEvent(self, GlobalNotify.handlePM_SMGVEGroupReadyRes, self.refreshView, self)
	self.addGEvent(self, GlobalNotify.handlePM_SMGVEGroupLeaveRes, self.refreshView, self)
	self.addGEvent(self, GlobalNotify.handlePM_NotifySMGVESuccessCreateGroupRes, self.refreshView, self)
	self.addGEvent(self, GlobalNotify.handlePM_NotifySMGVEGroupDisbandRes, self.refreshView, self)
	self.addGEvent(self, GlobalNotify.handlePM_NotifySMGVEOpReadyRes, self._PM_NotifySMGVEOpReadyRes, self)
	self.addGEvent(self, GlobalNotify.handlePM_NotifySMGVEReceiveGroupInviteRes, self._PM_NotifySMGVEReceiveGroupInviteRes, self)
	self.addGEvent(self, GlobalNotify.FriendSelected, self._onFriendSelect, self)

	self._inviteList = ScrollerList.create(self._inviteTable, self._inviteCell, GameUtil.handler(self._updateInviteCell, self), GameUtil.handler(self._clearInviteCell, self))
	self._timerMap = {}
	self._inviteListData = {}

	self:refreshView()
	settimer(1, self._refreshTimer, self, true)
end

function SeasonFormTeamView:refreshView()
	local state = SeasonModel.instance:getGroupState()
	local data = SeasonModel.instance:getGroupInfo()

	GameUtil.SetActive(self._btnInvite, false)
	GameUtil.SetActive(self._btnStart, false)
	GameUtil.SetActive(self._btnExitTeam, false)
	GameUtil.SetActive(self._btnExitTeam_2, false)
	GameUtil.SetActive(self._readyGo1, false)
	GameUtil.SetActive(self._readyGo2, false)
	HeadItemController.instance:resetHeadCell(self._headIcon1)
	HeadItemController.instance:resetHeadCell(self._headIcon2)
	HeadItemController.instance:setHeadCellByInfo(self._headIcon1, RoleModel.instance:getHeadInfo(), false)

	self._txtName1.text = RoleModel.instance:getUserName()
	self._txtName2.text = lang("待加入...")

	if state == SeasonModel.GVE_GROUP_STATE_FREE then
		GameUtil.SetActive(self._btnInvite, true)
		GameUtil.SetActive(self._btnStart, true)

		self._txtStart.text = lang("直接开始")
	elseif state == SeasonModel.GVE_GROUP_STATE_GROUPING or SeasonModel.GVE_GROUP_STATE_GVE then
		GameUtil.SetActive(self._btnStart, true)
		GameUtil.SetActive(self._btnExitTeam, true)
		GameUtil.SetActive(self._btnExitTeam_2, true)
		HeadItemController.instance:setHeadCellByInfo(self._headIcon2, data.headInfo, false)

		self._txtName2.text = data.headInfo.userName

		GameUtil.SetActive(self._readyGo1, data.ready)
		GameUtil.SetActive(self._readyGo2, data.opReady)

		self._txtStart.text = state == SeasonModel.GVE_GROUP_STATE_GROUPING and lang("准备") or lang("开始")
	elseif state == SeasonModel.GVE_GROUP_STATE_PVE then
		-- block empty
	end

	self:_refreshInvite()
end

function SeasonFormTeamView:_refreshInvite()
	if self._viewPresentor.viewName ~= UIStateManager.instance:getTopName() then
		return
	end

	local showList = {}

	for i, v in pairs(self._inviteListData) do
		if ServerTime.now() < v.endShowTime then
			table.insert(showList, v)
		else
			self._inviteListData[i] = nil
		end
	end

	table.sort(showList, function(a, b)
		return a.endShowTime < b.endShowTime
	end)
	self._inviteList:reloadData(showList)

	if #showList > 0 then
		self:_refreshTimer()
	end
end

function SeasonFormTeamView:_refreshTimer()
	for txt, endTime in pairs(self._timerMap or {}) do
		local haveTime = endTime - ServerTime.now()

		if haveTime > 0 then
			txt.text = haveTime
		else
			self:_refreshInvite()

			return
		end
	end
end

function SeasonFormTeamView:_updateInviteCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtTime = goutil.findChildTextComponent(go, "cutdown/txt")
	local btnSure = goutil.findChild(go, "btnSure")
	local btnCancel = goutil.findChild(go, "btnCancel")
	local headIcon = goutil.findChild(go, "head")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local txtLevel = goutil.findChildTextComponent(go, "txtLevel")
	local invateInfo = data.invateInfo
	local headInfo = data.mo.headInfo

	GameUtil.addClickHandler(btnSure, function()
		self:_onClickAccept(invateInfo.userId)
	end, self)
	GameUtil.addClickHandler(btnCancel, function()
		self:_onClickReject(invateInfo.userId)
	end, self)

	self._timerMap[txtTime] = data.endShowTime

	HeadItemController.instance:setHeadCellByInfo(headIcon, headInfo, false, nil)

	txtName.text = headInfo.userName
	txtLevel.text = headInfo.playerLv
end

function SeasonFormTeamView:_clearInviteCell(cell)
	local go = cell.gameObject
	local txtTime = goutil.findChildTextComponent(go, "cutdown/txt")
	local btnSure = goutil.findChild(go, "btnSure")
	local btnCancel = goutil.findChild(go, "btnCancel")
	local headIcon = goutil.findChild(go, "head")

	HeadItemController.instance:resetHeadCell(headIcon)
	GameUtil.rmClickHandler(btnSure)
	GameUtil.rmClickHandler(btnCancel)

	self._timerMap[txtTime] = nil
end

function SeasonFormTeamView:_onClickStart()
	local state = SeasonModel.instance:getGroupState()
	local data = SeasonModel.instance:getGroupInfo()

	if state == SeasonModel.GVE_GROUP_STATE_FREE then
		TipsFacade:openPopupWindow(lang("提示"), lang("是否确认直接开始，直接开始后将无法修改进入双人组队模式"), function()
			SeasonModePvePlusAgent.instance:sendPM_SMGVEDetermineCreatePveGameModeReq()
		end)
	elseif state == SeasonModel.GVE_GROUP_STATE_GROUPING and data then
		if data.ready == true then
			FloatWordMgr.instance:show(lang("已准备，等待队友准备中"))
		else
			local content = langPara("是否确认进入赛季玩法时与好友%s组队，确认组队后将无法修改", data.headInfo.userName)

			TipsFacade:openPopupWindow(lang("提示"), content, function()
				SeasonModePvePlusAgent.instance:sendPM_SMGVEGroupReadyReq()
			end)
		end
	else
		self:close()
		SurveyController.instance:reportBehavior(SurveyBehaviorID.SeasonEnter)
		SeasonController.instance:enterSeasonTilingScene()
	end
end

function SeasonFormTeamView:_onClickExitTeam()
	local state = SeasonModel.instance:getGroupState()

	if state == SeasonModel.GVE_GROUP_STATE_GROUPING then
		SeasonModePvePlusAgent.instance:sendPM_SMGVEGroupLeaveReq()
	else
		FloatWordMgr.instance:show(lang("不在队伍当中"))
	end
end

function SeasonFormTeamView:_onClickInvite()
	SeasonModePvePlusAgent.instance:sendPM_SMGVEGroupInviteBuddyListReq()
end

function SeasonFormTeamView:_onClickTip()
	TipsFacade.instance:openRulesView("seasonformteamview")
end

function SeasonFormTeamView:_onClickAccept(userId)
	self._inviteListData[userId] = nil

	SeasonModePvePlusAgent.instance:sendPM_SMGVEHandleGroupInviteReq(userId, 1)
end

function SeasonFormTeamView:_onClickReject(userId)
	self._inviteListData[userId] = nil

	SeasonModePvePlusAgent.instance:sendPM_SMGVEHandleGroupInviteReq(userId, 0)
end

function SeasonFormTeamView:_onFriendSelect(ids)
	SeasonController.instance:sendPM_SMGVESendGroupInviteReq(ids)
end

function SeasonFormTeamView:_PM_SMGVEDetermineCreatePveGameModeRes()
	self:close()
	SurveyController.instance:reportBehavior(SurveyBehaviorID.SeasonEnter)
	SeasonController.instance:enterSeasonTilingScene()
end

function SeasonFormTeamView:_PM_NotifySMGVESuccessCreateGVERoomRes()
	self:close()
	SurveyController.instance:reportBehavior(SurveyBehaviorID.SeasonEnter)
	SeasonController.instance:enterSeasonTilingScene()
end

function SeasonFormTeamView:_PM_SMGVEHandleGroupInviteRes()
	SeasonModePvePlusAgent.instance:sendPM_SMGVEGroupInfoReq()
end

function SeasonFormTeamView:_PM_NotifySMGVEOpReadyRes()
	SeasonModePvePlusAgent.instance:sendPM_SMGVEGroupInfoReq()
end

function SeasonFormTeamView:_PM_NotifySMGVEReceiveGroupInviteRes(msg)
	local invateInfo = msg.invite
	local mo = FriendModel.instance:getFriendMo(invateInfo.userId)

	if not mo then
		return
	end

	SeasonController.instance:tryUnregPopupMsg(mo.headInfo.userId)

	self._inviteListData[mo.headInfo.userId] = {
		invateInfo = invateInfo,
		endShowTime = ServerTime.now() + 20,
		mo = mo
	}

	self:_refreshInvite()
end

return SeasonFormTeamView
