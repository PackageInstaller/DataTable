-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/consumediamondgift/agent/ConsumeDiamondGiftAgent.lua

module("logic.extensions.consumediamondgift.agent.ConsumeDiamondGiftAgent", package.seeall)

local ConsumeDiamondGiftAgent = class("ConsumeDiamondGiftAgent", BaseAgent)

ConsumeDiamondGiftAgent.PM_GetActivityInfoRes = "ConsumeDiamondGiftAgent_PM_GetActivityInfoRes"
ConsumeDiamondGiftAgent.GainPrizeRes = "ConsumeDiamondGiftAgent_GainPrizeRes"

function ConsumeDiamondGiftAgent:ctor()
	return
end

function ConsumeDiamondGiftAgent:setExtId(extId)
	ConsumeDiamondGiftAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function ConsumeDiamondGiftAgent:sendPM_GetActivityInfoReq(activityId, handler, handlerObj, errHandler)
	local req = ConsumeDiamondGiftExtension_pb.PM_GetActivityInfoReq()

	req.activityId = activityId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(ConsumeDiamondGiftAgent.PM_GetActivityInfoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function ConsumeDiamondGiftAgent:handlePM_GetActivityInfoRes(status, msg)
	self:dispatch(ConsumeDiamondGiftAgent.PM_GetActivityInfoRes, status, msg)
end

function ConsumeDiamondGiftAgent:sendGainPrizeReq(activityId, prizeId, handler, handlerObj, errHandler)
	local req = ConsumeDiamondGiftExtension_pb.GainPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(ConsumeDiamondGiftAgent.GainPrizeRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function ConsumeDiamondGiftAgent:handleGainPrizeRes(status, msg)
	self:dispatch(ConsumeDiamondGiftAgent.GainPrizeRes, status, msg)
end

ConsumeDiamondGiftAgent.instance = ConsumeDiamondGiftAgent.New()

return ConsumeDiamondGiftAgent
