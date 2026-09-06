-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearscratch/agent/YearScratchAgent.lua

module("logic.extensions.yearscratch.agent.YearScratchAgent", package.seeall)

local YearScratchAgent = class("YearScratchAgent", BaseAgent)

function YearScratchAgent:sendPM_YearScratchInfoReq(activityId)
	local req = YearScratchExtension_pb.PM_YearScratchInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function YearScratchAgent:handlePM_YearScratchInfoRes(status, msg)
	if status == 0 then
		YearScratchController.instance:handlePM_YearScratchInfoRes(msg)
	end
end

function YearScratchAgent:sendPM_YearScratchGainPrizeReq(activityId, cycleId)
	local req = YearScratchExtension_pb.PM_YearScratchGainPrizeReq()

	req.activityId = activityId
	req.cycleId = cycleId

	self:sendMsg(req)
end

function YearScratchAgent:handlePM_YearScratchGainPrizeRes(status, msg)
	if status == 0 then
		YearScratchController.instance:handlePM_YearScratchGainPrizeRes(msg)
	end
end

function YearScratchAgent:sendPM_YearScratchGainGodGemReq(activityId)
	local req = YearScratchExtension_pb.PM_YearScratchGainGodGemReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function YearScratchAgent:handlePM_YearScratchGainGodGemRes(status, msg)
	if status == 0 then
		YearScratchController.instance:handlePM_YearScratchGainGodGemRes(msg)
	end
end

YearScratchAgent.instance = YearScratchAgent.New()

return YearScratchAgent
