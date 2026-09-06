-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luyinjiade/agent/LuYinJiaDeAgent.lua

module("logic.extensions.luyinjiade.agent.LuYinJiaDeAgent", package.seeall)

local LuYinJiaDeAgent = class("LuYinJiaDeAgent", BaseAgent)

function LuYinJiaDeAgent:sendPM_LuYinJiaDeClgGetInfoReq(activityId)
	local req = LuYinJiaDeClgExtension_pb.PM_LuYinJiaDeClgGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function LuYinJiaDeAgent:handlePM_LuYinJiaDeClgGetInfoRes(status, msg)
	if status == 0 then
		LuYinJiaDeController.instance:handlePM_LuYinJiaDeClgGetInfoRes(msg)
	end
end

function LuYinJiaDeAgent:sendPM_LuYinJiaDeClgFightReq(activityId, stageId, form)
	local req = LuYinJiaDeClgExtension_pb.PM_LuYinJiaDeClgFightReq()

	req.activityId = activityId
	req.stageId = stageId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function LuYinJiaDeAgent:handlePM_LuYinJiaDeClgFightRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function LuYinJiaDeAgent:handlePM_LuYinJiaDeClgNotifyFightRes(status, msg)
	if status == 0 then
		LuYinJiaDeController.instance:handlePM_LuYinJiaDeClgNotifyFightRes(msg)
	end
end

function LuYinJiaDeAgent:sendPM_LuYinJiaDeClgGodRankViewReq(activityId)
	local req = LuYinJiaDeClgExtension_pb.PM_LuYinJiaDeClgGodRankViewReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function LuYinJiaDeAgent:handlePM_LuYinJiaDeClgGodRankViewRes(status, msg)
	if status == 0 then
		LuYinJiaDeController.instance:handlePM_LuYinJiaDeClgGodRankViewRes(msg)
	end
end

function LuYinJiaDeAgent:sendPM_LuYinJiaDeClgDailyRankViewReq(activityId)
	local req = LuYinJiaDeClgExtension_pb.PM_LuYinJiaDeClgDailyRankViewReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function LuYinJiaDeAgent:handlePM_LuYinJiaDeClgDailyRankViewRes(status, msg)
	if status == 0 then
		LuYinJiaDeController.instance:handlePM_LuYinJiaDeClgDailyRankViewRes(msg)
	end
end

LuYinJiaDeAgent.instance = LuYinJiaDeAgent.New()

return LuYinJiaDeAgent
