-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tarolottery/agent/TarotLotteryAgent.lua

module("logic.extensions.tarotlottery.agent.TarotLotteryAgent", package.seeall)

local TarotLotteryAgent = class("TarotLotteryAgent", BaseAgent)

function TarotLotteryAgent:ctor()
	return
end

function TarotLotteryAgent:setExtId(extId)
	TarotLotteryAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function TarotLotteryAgent:sendPM_TarotLotteryInfoReq(activityId)
	local req = TarotLotteryExtension_pb.PM_TarotLotteryInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function TarotLotteryAgent:handlePM_TarotLotteryInfoRes(status, msg)
	if status == 0 then
		TaroLotteryController.instance:onGetInfo(msg)
	end
end

function TarotLotteryAgent:sendPM_TarotLotteryDrawReq(activityId, times)
	local req = TarotLotteryExtension_pb.PM_TarotLotteryDrawReq()

	req.activityId = activityId
	req.times = times

	self:sendMsg(req)
end

function TarotLotteryAgent:handlePM_TarotLotteryDrawRes(status, msg)
	if status == 0 then
		TaroLotteryController.instance:onGetDraw(msg)
	end
end

function TarotLotteryAgent:sendPM_TarotLotteryGainProgressReq(activityId, prizeId)
	local req = TarotLotteryExtension_pb.PM_TarotLotteryGainProgressReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function TarotLotteryAgent:handlePM_TarotLotteryGainProgressRes(status, msg)
	if status == 0 then
		TaroLotteryController.instance:onGetPrize(msg)
	end
end

TarotLotteryAgent.instance = TarotLotteryAgent.New()

return TarotLotteryAgent
