-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/teenchampionking/agent/TeenChampionKingAgent.lua

module("logic.extensions.teenchampionking.agent.TeenChampionKingAgent", package.seeall)

local TeenChampionKingAgent = class("TeenChampionKingAgent", BaseAgent)

function TeenChampionKingAgent:sendPM_TeenCKGlobalInfoReq(activityId)
	local req = TeenChampionKingExtension_pb.PM_TeenCKGlobalInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function TeenChampionKingAgent:handlePM_TeenCKGlobalInfoRes(status, msg)
	if status == 0 then
		TeenChampionKingController.instance:handleGetGlobalInfo(msg)
	end
end

function TeenChampionKingAgent:handlePM_TeenCKNotifyStepChangeRes(status, msg)
	if status == 0 then
		TeenChampionKingController.instance:handleNotifyStepChange(msg)
	end
end

function TeenChampionKingAgent:sendPM_TeenCKBattleRecordReq(activityId)
	local req = TeenChampionKingExtension_pb.PM_TeenCKBattleRecordReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function TeenChampionKingAgent:handlePM_TeenCKBattleRecordRes(status, msg)
	if status == 0 then
		TeenChampionKingController.instance:handleGetBattleRecord(msg)
	end
end

function TeenChampionKingAgent:sendPM_TeenCKBattleVideoReq(battleId)
	local req = TeenChampionKingExtension_pb.PM_TeenCKBattleVideoReq()

	req.battleId = battleId

	self:sendMsg(req)
end

function TeenChampionKingAgent:handlePM_TeenCKBattleVideoRes(status, msg)
	if status == 0 then
		TeenChampionKingController.instance:handlePlayBattleVideo(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.PM_TCKGetVideoError, status)
	end
end

function TeenChampionKingAgent:sendPM_TeenCKSelectPetReq(activityId, selectPetIds, useSysProperty)
	local req = TeenChampionKingExtension_pb.PM_TeenCKSelectPetReq()

	req.activityId = activityId

	if selectPetIds then
		for i, v in ipairs(selectPetIds) do
			req.selectPetIds:append(v)
		end
	end

	req.useSysProperty = useSysProperty

	self:sendMsg(req)
end

function TeenChampionKingAgent:handlePM_TeenCKSelectPetRes(status, msg)
	if status == 0 then
		TeenChampionKingController.instance:handleSelectPets(msg)
	end
end

function TeenChampionKingAgent:sendPM_TeenCKGainGuessCoinReq(activityId)
	local req = TeenChampionKingExtension_pb.PM_TeenCKGainGuessCoinReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function TeenChampionKingAgent:handlePM_TeenCKGainGuessCoinRes(status, msg)
	if status == 0 then
		TeenChampionKingController.instance:handleGainGuessCoin(msg)
	end
end

function TeenChampionKingAgent:sendPM_TeenCKQualifierInfoReq(activityId, stepId)
	local req = TeenChampionKingExtension_pb.PM_TeenCKQualifierInfoReq()

	req.activityId = activityId
	req.stepId = stepId

	self:sendMsg(req)
end

function TeenChampionKingAgent:handlePM_TeenCKQualifierInfoRes(status, msg)
	if status == 0 then
		TeenChampionKingController.instance:handleGetQualifierInfo(msg)
	end
end

function TeenChampionKingAgent:sendPM_TeenCKMatchReq(activityId, stepId)
	local req = TeenChampionKingExtension_pb.PM_TeenCKMatchReq()

	req.activityId = activityId
	req.stepId = stepId

	self:sendMsg(req)
end

function TeenChampionKingAgent:handlePM_TeenCKMatchRes(status, msg)
	if status == 0 then
		TeenChampionKingController.instance:handleStartMatch(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.PM_TCKMatchFail, status)
	end
end

function TeenChampionKingAgent:sendPM_TeenCKCancelMatchReq()
	local req = TeenChampionKingExtension_pb.PM_TeenCKCancelMatchReq()

	self:sendMsg(req)
end

function TeenChampionKingAgent:handlePM_TeenCKCancelMatchRes(status, msg)
	if status == 0 then
		TeenChampionKingController.instance:handleCancelMatch(msg)
	end
end

function TeenChampionKingAgent:handlePM_NotifyTeenCKMatchFailRes(status, msg)
	if status == 0 then
		TeenChampionKingController.instance:handleNotifyMatchFail(msg)
	end
end

function TeenChampionKingAgent:sendPM_TeenCKQualifierRankViewReq(activityId, zoneId, stepId)
	local req = TeenChampionKingExtension_pb.PM_TeenCKQualifierRankViewReq()

	req.activityId = activityId
	req.zoneId = zoneId
	req.stepId = stepId

	self:sendMsg(req)
end

function TeenChampionKingAgent:handlePM_TeenCKQualifierRankViewRes(status, msg)
	if status == 0 then
		TeenChampionKingController.instance:handleUpdateRankView(msg)
	end
end

function TeenChampionKingAgent:sendPM_TeenCKQualifierPetRankReq(activityId, stepId, winRank)
	local req = TeenChampionKingExtension_pb.PM_TeenCKQualifierPetRankReq()

	req.activityId = activityId
	req.stepId = stepId
	req.winRank = winRank

	self:sendMsg(req)
end

function TeenChampionKingAgent:handlePM_TeenCKQualifierPetRankRes(status, msg)
	if status == 0 then
		TeenChampionKingController.instance:handleUpdatePetView(msg)
	end
end

function TeenChampionKingAgent:sendPM_TeenCKMyKnockoutInfoReq(activityId)
	local req = TeenChampionKingExtension_pb.PM_TeenCKMyKnockoutInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function TeenChampionKingAgent:handlePM_TeenCKMyKnockoutInfoRes(status, msg)
	if status == 0 then
		TeenChampionKingController.instance:handleGetMyKnockoutInfo(msg)
	end
end

function TeenChampionKingAgent:sendPM_TeenCKGetKnockoutScheduleReq(activityId, viewGroupId, roundId)
	local req = TeenChampionKingExtension_pb.PM_TeenCKGetKnockoutScheduleReq()

	req.activityId = activityId
	req.viewGroupId = viewGroupId
	req.roundId = roundId

	self:sendMsg(req)
end

function TeenChampionKingAgent:handlePM_TeenCKGetKnockoutScheduleRes(status, msg)
	if status == 0 then
		TeenChampionKingController.instance:handleGetKnockoutSchedule(msg)
	end
end

function TeenChampionKingAgent:sendPM_TeenCKKnockoutGuessRecordReq(activityId, roundId)
	local req = TeenChampionKingExtension_pb.PM_TeenCKKnockoutGuessRecordReq()

	req.activityId = activityId
	req.roundId = roundId

	self:sendMsg(req)
end

function TeenChampionKingAgent:handlePM_TeenCKKnockoutGuessRecordRes(status, msg)
	if status == 0 then
		TeenChampionKingController.instance:handleGetKnockoutGuessRecord(msg)
	end
end

function TeenChampionKingAgent:sendPM_TeenCKGuessKnockoutReq(activityId, targetPlayerId, guessNum)
	local req = TeenChampionKingExtension_pb.PM_TeenCKGuessKnockoutReq()

	req.activityId = activityId
	req.targetPlayerId = targetPlayerId
	req.guessNum = guessNum

	self:sendMsg(req)
end

function TeenChampionKingAgent:handlePM_TeenCKGuessKnockoutRes(status, msg)
	if status == 0 then
		TeenChampionKingController.instance:handleGuessKnockout(msg)
	end
end

function TeenChampionKingAgent:sendPM_TeenCKGuessChampionshipReq(activityId, guessNum)
	local req = TeenChampionKingExtension_pb.PM_TeenCKGuessChampionshipReq()

	req.activityId = activityId
	req.guessNum = guessNum

	self:sendMsg(req)
end

function TeenChampionKingAgent:handlePM_TeenCKGuessChampionshipRes(status, msg)
	if status == 0 then
		TeenChampionKingController.instance:handleGuessChampionship(msg)
	end
end

function TeenChampionKingAgent:sendPM_TeenCKChangeGuessRankReq(activityId, guessPlayerIds)
	local req = TeenChampionKingExtension_pb.PM_TeenCKChangeGuessRankReq()

	req.activityId = activityId

	if guessPlayerIds then
		for i, v in ipairs(guessPlayerIds) do
			req.guessPlayerIds:append(v)
		end
	end

	self:sendMsg(req)
end

function TeenChampionKingAgent:handlePM_TeenCKChangeGuessRankRes(status, msg)
	if status == 0 then
		TeenChampionKingController.instance:handleChangeGuessRank(msg)
	end
end

function TeenChampionKingAgent:sendPM_TeenCKChampionshipGuessRecordReq(activityId)
	local req = TeenChampionKingExtension_pb.PM_TeenCKChampionshipGuessRecordReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function TeenChampionKingAgent:handlePM_TeenCKChampionshipGuessRecordRes(status, msg)
	if status == 0 then
		TeenChampionKingController.instance:handleGetChampionshipGuessRecord(msg)
	end
end

function TeenChampionKingAgent:sendPM_TeenCKDisplayInfoReq(activityId)
	local req = TeenChampionKingExtension_pb.PM_TeenCKDisplayInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function TeenChampionKingAgent:handlePM_TeenCKDisplayInfoRes(status, msg)
	if status == 0 then
		TeenChampionKingController.instance:handleGetDisplayInfo(msg)
	end
end

function TeenChampionKingAgent:sendPM_TeenCKKnockoutJoinRoomInfoReq(activityId, stepId, groupId)
	local req = TeenChampionKingExtension_pb.PM_TeenCKKnockoutJoinRoomInfoReq()

	req.activityId = activityId
	req.stepId = stepId
	req.groupId = groupId

	self:sendMsg(req)
end

function TeenChampionKingAgent:handlePM_TeenCKKnockoutJoinRoomInfoRes(status, msg)
	if status == 0 then
		TeenChampionKingController.instance:handleGetKnockoutJoinRoomInfo(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.PM_TCKKnockoutJoinRoomError, status)
	end
end

function TeenChampionKingAgent:sendPM_TeenCKKnockoutInviteOpReq(activityId, stepId, groupId)
	local req = TeenChampionKingExtension_pb.PM_TeenCKKnockoutInviteOpReq()

	req.activityId = activityId
	req.stepId = stepId
	req.groupId = groupId

	self:sendMsg(req)
end

function TeenChampionKingAgent:handlePM_TeenCKKnockoutInviteOpRes(status, msg)
	if status == 0 then
		TeenChampionKingController.instance:handleknockoutInviteOp(msg)
	end
end

function TeenChampionKingAgent:handlePM_NotifyTeenCKKnockoutOpInvitedRes(status, msg)
	if status == 0 then
		TeenChampionKingController.instance:handleNotifyTeenCKKnockoutOpInvited(msg)
	end
end

function TeenChampionKingAgent:sendPM_TeenCKKnockoutJoinRoomReq(activityId, stepId, groupId)
	local req = TeenChampionKingExtension_pb.PM_TeenCKKnockoutJoinRoomReq()

	req.activityId = activityId
	req.stepId = stepId
	req.groupId = groupId

	self:sendMsg(req)
end

function TeenChampionKingAgent:handlePM_TeenCKKnockoutJoinRoomRes(status, msg)
	if status == 0 then
		TeenChampionKingController.instance:handleknockoutJoinRoom(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.PM_TCKKnockoutJoinRoomError, status)
	end
end

function TeenChampionKingAgent:sendPM_TeenCKKnockoutLeaveRoomReq(activityId, stepId, groupId)
	local req = TeenChampionKingExtension_pb.PM_TeenCKKnockoutLeaveRoomReq()

	req.activityId = activityId
	req.stepId = stepId
	req.groupId = groupId

	self:sendMsg(req)
end

function TeenChampionKingAgent:handlePM_TeenCKKnockoutLeaveRoomRes(status, msg)
	if status == 0 then
		TeenChampionKingController.instance:handleknockoutLeaveRoom(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.PM_TCKKnockoutJoinRoomError, status)
	end
end

function TeenChampionKingAgent:handlePM_NotifyTeenCKKnockoutOpJoinRoomRes(status, msg)
	if status == 0 then
		TeenChampionKingController.instance:handleNotifyKnockoutOpRoomInfo(msg)
	end
end

function TeenChampionKingAgent:handlePM_NotifyTeenCKFightStartRes(status, msg)
	if status == 0 then
		TeenChampionKingController.instance:handleNotifyFightStart(msg)
	end
end

function TeenChampionKingAgent:sendPM_TeenCKSetGameFormReq(activityId, simpleForm, gameRoundId)
	local req = TeenChampionKingExtension_pb.PM_TeenCKSetGameFormReq()

	req.activityId = activityId

	if simpleForm ~= nil then
		req.simpleForm:ParseFromString(simpleForm:SerializeToString())
	end

	req.gameRoundId = gameRoundId

	self:sendMsg(req)
end

function TeenChampionKingAgent:handlePM_TeenCKSetGameFormRes(status, msg)
	if status == 0 then
		TeenChampionKingController.instance:handleSetGameForm(msg)
	end
end

function TeenChampionKingAgent:handlePM_NotifyTeenCKSetGameFormFailRes(status, msg)
	if status == 0 then
		TeenChampionKingController.instance:handleNotifySetGameFormFail(msg)
	end
end

function TeenChampionKingAgent:handlePM_NotifyTeenCKOpSetFormFinishRes(status, msg)
	if status == 0 then
		TeenChampionKingController.instance:handleNotifyOpSetFormFinish(msg)
	end
end

function TeenChampionKingAgent:handlePM_NotifyTeenCKTurnToNextGameRoundRes(status, msg)
	if status == 0 then
		TeenChampionKingController.instance:handleNotifyTurnToNextGameRound(msg)
	end
end

function TeenChampionKingAgent:handlePM_NotifyTeenCKGameEndRes(status, msg)
	if status == 0 then
		TeenChampionKingController.instance:handleNotifyGameEnd(msg)
	end
end

function TeenChampionKingAgent:sendPM_TeenCKSyncRoomInfoReq(activityId)
	local req = TeenChampionKingExtension_pb.PM_TeenCKSyncRoomInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function TeenChampionKingAgent:handlePM_TeenCKSyncRoomInfoRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function TeenChampionKingAgent:handlePM_TeenCKNotifyRoomInfoRes(status, msg)
	if status == 0 then
		TeenChampionKingController.instance:handleNotifySyncRoomInfo(msg)
	end
end

function TeenChampionKingAgent:sendPM_TeenCKLeaveGameReq(activityId)
	local req = TeenChampionKingExtension_pb.PM_TeenCKLeaveGameReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function TeenChampionKingAgent:handlePM_TeenCKLeaveGameRes(status, msg)
	if status == 0 then
		TeenChampionKingController.instance:handleLeaveGame(msg)
	end
end

TeenChampionKingAgent.instance = TeenChampionKingAgent.New()

return TeenChampionKingAgent
