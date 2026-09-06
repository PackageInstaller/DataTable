-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cardhot/agent/PoolPreHeatAgent.lua

module("logic.extensions.poolpreheat.agent.PoolPreHeatAgent", package.seeall)

local PoolPreHeatAgent = class("PoolPreHeatAgent", BaseAgent)

PoolPreHeatAgent.GetActivityInfoRes = "PoolPreHeatAgent_GetActivityInfoRes"
PoolPreHeatAgent.GainDailyPrizeRes = "PoolPreHeatAgent_GainDailyPrizeRes"
PoolPreHeatAgent.GainMassPrizeRes = "PoolPreHeatAgent_GainMassPrizeRes"

function PoolPreHeatAgent:ctor()
	return
end

function PoolPreHeatAgent:setExtId(extId)
	PoolPreHeatAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function PoolPreHeatAgent:sendGetActivityInfoReq(activityId, handler, handlerObj, errHandler)
	local req = PoolPreHeatExtension_pb.GetActivityInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
	self:addEventOnce(PoolPreHeatAgent.GetActivityInfoRes, handler, handlerObj, errHandler)
end

function PoolPreHeatAgent:handleGetActivityInfoRes(status, msg)
	self:dispatch(PoolPreHeatAgent.GetActivityInfoRes, status, msg)
end

function PoolPreHeatAgent:sendGainDailyPrizeReq(activityId, handler, handlerObj, errHandler)
	local req = PoolPreHeatExtension_pb.GainDailyPrizeReq()

	req.activityId = activityId

	self:sendMsg(req)
	self:addEventOnce(PoolPreHeatAgent.GainDailyPrizeRes, handler, handlerObj, errHandler)
end

function PoolPreHeatAgent:handleGainDailyPrizeRes(status, msg)
	self:dispatch(PoolPreHeatAgent.GainDailyPrizeRes, status, msg)
end

function PoolPreHeatAgent:sendGainMassPrizeReq(activityId, handler, handlerObj, errHandler)
	local req = PoolPreHeatExtension_pb.GainMassPrizeReq()

	req.activityId = activityId

	self:sendMsg(req)
	self:addEventOnce(PoolPreHeatAgent.GainMassPrizeRes, handler, handlerObj, errHandler)
end

function PoolPreHeatAgent:handleGainMassPrizeRes(status, msg)
	self:dispatch(PoolPreHeatAgent.GainMassPrizeRes, status, msg)
end

PoolPreHeatAgent.instance = PoolPreHeatAgent.New()

return PoolPreHeatAgent
