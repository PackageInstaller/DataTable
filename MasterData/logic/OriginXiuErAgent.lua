-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originxiuer/agent/OriginXiuErAgent.lua

module("logic.extensions.originxiuer.agent.OriginXiuErAgent", package.seeall)

local OriginXiuErAgent = class("OriginXiuErAgent", BaseAgent)

function OriginXiuErAgent:sendPM_OriginXiuErInfoReq(activityId)
	local req = OriginXiuErExtension_pb.PM_OriginXiuErInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function OriginXiuErAgent:handlePM_OriginXiuErInfoRes(status, msg)
	if status == 0 then
		OriginXiuErController.instance:handlePM_OriginXiuErInfoRes(msg)
	end
end

function OriginXiuErAgent:sendPM_OriginXiuErResetReq(activityId)
	local req = OriginXiuErExtension_pb.PM_OriginXiuErResetReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function OriginXiuErAgent:handlePM_OriginXiuErResetRes(status, msg)
	if status == 0 then
		OriginXiuErController.instance:handlePM_OriginXiuErResetRes(msg)
	end
end

function OriginXiuErAgent:sendPM_OriginXiuErChallengeReq(activityId, form, stageId)
	local req = OriginXiuErExtension_pb.PM_OriginXiuErChallengeReq()

	req.activityId = activityId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	req.stageId = stageId

	self:sendMsg(req)
end

function OriginXiuErAgent:handlePM_OriginXiuErChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function OriginXiuErAgent:handlePM_OriginXiuErNotifyChallengeRes(status, msg)
	if status == 0 then
		OriginXiuErController.instance:handlePM_OriginXiuErNotifyChallengeRes(msg)
	end
end

OriginXiuErAgent.instance = OriginXiuErAgent.New()

return OriginXiuErAgent
