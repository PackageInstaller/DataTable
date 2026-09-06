-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/view/ShowDownTeamDetailView.lua

module("logic.extensions.showdown.view.ShowDownTeamDetailView", package.seeall)

local ShowDownTeamDetailView = class("ShowDownTeamDetailView", ViewComponent)

function ShowDownTeamDetailView:ctor()
	ShowDownTeamDetailView.super.ctor(self)
end

function ShowDownTeamDetailView:buildUI()
	ShowDownTeamDetailView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._btnRecruit = goutil.findChild(self.mainGO, "btnRecruit")
	self._btnJoin = goutil.findChild(self.mainGO, "btnJoin")
	self._memberView = goutil.findChild(self.mainGO, "memberView")
	self._memberCellList = {}

	for idx = 1, self._memberView.transform.childCount do
		local mainGo = self._memberView.transform:GetChild(idx - 1).gameObject
		local cell = {}

		cell._mainGo = mainGo
		cell._empty = goutil.findChild(mainGo, "empty")
		cell._headRoot = goutil.findChild(mainGo, "headRoot")
		cell._tagOfCaptain = goutil.findChild(mainGo, "tagOfCaptain")
		cell._txtBg = goutil.findChild(mainGo, "txtBg")
		cell._txtName = goutil.findChildTextComponent(mainGo, "txtBg/txtName")

		table.insert(self._memberCellList, cell)
	end

	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "txtTitle")
end

function ShowDownTeamDetailView:bindEvents()
	ShowDownTeamDetailView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnRecruit, self._onClickBtnRecruit, self)
	GameUtil.addClickHandler(self._btnJoin, self._onClickBtnJoin, self)
end

function ShowDownTeamDetailView:unbindEvents()
	ShowDownTeamDetailView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnRecruit)
	GameUtil.rmClickHandler(self._btnJoin)
end

function ShowDownTeamDetailView:onEnter()
	ShowDownTeamDetailView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._roundId = checknumber(params[2])
	self._teamId = checknumber(params[3])
	self._teamName = params[4]
	self._mainRaceInfo = ShowDownController.instance:getShowDownMo(self._activityId):getMainRaceInfoMo(self._roundId)
	self._msg = nil
	self._nextCanSendTimeStamp = self._nextCanSendTimeStamp or 0
	self._leftTime = Mathf.Max(checkint(self._nextCanSendTimeStamp - ServerTime.now()), 0)
	self._maxDelaySend = 10

	self.addGEvent(self, GlobalNotify.ShowDownStepChange, self.close, self)
	self.addGEvent(self, GlobalNotify.HandlePM_ShowDown_GetMainInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_ShowDown_GetScheduleInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_ShowDownTeam_GetTeamMemberInfoRes, self._handlePM_ShowDownTeam_GetTeamMemberInfoRes, self)
	ShowDownController.instance:sendPM_ShowDownTeam_GetTeamMemberInfoReq(self._activityId, self._teamId)
	self:_onUpdate()

	self._txtTitle.text = self._teamName

	GameUtil.SetGray(self._btnJoin, self._leftTime > 0)

	if self._leftTime > 0 then
		self:_ticking()
		settimer(1, self._ticking, self, true)
	end
end

function ShowDownTeamDetailView:onExit()
	ShowDownTeamDetailView.super.onExit(self)
	removetimer(self._ticking, self)

	self._msg = nil

	for idx, cell in ipairs(self._memberCellList) do
		HeadItemController.instance:resetHeadCell(cell._headRoot)
	end
end

function ShowDownTeamDetailView:_ticking()
	self._leftTime = Mathf.Max(checkint(self._nextCanSendTimeStamp - ServerTime.now()), 0)

	if self._leftTime <= 0 then
		removetimer(self._ticking, self)
		GameUtil.SetGray(self._btnJoin, false)
	end
end

function ShowDownTeamDetailView:_handlePM_ShowDownTeam_GetTeamMemberInfoRes(msg)
	self._msg = msg

	self:_onUpdate()
end

function ShowDownTeamDetailView:_onUpdate()
	local msg = self._msg
	local myTeamId = ShowDownController.instance:getMyTeamId(self._activityId, self._roundId)
	local isLeader = self._mainRaceInfo:isLeader()
	local isFighter = ShowDownController.instance:isFighter(self._activityId, self._roundId)
	local recruitResult, _ = self:getTryRecruitResultAndTips(self._activityId, self._teamId)

	GameUtil.SetActive(self._btnRecruit, recruitResult == GameEnum.ResultCode.Success)

	local joinResult, _ = self:getTryJoinResultAndTips(self._activityId, self._teamId)

	GameUtil.SetActive(self._btnJoin, joinResult == GameEnum.ResultCode.Success)

	if msg and msg.memberView then
		if not msg.memberView.members then
			local headInfos = {}

			for idx, cell in ipairs(self._memberCellList) do
				local headInfo = headInfos[idx]

				if headInfo and not string.nilorempty(headInfo.userName) then
					GameUtil.SetActive(cell._empty, false)

					local proxy = HeadItemController.instance:setHeadCellByInfo(cell._headRoot, headInfo, false)

					if proxy then
						proxy:setCallBack(function()
							ShowDownController.instance:opPlayerInfoView(cell._headRoot, self._activityId, headInfo)
						end)
					end

					cell._txtName.text = headInfo.userName

					GameUtil.SetActive(cell._txtBg.gameObject, true)
				else
					GameUtil.SetActive(cell._empty, true)
					HeadItemController.instance:resetHeadCell(cell._headRoot)

					cell._txtName.text = ""

					GameUtil.SetActive(cell._txtBg.gameObject, false)
				end

				GameUtil.SetActive(cell._tagOfCaptain, idx == 1)
			end
		end
	end
end

function ShowDownTeamDetailView:_onClickBtnRecruit()
	local result, tips = self:getTryRecruitResultAndTips(self._activityId, self._teamId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	UIStateManager.instance:push(ViewName.ShowDownEliminateRecuitView, self._activityId, self._teamId)
end

function ShowDownTeamDetailView:_onClickBtnJoin()
	if self._leftTime > 0 then
		FloatWordMgr.instance:show(string.format("请等待%d秒后再尝试", self._leftTime))

		return
	end

	local result, tips = self:getTryJoinResultAndTips(self._activityId, self._teamId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	self._nextCanSendTimeStamp = ServerTime.now() + self._maxDelaySend

	self:_ticking()
	settimer(1, self._ticking, self, true)
	GameUtil.SetGray(self._btnJoin, true)
	ShowDownController.instance:sendPM_ShowDownTeam_JoinReq(self._activityId, self._teamId)
end

function ShowDownTeamDetailView:getTryRecruitResultAndTips(activityId, teamId)
	local result = GameEnum.ResultCode.Success
	local tips = ""
	local roundId = self._roundId
	local mainRaceInfo = self._mainRaceInfo
	local myTeamId = ShowDownController.instance:getMyTeamId(self._activityId, roundId)
	local isMyTeam = self._teamId == myTeamId

	if not isMyTeam then
		result = GameEnum.ResultCode.Error
		tips = "非自己队伍无法进行操作"

		return GameEnum.ResultCode.Error, "非自己队伍无法进行操作"
	end

	local isInGroupRound = roundId == ShowDownEnum.Round_Eliminate_Group

	if not isInGroupRound then
		result = GameEnum.ResultCode.Error
		tips = "不在组队阶段无法进行组队"

		return GameEnum.ResultCode.Error, "不在组队阶段无法进行组队"
	end

	local isFighter = ShowDownController.instance:isFighter(self._activityId, roundId)

	if not isFighter then
		result = GameEnum.ResultCode.Error
		tips = "不是参赛选手无法进行组队"

		return GameEnum.ResultCode.Error, "不是参赛选手无法进行组队"
	end

	local isLeader = mainRaceInfo:isLeader()

	if not isLeader then
		result = GameEnum.ResultCode.Error
		tips = "不是队长无法进行招募"

		return GameEnum.ResultCode.Error, "不是队长无法进行招募"
	end

	return result, tips
end

function ShowDownTeamDetailView:getTryJoinResultAndTips(activityId, teamId)
	local result = GameEnum.ResultCode.Success
	local tips = ""
	local curRoundId = self._roundId
	local mainRaceInfo = self._mainRaceInfo
	local myTeamId = ShowDownController.instance:getMyTeamId(self._activityId, curRoundId)
	local isInGroupRound = curRoundId == ShowDownEnum.Round_Eliminate_Group

	if not isInGroupRound then
		result = GameEnum.ResultCode.Error
		tips = "不在组队阶段无法进行组队"

		return GameEnum.ResultCode.Error, "不在组队阶段无法进行组队"
	end

	local isFighter = ShowDownController.instance:isFighter(self._activityId, curRoundId)

	if not isFighter then
		result = GameEnum.ResultCode.Error
		tips = "不是参赛选手无法进行组队"

		return GameEnum.ResultCode.Error, "不是参赛选手无法进行组队"
	end

	local isLeader = mainRaceInfo:isLeader()

	if isLeader then
		result = GameEnum.ResultCode.Error
		tips = "队长无法加入其它队伍"

		return GameEnum.ResultCode.Error, "队长无法加入其它队伍"
	end

	return result, tips
end

return ShowDownTeamDetailView
