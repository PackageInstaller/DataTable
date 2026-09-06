-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/gathertask/agent/ChristmasGatherAgent.lua

module("logic.extensions.christmasgather.agent.ChristmasGatherAgent", package.seeall)

local ChristmasGatherAgent = class("ChristmasGatherAgent", BaseAgent)

function ChristmasGatherAgent:ctor()
	return
end

function ChristmasGatherAgent:setExtId(extId)
	ChristmasGatherAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function ChristmasGatherAgent:sendPM_ChristmasGatherGetInfoReq(activityId)
	local req = ChristmasGatherExtension_pb.PM_ChristmasGatherGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function ChristmasGatherAgent:handlePM_ChristmasGatherGetInfoRes(status, msg)
	if status == 0 then
		GatherTaskController.instance:onGetInfo(msg)
	end
end

function ChristmasGatherAgent:sendPM_ChristmasGatherGainMaterialReq(activityId, materialId)
	local req = ChristmasGatherExtension_pb.PM_ChristmasGatherGainMaterialReq()

	req.activityId = activityId
	req.materialId = materialId

	self:sendMsg(req)
end

function ChristmasGatherAgent:handlePM_ChristmasGatherGainMaterialRes(status, msg)
	if status == 0 then
		GatherTaskController.instance:onGetMaterial(msg)
	end
end

function ChristmasGatherAgent:sendPM_ChristmasGatherGainProgressPrizeReq(activityId, index)
	local req = ChristmasGatherExtension_pb.PM_ChristmasGatherGainProgressPrizeReq()

	req.activityId = activityId
	req.index = index

	self:sendMsg(req)
end

function ChristmasGatherAgent:handlePM_ChristmasGatherGainProgressPrizeRes(status, msg)
	if status == 0 then
		GatherTaskController.instance:onGetPrize(msg)
	end
end

ChristmasGatherAgent.instance = ChristmasGatherAgent.New()

return ChristmasGatherAgent
