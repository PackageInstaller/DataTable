-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originhotbloodmmclg/agent/OriginHotBloodMMClgAgent.lua

module("logic.extensions.originhotbloodmmclg.agent.OriginHotBloodMMClgAgent", package.seeall)

local OriginHotBloodMMClgAgent = class("OriginHotBloodMMClgAgent", BaseAgent)

function OriginHotBloodMMClgAgent:sendPM_OriginHotBloodedMMClgGetInfoReq(activityId)
	local req = OriginHotBloodedMMClgExtension_pb.PM_OriginHotBloodedMMClgGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function OriginHotBloodMMClgAgent:handlePM_OriginHotBloodedMMClgGetInfoRes(status, msg)
	if status == 0 then
		OriginHotBloodMMClgController.instance:handlePM_OriginHotBloodMMClgGetInfoRes(msg)
	end
end

function OriginHotBloodMMClgAgent:sendPM_OriginHotBloodedMMClgChallengeReq(activityId, stageId, form)
	local req = OriginHotBloodedMMClgExtension_pb.PM_OriginHotBloodedMMClgChallengeReq()

	req.activityId = activityId
	req.stageId = stageId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function OriginHotBloodMMClgAgent:handlePM_OriginHotBloodedMMClgChallengeRes(status, msg)
	if status == 0 then
		OriginHotBloodMMClgController.instance:handlePM_OriginHotBloodMMClgChallengeRes(msg)
	end
end

function OriginHotBloodMMClgAgent:handlePM_Notify_OriginHotBloodedMMClgChallengeResultRes(status, msg)
	if status == 0 then
		OriginHotBloodMMClgController.instance:handlePM_Notify_OriginHotBloodMMClgChallengeResultRes(msg)
	end
end

OriginHotBloodMMClgAgent.instance = OriginHotBloodMMClgAgent.New()

return OriginHotBloodMMClgAgent
