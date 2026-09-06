-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/family/agent/FamilyRedPacketAgent.lua

module("logic.extensions.family.agent.FamilyRedPacketAgent", package.seeall)

local FamilyRedPacketAgent = class("FamilyRedPacketAgent", BaseAgent)

function FamilyRedPacketAgent:sendPM_FamilyRedPacketGetTaskInfoReq()
	local req = FamilyRedPacketExtension_pb.PM_FamilyRedPacketGetTaskInfoReq()

	self:sendMsg(req)
end

function FamilyRedPacketAgent:handlePM_FamilyRedPacketGetTaskInfoRes(status, msg)
	if status == 0 then
		FamilyController.instance:csSendFamilyRedPacketGetTaskInfo(msg)
	end
end

function FamilyRedPacketAgent:sendPM_FamilyRedPacketSendRedPacketReq(taskId)
	local req = FamilyRedPacketExtension_pb.PM_FamilyRedPacketSendRedPacketReq()

	req.taskId = taskId

	self:sendMsg(req)
end

function FamilyRedPacketAgent:handlePM_FamilyRedPacketSendRedPacketRes(status, msg)
	if status == 0 then
		FamilyController.instance:csSendFamilyRedPacketSendRedPacket(msg)
	end
end

function FamilyRedPacketAgent:sendPM_FamilyRedPacketGetListReq()
	local req = FamilyRedPacketExtension_pb.PM_FamilyRedPacketGetListReq()

	self:sendMsg(req)
end

function FamilyRedPacketAgent:handlePM_FamilyRedPacketGetListRes(status, msg)
	if status == 0 then
		FamilyController.instance:csSendFamilyRedPacketGetList(msg)
	end
end

function FamilyRedPacketAgent:sendPM_FamilyRedPacketGainReq(packetId, packetType)
	local req = FamilyRedPacketExtension_pb.PM_FamilyRedPacketGainReq()

	req.packetId = packetId
	req.packetType = packetType

	self:sendMsg(req)
end

function FamilyRedPacketAgent:handlePM_FamilyRedPacketGainRes(status, msg)
	if status == 0 then
		FamilyController.instance:csSendFamilyRedPacketGain(msg)
	end
end

function FamilyRedPacketAgent:sendPM_FamilyRedPacketGetGainRecordReq()
	local req = FamilyRedPacketExtension_pb.PM_FamilyRedPacketGetGainRecordReq()

	self:sendMsg(req)
end

function FamilyRedPacketAgent:handlePM_FamilyRedPacketGetGainRecordRes(status, msg)
	if status == 0 then
		FamilyController.instance:csSendFamilyRedPacketGetGainRecord(msg)
	end
end

FamilyRedPacketAgent.instance = FamilyRedPacketAgent.New()

return FamilyRedPacketAgent
