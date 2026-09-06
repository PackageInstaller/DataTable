-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originaruishiclg/agent/OriginAruishiClgAgent.lua

module("logic.extensions.originaruishiclg.agent.OriginAruishiClgAgent", package.seeall)

local OriginAruishiClgAgent = class("OriginAruishiClgAgent", BaseAgent)

function OriginAruishiClgAgent:sendPM_OriginAruishiClgGetInfoReq(activityId)
	local req = OriginAruishiClgExtension_pb.PM_OriginAruishiClgGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function OriginAruishiClgAgent:handlePM_OriginAruishiClgGetInfoRes(status, msg)
	if status == 0 then
		OriginaruishiclgModel.instance:setInfo(msg)
		GlobalDispatcher:dispatch(GlobalNotify.OriginAruishiClgGetInfoRes)
	end
end

function OriginAruishiClgAgent:sendPM_OriginAruishiClgChallengeReq(activityId, stageId, form)
	local req = OriginAruishiClgExtension_pb.PM_OriginAruishiClgChallengeReq()

	req.activityId = activityId
	req.stageId = stageId

	req.form:ParseFromString(form:SerializeToString())
	self:sendMsg(req)
end

function OriginAruishiClgAgent:handlePM_OriginAruishiClgChallengeRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.OriginAruishiClgChallengeRes)
	end
end

function OriginAruishiClgAgent:handlePM_Notify_OriginAruishiClgChallengeResultRes(status, msg)
	if status == 0 then
		OriginaruishiclgController.instance:onChallengeResultRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.Notify_OriginAruishiClgChallengeResultRes)
	end
end

OriginAruishiClgAgent.instance = OriginAruishiClgAgent.New()

return OriginAruishiClgAgent
