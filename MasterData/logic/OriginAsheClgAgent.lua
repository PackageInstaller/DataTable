-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originasheclg/agent/OriginAsheClgAgent.lua

module("logic.extensions.originasheclg.agent.OriginAsheClgAgent", package.seeall)

local OriginAsheClgAgent = class("OriginAsheClgAgent", BaseAgent)

function OriginAsheClgAgent:sendPM_OriginAsheClgGetInfoReq(activityId)
	local req = OriginAsheClgExtension_pb.PM_OriginAsheClgGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function OriginAsheClgAgent:handlePM_OriginAsheClgGetInfoRes(status, msg)
	if status == 0 then
		OriginAsheClgController.instance:handlePM_OriginAsheClgGetInfoRes(msg)
	end
end

function OriginAsheClgAgent:sendPM_OriginAsheClgChallengeReq(activityId, stageId, battleSeq, form)
	local req = OriginAsheClgExtension_pb.PM_OriginAsheClgChallengeReq()

	req.activityId = activityId
	req.stageId = stageId
	req.battleSeq = battleSeq

	if form ~= nil then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function OriginAsheClgAgent:handlePM_OriginAsheClgChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function OriginAsheClgAgent:sendPM_OriginAsheClgResetStageReq(activityId, stageId)
	local req = OriginAsheClgExtension_pb.PM_OriginAsheClgResetStageReq()

	req.activityId = activityId
	req.stageId = stageId

	self:sendMsg(req)
end

function OriginAsheClgAgent:handlePM_OriginAsheClgResetStageRes(status, msg)
	if status == 0 then
		OriginAsheClgController.instance:handlePM_OriginAsheClgResetStageRes(msg)
	end
end

function OriginAsheClgAgent:handlePM_Notify_OriginAsheClgChallengeResultRes(status, msg)
	if status == 0 then
		OriginAsheClgController.instance:handlePM_Notify_OriginAsheClgChallengeResultRes(msg)
	end
end

OriginAsheClgAgent.instance = OriginAsheClgAgent.New()

return OriginAsheClgAgent
