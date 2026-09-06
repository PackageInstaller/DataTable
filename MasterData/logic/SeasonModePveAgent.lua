-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/agent/SeasonModePveAgent.lua

module("logic.extensions.seasonmodepve.agent.SeasonModePveAgent", package.seeall)

local SeasonModePveAgent = class("SeasonModePveAgent", BaseAgent)

function SeasonModePveAgent:sendPM_SMPVEInitMapReq()
	local req = SeasonModePveExtension_pb.PM_SMPVEInitMapReq()

	self:sendMsg(req)
end

function SeasonModePveAgent:handlePM_SMPVEInitMapRes(status, msg)
	SeasonController.instance:handleSMPVEInitMapRes(status, msg)
end

function SeasonModePveAgent:sendPM_SMPVELoadMapInfoReq(req)
	self:sendMsg(req)
end

function SeasonModePveAgent:handlePM_SMPVELoadMapInfoRes(status, msg)
	SeasonController.instance:handleSMPVELoadMapInfoRes(status, msg)
end

function SeasonModePveAgent:sendPM_SMPVESwitchCurTeamReq(teamId)
	local req = SeasonModePveExtension_pb.PM_SMPVESwitchCurTeamReq()

	req.teamId = teamId

	self:sendMsg(req)
end

function SeasonModePveAgent:handlePM_SMPVESwitchCurTeamRes(status, msg)
	SeasonController.instance:handleSMPVESwitchCurTeamRes(status, msg)
end

function SeasonModePveAgent:sendPM_SMPVETeamMoveReq(teamId, targetPoint)
	local req = SeasonModePveExtension_pb.PM_SMPVETeamMoveReq()

	req.teamId = teamId
	req.targetPoint = targetPoint

	self:sendMsg(req)
end

function SeasonModePveAgent:handlePM_SMPVETeamMoveRes(status, msg)
	SeasonController.instance:handleSMPVETeamMoveRes(status, msg)
end

function SeasonModePveAgent:sendPM_SMPVEPathRouterMoveReq(req)
	self:sendMsg(req)
end

function SeasonModePveAgent:handlePM_SMPVEPathRouterMoveRes(status, msg)
	SeasonController.instance:handleSMPVEPathRouterMoveRes(status, msg)
end

function SeasonModePveAgent:sendPM_SMPVEMarkMapPointReq(pointIds, isMark)
	local req = SeasonModePveExtension_pb.PM_SMPVEMarkMapPointReq()

	for i = 1, #pointIds do
		table.insert(req.pointIds, pointIds[i])
	end

	req.isMark = isMark

	self:sendMsg(req)
end

function SeasonModePveAgent:handlePM_SMPVEMarkMapPointRes(status, msg)
	SeasonController.instance:handleSMPVEMarkMapPointRes(status, msg)
end

function SeasonModePveAgent:sendPM_SMPVEHandleEventReq(teamId, targetPoint, param, form)
	local req = SeasonModePveExtension_pb.PM_SMPVEHandleEventReq()

	req.teamId = teamId
	req.targetPoint = targetPoint
	req.param = param

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function SeasonModePveAgent:handlePM_SMPVEHandleEventRes(status, msg)
	SeasonController.instance:handleSMPVEHandleEventRes(status, msg)
end

function SeasonModePveAgent:sendPM_SMPVEEventInfoReq(targetPoint)
	local req = SeasonModePveExtension_pb.PM_SMPVEEventInfoReq()

	req.targetPoint = targetPoint

	self:sendMsg(req)
end

function SeasonModePveAgent:handlePM_SMPVEEventInfoRes(status, msg)
	SeasonController.instance:handleSMPVEEventInfoRes(status, msg)
end

function SeasonModePveAgent:handlePM_SMPVENotifyTeamLockRes(status, msg)
	SeasonPVEBossController.instance:handleSMPVENotifyTeamLockRes(status, msg)
end

function SeasonModePveAgent:sendPM_SMPVETeamStrengthInfoReq()
	local req = SeasonModePveExtension_pb.PM_SMPVETeamStrengthInfoReq()

	self:sendMsg(req)
end

function SeasonModePveAgent:handlePM_SMPVETeamStrengthInfoRes(status, msg)
	SeasonController.instance:handleSMPVETeamStrengthInfoRes(status, msg)
end

function SeasonModePveAgent:handlePM_NotifySMPVEStrengthChangeRes(status, msg)
	SeasonController.instance:handleNotifySMPVEStrengthChangeRes(status, msg)
end

function SeasonModePveAgent:sendPM_SMPVEPushBossPhaseReq()
	local req = SeasonModePveExtension_pb.PM_SMPVEPushBossPhaseReq()

	self:sendMsg(req)
end

function SeasonModePveAgent:handlePM_SMPVEPushBossPhaseRes(status, msg)
	SeasonPVEBossController.instance:handleSMPVEPushBossPhaseRes(status, msg)
end

function SeasonModePveAgent:handlePM_NotifySMPVEBossPhaseNextStepRes(status, msg)
	SeasonPVEBossController.instance:handleNotifySMPVEBossPhaseNextStepRes(status, msg)
end

function SeasonModePveAgent:sendPM_SMPVEBossDoppelgangerResetTeamReq(teamId)
	local req = SeasonModePveExtension_pb.PM_SMPVEBossDoppelgangerResetTeamReq()

	req.teamId = teamId

	self:sendMsg(req)
end

function SeasonModePveAgent:handlePM_SMPVEBossDoppelgangerResetTeamRes(status, msg)
	SeasonPVEBossController.instance:handleSMPVEBossDoppelgangerResetTeamRes(status, msg)
end

function SeasonModePveAgent:sendPM_SMPVECalPetStrengthInfoReq()
	local req = SeasonModePveExtension_pb.PM_SMPVECalPetStrengthInfoReq()

	self:sendMsg(req)
end

function SeasonModePveAgent:handlePM_SMPVECalPetStrengthInfoRes(status, msg)
	if status == 0 then
		SeasonTeamsModel.instance:onGetAllTeamAttrInfo(msg)
	end
end

function SeasonModePveAgent:sendPM_SMPVESeasonInfoReq(seasonId)
	local req = SeasonModePveExtension_pb.PM_SMPVESeasonInfoReq()

	req.seasonId = seasonId

	self:sendMsg(req)
end

function SeasonModePveAgent:handlePM_SMPVESeasonInfoRes(status, msg)
	SeasonController.instance:handleSMPVEInfoRes(status, msg)
end

function SeasonModePveAgent:sendPM_SMPVESeasonInitReq()
	local req = SeasonModePveExtension_pb.PM_SMPVESeasonInitReq()

	self:sendMsg(req)
end

function SeasonModePveAgent:handlePM_SMPVESeasonInitRes(status, msg)
	return
end

function SeasonModePveAgent:sendPM_SMPVEGetMainCampInfoReq(otherUserId)
	local req = SeasonModePveExtension_pb.PM_SMPVEGetMainCampInfoReq()

	if otherUserId then
		req.otherUserId = otherUserId
	end

	self:sendMsg(req)
end

function SeasonModePveAgent:handlePM_SMPVEGetMainCampInfoRes(status, msg)
	SeasonMainCampController.instance:handleSMPVEGetMainCampInfoRes(status, msg)
end

function SeasonModePveAgent:sendPM_SMPVEUpgradeCampLvReq()
	local req = SeasonModePveExtension_pb.PM_SMPVEUpgradeCampLvReq()

	self:sendMsg(req)
end

function SeasonModePveAgent:handlePM_SMPVEUpgradeCampLvRes(status, msg)
	SeasonMainCampController.instance:handleSMPVEUpgradeCampLvRes(status, msg)
end

function SeasonModePveAgent:sendPM_SMPVEGainHangingPrizeReq()
	local req = SeasonModePveExtension_pb.PM_SMPVEGainHangingPrizeReq()

	self:sendMsg(req)
end

function SeasonModePveAgent:handlePM_SMPVEGainHangingPrizeRes(status, msg)
	SeasonMainCampController.instance:handleSMPVEGainHangingPrizeRes(status, msg)
end

function SeasonModePveAgent:sendPM_SMPVETriggerHangingStartTimeReq()
	local req = SeasonModePveExtension_pb.PM_SMPVETriggerHangingStartTimeReq()

	self:sendMsg(req)
end

function SeasonModePveAgent:handlePM_SMPVETriggerHangingStartTimeRes(status, msg)
	SeasonMainCampController.instance:handlePSMPVETriggerHangingStartTimeRes(status, msg)
end

function SeasonModePveAgent:sendPM_SMPVEChangePetGuardReq(slotId, raceId)
	local req = SeasonModePveExtension_pb.PM_SMPVEChangePetGuardReq()

	req.slotId = slotId
	req.raceId = raceId

	self:sendMsg(req)
end

function SeasonModePveAgent:handlePM_SMPVEChangePetGuardRes(status, msg)
	SeasonMainCampController.instance:handleSMPVEChangePetGuardRes(status, msg)
end

function SeasonModePveAgent:sendPM_SMPVEGetTrainingGroundInfoReq()
	local req = SeasonModePveExtension_pb.PM_SMPVEGetTrainingGroundInfoReq()

	self:sendMsg(req)
end

function SeasonModePveAgent:handlePM_SMPVEGetTrainingGroundInfoRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function SeasonModePveAgent:sendPM_SMPVEUpgradeTeamLvReq(teamId)
	local req = SeasonModePveExtension_pb.PM_SMPVEUpgradeTeamLvReq()

	req.teamId = teamId

	self:sendMsg(req)
end

function SeasonModePveAgent:handlePM_SMPVEUpgradeTeamLvRes(status, msg)
	if status == 0 then
		SeasonController.instance:handlePM_SMPVEUpgradeTeamLvRes(status, msg)
	end
end

function SeasonModePveAgent:sendPM_SMPVEGetTotemPoleInfoReq(userId)
	local req = SeasonModePveExtension_pb.PM_SMPVEGetTotemPoleInfoReq()

	if userId then
		req.otherUserId = userId
	end

	self:sendMsg(req)
end

function SeasonModePveAgent:handlePM_SMPVEGetTotemPoleInfoRes(status, msg)
	SeasonMainCampController.instance:handleSMPVEGetTotemPoleInfoRes(status, msg)
end

function SeasonModePveAgent:sendPM_SMPVEUpgradeTotemPoleItemReq(raceType, itemId)
	local req = SeasonModePveExtension_pb.PM_SMPVEUpgradeTotemPoleItemReq()

	req.raceType = raceType
	req.itemId = itemId

	self:sendMsg(req)
end

function SeasonModePveAgent:handlePM_SMPVEUpgradeTotemPoleItemRes(status, msg)
	SeasonMainCampController.instance:handleSMPVEUpgradeTotemPoleItemRes(status, msg)
end

function SeasonModePveAgent:sendPM_SMPVEUpgradeMainTotemPoleReq(raceType)
	local req = SeasonModePveExtension_pb.PM_SMPVEUpgradeMainTotemPoleReq()

	req.raceType = raceType

	self:sendMsg(req)
end

function SeasonModePveAgent:handlePM_SMPVEUpgradeMainTotemPoleRes(status, msg)
	SeasonMainCampController.instance:handleSMPVEUpgradeMainTotemPoleRes(status, msg)
end

function SeasonModePveAgent:sendPM_SMPVEGetPetPalaceInfoReq(otherUserId)
	local req = SeasonModePveExtension_pb.PM_SMPVEGetPetPalaceInfoReq()

	if otherUserId then
		req.otherUserId = otherUserId
	end

	self:sendMsg(req)
end

function SeasonModePveAgent:handlePM_SMPVEGetPetPalaceInfoRes(status, msg)
	SeasonController.instance:handlePM_SMPVEGetPetPalaceInfoRes(status, msg)
end

function SeasonModePveAgent:sendPM_SMPVEChangeHirePetReq(slotId, petDefineId)
	local req = SeasonModePveExtension_pb.PM_SMPVEChangeHirePetReq()

	req.slotId = slotId
	req.petDefineId = petDefineId

	self:sendMsg(req)
end

function SeasonModePveAgent:handlePM_SMPVEChangeHirePetRes(status, msg)
	SeasonController.instance:handlePM_SMPVEChangeHirePetRes(status, msg)
end

function SeasonModePveAgent:sendPM_SMPVEGetBudgeInfoReq()
	local req = SeasonModePveExtension_pb.PM_SMPVEGetBudgeInfoReq()

	self:sendMsg(req)
end

function SeasonModePveAgent:handlePM_SMPVEGetBudgeInfoRes(status, msg)
	SeasonMainCampController.instance:handleSMPVEGetBudgeInfoRes(status, msg)
end

function SeasonModePveAgent:sendPM_SMPVEActiviteBudgeReq(budgeId)
	local req = SeasonModePveExtension_pb.PM_SMPVEActiviteBudgeReq()

	req.budgeId = budgeId

	self:sendMsg(req)
end

function SeasonModePveAgent:handlePM_SMPVEActiviteBudgeRes(status, msg)
	SeasonMainCampController.instance:handleSMPVEActiviteBudgeRes(status, msg)
end

function SeasonModePveAgent:sendPM_SMPVEGetRankInfoReq(rankType, seasonId, zoneId)
	local req = SeasonModePveExtension_pb.PM_SMPVEGetRankInfoReq()

	req.rankType = rankType
	req.seasonId = seasonId
	req.zoneId = zoneId

	self:sendMsg(req)
end

function SeasonModePveAgent:handlePM_SMPVEGetRankInfoRes(status, msg)
	SeasonController.instance:handlePM_SMPVEGetRankInfoRes(status, msg)
end

SeasonModePveAgent.instance = SeasonModePveAgent.New()

return SeasonModePveAgent
