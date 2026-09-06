-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/agent/ShowDownQualifyAndTeamAgent.lua

module("logic.extensions.showdown.agent.ShowDownQualifyAndTeamAgent", package.seeall)

local ShowDownQualifyAndTeamAgent = class("ShowDownQualifyAndTeamAgent", BaseAgent)

function ShowDownQualifyAndTeamAgent:sendPM_ShowDown_SetWishListReq(activityId, roundId, wishListPetIds)
	local req = ShowDownQualifyAndTeamExtension_pb.PM_ShowDown_SetWishListReq()
	local round = self:_getPetRepoRound(activityId, roundId)

	req.round:ParseFromString(round:SerializeToString())

	if wishListPetIds then
		for _, v in ipairs(wishListPetIds) do
			req.wishListPetIds:append(v)
		end
	end

	self:sendMsg(req)
end

function ShowDownQualifyAndTeamAgent:handlePM_ShowDown_SetWishListRes(status, msg)
	if status == 0 then
		ShowDownController.instance:handlePM_ShowDown_SetWishListRes(msg)
	end
end

function ShowDownQualifyAndTeamAgent:sendPM_ShowDown_RollPetsReq(activityId, roundId)
	local req = ShowDownQualifyAndTeamExtension_pb.PM_ShowDown_RollPetsReq()
	local round = self:_getPetRepoRound(activityId, roundId)

	req.round:ParseFromString(round:SerializeToString())
	self:sendMsg(req)
end

function ShowDownQualifyAndTeamAgent:handlePM_ShowDown_RollPetsRes(status, msg)
	if status == 0 then
		ShowDownController.instance:handlePM_ShowDown_RollPetsRes(msg)
	end
end

function ShowDownQualifyAndTeamAgent:sendPM_ShowDown_ConfirmPetsReq(activityId, roundId)
	local req = ShowDownQualifyAndTeamExtension_pb.PM_ShowDown_ConfirmPetsReq()
	local round = self:_getPetRepoRound(activityId, roundId)

	req.round:ParseFromString(round:SerializeToString())
	self:sendMsg(req)
end

function ShowDownQualifyAndTeamAgent:handlePM_ShowDown_ConfirmPetsRes(status, msg)
	ShowDownController.instance:handlePM_ShowDown_ConfirmPetsRes(status, msg)
end

function ShowDownQualifyAndTeamAgent:sendPM_ShowDown_SetFormReq(activityId, roundId, formIndex, simpleForm, buffId)
	local req = ShowDownQualifyAndTeamExtension_pb.PM_ShowDown_SetFormReq()
	local round = self:_getPetRepoRound(activityId, roundId)

	req.round:ParseFromString(round:SerializeToString())

	req.formIndex = formIndex

	local form = self:_getShowDownForm(simpleForm, buffId)

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function ShowDownQualifyAndTeamAgent:handlePM_ShowDown_SetFormRes(status, msg)
	ShowDownController.instance:handlePM_ShowDown_SetFormRes(status, msg)
end

function ShowDownQualifyAndTeamAgent:sendPM_ShowDown_ResetPetsAndFormReq(activityId, roundId, expectPrice)
	local req = ShowDownQualifyAndTeamExtension_pb.PM_ShowDown_ResetPetsAndFormReq()
	local round = self:_getPetRepoRound(activityId, roundId)

	req.round:ParseFromString(round:SerializeToString())

	req.expectPrice = expectPrice

	self:sendMsg(req)
end

function ShowDownQualifyAndTeamAgent:handlePM_ShowDown_ResetPetsAndFormRes(status, msg)
	if status == 0 then
		ShowDownController.instance:handlePM_ShowDown_ResetPetsAndFormRes(msg)
	end
end

function ShowDownQualifyAndTeamAgent:sendPM_ShowDown_GainDailyGuessItemReq(activityId)
	local req = ShowDownQualifyAndTeamExtension_pb.PM_ShowDown_GainDailyGuessItemReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function ShowDownQualifyAndTeamAgent:handlePM_ShowDown_GainDailyGuessItemRes(status, msg)
	if status == 0 then
		ShowDownController.instance:handlePM_ShowDown_GainDailyGuessItemRes(msg)
	end
end

function ShowDownQualifyAndTeamAgent:sendPM_ShowDownTeam_GetPlayerViewReq(activityId, playerId)
	local req = ShowDownQualifyAndTeamExtension_pb.PM_ShowDownTeam_GetPlayerViewReq()

	req.activityId = activityId
	req.playerId = playerId

	self:sendMsg(req)
end

function ShowDownQualifyAndTeamAgent:handlePM_ShowDownTeam_GetPlayerViewRes(status, msg)
	if status == 0 then
		ShowDownController.instance:handlePM_ShowDownTeam_GetPlayerViewRes(msg)
	end
end

function ShowDownQualifyAndTeamAgent:sendPM_ShowDownQualify_StartMatchingReq(activityId, qualType)
	local req = ShowDownQualifyAndTeamExtension_pb.PM_ShowDownQualify_StartMatchingReq()

	req.activityId = activityId
	req.type = qualType

	self:sendMsg(req)
end

function ShowDownQualifyAndTeamAgent:handlePM_ShowDownQualify_StartMatchingRes(status, msg)
	ShowDownController.instance:handlePM_ShowDownQualify_StartMatchingRes(status, msg)
end

function ShowDownQualifyAndTeamAgent:sendPM_ShowDownQualify_CancelMatchingReq(activityId)
	local req = ShowDownQualifyAndTeamExtension_pb.PM_ShowDownQualify_CancelMatchingReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function ShowDownQualifyAndTeamAgent:handlePM_ShowDownQualify_CancelMatchingRes(status, msg)
	if status == 0 then
		ShowDownController.instance:handlePM_ShowDownQualify_CancelMatchingRes(msg)
	end
end

function ShowDownQualifyAndTeamAgent:sendPM_ShowDownQualify_GetQualifyRankReq(activityId, qualType)
	local req = ShowDownQualifyAndTeamExtension_pb.PM_ShowDownQualify_GetQualifyRankReq()

	req.activityId = activityId
	req.type = qualType

	self:sendMsg(req)
end

function ShowDownQualifyAndTeamAgent:handlePM_ShowDownQualify_GetQualifyRankRes(status, msg)
	if status == 0 then
		ShowDownController.instance:handlePM_ShowDownQualify_GetQualifyRankRes(msg)
	end
end

function ShowDownQualifyAndTeamAgent:handlePM_ShowDownQualify_NotifyMatchBattleResultRes(status, msg)
	if status == 0 then
		ShowDownController.instance:handlePM_ShowDownQualify_NotifyMatchBattleResultRes(msg)
	end
end

function ShowDownQualifyAndTeamAgent:sendPM_ShowDownQualify_GetQualifyBattleVideoReq(battleId)
	local req = ShowDownQualifyAndTeamExtension_pb.PM_ShowDownQualify_GetQualifyBattleVideoReq()

	req.battleId = battleId

	self:sendMsg(req)
end

function ShowDownQualifyAndTeamAgent:handlePM_ShowDownQualify_GetQualifyBattleVideoRes(status, msg)
	if status == 0 then
		ShowDownController.instance:handlePM_ShowDownQualify_GetQualifyBattleVideoRes(msg)
	end
end

function ShowDownQualifyAndTeamAgent:handlePM_ShowDownQualify_NotifyMatchFailRes(status, msg)
	ShowDownController.instance:handlePM_ShowDownQualify_NotifyMatchFailRes(status, msg)
end

function ShowDownQualifyAndTeamAgent:sendPM_ShowDownTeam_SetMyTeamInfoReq(activityId, teamInfo)
	local req = ShowDownQualifyAndTeamExtension_pb.PM_ShowDownTeam_SetMyTeamInfoReq()

	req.activityId = activityId

	if teamInfo then
		req.teamInfo:ParseFromString(teamInfo:SerializeToString())
	end

	self:sendMsg(req)
end

function ShowDownQualifyAndTeamAgent:handlePM_ShowDownTeam_SetMyTeamInfoRes(status, msg)
	if status == 0 then
		ShowDownController.instance:handlePM_ShowDownTeam_SetMyTeamInfoRes(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.HandlePM_ShowDownTeam_SetMyTeamInfoError, status)
	end
end

function ShowDownQualifyAndTeamAgent:sendPM_ShowDownTeam_GetOtherGroupInfoReq(activityId, groupId)
	local req = ShowDownQualifyAndTeamExtension_pb.PM_ShowDownTeam_GetOtherGroupInfoReq()

	req.activityId = activityId
	req.groupId = groupId

	self:sendMsg(req)
end

function ShowDownQualifyAndTeamAgent:handlePM_ShowDownTeam_GetOtherGroupInfoRes(status, msg)
	if status == 0 then
		ShowDownController.instance:handlePM_ShowDownTeam_GetOtherGroupInfoRes(msg)
	end
end

function ShowDownQualifyAndTeamAgent:sendPM_ShowDownTeam_GetTeamMemberInfoReq(activityId, teamId)
	local req = ShowDownQualifyAndTeamExtension_pb.PM_ShowDownTeam_GetTeamMemberInfoReq()

	req.activityId = activityId
	req.teamId = teamId

	self:sendMsg(req)
end

function ShowDownQualifyAndTeamAgent:handlePM_ShowDownTeam_GetTeamMemberInfoRes(status, msg)
	if status == 0 then
		ShowDownController.instance:handlePM_ShowDownTeam_GetTeamMemberInfoRes(msg)
	end
end

function ShowDownQualifyAndTeamAgent:sendPM_ShowDownTeam_SendEnlistMsgReq(activityId, teamId, left, right, winCount, ownRaceCount)
	local req = ShowDownQualifyAndTeamExtension_pb.PM_ShowDownTeam_SendEnlistMsgReq()

	req.activityId = activityId
	req.teamId = teamId
	req.playerLvRange.left = left
	req.playerLvRange.right = right
	req.winCount = winCount
	req.ownRaceCount = ownRaceCount

	self:sendMsg(req)
end

function ShowDownQualifyAndTeamAgent:handlePM_ShowDownTeam_SendEnlistMsgRes(status, msg)
	if status == 0 then
		ShowDownController.instance:handlePM_ShowDownTeam_SendEnlistMsgRes(msg)
	end
end

function ShowDownQualifyAndTeamAgent:sendPM_ShowDownTeam_GetMyTeamApplyListReq(activityId)
	local req = ShowDownQualifyAndTeamExtension_pb.PM_ShowDownTeam_GetMyTeamApplyListReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function ShowDownQualifyAndTeamAgent:handlePM_ShowDownTeam_GetMyTeamApplyListRes(status, msg)
	if status == 0 then
		ShowDownController.instance:handlePM_ShowDownTeam_GetMyTeamApplyListRes(msg)
	end
end

function ShowDownQualifyAndTeamAgent:sendPM_ShowDownTeam_GetOrRefreshTeamListReq(activityId)
	local req = ShowDownQualifyAndTeamExtension_pb.PM_ShowDownTeam_GetOrRefreshTeamListReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function ShowDownQualifyAndTeamAgent:handlePM_ShowDownTeam_GetOrRefreshTeamListRes(status, msg)
	if status == 0 then
		ShowDownController.instance:handlePM_ShowDownTeam_GetOrRefreshTeamListRes(msg)
	end
end

function ShowDownQualifyAndTeamAgent:sendPM_ShowDownTeam_SearchTeamReq(activityId, keyword, beginIndex, endIndex)
	local req = ShowDownQualifyAndTeamExtension_pb.PM_ShowDownTeam_SearchTeamReq()

	req.activityId = activityId
	req.keyword = keyword
	req.beginIndex = beginIndex
	req.endIndex = endIndex

	self:sendMsg(req)
end

function ShowDownQualifyAndTeamAgent:handlePM_ShowDownTeam_SearchTeamRes(status, msg)
	if status == 0 then
		ShowDownController.instance:handlePM_ShowDownTeam_SearchTeamRes(msg)
	end
end

function ShowDownQualifyAndTeamAgent:sendPM_ShowDownTeam_QuickJoinReq(activityId)
	local req = ShowDownQualifyAndTeamExtension_pb.PM_ShowDownTeam_QuickJoinReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function ShowDownQualifyAndTeamAgent:handlePM_ShowDownTeam_QuickJoinRes(status, msg)
	if status == 0 then
		ShowDownController.instance:handlePM_ShowDownTeam_QuickJoinRes(msg)
	end
end

function ShowDownQualifyAndTeamAgent:sendPM_ShowDownTeam_JoinReq(activityId, teamId, inviteCode)
	local req = ShowDownQualifyAndTeamExtension_pb.PM_ShowDownTeam_JoinReq()

	req.activityId = activityId
	req.teamId = teamId
	req.inviteCode = inviteCode

	self:sendMsg(req)
end

function ShowDownQualifyAndTeamAgent:handlePM_ShowDownTeam_JoinRes(status, msg)
	ShowDownController.instance:handlePM_ShowDownTeam_JoinRes(status, msg)
end

function ShowDownQualifyAndTeamAgent:sendPM_ShowDownTeam_HandleApplyReq(activityId, memberId, agree)
	local req = ShowDownQualifyAndTeamExtension_pb.PM_ShowDownTeam_HandleApplyReq()

	req.activityId = activityId
	req.memberId = memberId
	req.agree = agree

	self:sendMsg(req)
end

function ShowDownQualifyAndTeamAgent:handlePM_ShowDownTeam_HandleApplyRes(status, msg)
	if status == 0 then
		ShowDownController.instance:handlePM_ShowDownTeam_HandleApplyRes(msg)
	end
end

function ShowDownQualifyAndTeamAgent:handlePM_ShowDown_NotifyJoinTeamRes(status, msg)
	if status == 0 then
		ShowDownController.instance:handlePM_ShowDown_NotifyJoinTeamRes(msg)
	end
end

function ShowDownQualifyAndTeamAgent:_getPetRepoRound(activityId, roundId)
	local round = ShowDownQualifyAndTeamExtension_pb.PM_ShowDown_PetRepoRound()

	round.activityId = activityId
	round.roundId = roundId
	round.type = roundId == ShowDownEnum.Round_Func and ShowDownEnum.QualType_Fun or ShowDownEnum.QualType_Normal

	return round
end

function ShowDownQualifyAndTeamAgent:_getShowDownForm(simpleForm, buffId)
	local result = ShowDownExtension_pb.PM_ShowDown_Form()

	result.formation:ParseFromString(simpleForm:SerializeToString())

	result.buffId = buffId

	return result
end

ShowDownQualifyAndTeamAgent.instance = ShowDownQualifyAndTeamAgent.New()

return ShowDownQualifyAndTeamAgent
