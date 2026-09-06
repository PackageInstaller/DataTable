-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yunjiedragonclg/agent/YunJieDragonClgAgent.lua

module("logic.extensions.yunjiedragonclg.agent.YunJieDragonClgAgent", package.seeall)

local YunJieDragonClgAgent = class("YunJieDragonClgAgent", BaseAgent)

function YunJieDragonClgAgent:sendPM_YunJieDragonClgGetInfoReq(activityId)
	local req = YunJieDragonClgExtension_pb.PM_YunJieDragonClgGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function YunJieDragonClgAgent:handlePM_YunJieDragonClgGetInfoRes(status, msg)
	if status == 0 then
		YunJieDragonClgController.instance:handlePM_YunJieDragonClgGetInfoRes(msg)
	end
end

function YunJieDragonClgAgent:sendPM_YunJieDragonClgChallengeReq(activityId, stageId, form)
	local req = YunJieDragonClgExtension_pb.PM_YunJieDragonClgChallengeReq()

	req.activityId = activityId
	req.stageId = stageId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function YunJieDragonClgAgent:handlePM_YunJieDragonClgChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function YunJieDragonClgAgent:sendPM_YunJieDragonClgOneKeyPassReq(activityId, leftStageCount)
	local req = YunJieDragonClgExtension_pb.PM_YunJieDragonClgOneKeyPassReq()

	req.activityId = activityId
	req.leftStageCount = leftStageCount

	self:sendMsg(req)
end

function YunJieDragonClgAgent:handlePM_YunJieDragonClgOneKeyPassRes(status, msg)
	if status == 0 then
		YunJieDragonClgController.instance:handlePM_YunJieDragonClgOneKeyPassRes(msg)
	end
end

function YunJieDragonClgAgent:handlePM_Notify_YunJieDragonClgChallengeEndRes(status, msg)
	if status == 0 then
		YunJieDragonClgController.instance:handlePM_Notify_YunJieDragonClgChallengeEndRes(msg)
	end
end

YunJieDragonClgAgent.instance = YunJieDragonClgAgent.New()

return YunJieDragonClgAgent
