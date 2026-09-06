-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/controller/ShowDownController.lua

module("logic.extensions.showdown.controller.ShowDownController", package.seeall)

local ShowDownController = class("ShowDownController", BaseController)

function ShowDownController:ctor()
	self._stepMgrs = {}
	self._stepMgrDeltas = {}
	self._showDownMos = {}
end

function ShowDownController:onInit()
	GlobalDispatcher:addListener("entershowdown", self.enterShowDown, self)
	self:onReset()
end

function ShowDownController:onReset()
	self:_destroyAllStepMgr()
	table.clear(self._showDownMos)

	self._formationCustomFmtMo = nil
end

function ShowDownController:sendPM_ShowDown_SetWishListReq(activityId, roundId, wishListPetIds)
	ShowDownQualifyAndTeamAgent.instance:sendPM_ShowDown_SetWishListReq(activityId, roundId, wishListPetIds)
end

function ShowDownController:handlePM_ShowDown_SetWishListRes(msg)
	local activityId = msg.round.activityId

	self:getShowDownMo(activityId):handlePM_ShowDown_SetWishListRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_ShowDown_SetWishListRes)
end

function ShowDownController:sendPM_ShowDown_RollPetsReq(activityId, roundId)
	ShowDownQualifyAndTeamAgent.instance:sendPM_ShowDown_RollPetsReq(activityId, roundId)
end

function ShowDownController:handlePM_ShowDown_RollPetsRes(msg)
	local activityId = msg.round.activityId

	self:getShowDownMo(activityId):handlePM_ShowDown_RollPetsRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_ShowDown_RollPetsRes)
end

function ShowDownController:sendPM_ShowDown_ConfirmPetsReq(activityId, roundId)
	ShowDownQualifyAndTeamAgent.instance:sendPM_ShowDown_ConfirmPetsReq(activityId, roundId)
end

function ShowDownController:handlePM_ShowDown_ConfirmPetsRes(status, msg)
	if status == 0 then
		local activityId = msg.round.activityId

		self:getShowDownMo(activityId):handlePM_ShowDown_ConfirmPetsRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_ShowDown_ConfirmPetsRes, status)
end

function ShowDownController:sendPM_ShowDown_SetFormReq(activityId, roundId, formIndex, simpleForm, buffId)
	buffId = checknumber(buffId)

	ShowDownQualifyAndTeamAgent.instance:sendPM_ShowDown_SetFormReq(activityId, roundId, formIndex, simpleForm, buffId)
end

function ShowDownController:handlePM_ShowDown_SetFormRes(status, msg)
	if status == 0 then
		local activityId = msg.round.activityId

		self:getShowDownMo(activityId):handlePM_ShowDown_SetFormRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_ShowDown_SetFormRes, status, msg)
end

function ShowDownController:sendPM_ShowDown_ResetPetsAndFormReq(activityId, roundId, expectPrice)
	ShowDownQualifyAndTeamAgent.instance:sendPM_ShowDown_ResetPetsAndFormReq(activityId, roundId, tostring(expectPrice))
end

function ShowDownController:handlePM_ShowDown_ResetPetsAndFormRes(msg)
	local activityId = msg.round.activityId

	self:getShowDownMo(activityId):handlePM_ShowDown_ResetPetsAndFormRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_ShowDown_ResetPetsAndFormRes)
end

function ShowDownController:sendPM_ShowDown_GainDailyGuessItemReq(activityId)
	ShowDownQualifyAndTeamAgent.instance:sendPM_ShowDown_GainDailyGuessItemReq(activityId)
end

function ShowDownController:handlePM_ShowDown_GainDailyGuessItemRes(msg)
	local activityId = self:getRuningActivityId()

	self:getShowDownMo(activityId):handlePM_ShowDown_GainDailyGuessItemRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_ShowDown_GainDailyGuessItemRes)
end

function ShowDownController:sendPM_ShowDownTeam_GetPlayerViewReq(activityId, playerId)
	playerId = checknumber(playerId)

	ShowDownQualifyAndTeamAgent.instance:sendPM_ShowDownTeam_GetPlayerViewReq(activityId, playerId)
end

function ShowDownController:handlePM_ShowDownTeam_GetPlayerViewRes(msg)
	local activityId = self:getRuningActivityId()

	self:getShowDownMo(activityId):handlePM_ShowDownTeam_GetPlayerViewRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_ShowDownTeam_GetPlayerViewRes)
end

function ShowDownController:sendPM_ShowDownQualify_StartMatchingReq(activityId, qualType)
	ShowDownQualifyAndTeamAgent.instance:sendPM_ShowDownQualify_StartMatchingReq(activityId, qualType)
end

function ShowDownController:handlePM_ShowDownQualify_StartMatchingRes(status, msg)
	if status == 0 then
		local activityId = self:getRuningActivityId()

		self:getShowDownMo(activityId):handlePM_ShowDownQualify_StartMatchingRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_ShowDownQualify_StartMatchingRes, status)
end

function ShowDownController:sendPM_ShowDownQualify_CancelMatchingReq(activityId)
	ShowDownQualifyAndTeamAgent.instance:sendPM_ShowDownQualify_CancelMatchingReq(activityId)
end

function ShowDownController:handlePM_ShowDownQualify_CancelMatchingRes(msg)
	local activityId = self:getRuningActivityId()

	self:getShowDownMo(activityId):handlePM_ShowDownQualify_CancelMatchingRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_ShowDownQualify_CancelMatchingRes)
end

function ShowDownController:sendPM_ShowDownQualify_GetQualifyRankReq(activityId, qualtType)
	ShowDownQualifyAndTeamAgent.instance:sendPM_ShowDownQualify_GetQualifyRankReq(activityId, qualtType)
end

function ShowDownController:handlePM_ShowDownQualify_GetQualifyRankRes(msg)
	local activityId = msg.activityId

	self:getShowDownMo(activityId):handlePM_ShowDownQualify_GetQualifyRankRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_ShowDownQualify_GetQualifyRankRes, msg)
end

function ShowDownController:handlePM_ShowDownQualify_NotifyMatchBattleResultRes(msg)
	local activityId = msg.detail.activityId
	local changeSetId = msg.detail.changeSetId

	self:getShowDownMo(activityId):handlePM_ShowDownQualify_NotifyMatchBattleResultRes(msg)

	if changeSetId then
		MaterialController.instance:saveChangeSetToTemp(changeSetId)
	end

	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_ShowDownQualify_NotifyMatchBattleResultRes, msg)
end

function ShowDownController:sendPM_ShowDownQualify_GetQualifyBattleVideoReq(battleId)
	ShowDownQualifyAndTeamAgent.instance:sendPM_ShowDownQualify_GetQualifyBattleVideoReq(battleId)
end

function ShowDownController:handlePM_ShowDownQualify_GetQualifyBattleVideoRes(msg)
	local activityId = self:getRuningActivityId()

	self:getShowDownMo(activityId):handlePM_ShowDownQualify_GetQualifyBattleVideoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_ShowDownQualify_GetQualifyBattleVideoRes, msg)
end

function ShowDownController:handlePM_ShowDownQualify_NotifyMatchFailRes(status, msg)
	if status == 0 then
		local activityId = self:getRuningActivityId()

		self:getShowDownMo(activityId):handlePM_ShowDownQualify_NotifyMatchFailRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_ShowDownQualify_NotifyMatchFailRes, status)
end

function ShowDownController:sendPM_ShowDownTeam_SetMyTeamInfoReq(activityId, teamInfo)
	ShowDownQualifyAndTeamAgent.instance:sendPM_ShowDownTeam_SetMyTeamInfoReq(activityId, teamInfo)
end

function ShowDownController:handlePM_ShowDownTeam_SetMyTeamInfoRes(msg)
	local activityId = self:getRuningActivityId()

	self:getShowDownMo(activityId):handlePM_ShowDownTeam_SetMyTeamInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_ShowDownTeam_SetMyTeamInfoRes)
end

function ShowDownController:sendPM_ShowDownTeam_GetOtherGroupInfoReq(activityId, groupId)
	ShowDownQualifyAndTeamAgent.instance:sendPM_ShowDownTeam_GetOtherGroupInfoReq(activityId, groupId)
end

function ShowDownController:handlePM_ShowDownTeam_GetOtherGroupInfoRes(msg)
	local activityId = self:getRuningActivityId()

	self:getShowDownMo(activityId):handlePM_ShowDownTeam_GetOtherGroupInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_ShowDownTeam_GetOtherGroupInfoRes)
end

function ShowDownController:sendPM_ShowDownTeam_GetTeamMemberInfoReq(activityId, teamId)
	ShowDownQualifyAndTeamAgent.instance:sendPM_ShowDownTeam_GetTeamMemberInfoReq(activityId, teamId)
end

function ShowDownController:handlePM_ShowDownTeam_GetTeamMemberInfoRes(msg)
	local activityId = self:getRuningActivityId()

	self:getShowDownMo(activityId):handlePM_ShowDownTeam_GetTeamMemberInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_ShowDownTeam_GetTeamMemberInfoRes, msg)
end

function ShowDownController:sendPM_ShowDownTeam_SendEnlistMsgReq(activityId, teamId, left, right, winCount, ownRaceCount)
	left = checknumber(left)
	right = checknumber(right)
	winCount = checknumber(winCount)
	ownRaceCount = checknumber(ownRaceCount)

	ShowDownQualifyAndTeamAgent.instance:sendPM_ShowDownTeam_SendEnlistMsgReq(activityId, teamId, left, right, winCount, ownRaceCount)
end

function ShowDownController:handlePM_ShowDownTeam_SendEnlistMsgRes(msg)
	local activityId = self:getRuningActivityId()

	self:getShowDownMo(activityId):handlePM_ShowDownTeam_SendEnlistMsgRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_ShowDownTeam_SendEnlistMsgRes)
end

function ShowDownController:sendPM_ShowDownTeam_GetMyTeamApplyListReq(activityId)
	ShowDownQualifyAndTeamAgent.instance:sendPM_ShowDownTeam_GetMyTeamApplyListReq(activityId)
end

function ShowDownController:handlePM_ShowDownTeam_GetMyTeamApplyListRes(msg)
	local activityId = self:getRuningActivityId()

	self:getShowDownMo(activityId):handlePM_ShowDownTeam_GetMyTeamApplyListRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_ShowDownTeam_GetMyTeamApplyListRes)
end

function ShowDownController:sendPM_ShowDownTeam_GetOrRefreshTeamListReq(activityId)
	ShowDownQualifyAndTeamAgent.instance:sendPM_ShowDownTeam_GetOrRefreshTeamListReq(activityId)
end

function ShowDownController:handlePM_ShowDownTeam_GetOrRefreshTeamListRes(msg)
	local activityId = self:getRuningActivityId()

	self:getShowDownMo(activityId):handlePM_ShowDownTeam_GetOrRefreshTeamListRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_ShowDownTeam_GetOrRefreshTeamListRes)
end

function ShowDownController:sendPM_ShowDownTeam_SearchTeamReq(activityId, keyword, beginIndex, endIndex)
	ShowDownQualifyAndTeamAgent.instance:sendPM_ShowDownTeam_SearchTeamReq(activityId, keyword, beginIndex, endIndex)
end

function ShowDownController:handlePM_ShowDownTeam_SearchTeamRes(msg)
	local activityId = self:getRuningActivityId()

	self:getShowDownMo(activityId):handlePM_ShowDownTeam_SearchTeamRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_ShowDownTeam_SearchTeamRes)
end

function ShowDownController:sendPM_ShowDownTeam_QuickJoinReq(activityId)
	ShowDownQualifyAndTeamAgent.instance:sendPM_ShowDownTeam_QuickJoinReq(activityId)
end

function ShowDownController:handlePM_ShowDownTeam_QuickJoinRes(msg)
	local activityId = self:getRuningActivityId()

	self:getShowDownMo(activityId):handlePM_ShowDownTeam_QuickJoinRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_ShowDownTeam_QuickJoinRes, msg.teamId)
end

function ShowDownController:sendPM_ShowDownTeam_JoinReq(activityId, teamId, inviteCode)
	inviteCode = inviteCode == nil and "" or tostring(inviteCode)

	ShowDownQualifyAndTeamAgent.instance:sendPM_ShowDownTeam_JoinReq(activityId, teamId, inviteCode)
end

function ShowDownController:handlePM_ShowDownTeam_JoinRes(status, msg)
	if status == 0 then
		local activityId = self:getRuningActivityId()

		self:getShowDownMo(activityId):handlePM_ShowDownTeam_JoinRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_ShowDownTeam_JoinRes, status, msg)
end

function ShowDownController:sendPM_ShowDownTeam_HandleApplyReq(activityId, memberId, agree)
	ShowDownQualifyAndTeamAgent.instance:sendPM_ShowDownTeam_HandleApplyReq(activityId, memberId, agree)
end

function ShowDownController:handlePM_ShowDownTeam_HandleApplyRes(msg)
	local activityId = self:getRuningActivityId()

	self:getShowDownMo(activityId):handlePM_ShowDownTeam_HandleApplyRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_ShowDownTeam_HandleApplyRes)

	local info = GameUtil.pbToTable(msg)

	if info.handled and info.sucJoinTeam then
		GlobalDispatcher:dispatch(GlobalNotify.HandlePM_ShowDown_NotifyMyTeamDataChange)
	end
end

function ShowDownController:handlePM_ShowDown_NotifyJoinTeamRes(msg)
	local activityId = self:getRuningActivityId()

	self:getShowDownMo(activityId):handlePM_ShowDown_NotifyJoinTeamRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_ShowDown_NotifyJoinTeamRes, msg)
end

function ShowDownController:sendPM_ShowDown_GetQualifyMainInfoReq(activityId)
	ShowDownAgent.instance:sendPM_ShowDown_GetQualifyMainInfoReq(activityId)
end

function ShowDownController:handlePM_ShowDown_GetQualifyMainInfoRes(status, msg)
	if status == 0 then
		local activityId = msg.activityId

		self:getShowDownMo(activityId):handlePM_ShowDown_GetQualifyMainInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.HandlePM_ShowDown_GetQualifyMainInfoRes)
	else
		GlobalDispatcher:dispatch(GlobalNotify.ShowDownClose)
	end
end

function ShowDownController:sendPM_ShowDown_GetJoyModeInfoReq(activityId)
	ShowDownAgent.instance:sendPM_ShowDown_GetJoyModeInfoReq(activityId)
end

function ShowDownController:handlePM_ShowDown_GetJoyModeInfoRes(status, msg)
	if status == 0 then
		local activityId = msg.activityId

		self:getShowDownMo(activityId):handlePM_ShowDown_GetJoyModeInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.HandlePM_ShowDown_GetJoyModeInfoRes)
	else
		GlobalDispatcher:dispatch(GlobalNotify.ShowDownClose)
	end
end

function ShowDownController:sendPM_ShowDown_GetTeamMainInfoReq(activityId, groupId)
	ShowDownAgent.instance:sendPM_ShowDown_GetTeamMainInfoReq(activityId, groupId)
end

function ShowDownController:handlePM_ShowDown_GetTeamMainInfoRes(status, msg)
	if status == 0 then
		local activityId = msg.activityId
		local groupId = msg.teamMainInfo.groupInfo.groupId

		self:getShowDownMo(activityId):handlePM_ShowDown_GetTeamMainInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.HandlePM_ShowDown_GetTeamMainInfoRes, groupId)
	else
		GlobalDispatcher:dispatch(GlobalNotify.ShowDownClose)
	end
end

function ShowDownController:sendPM_ShowDown_GetMainInfoReq(activityId, groupId)
	ShowDownAgent.instance:sendPM_ShowDown_GetMainInfoReq(activityId, groupId)
end

function ShowDownController:handlePM_ShowDown_GetMainInfoRes(status, msg)
	if status == 0 then
		local activityId = msg.activityId
		local groupId = msg.groupId

		self:getShowDownMo(activityId):handlePM_ShowDown_GetMainInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.HandlePM_ShowDown_GetMainInfoRes, groupId)
	else
		GlobalDispatcher:dispatch(GlobalNotify.ShowDownClose)
	end
end

function ShowDownController:sendPM_ShowDown_GetScheduleInfoReq(activityId)
	ShowDownAgent.instance:sendPM_ShowDown_GetScheduleInfoReq(activityId)
end

function ShowDownController:handlePM_ShowDown_GetScheduleInfoRes(msg)
	local activityId = msg.activityId

	self:getShowDownMo(activityId):handlePM_ShowDown_GetScheduleInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_ShowDown_GetScheduleInfoRes)
end

function ShowDownController:sendPM_ShowDownKnockout_GetBattleOrderReq(activityId, roundId, teamId)
	ShowDownAgent.instance:sendPM_ShowDownKnockout_GetBattleOrderReq(activityId, roundId, teamId)
end

function ShowDownController:handlePM_ShowDownKnockout_GetBattleOrderRes(msg)
	local activityId = msg.activityId

	self:getShowDownMo(activityId):handlePM_ShowDownKnockout_GetBattleOrderRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_ShowDownKnockout_GetBattleOrderRes)
end

function ShowDownController:sendPM_ShowDownKnockout_AdjustBattleOrderReq(activityId, roundId, memberIdList)
	ShowDownAgent.instance:sendPM_ShowDownKnockout_AdjustBattleOrderReq(activityId, roundId, memberIdList)
end

function ShowDownController:handlePM_ShowDownKnockout_AdjustBattleOrderRes(msg)
	local activityId = msg.activityId

	self:getShowDownMo(activityId):handlePM_ShowDownKnockout_AdjustBattleOrderRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_ShowDownKnockout_AdjustBattleOrderRes)
end

function ShowDownController:sendPM_ShowDown_GetGuessRecordReq(activityId)
	ShowDownAgent.instance:sendPM_ShowDown_GetGuessRecordReq(activityId)
end

function ShowDownController:handlePM_ShowDown_GetGuessRecordRes(msg)
	local activityId = msg.activityId

	self:getShowDownMo(activityId):handlePM_ShowDown_GetGuessRecordRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_ShowDown_GetGuessRecordRes)
end

function ShowDownController:sendPM_ShowDown_GuessReq(activityId, teamId, guessNum)
	ShowDownAgent.instance:sendPM_ShowDown_GuessReq(activityId, teamId, guessNum)
end

function ShowDownController:handlePM_ShowDown_GuessRes(msg)
	local activityId = msg.activityId

	self:getShowDownMo(activityId):handlePM_ShowDown_GuessRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_ShowDown_GuessRes)
end

function ShowDownController:sendPM_ShowDown_GetDisplayInfoReq(activityId)
	ShowDownAgent.instance:sendPM_ShowDown_GetDisplayInfoReq(activityId)
end

function ShowDownController:handlePM_ShowDown_GetDisplayInfoRes(msg)
	local activityId = msg.activityId

	self:getShowDownMo(activityId):handlePM_ShowDown_GetDisplayInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_ShowDown_GetDisplayInfoRes)
end

function ShowDownController:sendPM_ShowDown_GetBattleRecordsReq(activityId, stepId, teamId, otherTeamId)
	ShowDownAgent.instance:sendPM_ShowDown_GetBattleRecordsReq(activityId, stepId, teamId, otherTeamId)
end

function ShowDownController:handlePM_ShowDown_GetBattleRecordsRes(msg)
	local activityId = msg.activityId

	self:getShowDownMo(activityId):handlePM_ShowDown_GetBattleRecordsRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_ShowDown_GetBattleRecordsRes)
end

function ShowDownController:sendPM_ShowDown_GetFinalMatchBattleVideoReq(battleId)
	ShowDownAgent.instance:sendPM_ShowDown_GetFinalMatchBattleVideoReq(battleId)
end

function ShowDownController:handlePM_ShowDown_GetFinalMatchBattleVideoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_ShowDown_GetFinalMatchBattleVideoRes)
end

function ShowDownController:sendPM_ShowDown_GetGroupMatchBattleDetailReq(battleId)
	ShowDownAgent.instance:sendPM_ShowDown_GetGroupMatchBattleDetailReq(battleId)
end

function ShowDownController:handlePM_ShowDown_GetGroupMatchBattleDetailRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_ShowDown_GetGroupMatchBattleDetailRes, msg)
end

function ShowDownController:sendPM_ShowDown_FinalMatchGuessReq(activityId, guessRank, teamId, guessNum)
	ShowDownAgent.instance:sendPM_ShowDown_FinalMatchGuessReq(activityId, guessRank, teamId, guessNum)
end

function ShowDownController:handlePM_ShowDown_FinalMatchGuessRes(msg)
	local activityId = msg.activityId

	self:getShowDownMo(activityId):handlePM_ShowDown_FinalMatchGuessRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_ShowDown_FinalMatchGuessRes)
end

function ShowDownController:sendPM_ShowDown_GetStepInfoReq(activityId)
	ShowDownAgent.instance:sendPM_ShowDown_GetStepInfoReq(activityId)
end

function ShowDownController:handlePM_ShowDown_GetStepInfoRes(status, msg)
	if status == 0 then
		local activityId = msg.activityId

		self:getShowDownMo(activityId):handlePM_ShowDown_GetStepInfoRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_ShowDown_GetStepInfoRes, status, msg)
end

function ShowDownController:handlePM_ShowDown_NotifyStepChangeRes(msg)
	local activityId = msg.activityId

	self:getShowDownMo(activityId):handlePM_ShowDown_NotifyStepChangeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_ShowDown_NotifyStepChangeRes)
end

function ShowDownController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(self:getActivityType())
end

function ShowDownController:getActivityType()
	return GameEnum.ActivityType.ShowDown
end

function ShowDownController:isInActivityTime(activityId)
	local activityType = self:getActivityType()

	return ActivityDefineController.instance:isInActivityTimeById(activityType, activityId)
end

function ShowDownController:enterShowDown()
	local activityId = self:getActivityId()
	local result, tips = self:getTryEnterShowDownResultAndTips(activityId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	GlobalDispatcher:addListener(GlobalNotify.HandlePM_ShowDown_GetStepInfoRes, self._handleEnterShowDown, self)
	ShowDownController.instance:sendPM_ShowDown_GetStepInfoReq(activityId)
end

function ShowDownController:_handleEnterShowDown(status, msg)
	GlobalDispatcher:removeListener(GlobalNotify.HandlePM_ShowDown_GetStepInfoRes, self._handleEnterShowDown, self)

	if status ~= 0 then
		return
	end

	local activityId = msg.activityId

	self:setRuningActivityId(activityId)
	UIStateManager.instance:push(ViewName.ShowDownMainView, activityId)
end

function ShowDownController:getShowDownMo(activityId)
	if self._showDownMos[activityId] == nil then
		self._showDownMos[activityId] = ShowDownMo.New(activityId)
	end

	return self._showDownMos[activityId]
end

function ShowDownController:setRuningActivityId(activityId)
	self._runingActivityId = checknumber(activityId)
end

function ShowDownController:getRuningActivityId()
	return self._runingActivityId
end

function ShowDownController:getTryEnterShowDownResultAndTips(activityId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not self:isInActivityTime(activityId) then
		result = GameEnum.ResultCode.NotInTime
		tips = "不在开启期限内"
	end

	return result, tips
end

function ShowDownController:enterInStepMgr(activityId)
	local stepMgr = self._stepMgrs[activityId]

	if stepMgr == nil then
		self._stepMgrs[activityId] = ShowDownStepMgr.New(activityId)
		stepMgr = self._stepMgrs[activityId]
		self._stepMgrDeltas[activityId] = 0
	end

	if not self._stepMgrDeltas[activityId] then
		local curDelta = 0

		if curDelta == 0 then
			stepMgr:onEnter()
		end

		self._stepMgrDeltas[activityId] = curDelta + 1
	end
end

function ShowDownController:exitInStepMgr(activityId)
	local stepMgr = self._stepMgrs[activityId]

	if stepMgr then
		self._stepMgrDeltas[activityId] = Mathf.Max(checknumber(self._stepMgrDeltas[activityId]) - 1, 0)

		if self._stepMgrDeltas[activityId] <= 0 then
			stepMgr:onExit()
		end
	end
end

function ShowDownController:_destroyAllStepMgr()
	for activityId, stepMgr in pairs(self._stepMgrs) do
		stepMgr:onDestroy()

		self._stepMgrs[activityId] = nil
		self._stepMgrDeltas[activityId] = 0
	end
end

function ShowDownController:_getStepMgr(activityId)
	return self._stepMgrs[activityId]
end

function ShowDownController:getLeftTimeStampToNext(activityId, stepId)
	local mgr = self:_getStepMgr(activityId)

	if mgr and mgr:getMgrState() == ShowDownStepMgr.MgrState_Running then
		return mgr:getLeftTimeStampToNext(stepId)
	else
		return 0
	end
end

function ShowDownController:getLeftTimeStampToNextInVote(activityId, stepId)
	local mgr = self:_getStepMgr(activityId)

	if mgr and mgr:getMgrState() == ShowDownStepMgr.MgrState_Running then
		return mgr:getLeftTimeStampToNextInVote(stepId)
	else
		return 0
	end
end

function ShowDownController:getCurStepId(activityId)
	return self:getShowDownMo(activityId):getCurStepId()
end

function ShowDownController:getRoundIdByStep(activityId, stepId)
	local stepData = ShowDownConfig.instance:getStepData(activityId, stepId)

	if stepData == nil then
		printError(string.format("stepId 不存在，请联系开发： %s %s", activityId, stepId))
	end

	return (stepData or nil) and (stepData.roundId or 0)
end

function ShowDownController:getStepTimeStamp(activityId, startStepId, endStepId)
	local startStamp, endStamp = 0, 0
	local curStepData = ShowDownConfig.instance:getStepData(activityId, startStepId)
	local nextStepData = ShowDownConfig.instance:getStepData(activityId, endStepId)

	if curStepData and nextStepData then
		local startTime, endTime = curStepData.startTime, nextStepData.startTime

		if not string.nilorempty(startTime) then
			startStamp = GameUtil.string2time(startTime)
		end

		if not string.nilorempty(endTime) then
			endStamp = GameUtil.string2time(endTime)
		end
	elseif curStepData and nextStepData == nil then
		local startTime = curStepData.startTime

		if not string.nilorempty(startTime) then
			startStamp = GameUtil.string2time(startTime)
		end

		local activityType = self:getActivityType()
		local actStartStamp, actEndStamp = ActivityDefineController.instance:getStartTimeAndEndTime(activityType, activityId)

		endStamp = actEndStamp
	end

	return startStamp, endStamp
end

function ShowDownController:getRacePeriodByStep(activityId, roundId)
	local racePeriod = ShowDownEnum.RoundInRace[roundId]

	return racePeriod or ShowDownEnum.RacePeriod_Error
end

function ShowDownController:getFormPeriodInStep(activityId, stepId)
	local data = ShowDownConfig.instance:getStepData(activityId, stepId)
	local formPeriod = data and data.formPeriod

	if string.nilorempty(formPeriod) then
		formPeriod = ShowDownEnum.FormPeriod_None
	end

	return formPeriod
end

function ShowDownController:isCanGuessInStep(activityId, stepId)
	local data = ShowDownConfig.instance:getStepData(activityId, stepId)

	return (data or nil) and (data.canGuess or false)
end

function ShowDownController:isCanChangeOrderInStep(activityId, stepId)
	local data = ShowDownConfig.instance:getStepData(activityId, stepId)

	return (data or nil) and (data.canChangeOrder or false)
end

function ShowDownController:isBattleStepInStep(activityId, stepId)
	local data = ShowDownConfig.instance:getStepData(activityId, stepId)

	return (data or nil) and (data.battleStep or false)
end

function ShowDownController:isShowResultInStep(activityId, stepId)
	local data = ShowDownConfig.instance:getStepData(activityId, stepId)

	return (data or nil) and (data.showResult or false)
end

function ShowDownController:getFormIndexInStep(activityId, roundId, stepId)
	local formIndex = 0
	local racePeriod = self:getRacePeriodByStep(activityId, roundId)

	if racePeriod == ShowDownEnum.RacePeriod_Qualify then
		formIndex = 1
	elseif racePeriod == ShowDownEnum.RacePeriod_Eliminate then
		local data = ShowDownConfig.instance:getStepData(activityId, stepId)

		formIndex = data and data.formIndex or 1
	elseif racePeriod == ShowDownEnum.RacePeriod_Final then
		formIndex = 1
	elseif racePeriod == ShowDownEnum.RacePeriod_Func then
		formIndex = ShowDownEnum.FormIndexFunc
	end

	return formIndex
end

function ShowDownController:getShowTipsInStep(activityId, stepId)
	local data = ShowDownConfig.instance:getStepData(activityId, stepId)

	return (data or nil) and (data.showTips or "")
end

function ShowDownController:isCanSelectBuffInRound(activityId, roundId)
	local roundData = ShowDownConfig.instance:getRoundData(activityId, roundId)

	if roundData then
		return roundData.selectBuffPlanId > 0
	end

	return false
end

function ShowDownController:isCanShopPetInRound(activityId, roundId)
	local roundData = ShowDownConfig.instance:getRoundData(activityId, roundId)

	if roundData then
		return roundData.selectPetPlanId > 0
	end

	return false
end

function ShowDownController:isNeedGuessInAct(activityId)
	local showDownMo = self:getShowDownMo(activityId)

	return showDownMo:isNeedGuessInAct()
end

function ShowDownController:enterShowDownPetShopAndFmt(activityId, roundId, stepId)
	if self._formationCustomFmtMo == nil then
		self._formationCustomFmtMo = ShowDownFormationCustomFmtMo.New()
	end

	local customFmtMo = self._formationCustomFmtMo

	customFmtMo:updateCfg(activityId, roundId, stepId)
	CustomFmtController.instance:showMissionFormationView(customFmtMo)
end

function ShowDownController:enterShowDownPetShop(activityId, roundId)
	UIStateManager.instance:push(ViewName.ShowDownPetShopView, activityId, roundId)
end

function ShowDownController:_getPetShopMo(activityId, roundId)
	local showDownMo = self:getShowDownMo(activityId)

	return showDownMo:getPetShopMo(roundId)
end

function ShowDownController:getMaxWishPetCountInPetShop(activityId, roundId)
	local petShopMo = self:_getPetShopMo(activityId, roundId)

	return petShopMo:getMaxWishPetCount()
end

function ShowDownController:getMaxPetCountInPetShop(activityId, roundId)
	local petShopMo = self:_getPetShopMo(activityId, roundId)

	return petShopMo:getMaxPetCount()
end

function ShowDownController:getMaxRefreshTimesInPetShop(activityId, roundId)
	local petShopMo = self:_getPetShopMo(activityId, roundId)

	return petShopMo:getMaxRefreshTimes()
end

function ShowDownController:getCurRefreshTimesInPetShop(activityId, roundId)
	local petShopMo = self:_getPetShopMo(activityId, roundId)

	return petShopMo:getCurRefreshTimes()
end

function ShowDownController:getLeftRefreshTimesInPetShop(activityId, roundId)
	local cur = self:getCurRefreshTimesInPetShop(activityId, roundId)
	local max = self:getMaxRefreshTimesInPetShop(activityId, roundId)

	return Mathf.Max(max - cur, 0)
end

function ShowDownController:getMaxResetTimesInPetShop(activityId, roundId)
	local petShopMo = self:_getPetShopMo(activityId, roundId)

	return petShopMo:getMaxResetTimes()
end

function ShowDownController:getCurResetTimesInPetShop(activityId, roundId)
	local petShopMo = self:_getPetShopMo(activityId, roundId)

	return petShopMo:getCurResetTimes()
end

function ShowDownController:getLeftResetTimesInPetShop(activityId, roundId)
	local cur = self:getCurResetTimesInPetShop(activityId, roundId)
	local max = self:getMaxResetTimesInPetShop(activityId, roundId)

	return Mathf.Max(max - cur, 0)
end

function ShowDownController:isHasConfirmInPetShop(activityId, roundId)
	local petShopMo = self:_getPetShopMo(activityId, roundId)

	return petShopMo:isHasConfirm()
end

function ShowDownController:isHasFirstDrawInPetShop(activityId, roundId)
	local petShopMo = self:_getPetShopMo(activityId, roundId)

	return petShopMo:isHasFirstDraw()
end

function ShowDownController:getCostInRefreshTimesInPetShop(activityId, roundId, times)
	local data = ShowDownConfig.instance:getBuyRefreshTimesDataByTimes(activityId, roundId, times)

	return data and data.cost
end

function ShowDownController:getWishPetListInPetShop(activityId, roundId)
	local petShopMo = self:_getPetShopMo(activityId, roundId)
	local list = {}
	local wishPetList = petShopMo:getWishPetList()

	for i, v in ipairs(wishPetList) do
		table.insert(list, v)
	end

	return list
end

function ShowDownController:setWishPetListInPetShop(activityId, roundId, wishPetList)
	local petShopMo = self:_getPetShopMo(activityId, roundId)

	return petShopMo:setWishPetList(wishPetList)
end

function ShowDownController:clearWishPetListInPetShop(activityId, roundId)
	local petShopMo = self:_getPetShopMo(activityId, roundId)

	return petShopMo:clearWishPetList()
end

function ShowDownController:getWishPetCountInPetShop(activityId, roundId)
	local petShopMo = self:_getPetShopMo(activityId, roundId)
	local list = petShopMo:getWishPetList()

	return #list
end

function ShowDownController:getShopPetListInPetShop(activityId, roundId)
	local petShopMo = self:_getPetShopMo(activityId, roundId)

	return petShopMo:getShopPetList()
end

function ShowDownController:getBagPetListInPetShop(activityId, roundId)
	local petShopMo = self:_getPetShopMo(activityId, roundId)

	return petShopMo:getBagPetList()
end

function ShowDownController:isEmptyFormInPetShop(activityId, roundId, stepId)
	local formIndex = self:getFormIndexInStep(activityId, roundId, stepId)
	local formMo = self:getShowDownFormMoInPetShop(activityId, roundId, formIndex)

	if formMo then
		return formMo:isEmptyForm()
	else
		return true
	end
end

function ShowDownController:getShowDownFormMoInPetShop(activityId, roundId, formIndex)
	local list = self:getShowDownFormMoListInPetShop(activityId, roundId)

	return list[formIndex]
end

function ShowDownController:getShowDownFormMoListInPetShop(activityId, roundId)
	local petShopMo = self:_getPetShopMo(activityId, roundId)

	return petShopMo:getShowDownFormMoList()
end

function ShowDownController:getCurChallengeTimesInQualify(activityId, qualType)
	local showDownMo = self:getShowDownMo(activityId)

	return showDownMo:getCurChallengeTimesInQualify(qualType)
end

function ShowDownController:getMaxChallengeTimesInQualify(activityId, qualType)
	local prizeCfg = ShowDownConfig.instance:getQualifyPrizeCfg(activityId, qualType)
	local data = prizeCfg and prizeCfg[#prizeCfg]

	return (data or nil) and (data.times or 0)
end

function ShowDownController:getLeftChallengeTimesInQualify(activityId, qualType)
	local cur = self:getCurChallengeTimesInQualify(activityId, qualType)
	local max = self:getMaxChallengeTimesInQualify(activityId, qualType)

	return Mathf.Max(max - cur, 0)
end

function ShowDownController:isMatchTimeInQualify(activityId, qualType)
	local startTime, endTime = self:getMatchTimeInQualify(activityId, qualType)

	return GameUtil.getTimePeriod(startTime, endTime) == GameUtil.inTimePeriod
end

function ShowDownController:getMatchTimeInQualify(activityId, qualType)
	local data = ShowDownConfig.instance:getQualifyData(activityId, qualType)

	if data and not string.nilorempty(data.matchTimePeriodStr) then
		local arr = string.split(data.matchTimePeriodStr, "#")
		local startTime, endTime = "0-0-0 " .. arr[1], "0-0-0 " .. arr[2]

		return startTime, endTime
	end
end

function ShowDownController:isEndMatchMinuteEarlyInQualify(activityId, qualType)
	local isEnd = true
	local data = ShowDownConfig.instance:getQualifyData(activityId, qualType)

	if data then
		local endMatchMinuteEarly = data.endMatchMinuteEarly
		local endEarlyStamp = endMatchMinuteEarly * 60
		local _, endStamp = ShowDownController.instance:getStepTimeStamp(activityId, 1, 2)
		local startStamp = endStamp - endEarlyStamp
		local timePeriod = GameUtil.getTimePeriodTypeBySec(startStamp, endStamp)

		isEnd = timePeriod >= GameUtil.inTimePeriod
	end

	return isEnd
end

function ShowDownController:getPlayerRoundId(activityId)
	local showDownMo = self:getShowDownMo(activityId)

	return showDownMo:getPlayerRoundId()
end

function ShowDownController:isFighter(activityId, roundId)
	if roundId == ShowDownEnum.Round_Qualify then
		return true
	elseif roundId == ShowDownEnum.Round_Eliminate_Group then
		local mainRaceInfo = self:getShowDownMo(activityId):getMainRaceInfoMo(ShowDownEnum.Round_Eliminate_Group)

		return mainRaceInfo:isPromotionGroup()
	else
		local playerRoundId = self:getPlayerRoundId(activityId)

		return roundId <= playerRoundId
	end
end

function ShowDownController:getMyTeamId(activityId, roundId)
	local myTeamId = -1
	local racePeriod = ShowDownEnum.RoundInRace[roundId]

	if roundId == ShowDownEnum.Round_Eliminate_Group then
		local showDownMo = self:getShowDownMo(activityId)
		local mainRaceInfo = showDownMo:getMainRaceInfoMo(roundId)

		myTeamId = mainRaceInfo:getMyTeamId()
	elseif racePeriod == ShowDownEnum.RacePeriod_Eliminate then
		local schedule = self:getScheduleInfoInElimate(activityId)

		myTeamId = schedule:getMyTeamOfTeamId()
	elseif racePeriod == ShowDownEnum.RacePeriod_Final then
		local schedule = self:getScheduleInfoInFinal(activityId)

		myTeamId = schedule:getMyTeamOfTeamId()
	end

	return myTeamId
end

function ShowDownController:getMyFinalRank(activityId)
	local showDownMo = self:getShowDownMo(activityId)

	return showDownMo:getMyFinalRank()
end

function ShowDownController:getScheduleInfoInQualify(activityId)
	local showDownMo = self:getShowDownMo(activityId)

	return showDownMo:getScheduleInfoInQualify()
end

function ShowDownController:getScheduleInfoInElimate(activityId)
	local showDownMo = self:getShowDownMo(activityId)

	return showDownMo:getScheduleInfoInElimate()
end

function ShowDownController:getScheduleInfoInFinal(activityId)
	local showDownMo = self:getShowDownMo(activityId)

	return showDownMo:getScheduleInfoInFinal()
end

function ShowDownController:getBattleOrderMo(activityId, roundId)
	local showDownMo = self:getShowDownMo(activityId)

	return showDownMo:getBattleOrderMo(roundId)
end

function ShowDownController:getGroupCountInShowDown(roundId)
	local result = 0
	local playerCountInTeam = self:getPlayerCountInTeamInEliminate()

	if roundId == ShowDownEnum.Round_Eliminate_Group then
		result = 512 / playerCountInTeam
	elseif roundId == ShowDownEnum.Round_Eliminate_512To64 then
		result = 512 / playerCountInTeam
	elseif roundId == ShowDownEnum.Round_Eliminate_64To8 then
		result = 64 / playerCountInTeam
	elseif roundId > ShowDownEnum.Round_Final_01 then
		result = 16
	end

	return result
end

function ShowDownController:getTeamIconPath(activityId, iconId)
	local iconData = ShowDownConfig.instance:getTeamIconData(activityId, iconId)

	if iconData == nil then
		local teamData = ShowDownConfig.instance:getTeamData(activityId)

		iconData = ShowDownConfig.instance:getTeamIconData(activityId, teamData.defaultTeamIcon)
	end

	if iconData then
		return string.format("ui/icon/items/%s.png", iconData.iconPath)
	end
end

function ShowDownController:getTeamMemberCount(activityId)
	local teamData = ShowDownConfig.instance:getTeamData(activityId)

	return (teamData or nil) and (teamData.teamMemberCount or 0)
end

function ShowDownController:isGainDailyGuessItem(activityId)
	local showDownMo = self:getShowDownMo(activityId)

	return showDownMo:isGainDailyGuessItem()
end

function ShowDownController:getBuffIconPath(activityId, roundId, buffId)
	local data = ShowDownConfig.instance:getBuffData(activityId, roundId, buffId)

	if data then
		return string.format("ui/icon/expevents/%s.png", data.iconPath)
	end
end

function ShowDownController:getMainRaceInfoMo(activityId, stepId)
	local showDownMo = self:getShowDownMo(activityId)
	local roundId = self:getRoundIdByStep(activityId, stepId)

	return showDownMo:getMainRaceInfoMo(roundId)
end

function ShowDownController:getTeamCountEachGroupInEliminate()
	return 8
end

function ShowDownController:getPlayerCountInTeamInEliminate()
	return 8
end

function ShowDownController:getMainRaceInfoMoInFinal(activityId, roundId)
	local showDownMo = self:getShowDownMo(activityId)

	return showDownMo:getMainRaceInfoMoInFinal(roundId)
end

function ShowDownController:playFightRecord(activityId, battleResult, leftUserId)
	local teamId = self:getMyTeamIdByBattleResult(battleResult, leftUserId)

	if teamId >= 0 then
		BattleModel.instance:setLeftTeamId(teamId)
	end

	BattleController.instance:viewUserFightMonsterBtlResult(battleResult, false)
end

function ShowDownController:getMyTeamIdByBattleResult(battleResult, leftUserId)
	local teamId = 0

	leftUserId = checknumber(leftUserId)

	if battleResult and leftUserId > 0 then
		local teams = battleResult.originalStates.teams

		for _, v in ipairs(teams) do
			local id = checknumber(v.playerView.id)

			if leftUserId == id then
				teamId = v.teamId

				break
			end
		end
	end

	return teamId
end

function ShowDownController:opShowDownRank(activityId, qualType)
	UIStateManager.instance:push(ViewName.ShowDownRankView, activityId, qualType)
end

function ShowDownController:joinTeamFromChat(obj)
	local activityId = checknumber(obj.activityId)
	local teamId = checknumber(obj.teamId)
	local inviteCode = obj.inviteCode
	local minPlayerLevel = checknumber(obj.minPlayerLevel)
	local maxPlayerLevel = checknumber(obj.maxPlayerLevel)
	local petNum = checknumber(obj.petNum)
	local result, tips = self:getTryEnterShowDownResultAndTips(activityId)

	if result ~= GameEnum.ResultCode.Success then
		FloatWordMgr.instance:show(tips)

		return
	end

	if teamId <= 0 then
		printError("缺失战队id")

		return
	end

	local myLv = RoleModel.instance:getMyLevel()

	if myLv < minPlayerLevel or maxPlayerLevel < myLv then
		FloatWordMgr.instance:show("您的等级不符合加入条件")

		return
	end

	local myPetNum = BagModel.instance:BagCount()

	if myPetNum < petNum then
		FloatWordMgr.instance:show("您的精灵数量不符合加入条件")

		return
	end

	GlobalDispatcher:addListener(GlobalNotify.HandlePM_ShowDownTeam_JoinRes, self._handleJoinTeamFromChat, self)
	self:sendPM_ShowDownTeam_JoinReq(activityId, teamId, inviteCode)
end

function ShowDownController:_handleJoinTeamFromChat(status, msg)
	GlobalDispatcher:removeListener(GlobalNotify.HandlePM_ShowDownTeam_JoinRes, self._handleJoinTeamFromChat, self)

	if status == 0 then
		FloatWordMgr.instance:show("申请加入战队成功")
		self:enterShowDown()
	end
end

function ShowDownController:opTaskView(activityId)
	UIStateManager.instance:push(ViewName.ShowDownTaskFrameView, activityId)
end

function ShowDownController:opEliminateResultView(activityId, teamViewMo, result)
	UIStateManager.instance:push(ViewName.ShowDownEliminateResultView, activityId, teamViewMo, result)
end

function ShowDownController:opTeamDetailView(activityId, roundId, teamId, teamName)
	UIStateManager.instance:push(ViewName.ShowDownTeamDetailView, activityId, roundId, teamId, teamName)
end

function ShowDownController:opPlayerInfoView(goOrPos, activityId, headInfo)
	local pos = goOrPos
	local sizeDelta = {
		0,
		0
	}

	if goOrPos and goOrPos.gameObject then
		local rect = goOrPos.gameObject:GetComponent("RectTransform")

		if rect ~= nil then
			sizeDelta = {
				rect.sizeDelta.x,
				rect.sizeDelta.y
			}
		end

		pos = goOrPos.gameObject.transform.position

		local uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()

		pos = uiCamera:WorldToScreenPoint(pos)
	end

	UIStateManager.instance:push(ViewName.ShowDownPlayerInfoView, activityId, headInfo, pos, sizeDelta)
end

function ShowDownController:opFinalFmtAdjustView(activityId, roundId, enemyTeamId, state)
	UIStateManager.instance:push(ViewName.ShowDownFinalFmtAdjustView, activityId, roundId, enemyTeamId, state)
end

function ShowDownController:setTeamHeadCellRoot(go, headInfo, activityId, teamIconId, clickCallBack)
	headInfo = RoleModel.instance:copyHeadInfo(headInfo)
	headInfo.headFrameId = 0

	local headRoot = goutil.findChild(go, "headRoot")

	if goutil.isNil(headRoot) then
		headRoot = goutil.create("headRoot", true)

		goutil.addChildToParent(headRoot, go)
	end

	GameUtil.setLocalPos(headRoot, 0, 0, 0)
	GameUtil.setLocalScale(headRoot, 1, 1, 1)

	local proxy

	if headInfo then
		proxy = HeadItemController.instance:setHeadCellByInfo(headRoot, headInfo)

		if proxy then
			proxy:setAutoTips(false)
			proxy:setCallBack(clickCallBack)
		end
	else
		HeadItemController.instance:resetHeadCell(headRoot)
	end

	local teamIconGo = goutil.findChild(go, "teamIcon")

	if goutil.isNil(teamIconGo) then
		teamIconGo = goutil.create("teamIcon", true)

		goutil.addChildToParent(teamIconGo, go)
	end

	GameUtil.setLocalPos(teamIconGo, 0, 0, 0)
	GameUtil.setLocalScale(teamIconGo, 1, 1, 1)

	local teamIconPath = self:getTeamIconPath(activityId, teamIconId)

	if not string.nilorempty(teamIconPath) then
		local function func()
			local image = teamIconGo:GetComponent(goutil.Type_UIImage)

			image:SetNativeSize()

			image.raycastTarget = false
		end

		uGuiUtil.setSpriteToImage(teamIconGo, uGuiUtil.SpriteType.BigBg, teamIconPath, func)
	else
		uGuiUtil.clearImage(teamIconGo)
	end

	return proxy
end

function ShowDownController:clearTeamHeadCellRoot(go)
	local headRoot = goutil.findChild(go, "headRoot")
	local teamIconGo = goutil.findChild(go, "teamIcon")

	HeadItemController.instance:resetHeadCell(headRoot)

	if not goutil.isNil(teamIconGo) then
		uGuiUtil.clearImage(teamIconGo)
	end
end

ShowDownController.instance = ShowDownController.New()

return ShowDownController
