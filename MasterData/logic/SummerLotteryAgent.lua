-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summerlottery/agent/SummerLotteryAgent.lua

module("logic.extensions.summerlottery.agent.SummerLotteryAgent", package.seeall)

local SummerLotteryAgent = class("SummerLotteryAgent", BaseAgent)

function SummerLotteryAgent:sendPM_SummerLotteryGetInfoReq(activityId)
	local req = SummerLotteryExtension_pb.PM_SummerLotteryGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function SummerLotteryAgent:handlePM_SummerLotteryGetInfoRes(status, msg)
	SummerLotteryController.instance:handleGetInfo(status, msg)
end

function SummerLotteryAgent:sendPM_SummerLotteryDrawReq(activityId, times)
	local req = SummerLotteryExtension_pb.PM_SummerLotteryDrawReq()

	req.activityId = activityId
	req.times = times

	self:sendMsg(req)
end

function SummerLotteryAgent:handlePM_SummerLotteryDrawRes(status, msg)
	SummerLotteryController.instance:handleDraw(status, msg)
end

function SummerLotteryAgent:sendPM_SummerLotteryGetTaskInfoReq(activityId)
	local req = SummerLotteryExtension_pb.PM_SummerLotteryGetTaskInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function SummerLotteryAgent:handlePM_SummerLotteryGetTaskInfoRes(status, msg)
	SummerLotteryController.instance:handleGainTaskInfo(status, msg)
end

function SummerLotteryAgent:sendPM_SummerLotteryGainTaskPrizeReq(activityId, taskIds)
	local req = SummerLotteryExtension_pb.PM_SummerLotteryGainTaskPrizeReq()

	req.activityId = activityId

	for _, taskId in ipairs(taskIds or {}) do
		req.taskId:append(taskId)
	end

	self:sendMsg(req)
end

function SummerLotteryAgent:handlePM_SummerLotteryGainTaskPrizeRes(status, msg)
	SummerLotteryController.instance:handleGainTaskPrize(status, msg)
end

function SummerLotteryAgent:sendPM_SummerLotteryGainProgressPrizeReq(activityId)
	local req = SummerLotteryExtension_pb.PM_SummerLotteryGainProgressPrizeReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function SummerLotteryAgent:handlePM_SummerLotteryGainProgressPrizeRes(status, msg)
	SummerLotteryController.instance:handleGainTaskProgressPrize(status, msg)
end

function SummerLotteryAgent:sendPM_SummerLotteryViewReq(activityId, viewId)
	local req = SummerLotteryExtension_pb.PM_SummerLotteryViewReq()

	req.activityId = activityId
	req.viewId = viewId

	self:sendMsg(req)
end

function SummerLotteryAgent:handlePM_SummerLotteryViewRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

SummerLotteryAgent.instance = SummerLotteryAgent.New()

return SummerLotteryAgent
