-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/monopoly/agent/MonopolyAgent.lua

module("logic.extensions.monopoly.agent.MonopolyAgent", package.seeall)

local MonopolyAgent = class("MonopolyAgent", BaseAgent)

MonopolyAgent.PM_GetMyMonopolyInfoRes = "MonopolyAgent_PM_GetMyMonopolyInfoRes"
MonopolyAgent.PM_MonopolyDiceRes = "MonopolyAgent_PM_MonopolyDiceRes"
MonopolyAgent.PM_BuyDiceTimesRes = "MonopolyAgent_PM_BuyDiceTimesRes"

function MonopolyAgent:ctor()
	return
end

function MonopolyAgent:setExtId(extId)
	MonopolyAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function MonopolyAgent:sendPM_GetMyMonopolyInfoReq(activityId, handler, handlerObj, errHandler)
	local req = MonopolyExtension_pb.PM_GetMyMonopolyInfoReq()

	req.activityId = activityId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(MonopolyAgent.PM_GetMyMonopolyInfoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function MonopolyAgent:handlePM_GetMyMonopolyInfoRes(status, msg)
	self:dispatch(MonopolyAgent.PM_GetMyMonopolyInfoRes, status, msg)
end

function MonopolyAgent:sendPM_MonopolyDiceReq(activityId, pointedForward, handler, handlerObj, errHandler)
	local req = MonopolyExtension_pb.PM_MonopolyDiceReq()

	req.activityId = activityId

	if pointedForward ~= nil then
		req.pointedForward = pointedForward
	end

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(MonopolyAgent.PM_MonopolyDiceRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function MonopolyAgent:handlePM_MonopolyDiceRes(status, msg)
	self:dispatch(MonopolyAgent.PM_MonopolyDiceRes, status, msg)
end

function MonopolyAgent:sendPM_BuyDiceTimesReq(activityId, curTimes, buyTimes, handler, handlerObj, errHandler)
	local req = MonopolyExtension_pb.PM_BuyDiceTimesReq()

	req.activityId = activityId
	req.curTimes = curTimes
	req.buyTimes = buyTimes

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(MonopolyAgent.PM_BuyDiceTimesRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function MonopolyAgent:handlePM_BuyDiceTimesRes(status, msg)
	self:dispatch(MonopolyAgent.PM_BuyDiceTimesRes, status, msg)
end

MonopolyAgent.instance = MonopolyAgent.New()

return MonopolyAgent
