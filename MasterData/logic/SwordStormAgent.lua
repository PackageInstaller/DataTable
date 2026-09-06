-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/swordstorm/agent/SwordStormAgent.lua

module("logic.extensions.swordstorm.agent.SwordStormAgent", package.seeall)

local SwordStormAgent = class("SwordStormAgent", BaseAgent)

function SwordStormAgent:sendPM_SwordStormGetInfoReq(activityId)
	local req = SwordStormExtension_pb.PM_SwordStormGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function SwordStormAgent:handlePM_SwordStormGetInfoRes(status, msg)
	if status == 0 then
		SwordStormController.instance:handlePM_SwordStormGetInfoRes(msg)
	end
end

function SwordStormAgent:sendPM_SwordStormChallengeReq(activityId, phaseId, stageId, form)
	local req = SwordStormExtension_pb.PM_SwordStormChallengeReq()

	req.activityId = activityId
	req.phaseId = phaseId
	req.stageId = stageId

	if form ~= nil then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function SwordStormAgent:handlePM_SwordStormChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function SwordStormAgent:handlePM_Notify_SwordStormChallengeResultRes(status, msg)
	if status == 0 then
		SwordStormController.instance:handlePM_Notify_SwordStormChallengeResultRes(msg)
	end
end

SwordStormAgent.instance = SwordStormAgent.New()

return SwordStormAgent
