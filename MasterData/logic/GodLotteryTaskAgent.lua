-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lottery/agent/GodLotteryTaskAgent.lua

module("logic.extensions.lottery.agent.GodLotteryTaskAgent", package.seeall)

local GodLotteryTaskAgent = class("GodLotteryTaskAgent", BaseAgent)

function GodLotteryTaskAgent:sendPM_GodLotteryGetTasksReq(activityId)
	local req = GodLotteryTaskExtension_pb.PM_GodLotteryGetTasksReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function GodLotteryTaskAgent:handlePM_GodLotteryGetTasksRes(status, msg)
	if status == 0 then
		DragonController.instance:scGodLotteryGetTasks(msg)
	end
end

function GodLotteryTaskAgent:sendPM_GodLotteryGainPrizeReq(activityId, type, id)
	local req = GodLotteryTaskExtension_pb.PM_GodLotteryGainPrizeReq()

	req.activityId = activityId
	req.type = type
	req.id = id

	self:sendMsg(req)
end

function GodLotteryTaskAgent:handlePM_GodLotteryGainPrizeRes(status, msg)
	if status == 0 then
		DragonController.instance:scGodLotteryGainPrize(msg)
	end
end

GodLotteryTaskAgent.instance = GodLotteryTaskAgent.New()

return GodLotteryTaskAgent
