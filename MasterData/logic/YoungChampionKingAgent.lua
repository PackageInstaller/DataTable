-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youngchampionking/agent/YoungChampionKingAgent.lua

module("logic.extensions.youngchampionking.agent.YoungChampionKingAgent", package.seeall)

local YoungChampionKingAgent = class("YoungChampionKingAgent", BaseAgent)

function YoungChampionKingAgent:sendPM_YCKGetVideoReq(battleId)
	local req = YoungChampionKingExtension_pb.PM_YCKGetVideoReq()

	req.battleId = battleId

	self:sendMsg(req)
end

function YoungChampionKingAgent:handlePM_YCKGetVideoRes(status, msg)
	if status == 0 then
		YoungChampionKingController.instance:handlePM_YCKGetVideoRes(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.PM_YCKGetVideoError, status)
	end
end

function YoungChampionKingAgent:sendPM_YCKGetQualifierInfoReq(activityId, stepId)
	local req = YoungChampionKingExtension_pb.PM_YCKGetQualifierInfoReq()

	req.activityId = activityId
	req.stepId = stepId

	self:sendMsg(req)
end

function YoungChampionKingAgent:handlePM_YCKGetQualifierInfoRes(status, msg)
	if status == 0 then
		YoungChampionKingController.instance:handlePM_YCKGetQualifierInfoRes(msg)
	end
end

function YoungChampionKingAgent:sendPM_YCKGetDefenseForamtionReq()
	local req = YoungChampionKingExtension_pb.PM_YCKGetDefenseForamtionReq()

	self:sendMsg(req)
end

function YoungChampionKingAgent:handlePM_YCKGetDefenseForamtionRes(status, msg)
	if status == 0 then
		YoungChampionKingController.instance:handlePM_YCKGetDefenseForamtionRes(msg)
	end
end

function YoungChampionKingAgent:sendPM_YCKSetDefenseForamtionReq(simpleForm)
	local req = YoungChampionKingExtension_pb.PM_YCKSetDefenseForamtionReq()

	if simpleForm ~= nil then
		req.simpleForm:ParseFromString(simpleForm:SerializeToString())
	end

	self:sendMsg(req)
end

function YoungChampionKingAgent:handlePM_YCKSetDefenseForamtionRes(status, msg)
	if status == 0 then
		YoungChampionKingController.instance:handlePM_YCKSetDefenseForamtionRes(msg)
	end
end

function YoungChampionKingAgent:sendPM_YCKQualifierGetNewOpponentReq(activityId, stepId)
	local req = YoungChampionKingExtension_pb.PM_YCKQualifierGetNewOpponentReq()

	req.activityId = activityId
	req.stepId = stepId

	self:sendMsg(req)
end

function YoungChampionKingAgent:handlePM_YCKQualifierGetNewOpponentRes(status, msg)
	if status == 0 then
		YoungChampionKingController.instance:handlePM_YCKQualifierGetNewOpponentRes(msg)
	end
end

function YoungChampionKingAgent:sendPM_YCKQualifierFightReq(activityId, stepId, simpleForm)
	local req = YoungChampionKingExtension_pb.PM_YCKQualifierFightReq()

	req.activityId = activityId
	req.stepId = stepId

	if simpleForm ~= nil then
		req.simpleForm:ParseFromString(simpleForm:SerializeToString())
	end

	self:sendMsg(req)
end

function YoungChampionKingAgent:handlePM_YCKQualifierFightRes(status, msg)
	if status == 0 then
		YoungChampionKingController.instance:handlePM_YCKQualifierFightRes(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function YoungChampionKingAgent:sendPM_YCKQualifierRecordsReq(activityId)
	local req = YoungChampionKingExtension_pb.PM_YCKQualifierRecordsReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function YoungChampionKingAgent:handlePM_YCKQualifierRecordsRes(status, msg)
	if status == 0 then
		YoungChampionKingController.instance:handlePM_YCKQualifierRecordsRes(msg)
	end
end

function YoungChampionKingAgent:sendPM_YCKQualifierRankInfoReq(activityId, zoneId, stepId)
	local req = YoungChampionKingExtension_pb.PM_YCKQualifierRankInfoReq()

	req.activityId = activityId
	req.zoneId = zoneId
	req.stepId = stepId

	self:sendMsg(req)
end

function YoungChampionKingAgent:handlePM_YCKQualifierRankInfoRes(status, msg)
	if status == 0 then
		YoungChampionKingController.instance:handlePM_YCKQualifierRankInfoRes(msg)
	end
end

function YoungChampionKingAgent:sendPM_YCKQualifierPetRaceRankReq(activityId, stepId, winRank)
	local req = YoungChampionKingExtension_pb.PM_YCKQualifierPetRaceRankReq()

	req.activityId = activityId
	req.stepId = stepId
	req.winRank = winRank

	self:sendMsg(req)
end

function YoungChampionKingAgent:handlePM_YCKQualifierPetRaceRankRes(status, msg)
	if status == 0 then
		YoungChampionKingController.instance:handlePM_YCKQualifierPetRaceRankRes(msg)
	end
end

function YoungChampionKingAgent:sendPM_YCKMyKnockoutInfoReq(activityId)
	local req = YoungChampionKingExtension_pb.PM_YCKMyKnockoutInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function YoungChampionKingAgent:handlePM_YCKMyKnockoutInfoRes(status, msg)
	if status == 0 then
		YoungChampionKingController.instance:handlePM_YCKMyKnockoutInfoRes(msg)
	end
end

function YoungChampionKingAgent:sendPM_YCKGetKnockoutScheduleReq(activityId, viewGroupId, roundId)
	local req = YoungChampionKingExtension_pb.PM_YCKGetKnockoutScheduleReq()

	req.activityId = activityId
	req.viewGroupId = viewGroupId
	req.roundId = roundId

	self:sendMsg(req)
end

function YoungChampionKingAgent:handlePM_YCKGetKnockoutScheduleRes(status, msg)
	if status == 0 then
		YoungChampionKingController.instance:handlePM_YCKGetKnockoutScheduleRes(msg)
	end
end

function YoungChampionKingAgent:sendPM_YCKGetGuessRecordReq(activityId, roundId)
	local req = YoungChampionKingExtension_pb.PM_YCKGetGuessRecordReq()

	req.activityId = activityId
	req.roundId = roundId

	self:sendMsg(req)
end

function YoungChampionKingAgent:handlePM_YCKGetGuessRecordRes(status, msg)
	if status == 0 then
		YoungChampionKingController.instance:handlePM_YCKGetGuessRecordRes(msg)
	end
end

function YoungChampionKingAgent:sendPM_YCKGuessReq(activityId, targetPlayerId, guessNum)
	local req = YoungChampionKingExtension_pb.PM_YCKGuessReq()

	req.activityId = activityId
	req.targetPlayerId = targetPlayerId
	req.guessNum = guessNum

	self:sendMsg(req)
end

function YoungChampionKingAgent:handlePM_YCKGuessRes(status, msg)
	if status == 0 then
		YoungChampionKingController.instance:handlePM_YCKGuessRes(msg)
	end
end

function YoungChampionKingAgent:sendPM_YCKGainGuessCoinReq(activityId)
	local req = YoungChampionKingExtension_pb.PM_YCKGainGuessCoinReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function YoungChampionKingAgent:handlePM_YCKGainGuessCoinRes(status, msg)
	if status == 0 then
		YoungChampionKingController.instance:handlePM_YCKGainGuessCoinRes(msg)
	end
end

function YoungChampionKingAgent:sendPM_YCKGetDisplayInfoReq(activityId)
	local req = YoungChampionKingExtension_pb.PM_YCKGetDisplayInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function YoungChampionKingAgent:handlePM_YCKGetDisplayInfoRes(status, msg)
	if status == 0 then
		YoungChampionKingController.instance:handlePM_YCKGetDisplayInfoRes(msg)
	end
end

function YoungChampionKingAgent:sendPM_YCKKnockoutGetFormationReq()
	local req = YoungChampionKingExtension_pb.PM_YCKKnockoutGetFormationReq()

	self:sendMsg(req)
end

function YoungChampionKingAgent:handlePM_YCKKnockoutGetFormationRes(status, msg)
	if status == 0 then
		YoungChampionKingController.instance:handlePM_YCKKnockoutGetFormationRes(msg)
	end
end

function YoungChampionKingAgent:sendPM_YCKKnockoutSetFormationReq(forms)
	local req = YoungChampionKingExtension_pb.PM_YCKKnockoutSetFormationReq()

	if forms ~= nil then
		for formId, simpleForm in ipairs(forms) do
			local form = YoungChampionKingExtension_pb.YCKKnockoutSetFormNO()

			form.formId = formId

			form.simpleForm:ParseFromString(simpleForm:SerializeToString())

			local forms = req.forms:add()

			forms:ParseFromString(form:SerializeToString())
		end
	end

	self:sendMsg(req)
end

function YoungChampionKingAgent:handlePM_YCKKnockoutSetFormationRes(status, msg)
	if status == 0 then
		YoungChampionKingController.instance:handlePM_YCKKnockoutSetFormationRes(msg)
	end
end

function YoungChampionKingAgent:sendPM_YCKKnockoutJoinRoomInfoReq(activityId, stepId, groupId)
	local req = YoungChampionKingExtension_pb.PM_YCKKnockoutJoinRoomInfoReq()

	req.activityId = activityId
	req.stepId = stepId
	req.groupId = groupId

	self:sendMsg(req)
end

function YoungChampionKingAgent:handlePM_YCKKnockoutJoinRoomInfoRes(status, msg)
	if status == 0 then
		YoungChampionKingController.instance:handlePM_YCKKnockoutJoinRoomInfoRes(msg)
	end
end

function YoungChampionKingAgent:sendPM_YCKKnockoutJoinRoomReq(activityId, stepId, groupId)
	local req = YoungChampionKingExtension_pb.PM_YCKKnockoutJoinRoomReq()

	req.activityId = activityId
	req.stepId = stepId
	req.groupId = groupId

	self:sendMsg(req)
end

function YoungChampionKingAgent:handlePM_YCKKnockoutJoinRoomRes(status, msg)
	if status == 0 then
		YoungChampionKingController.instance:handlePM_YCKKnockoutJoinRoomRes(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.PM_YCKKnockoutJoinRoomError, status)
	end
end

function YoungChampionKingAgent:sendPM_YCKKnockoutInviteOpReq(activityId, stepId, groupId)
	local req = YoungChampionKingExtension_pb.PM_YCKKnockoutInviteOpReq()

	req.activityId = activityId
	req.stepId = stepId
	req.groupId = groupId

	self:sendMsg(req)
end

function YoungChampionKingAgent:handlePM_YCKKnockoutInviteOpRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function YoungChampionKingAgent:handlePM_NotifyYCKKnockoutOpInvitedRes(status, msg)
	if status == 0 then
		YoungChampionKingController.instance:handlePM_NotifyYCKKnockoutOpInvitedRes(msg)
	end
end

function YoungChampionKingAgent:sendPM_YCKKnockoutLeaveRoomReq()
	local req = YoungChampionKingExtension_pb.PM_YCKKnockoutLeaveRoomReq()

	self:sendMsg(req)
end

function YoungChampionKingAgent:handlePM_YCKKnockoutLeaveRoomRes(status, msg)
	if status == 0 then
		YoungChampionKingController.instance:handlePM_YCKKnockoutLeaveRoomRes(msg)
	end
end

function YoungChampionKingAgent:handlePM_NotifyYCKKnockoutOpJoinRoomRes(status, msg)
	if status == 0 then
		YoungChampionKingController.instance:handlePM_NotifyYCKKnockoutOpJoinRoomRes(msg)
	end
end

function YoungChampionKingAgent:handlePM_NotifyYCKKnockoutFightStartRes(status, msg)
	if status == 0 then
		YoungChampionKingController.instance:handlePM_NotifyYCKKnockoutFightStartRes(msg)
	end
end

function YoungChampionKingAgent:sendPM_YCKKnockoutSetGameFormationReq(activityId, simpleForm)
	local req = YoungChampionKingExtension_pb.PM_YCKKnockoutSetGameFormationReq()

	req.activityId = activityId

	if simpleForm ~= nil then
		req.simpleForm:ParseFromString(simpleForm:SerializeToString())
	end

	self:sendMsg(req)
end

function YoungChampionKingAgent:handlePM_YCKKnockoutSetGameFormationRes(status, msg)
	if status == 0 then
		YoungChampionKingController.instance:handlePM_YCKKnockoutSetGameFormationRes(msg)
	end
end

function YoungChampionKingAgent:handlePM_NotifyYCKKnockoutSetGameFormationFailRes(status, msg)
	if status == 0 then
		YoungChampionKingController.instance:handlePM_YCKKnockoutSetGameFormationRes(msg)
	end
end

function YoungChampionKingAgent:handlePM_NotifyYCKKnockoutOpSetFormationFinishRes(status, msg)
	if status == 0 then
		YoungChampionKingController.instance:handlePM_NotifyYCKKnockoutOpSetFormationFinishRes(msg)
	end
end

function YoungChampionKingAgent:handlePM_NotifyYCKKnockoutTurnToNextGameRoundRes(status, msg)
	if status == 0 then
		YoungChampionKingController.instance:handlePM_NotifyYCKKnockoutTurnToNextGameRoundRes(msg)
	end
end

function YoungChampionKingAgent:handlePM_NotifyYCKKnockoutGameEndRes(status, msg)
	if status == 0 then
		YoungChampionKingController.instance:handlePM_NotifyYCKKnockoutGameEndRes(msg)
	end
end

function YoungChampionKingAgent:handlePM_YCKNotifyStepChangeRes(status, msg)
	if status == 0 then
		YoungChampionKingController.instance:handlePM_YCKNotifyStepChangeRes(msg)
	end
end

function YoungChampionKingAgent:sendPM_YCKGetInfoReq(activityId)
	local req = YoungChampionKingExtension_pb.PM_YCKGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function YoungChampionKingAgent:handlePM_YCKGetInfoRes(status, msg)
	if status == 0 then
		YoungChampionKingController.instance:handlePM_YCKGetInfoRes(msg)
	end
end

function YoungChampionKingAgent:sendPM_YCKKnockoutSyncRoomInfoReq(activityId)
	local req = YoungChampionKingExtension_pb.PM_YCKKnockoutSyncRoomInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function YoungChampionKingAgent:handlePM_YCKKnockoutSyncRoomInfoRes(status, msg)
	if status == 0 then
		YoungChampionKingController.instance:handlePM_YCKKnockoutSyncRoomInfoRes(msg)
	end
end

YoungChampionKingAgent.instance = YoungChampionKingAgent.New()

return YoungChampionKingAgent
