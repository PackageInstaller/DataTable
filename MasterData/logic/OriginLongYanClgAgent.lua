-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originlongyanclg/agent/OriginLongYanClgAgent.lua

module("logic.extensions.originlongyanclg.agent.OriginLongYanClgAgent", package.seeall)

local OriginLongYanClgAgent = class("OriginLongYanClgAgent", BaseAgent)

function OriginLongYanClgAgent:sendPM_OriginLongYanClgGetInfoReq(activityId)
	local req = OriginLongYanClgExtension_pb.PM_OriginLongYanClgGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function OriginLongYanClgAgent:handlePM_OriginLongYanClgGetInfoRes(status, msg)
	if status == 0 then
		OriginLongYanClgController.instance:handlePM_OriginLongYanClgGetInfoRes(msg)
	end
end

function OriginLongYanClgAgent:sendPM_OriginLongYanClgChallengeReq(activityId, stageId, form_pb)
	local req = OriginLongYanClgExtension_pb.PM_OriginLongYanClgChallengeReq()

	req.activityId = activityId
	req.stageId = stageId

	if form_pb ~= nil then
		req.form:ParseFromString(form_pb:SerializeToString())
	end

	self:sendMsg(req)
end

function OriginLongYanClgAgent:handlePM_OriginLongYanClgChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function OriginLongYanClgAgent:handlePM_Notify_OriginLongYanClgChallengeEndRes(status, msg)
	if status == 0 then
		OriginLongYanClgController.instance:handleNotifyChallenge(msg)
	end
end

OriginLongYanClgAgent.instance = OriginLongYanClgAgent.New()

return OriginLongYanClgAgent
