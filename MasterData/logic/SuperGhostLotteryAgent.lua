-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/superghostlottery/agent/SuperGhostLotteryAgent.lua

module("logic.extensions.superghostlottery.agent.SuperGhostLotteryAgent", package.seeall)

local SuperGhostLotteryAgent = class("SuperGhostLotteryAgent", BaseAgent)

SuperGhostLotteryAgent.handlePM_SuperGhostLotteryGetInfoRes = "SuperGhostLotteryAgent.handlePM_SuperGhostLotteryGetInfoRes"
SuperGhostLotteryAgent.handlePM_SuperGhostLotterySelectBigPrizeRes = "SuperGhostLotteryAgent.handlePM_SuperGhostLotterySelectBigPrizeRes"
SuperGhostLotteryAgent.handlePM_SuperGhostLotteryDrawRes = "SuperGhostLotteryAgent.handlePM_SuperGhostLotteryDrawRes"

function SuperGhostLotteryAgent:sendPM_SuperGhostLotteryGetInfoReq(activityId)
	local req = SuperGhostLotteryExtension_pb.PM_SuperGhostLotteryGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function SuperGhostLotteryAgent:handlePM_SuperGhostLotteryGetInfoRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(SuperGhostLotteryAgent.handlePM_SuperGhostLotteryGetInfoRes, msg)
	end
end

function SuperGhostLotteryAgent:sendPM_SuperGhostLotterySelectBigPrizeReq(activityId, prizeId)
	local req = SuperGhostLotteryExtension_pb.PM_SuperGhostLotterySelectBigPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function SuperGhostLotteryAgent:handlePM_SuperGhostLotterySelectBigPrizeRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(SuperGhostLotteryAgent.handlePM_SuperGhostLotterySelectBigPrizeRes, msg)
	end
end

function SuperGhostLotteryAgent:sendPM_SuperGhostLotteryDrawReq(activityId)
	local req = SuperGhostLotteryExtension_pb.PM_SuperGhostLotteryDrawReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function SuperGhostLotteryAgent:handlePM_SuperGhostLotteryDrawRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(SuperGhostLotteryAgent.handlePM_SuperGhostLotteryDrawRes, msg)
	end
end

SuperGhostLotteryAgent.instance = SuperGhostLotteryAgent.New()

return SuperGhostLotteryAgent
