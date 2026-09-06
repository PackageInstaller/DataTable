-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/agent/SeasonModePveTeamAgent.lua

module("logic.extensions.seasonmodepveteam.agent.SeasonModePveTeamAgent", package.seeall)

local SeasonModePveTeamAgent = class("SeasonModePveTeamAgent", BaseAgent)

function SeasonModePveTeamAgent:sendPM_GetSMPVEAllTeamInfoReq()
	local req = SeasonModePveTeamExtension_pb.PM_GetSMPVEAllTeamInfoReq()

	self:sendMsg(req)
end

function SeasonModePveTeamAgent:handlePM_GetSMPVEAllTeamInfoRes(status, msg)
	SeasonController.instance:handleGetSMPVEAllTeamInfoRes(status, msg)
end

function SeasonModePveTeamAgent:sendPM_GetSMPVECommonPetPackageReq()
	local req = SeasonModePveTeamExtension_pb.PM_GetSMPVECommonPetPackageReq()

	self:sendMsg(req)
end

function SeasonModePveTeamAgent:handlePM_GetSMPVECommonPetPackageRes(status, msg)
	SeasonController.instance:handleGetSMPVECommonPetPackageRes(status, msg)
end

function SeasonModePveTeamAgent:sendPM_SaveSMPSinglePetPackageReq(teamId, petIds)
	local req = SeasonModePveTeamExtension_pb.PM_SaveSMPSinglePetPackageReq()

	req.teamId = teamId

	for i, v3 in ipairs(petIds) do
		req.petIds:append(v3)
	end

	self:sendMsg(req)
end

function SeasonModePveTeamAgent:handlePM_SaveSMPSinglePetPackageRes(status, msg)
	SeasonController.instance:handleSaveSMPSinglePetPackageRes(status, msg)
end

function SeasonModePveTeamAgent:sendPM_ResetSMPVEAllTeamInfoReq()
	local req = SeasonModePveTeamExtension_pb.PM_ResetSMPVEAllTeamInfoReq()

	self:sendMsg(req)
end

function SeasonModePveTeamAgent:handlePM_ResetSMPVEAllTeamInfoRes(status, msg)
	SeasonController.instance:handleResetSMPVEAllTeamInfoRes(status, msg)
end

function SeasonModePveTeamAgent:sendPM_SaveSMPVESingleTeamFormReq(req)
	self:sendMsg(req)
end

function SeasonModePveTeamAgent:handlePM_SaveSMPVESingleTeamFormRes(status, msg)
	SeasonController.instance:handleSaveSMPVESingleTeamFormRes(status, msg)
end

function SeasonModePveTeamAgent:sendPM_SaveSMPVESingleTeamFormSummonInfoReq(req)
	self:sendMsg(req)
end

function SeasonModePveTeamAgent:handlePM_SaveSMPVESingleTeamFormSummonInfoRes(status, msg)
	SeasonController.instance:handleSaveSMPVESingleTeamFormSummonInfoRes(status, msg)
end

function SeasonModePveTeamAgent:sendPM_BuySMPVEPackageTimesReq(teamId)
	local req = SeasonModePveTeamExtension_pb.PM_BuySMPVEPackageTimesReq()

	req.teamId = teamId

	self:sendMsg(req)
end

function SeasonModePveTeamAgent:handlePM_BuySMPVEPackageTimesRes(status, msg)
	SeasonController.instance:handleBuySMPVEPackageTimesRes(status, msg)
end

function SeasonModePveTeamAgent:sendPM_SetSMPVETeamNameReq(teamId, name)
	local req = SeasonModePveTeamExtension_pb.PM_SetSMPVETeamNameReq()

	req.teamId = teamId
	req.name = name

	self:sendMsg(req)
end

function SeasonModePveTeamAgent:handlePM_SetSMPVETeamNameRes(status, msg)
	SeasonController.instance:handleSetSMPVETeamNameRes(status, msg)
end

function SeasonModePveTeamAgent:sendPM_GetSMPVESingleTeamHolyStripesInfoReq(teamId)
	local req = SeasonModePveTeamExtension_pb.PM_GetSMPVESingleTeamHolyStripesInfoReq()

	req.teamId = teamId

	self:sendMsg(req)
end

function SeasonModePveTeamAgent:handlePM_GetSMPVESingleTeamHolyStripesInfoRes(status, msg)
	SeasonController.instance:handleGetSMPVESingleTeamHolyStripesInfoRes(status, msg)
end

function SeasonModePveTeamAgent:sendPM_ChangeSMPVESinglePetHolyStripesInfoReq(teamId, raceId, holyStripesId)
	local req = SeasonModePveTeamExtension_pb.PM_ChangeSMPVESinglePetHolyStripesInfoReq()

	req.teamId = teamId
	req.raceId = raceId
	req.holyStripesId = holyStripesId

	self:sendMsg(req)
end

function SeasonModePveTeamAgent:handlePM_ChangeSMPVESinglePetHolyStripesInfoRes(status, msg)
	SeasonController.instance:handleChangeSMPVESinglePetHolyStripesInfoRes(status, msg)
end

function SeasonModePveTeamAgent:handlePM_SMPVENotifyTeamZdlChangedRes(status, msg)
	SeasonController.instance:handlePM_SMPVENotifyTeamZdlChangedRes(status, msg)
end

function SeasonModePveTeamAgent:sendPM_SMPVEPetChangeTipInfoReq()
	local req = SeasonModePveTeamExtension_pb.PM_SMPVEPetChangeTipInfoReq()

	self:sendMsg(req)
end

function SeasonModePveTeamAgent:handlePM_SMPVEPetChangeTipInfoRes(status, msg)
	SeasonController.instance:handlePM_SMPVEPetChangeTipInfoRes(status, msg)
end

function SeasonModePveTeamAgent:handlePM_NotifySMPVEUnlockTeamRes(status, msg)
	SeasonController.instance:handleNotifySMPVEUnlockTeamRes(status, msg)
end

SeasonModePveTeamAgent.instance = SeasonModePveTeamAgent.New()

return SeasonModePveTeamAgent
