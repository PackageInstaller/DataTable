-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/starscratch/agent/StarScratchAgent.lua

module("logic.extensions.starscratch.agent.StarScratchAgent", package.seeall)

local StarScratchAgent = class("StarScratchAgent", BaseAgent)

function StarScratchAgent:sendPM_StarScratchInfoReq(activityId)
	local req = StarScratchExtension_pb.PM_StarScratchInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function StarScratchAgent:handlePM_StarScratchInfoRes(status, msg)
	if status == 0 then
		StarScratchController.instance:handlePM_StarScratchInfoRes(msg)
	end
end

function StarScratchAgent:sendPM_StarScratchBuyReq(activityId, cycleId)
	local req = StarScratchExtension_pb.PM_StarScratchBuyReq()

	req.activityId = activityId
	req.cycleId = cycleId

	self:sendMsg(req)
end

function StarScratchAgent:handlePM_StarScratchBuyRes(status, msg)
	if status == 0 then
		StarScratchController.instance:handlePM_StarScratchBuyRes(msg)
	end
end

function StarScratchAgent:sendPM_StarScratchGainReq(activityId, cycleId, id)
	local req = StarScratchExtension_pb.PM_StarScratchGainReq()

	req.activityId = activityId
	req.cycleId = cycleId
	req.id = id

	self:sendMsg(req)
end

function StarScratchAgent:handlePM_StarScratchGainRes(status, msg)
	if status == 0 then
		StarScratchController.instance:handlePM_StarScratchGainRes(msg)
	end
end

function StarScratchAgent:sendPM_StarScratchRefreshBroadcastReq(activityId)
	local req = StarScratchExtension_pb.PM_StarScratchRefreshBroadcastReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function StarScratchAgent:handlePM_StarScratchRefreshBroadcastRes(status, msg)
	if status == 0 then
		StarScratchController.instance:handlePM_StarScratchRefreshBroadcastRes(msg)
	end
end

StarScratchAgent.instance = StarScratchAgent.New()

return StarScratchAgent
