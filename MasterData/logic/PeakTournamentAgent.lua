-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktournament/agent/PeakTournamentAgent.lua

module("logic.extensions.peaktournament.agent.PeakTournamentAgent", package.seeall)

local PeakTournamentAgent = class("PeakTournamentAgent", BaseAgent)

function PeakTournamentAgent:sendPM_PeakTournamentGetQualifierInfoReq(actId)
	local req = PeakTournamentExtension_pb.PM_PeakTournamentGetQualifierInfoReq()

	req.actId = actId

	self:sendMsg(req)
end

function PeakTournamentAgent:handlePM_PeakTournamentGetQualifierInfoRes(status, msg)
	if status == 0 then
		PeakTournamentController.instance:handlePM_PeakTournamentGetQualifierInfoRes(msg)
	end
end

function PeakTournamentAgent:sendPM_PeakTournamentQualifierFightReq(actId)
	local req = PeakTournamentExtension_pb.PM_PeakTournamentQualifierFightReq()

	req.actId = actId

	self:sendMsg(req)
end

function PeakTournamentAgent:handlePM_PeakTournamentQualifierFightRes(status, msg)
	if status == 0 then
		PeakTournamentController.instance:handlePM_PeakTournamentQualifierFightRes(msg)
	end
end

function PeakTournamentAgent:sendPM_PeakTournamentQualifierRecordsReq(actId)
	local req = PeakTournamentExtension_pb.PM_PeakTournamentQualifierRecordsReq()

	req.actId = actId

	self:sendMsg(req)
end

function PeakTournamentAgent:handlePM_PeakTournamentQualifierRecordsRes(status, msg)
	if status == 0 then
		PeakTournamentController.instance:handlePM_PeakTournamentQualifierRecordsRes(msg)
	end
end

function PeakTournamentAgent:sendPM_PeakTournamentQualifierRankInfoReq(actId, zoneId)
	local req = PeakTournamentExtension_pb.PM_PeakTournamentQualifierRankInfoReq()

	req.actId = actId
	req.zoneId = zoneId

	self:sendMsg(req)
end

function PeakTournamentAgent:handlePM_PeakTournamentQualifierRankInfoRes(status, msg)
	if status == 0 then
		PeakTournamentController.instance:handlePM_PeakTournamentQualifierRankInfoRes(msg)
	end
end

function PeakTournamentAgent:sendPM_PeakTournamentQualifierTaskInfoReq(actId)
	local req = PeakTournamentExtension_pb.PM_PeakTournamentQualifierTaskInfoReq()

	req.actId = actId

	self:sendMsg(req)
end

function PeakTournamentAgent:handlePM_PeakTournamentQualifierTaskInfoRes(status, msg)
	if status == 0 then
		PeakTournamentController.instance:handlePM_PeakTournamentQualifierTaskInfoRes(msg)
	end
end

function PeakTournamentAgent:sendPM_PeakTournamentGainQualifierTaskPrizeReq(actId, taskId_i32_Ary)
	local req = PeakTournamentExtension_pb.PM_PeakTournamentGainQualifierTaskPrizeReq()

	req.actId = actId

	for i, v1 in ipairs(taskId_i32_Ary) do
		req.taskId:append(v1)
	end

	self:sendMsg(req)
end

function PeakTournamentAgent:handlePM_PeakTournamentGainQualifierTaskPrizeRes(status, msg)
	if status == 0 then
		PeakTournamentController.instance:handlePM_PeakTournamentGainQualifierTaskPrizeRes(msg)
	end
end

function PeakTournamentAgent:sendPM_PeakTournamentQualifierVideoReq(battleId)
	local req = PeakTournamentExtension_pb.PM_PeakTournamentQualifierVideoReq()

	req.battleId = battleId

	self:sendMsg(req)
end

function PeakTournamentAgent:handlePM_PeakTournamentQualifierVideoRes(status, msg)
	if status == 0 then
		PeakTournamentController.instance:handlePM_PeakTournamentQualifierVideoRes(msg)
	end
end

function PeakTournamentAgent:sendPM_PeakTournamentKnockoutGetParticipationInfoReq(actId)
	local req = PeakTournamentExtension_pb.PM_PeakTournamentKnockoutGetParticipationInfoReq()

	req.actId = actId

	self:sendMsg(req)
end

function PeakTournamentAgent:handlePM_PeakTournamentKnockoutGetParticipationInfoRes(status, msg)
	if status == 0 then
		PeakTournamentController.instance:handlePM_PeakTournamentKnockoutGetParticipationInfoRes(msg)
	end
end

function PeakTournamentAgent:sendPM_PeakTournamentKnockoutGetMyScheduleInfoReq(actId)
	local req = PeakTournamentExtension_pb.PM_PeakTournamentKnockoutGetMyScheduleInfoReq()

	req.actId = actId

	self:sendMsg(req)
end

function PeakTournamentAgent:handlePM_PeakTournamentKnockoutGetMyScheduleInfoRes(status, msg)
	if status == 0 then
		PeakTournamentController.instance:handlePM_PeakTournamentKnockoutGetMyScheduleInfoRes(msg)
	end
end

function PeakTournamentAgent:sendPM_PeakTournamentKnockoutGetMyBattleRecordsReq(actId)
	local req = PeakTournamentExtension_pb.PM_PeakTournamentKnockoutGetMyBattleRecordsReq()

	req.actId = actId

	self:sendMsg(req)
end

function PeakTournamentAgent:handlePM_PeakTournamentKnockoutGetMyBattleRecordsRes(status, msg)
	if status == 0 then
		PeakTournamentController.instance:handlePM_PeakTournamentKnockoutGetMyBattleRecordsRes(msg)
	end
end

function PeakTournamentAgent:sendPM_PeakTournamentKnockoutGetBattleVideoReq(battleIds)
	local req = PeakTournamentExtension_pb.PM_PeakTournamentKnockoutGetBattleVideoReq()

	if battleIds then
		for _, battleId in ipairs(battleIds) do
			req.battleId:append(battleId)
		end
	end

	self:sendMsg(req)
end

function PeakTournamentAgent:handlePM_PeakTournamentKnockoutGetBattleVideoRes(status, msg)
	if status == 0 then
		PeakTournamentController.instance:handlePM_PeakTournamentKnockoutGetBattleVideoRes(msg)
	end
end

function PeakTournamentAgent:sendPM_PeakTournamentSetFormReq(actId, simpleFormList, defenseForm)
	local req = PeakTournamentExtension_pb.PM_PeakTournamentSetFormReq()

	req.actId = actId
	req.defenseForm = checkbool(defenseForm)

	for formId, simpleForm in ipairs(simpleFormList) do
		local form = PeakTournamentExtension_pb.PeakTournamentFormationNO()
		local playerView = PlayerExtension_pb.PM_OtherPlayerView()

		playerView.curForm:ParseFromString(simpleForm:SerializeToString())

		form.formId = formId

		form.view:ParseFromString(playerView:SerializeToString())

		local forms = req.forms:add()

		forms:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function PeakTournamentAgent:handlePM_PeakTournamentSetFormRes(status, msg)
	if status == 0 then
		PeakTournamentController.instance:handlePM_PeakTournamentSetFormRes(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.OneKeySetDefenseSaveFmtFailed)
	end
end

function PeakTournamentAgent:sendPM_PeakTournamentGetFormReq(actId, defenseForm)
	local req = PeakTournamentExtension_pb.PM_PeakTournamentGetFormReq()

	req.actId = actId
	req.defenseForm = checkbool(defenseForm)

	self:sendMsg(req)
end

function PeakTournamentAgent:handlePM_PeakTournamentFormRes(status, msg)
	PeakTournamentController.instance:handlePM_PeakTournamentFormRes(status, msg)
end

function PeakTournamentAgent:sendPM_PeakTournamentKnockoutGetGuessInfoReq(actId)
	local req = PeakTournamentExtension_pb.PM_PeakTournamentKnockoutGetGuessInfoReq()

	req.actId = actId

	self:sendMsg(req)
end

function PeakTournamentAgent:handlePM_PeakTournamentKnockoutGetGuessInfoRes(status, msg)
	if status == 0 then
		PeakTournamentController.instance:handlePM_PeakTournamentKnockoutGetGuessInfoRes(msg)
	end
end

function PeakTournamentAgent:sendPM_PeakTournamentKnockoutGuessReq(actId, targetUserId, guessNums)
	local req = PeakTournamentExtension_pb.PM_PeakTournamentKnockoutGuessReq()

	req.actId = actId
	req.targetUserId = targetUserId
	req.guessNums = guessNums

	self:sendMsg(req)
end

function PeakTournamentAgent:handlePM_PeakTournamentKnockoutGuessRes(status, msg)
	if status == 0 then
		PeakTournamentController.instance:handlePM_PeakTournamentKnockoutGuessRes(msg)
	end
end

function PeakTournamentAgent:sendPM_PeakTournamentKnockoutGainGuessCoinReq(actId)
	local req = PeakTournamentExtension_pb.PM_PeakTournamentKnockoutGainGuessCoinReq()

	req.actId = actId

	self:sendMsg(req)
end

function PeakTournamentAgent:handlePM_PeakTournamentKnockoutGainGuessCoinRes(status, msg)
	if status == 0 then
		PeakTournamentController.instance:handlePM_PeakTournamentKnockoutGainGuessCoinRes(msg)
	end
end

function PeakTournamentAgent:sendPM_PeakTournamentKnockoutGainGuessRecordReq(actId, roundId)
	local req = PeakTournamentExtension_pb.PM_PeakTournamentKnockoutGainGuessRecordReq()

	req.actId = actId
	req.roundId = roundId

	self:sendMsg(req)
end

function PeakTournamentAgent:handlePM_PeakTournamentKnockoutGainGuessRecordRes(status, msg)
	if status == 0 then
		PeakTournamentController.instance:handlePM_PeakTournamentKnockoutGainGuessRecordRes(msg)
	end
end

function PeakTournamentAgent:sendPM_PeakTournamentKnockoutGetGroupStageInfoReq(actId, roundGroupListPool)
	local req = PeakTournamentExtension_pb.PM_PeakTournamentKnockoutGetGroupStageInfoReq()

	req.actId = actId

	for roundId, groupIdList in pairs(roundGroupListPool) do
		for _, groupId in ipairs(groupIdList) do
			local roundGroup = PeakTournamentExtension_pb.PeakTournamentKnockoutRoundGroup()

			roundGroup.groupId = groupId
			roundGroup.roundId = roundId

			req.roundGroups:add():ParseFromString(roundGroup:SerializeToString())
		end
	end

	self:sendMsg(req)
end

function PeakTournamentAgent:handlePM_PeakTournamentKnockoutGetGroupStageInfoRes(status, msg)
	if status == 0 then
		PeakTournamentController.instance:handlePM_PeakTournamentKnockoutGetGroupStageInfoRes(msg)
	end
end

function PeakTournamentAgent:sendPM_PeakTournamentKnockoutGetTopViewReq(actId)
	local req = PeakTournamentExtension_pb.PM_PeakTournamentKnockoutGetTopViewReq()

	req.actId = actId

	self:sendMsg(req)
end

function PeakTournamentAgent:handlePM_PeakTournamentKnockoutGetTopViewRes(status, msg)
	if status == 0 then
		PeakTournamentController.instance:handlePM_PeakTournamentKnockoutGetTopViewRes(msg)
	end
end

function PeakTournamentAgent:sendPM_PeakTournamentKudosReq(actId, isGlobal)
	local req = PeakTournamentExtension_pb.PM_PeakTournamentKudosReq()

	req.actId = actId
	req.isGlobal = isGlobal

	self:sendMsg(req)
end

function PeakTournamentAgent:handlePM_PeakTournamentKudosRes(status, msg)
	if status == 0 then
		PeakTournamentController.instance:handlePM_PeakTournamentKudosRes(msg)
	end
end

function PeakTournamentAgent:sendPM_PeakTournamentBanPetReq(actId, raceIds)
	local req = PeakTournamentExtension_pb.PM_PeakTournamentBanPetReq()

	req.actId = actId

	for _, v in ipairs(raceIds) do
		req.raceIds:append(v)
	end

	self:sendMsg(req)
end

function PeakTournamentAgent:handlePM_PeakTournamentBanPetRes(status, msg)
	if status == 0 then
		PeakTournamentController.instance:handlePM_PeakTournamentBanPetRes(msg)
	end
end

function PeakTournamentAgent:sendPM_PeakTournamentBanPetInfoReq(actId)
	local req = PeakTournamentExtension_pb.PM_PeakTournamentBanPetInfoReq()

	req.actId = actId

	self:sendMsg(req)
end

function PeakTournamentAgent:handlePM_PeakTournamentBanPetInfoRes(status, msg)
	if status == 0 then
		PeakTournamentController.instance:handlePM_PeakTournamentBanPetInfoRes(msg)
	end
end

PeakTournamentAgent.instance = PeakTournamentAgent.New()

return PeakTournamentAgent
