-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/repairchannel/agent/RepairChannelAgent.lua

module("logic.extensions.repairchannel.agent.RepairChannelAgent", package.seeall)

local RepairChannelAgent = class("RepairChannelAgent", BaseAgent)

function RepairChannelAgent:sendPM_RepairChannelGetInfoReq(activityId)
	local req = RepairChannelExtension_pb.PM_RepairChannelGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function RepairChannelAgent:handlePM_RepairChannelGetInfoRes(status, msg)
	if status == 0 then
		RepairChannelController.instance:handlePM_RepairChannelGetInfoRes(msg)
	end
end

function RepairChannelAgent:sendPM_RepairChannelRepairNodeReq(activityId, branchId, nodeId, petIds_i32_Ary)
	local req = RepairChannelExtension_pb.PM_RepairChannelRepairNodeReq()

	req.activityId = activityId
	req.branchId = branchId
	req.nodeId = nodeId

	for i, v1 in ipairs(petIds_i32_Ary) do
		req.petIds:append(v1)
	end

	self:sendMsg(req)
end

function RepairChannelAgent:handlePM_RepairChannelRepairNodeRes(status, msg)
	if status == 0 then
		RepairChannelController.instance:handlePM_RepairChannelRepairNodeRes(msg)
	end
end

RepairChannelAgent.instance = RepairChannelAgent.New()

return RepairChannelAgent
