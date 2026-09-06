-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/agent/SeasonModePvePlusAgent.lua

module("logic.extensions.season.agent.SeasonModePvePlusAgent", package.seeall)

local SeasonModePvePlusAgent = class("SeasonModePvePlusAgent", BaseAgent)

function SeasonModePvePlusAgent:ctor()
	return
end

function SeasonModePvePlusAgent:setExtId(extId)
	SeasonModePvePlusAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function SeasonModePvePlusAgent:sendPM_SMPVEGetMapBuffInfoReq()
	local req = SeasonModePvePlusExtension_pb.PM_SMPVEGetMapBuffInfoReq()

	self:sendMsg(req)
end

function SeasonModePvePlusAgent:handlePM_SMPVEGetMapBuffInfoRes(status, msg)
	if status == 0 then
		SeasonController.instance:handleMapBuffInfo(msg)
	end
end

function SeasonModePvePlusAgent:sendPM_SMPVEEmakiFragmentInfosReq()
	local req = SeasonModePvePlusExtension_pb.PM_SMPVEEmakiFragmentInfosReq()

	self:sendMsg(req)
end

function SeasonModePvePlusAgent:handlePM_SMPVEEmakiFragmentInfosRes(status, msg)
	if status == 0 then
		SeasonModel.instance:handleAllFragment(msg)
	end
end

function SeasonModePvePlusAgent:handlePM_NotifySMPVEMapBuffChangedRes(status, msg)
	if status == 0 then
		SeasonController.instance:handleMapBuffInfo(msg)
	end
end

function SeasonModePvePlusAgent:handlePM_NotifySMPVEGainHirePetRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function SeasonModePvePlusAgent:sendPM_SMPVEFindKeyInfoReq()
	local req = SeasonModePvePlusExtension_pb.PM_SMPVEFindKeyInfoReq()

	self:sendMsg(req)
end

function SeasonModePvePlusAgent:handlePM_SMPVEFindKeyInfoRes(status, msg)
	if status == 0 then
		SeasonController.instance:handleFindKeyInfo(msg)
	end
end

function SeasonModePvePlusAgent:sendPM_GetSMPVESingleTeamCutePetInfoReq(teamId)
	local req = SeasonModePvePlusExtension_pb.PM_GetSMPVESingleTeamCutePetInfoReq()

	req.teamId = teamId

	self:sendMsg(req)
end

function SeasonModePvePlusAgent:handlePM_GetSMPVESingleTeamCutePetInfoRes(status, msg)
	if status == 0 then
		SeasonController.instance:handlePM_GetSMPVESingleTeamCutePetInfoRes(status, msg)
	end
end

function SeasonModePvePlusAgent:sendPM_ChangeSMPVESinglePetCutePetInfoReq(teamId, raceId, cutePetType, cutePetTalentId)
	local req = SeasonModePvePlusExtension_pb.PM_ChangeSMPVESinglePetCutePetInfoReq()

	req.teamId = teamId
	req.raceId = raceId
	req.cutePetType = cutePetType
	req.cutePetTalentId = cutePetTalentId

	self:sendMsg(req)
end

function SeasonModePvePlusAgent:handlePM_ChangeSMPVESinglePetCutePetInfoRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function SeasonModePvePlusAgent:sendPM_GetSMPVEAllTeamCutePetInfoReq()
	local req = SeasonModePvePlusExtension_pb.PM_GetSMPVEAllTeamCutePetInfoReq()

	self:sendMsg(req)
end

function SeasonModePvePlusAgent:handlePM_GetSMPVEAllTeamCutePetInfoRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function SeasonModePvePlusAgent:sendPM_SMGVEGroupInfoReq()
	local req = SeasonModePvePlusExtension_pb.PM_SMGVEGroupInfoReq()

	self:sendMsg(req)
end

function SeasonModePvePlusAgent:handlePM_SMGVEGroupInfoRes(status, msg)
	if status == 0 then
		SeasonController.instance:handlePM_SMGVEGroupInfoRes(msg)
	end
end

function SeasonModePvePlusAgent:sendPM_SMGVEGroupInviteListReq()
	local req = SeasonModePvePlusExtension_pb.PM_SMGVEGroupInviteListReq()

	self:sendMsg(req)
end

function SeasonModePvePlusAgent:handlePM_SMGVEGroupInviteListRes(status, msg)
	if status == 0 then
		SeasonController.instance:handlePM_SMGVEGroupInviteListRes(msg)
	end
end

function SeasonModePvePlusAgent:sendPM_SMGVEGroupInviteBuddyListReq()
	local req = SeasonModePvePlusExtension_pb.PM_SMGVEGroupInviteBuddyListReq()

	self:sendMsg(req)
end

function SeasonModePvePlusAgent:handlePM_SMGVEGroupInviteBuddyListRes(status, msg)
	if status == 0 then
		SeasonController.instance:handlePM_SMGVEGroupInviteBuddyListRes(msg)
	end
end

function SeasonModePvePlusAgent:sendPM_SMGVESendGroupInviteReq(ids)
	local req = SeasonModePvePlusExtension_pb.PM_SMGVESendGroupInviteReq()

	for i, v in ipairs(ids) do
		req.targetUserId:append(v)
	end

	self:sendMsg(req)
end

function SeasonModePvePlusAgent:handlePM_SMGVESendGroupInviteRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function SeasonModePvePlusAgent:sendPM_SMGVEHandleGroupInviteReq(userId, action)
	local req = SeasonModePvePlusExtension_pb.PM_SMGVEHandleGroupInviteReq()

	req.userId = userId
	req.action = action

	self:sendMsg(req)
end

function SeasonModePvePlusAgent:handlePM_SMGVEHandleGroupInviteRes(status, msg)
	if status == 0 then
		SeasonController.instance:handlePM_SMGVEHandleGroupInviteRes(msg)
	end
end

function SeasonModePvePlusAgent:sendPM_SMGVEGroupReadyReq()
	local req = SeasonModePvePlusExtension_pb.PM_SMGVEGroupReadyReq()

	self:sendMsg(req)
end

function SeasonModePvePlusAgent:handlePM_SMGVEGroupReadyRes(status, msg)
	if status == 0 then
		SeasonController.instance:handlePM_SMGVEGroupReadyRes(msg)
	end
end

function SeasonModePvePlusAgent:sendPM_SMGVEGroupLeaveReq()
	local req = SeasonModePvePlusExtension_pb.PM_SMGVEGroupLeaveReq()

	self:sendMsg(req)
end

function SeasonModePvePlusAgent:handlePM_SMGVEGroupLeaveRes(status, msg)
	if status == 0 then
		SeasonController.instance:handlePM_SMGVEGroupLeaveRes(msg)
	end
end

function SeasonModePvePlusAgent:sendPM_SMGVEDetermineCreatePveGameModeReq()
	local req = SeasonModePvePlusExtension_pb.PM_SMGVEDetermineCreatePveGameModeReq()

	self:sendMsg(req)
end

function SeasonModePvePlusAgent:handlePM_SMGVEDetermineCreatePveGameModeRes(status, msg)
	if status == 0 then
		SeasonController.instance:handlePM_SMGVEDetermineCreatePveGameModeReq(msg)
	end
end

function SeasonModePvePlusAgent:handlePM_NotifySMGVEReceiveGroupInviteRes(status, msg)
	if status == 0 then
		SeasonController.instance:handlePM_NotifySMGVEReceiveGroupInviteRes(msg)
	end
end

function SeasonModePvePlusAgent:handlePM_NotifySMGVESuccessCreateGroupRes(status, msg)
	if status == 0 then
		SeasonController.instance:handlePM_NotifySMGVESuccessCreateGroupRes(msg)
	end
end

function SeasonModePvePlusAgent:handlePM_NotifySMGVEGroupDisbandRes(status, msg)
	if status == 0 then
		SeasonController.instance:handlePM_NotifySMGVEGroupDisbandRes(msg)
	end
end

function SeasonModePvePlusAgent:handlePM_NotifySMGVESuccessCreateGVERoomRes(status, msg)
	if status == 0 then
		SeasonController.instance:handlePM_NotifySMGVESuccessCreateGVERoomRes(msg)
	end
end

function SeasonModePvePlusAgent:handlePM_NotifySMGVEOpReadyRes(status, msg)
	if status == 0 then
		SeasonController.instance:handlePM_NotifySMGVEOpReadyRes(msg)
	end
end

function SeasonModePvePlusAgent:sendPM_SMGVETeammateTeamInfoReq()
	local req = SeasonModePvePlusExtension_pb.PM_SMGVETeammateTeamInfoReq()

	self:sendMsg(req)
end

function SeasonModePvePlusAgent:handlePM_SMGVETeammateTeamInfoRes(status, msg)
	if status == 0 then
		SeasonController.instance:handlePM_SMGVETeammateTeamInfoRes(msg)
	end
end

function SeasonModePvePlusAgent:sendPM_SMGVETeammateAllTeamInfoReq(otherUserId)
	local req = SeasonModePvePlusExtension_pb.PM_SMGVETeammateAllTeamInfoReq()

	req.otherUserId = otherUserId

	self:sendMsg(req)
end

function SeasonModePvePlusAgent:handlePM_SMGVETeammateAllTeamInfoRes(status, msg)
	if status == 0 then
		SeasonController.instance:handlePM_SMGVETeammateAllTeamInfoRes(msg)
	end
end

function SeasonModePvePlusAgent:handlePM_SMPVENotifyPointOccupiedRes(status, msg)
	SeasonController.instance:handleSMPVENotifyPointOccupiedRes(status, msg)
end

function SeasonModePvePlusAgent:handlePM_SMPVENotifyTeammateMoveRes(status, msg)
	if status == 0 then
		SeasonController.instance:handlePM_SMPVENotifyTeammateMoveRes(status, msg)
	end
end

function SeasonModePvePlusAgent:sendPM_SMGVEGainTeammateSharePrizeReq()
	local req = SeasonModePvePlusExtension_pb.PM_SMGVEGainTeammateSharePrizeReq()

	self:sendMsg(req)
end

function SeasonModePvePlusAgent:handlePM_SMGVEGainTeammateSharePrizeRes(status, msg)
	if status == 0 then
		SeasonController.instance:handlePM_SMGVEGainTeammateSharePrizeRes(msg)
	end
end

SeasonModePvePlusAgent.instance = SeasonModePvePlusAgent.New()

return SeasonModePvePlusAgent
