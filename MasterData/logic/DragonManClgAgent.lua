-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonmanclg/agent/DragonManClgAgent.lua

module("logic.extensions.dragonmanclg.agent.DragonManClgAgent", package.seeall)

local DragonManClgAgent = class("DragonManClgAgent", BaseAgent)

function DragonManClgAgent:sendPM_DragonManClgInfoReq(activityId)
	local req = DragonManClgExtension_pb.PM_DragonManClgInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DragonManClgAgent:handlePM_DragonManClgInfoRes(status, msg)
	if status == 0 then
		DragonManClgController.instance:handleGetInfo(msg)
	end
end

function DragonManClgAgent:sendPM_DragonManClgChallengeReq(activityId, stageId, form_pb)
	local req = DragonManClgExtension_pb.PM_DragonManClgChallengeReq()

	req.activityId = activityId
	req.stageId = stageId

	if form_pb ~= nil then
		req.form:ParseFromString(form_pb:SerializeToString())
	end

	self:sendMsg(req)
end

function DragonManClgAgent:handlePM_DragonManClgChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function DragonManClgAgent:handlePM_Notify_DragonManClgChallengeRes(status, msg)
	if status == 0 then
		DragonManClgController.instance:handleNotifyChallenge(msg)
	end
end

DragonManClgAgent.instance = DragonManClgAgent.New()

return DragonManClgAgent
