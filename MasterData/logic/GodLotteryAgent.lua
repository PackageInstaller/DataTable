-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lottery/agent/GodLotteryAgent.lua

module("logic.extensions.lottery.agent.GodLotteryAgent", package.seeall)

local GodLotteryAgent = class("GodLotteryAgent", BaseAgent)

function GodLotteryAgent:sendPM_GodLotteryGetInfoReq(activityId, poolId)
	local req = GodLotteryExtension_pb.PM_GodLotteryGetInfoReq()

	req.activityId = activityId
	req.poolId = poolId

	self:sendMsg(req)
end

function GodLotteryAgent:handlePM_GodLotteryGetInfoRes(status, msg)
	if status == 0 then
		DragonController.instance:scGodLotteryGetInfo(msg)
	end
end

function GodLotteryAgent:sendPM_GodLotteryDoneReq(activityId, poolId, time)
	local req = GodLotteryExtension_pb.PM_GodLotteryDoneReq()

	req.activityId = activityId
	req.poolId = poolId
	req.time = time

	self:sendMsg(req)
end

function GodLotteryAgent:handlePM_GodLotteryDoneRes(status, msg)
	if status == 0 then
		DragonController.instance:scGodLotteryDone(msg)
	end
end

function GodLotteryAgent:sendPM_GodLotteryBuyReq(activityId, poolId, num)
	local req = GodLotteryExtension_pb.PM_GodLotteryBuyReq()

	req.activityId = activityId
	req.poolId = poolId
	req.num = num

	self:sendMsg(req)
end

function GodLotteryAgent:handlePM_GodLotteryBuyRes(status, msg)
	if status == 0 then
		DragonController.instance:scGodLotteryBuy(msg)
	end
end

GodLotteryAgent.instance = GodLotteryAgent.New()

return GodLotteryAgent
