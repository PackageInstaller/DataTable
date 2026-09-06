-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rolerelationship/agent/RoleRelationshipAgent.lua

module("logic.extensions.rolerelationship.agent.RoleRelationshipAgent", package.seeall)

local RoleRelationshipAgent = class("RoleRelationshipAgent", BaseAgent)

function RoleRelationshipAgent:ctor()
	return
end

function RoleRelationshipAgent:sendPM_RRMGetMapInfoReq(activityId)
	local req = RoleRelationMapExtension_pb.PM_RRMGetMapInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function RoleRelationshipAgent:handlePM_RRMGetMapInfoRes(status, msg)
	if status == 0 then
		RoleRelationshipController.instance:onHandleRRMGetMapInfoRes(msg)
	end
end

function RoleRelationshipAgent:sendPM_RRMGetTaskInfoReq(activityId)
	local req = RoleRelationMapExtension_pb.PM_RRMGetTaskInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function RoleRelationshipAgent:handlePM_RRMGetTaskInfoRes(status, msg)
	if status == 0 then
		RoleRelationshipController.instance:onHandleRRMGetTaskInfoRes(msg)
	end
end

function RoleRelationshipAgent:sendPM_RRMUnlockLineReq(activityId, lineId)
	local req = RoleRelationMapExtension_pb.PM_RRMUnlockLineReq()

	req.activityId = activityId
	req.lineId = lineId

	self:sendMsg(req)
end

function RoleRelationshipAgent:handlePM_RRMUnlockLineRes(status, msg)
	if status == 0 then
		RoleRelationshipController.instance:onHandleRRMUnlockLineRes(msg)
	end
end

function RoleRelationshipAgent:sendPM_RRMGainProgressPrizeReq(activityId, prizeId)
	local req = RoleRelationMapExtension_pb.PM_RRMGainProgressPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function RoleRelationshipAgent:handlePM_RRMGainProgressPrizeRes(status, msg)
	if status == 0 then
		RoleRelationshipController.instance:onHandleRRMGainProgressPrizeRes(msg)
	end
end

function RoleRelationshipAgent:sendPM_RRMGainImpressPrizeReq(activityId, roleId, archiveId, impressId)
	local req = RoleRelationMapExtension_pb.PM_RRMGainImpressPrizeReq()

	req.activityId = activityId
	req.roleId = roleId
	req.archiveId = archiveId
	req.impressId = impressId

	self:sendMsg(req)
end

function RoleRelationshipAgent:handlePM_RRMGainImpressPrizeRes(status, msg)
	if status == 0 then
		RoleRelationshipController.instance:onHandleRRMGainImpressPrizeRes(msg)
	end
end

RoleRelationshipAgent.instance = RoleRelationshipAgent.New()

return RoleRelationshipAgent
