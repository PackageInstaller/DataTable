-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sourcetrace/agent/SourceTraceAgent.lua

module("logic.extensions.sourcetrace.agent.SourceTraceAgent", package.seeall)

local SourceTraceAgent = class("SourceTraceAgent", BaseAgent)

function SourceTraceAgent:sendPM_SourceTraceUnlockNodeReq(petId, targetNodeId)
	local req = SourceTraceExtension_pb.PM_SourceTraceUnlockNodeReq()

	req.petId = petId
	req.targetNodeId = targetNodeId

	self:sendMsg(req)
end

function SourceTraceAgent:handlePM_SourceTraceUnlockNodeRes(status, msg)
	if status == 0 then
		SourceTraceController.instance:handlePM_SourceTraceUnlockNodeRes(msg)
	end
end

function SourceTraceAgent:sendPM_SourceTraceChangeEffectReq(petId, targetNodeId, selectEffectId)
	local req = SourceTraceExtension_pb.PM_SourceTraceChangeEffectReq()

	req.petId = petId
	req.targetNodeId = targetNodeId
	req.selectEffectId = selectEffectId

	self:sendMsg(req)
end

function SourceTraceAgent:handlePM_SourceTraceChangeEffectRes(status, msg)
	if status == 0 then
		SourceTraceController.instance:handlePM_SourceTraceChangeEffectRes(msg)
	end
end

function SourceTraceAgent:sendPM_SourceTraceOneKeyUnlockNodeReq(petId)
	local req = SourceTraceExtension_pb.PM_SourceTraceOneKeyUnlockNodeReq()

	req.petId = petId

	self:sendMsg(req)
end

function SourceTraceAgent:handlePM_SourceTraceOneKeyUnlockNodeRes(status, msg)
	if status == 0 then
		SourceTraceController.instance:PM_SourceTraceOneKeyUnlockNodeRes(msg)
	end
end

SourceTraceAgent.instance = SourceTraceAgent.New()

return SourceTraceAgent
