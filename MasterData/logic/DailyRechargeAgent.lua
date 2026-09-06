-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/activitydaylirecharge/agent/DailyRechargeAgent.lua

module("logic.extensions.dailyrecharge.agent.DailyRechargeAgent", package.seeall)

local DailyRechargeAgent = class("DailyRechargeAgent", BaseAgent)

DailyRechargeAgent.PM_DailyRechargeInfoRes = "DailyRechargeAgent_PM_DailyRechargeInfoRes"
DailyRechargeAgent.PM_GainDailyRechargePrizeRes = "DailyRechargeAgent_PM_GainDailyRechargePrizeRes"

function DailyRechargeAgent:ctor()
	return
end

function DailyRechargeAgent:setExtId(extId)
	DailyRechargeAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function DailyRechargeAgent:sendPM_DailyRechargeInfoReq(handler, handlerObj, errHandler)
	local req = DailyRechargeExtension_pb.PM_DailyRechargeInfoReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(DailyRechargeAgent.PM_DailyRechargeInfoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function DailyRechargeAgent:handlePM_DailyRechargeInfoRes(status, msg)
	self:dispatch(DailyRechargeAgent.PM_DailyRechargeInfoRes, status, msg)
end

function DailyRechargeAgent:sendPM_GainDailyRechargePrizeReq(prizeId, handler, handlerObj, errHandler)
	local req = DailyRechargeExtension_pb.PM_GainDailyRechargePrizeReq()

	req.prizeId = prizeId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(DailyRechargeAgent.PM_GainDailyRechargePrizeRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function DailyRechargeAgent:handlePM_GainDailyRechargePrizeRes(status, msg)
	self:dispatch(DailyRechargeAgent.PM_GainDailyRechargePrizeRes, status, msg)
end

DailyRechargeAgent.instance = DailyRechargeAgent.New()

return DailyRechargeAgent
