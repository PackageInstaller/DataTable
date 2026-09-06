-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/topuplottery/agent/TopUpLotteryAgent.lua

module("logic.extensions.topuplottery.agent.TopUpLotteryAgent", package.seeall)

local TopUpLotteryAgent = class("TopUpLotteryAgent", BaseAgent)

function TopUpLotteryAgent:sendPM_TopUpLotteryGetInfoReq(activityId)
	local req = TopUpLotteryExtension_pb.PM_TopUpLotteryGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function TopUpLotteryAgent:handlePM_TopUpLotteryGetInfoRes(status, msg)
	TopUpLotteryController.instance:handleGetInfoRes(status, msg)
end

function TopUpLotteryAgent:sendPM_TopUpLotterySetBigPrizeReq(activityId, prizeId)
	local req = TopUpLotteryExtension_pb.PM_TopUpLotterySetBigPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function TopUpLotteryAgent:handlePM_TopUpLotterySetBigPrizeRes(status, msg)
	TopUpLotteryController.instance:handleSetBigPrizeRes(status, msg)
end

function TopUpLotteryAgent:sendPM_TopUpLotteryRandReq(activityId)
	local req = TopUpLotteryExtension_pb.PM_TopUpLotteryRandReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function TopUpLotteryAgent:handlePM_TopUpLotteryRandRes(status, msg)
	TopUpLotteryController.instance:handleRandRes(status, msg)
end

TopUpLotteryAgent.instance = TopUpLotteryAgent.New()

return TopUpLotteryAgent
