-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/worldprogressprize/agent/WorldProgressPrizeAgent.lua

module("logic.extensions.worldprogressprize.agent.WorldProgressPrizeAgent", package.seeall)

local WorldProgressPrizeAgent = class("WorldProgressPrizeAgent", BaseAgent)

function WorldProgressPrizeAgent:sendPM_WorldProgressPrizeGetInfoReq(activityId)
	local req = WorldProgressPrizeExtension_pb.PM_WorldProgressPrizeGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function WorldProgressPrizeAgent:handlePM_WorldProgressPrizeGetInfoRes(status, msg)
	if status == 0 then
		WorldProgressPrizeController.instance:handlePM_WorldProgressPrizeGetInfoRes(msg)
	end
end

function WorldProgressPrizeAgent:sendPM_WorldProgressPrizeGainPrizeReq(activityId, progressId, prizeId)
	local req = WorldProgressPrizeExtension_pb.PM_WorldProgressPrizeGainPrizeReq()

	req.activityId = activityId
	req.progressId = progressId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function WorldProgressPrizeAgent:handlePM_WorldProgressPrizeGainPrizeRes(status, msg)
	if status == 0 then
		WorldProgressPrizeController.instance:handlePM_WorldProgressPrizeGainPrizeRes(msg)
	end
end

function WorldProgressPrizeAgent:sendPM_WorldProgressOneClickGainPrizeReq(activityId, progressId)
	local req = WorldProgressPrizeExtension_pb.PM_WorldProgressOneClickGainPrizeReq()

	req.activityId = activityId
	req.progressId = progressId

	self:sendMsg(req)
end

function WorldProgressPrizeAgent:handlePM_WorldProgressOneClickGainPrizeRes(status, msg)
	if status == 0 then
		WorldProgressPrizeController.instance:handlePM_WorldProgressOneClickGainPrizeRes(msg)
	end
end

WorldProgressPrizeAgent.instance = WorldProgressPrizeAgent.New()

return WorldProgressPrizeAgent
