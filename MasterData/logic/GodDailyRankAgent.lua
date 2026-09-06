-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddailyrank/agent/GodDailyRankAgent.lua

module("logic.extensions.goddailyrank.agent.GodDailyRankAgent", package.seeall)

local GodDailyRankAgent = class("GodDailyRankAgent", BaseAgent)

function GodDailyRankAgent:sendPM_GodDailyRankGodRankViewReq(activityId)
	local req = GodDailyRankExtension_pb.PM_GodDailyRankGodRankViewReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function GodDailyRankAgent:handlePM_GodDailyRankGodRankViewRes(status, msg)
	if status == 0 then
		GodDailyRankController.instance:onGetGodRankInfo(msg)
	end
end

function GodDailyRankAgent:sendPM_GodDailyRankDailyRankViewReq(activityId)
	local req = GodDailyRankExtension_pb.PM_GodDailyRankDailyRankViewReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function GodDailyRankAgent:handlePM_GodDailyRankDailyRankViewRes(status, msg)
	if status == 0 then
		GodDailyRankController.instance:onGetDailyRankInfo(msg)
	end
end

GodDailyRankAgent.instance = GodDailyRankAgent.New()

return GodDailyRankAgent
