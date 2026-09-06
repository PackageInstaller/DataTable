-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shizudragonclg/agent/ShiZuDragonClgAgent.lua

module("logic.extensions.shizudragonclg.agent.ShiZuDragonClgAgent", package.seeall)

local ShiZuDragonClgAgent = class("ShiZuDragonClgAgent", BaseAgent)

function ShiZuDragonClgAgent:sendPM_ShiZuDragonClgInfoReq(activityId)
	local req = ShiZuDragonClgExtension_pb.PM_ShiZuDragonClgInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function ShiZuDragonClgAgent:handlePM_ShiZuDragonClgInfoRes(status, msg)
	if status == 0 then
		ShiZuDragonClgController.instance:handlePM_ShiZuDragonClgInfoRes(msg)
	end
end

function ShiZuDragonClgAgent:sendPM_ShiZuDragonClgChallengeReq(activityId, phaseId, stageId, form)
	local req = ShiZuDragonClgExtension_pb.PM_ShiZuDragonClgChallengeReq()

	req.activityId = activityId
	req.phaseId = phaseId
	req.stageId = stageId

	if form ~= nil then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function ShiZuDragonClgAgent:handlePM_ShiZuDragonClgChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function ShiZuDragonClgAgent:sendPM_ShiZuDragonClgResetReq(activityId, phaseId, stageId)
	local req = ShiZuDragonClgExtension_pb.PM_ShiZuDragonClgResetReq()

	req.activityId = activityId
	req.phaseId = phaseId
	req.stageId = stageId

	self:sendMsg(req)
end

function ShiZuDragonClgAgent:handlePM_ShiZuDragonClgResetRes(status, msg)
	if status == 0 then
		ShiZuDragonClgController.instance:sendPM_ShiZuDragonClgResetReq(msg)
	end
end

function ShiZuDragonClgAgent:handlePM_NotifyShiZuDragonClgFinishRes(status, msg)
	if status == 0 then
		ShiZuDragonClgController.instance:handlePM_NotifyShiZuDragonClgFinishRes(msg)
	end
end

ShiZuDragonClgAgent.instance = ShiZuDragonClgAgent.New()

return ShiZuDragonClgAgent
