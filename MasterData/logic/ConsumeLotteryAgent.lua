-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/consumelottery/agent/ConsumeLotteryAgent.lua

module("logic.extensions.consumelottery.agent.ConsumeLotteryAgent", package.seeall)

local ConsumeLotteryAgent = class("ConsumeLotteryAgent", BaseAgent)

ConsumeLotteryAgent.PM_ConsumeLotteryGetInfoRes = "ConsumeLotteryAgent_PM_ConsumeLotteryGetInfoRes"
ConsumeLotteryAgent.PM_ConsumeLotteryDrawRes = "ConsumeLotteryAgent_PM_ConsumeLotteryDrawRes"
ConsumeLotteryAgent.PM_ConsumeLotteryGetAddressInfoRes = "ConsumeLotteryAgent_PM_ConsumeLotteryGetAddressInfoRes"
ConsumeLotteryAgent.PM_ConsumeLotteryUpdateAddressInfoRes = "ConsumeLotteryAgent_PM_ConsumeLotteryUpdateAddressInfoRes"

function ConsumeLotteryAgent:ctor()
	return
end

function ConsumeLotteryAgent:setExtId(extId)
	ConsumeLotteryAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function ConsumeLotteryAgent:sendPM_ConsumeLotteryGetInfoReq(activityId, handler, handlerObj, errHandler)
	local req = ConsumeLotteryExtension_pb.PM_ConsumeLotteryGetInfoReq()

	req.activityId = activityId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(ConsumeLotteryAgent.PM_ConsumeLotteryGetInfoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function ConsumeLotteryAgent:handlePM_ConsumeLotteryGetInfoRes(status, msg)
	self:dispatch(ConsumeLotteryAgent.PM_ConsumeLotteryGetInfoRes, status, msg)
end

function ConsumeLotteryAgent:sendPM_ConsumeLotteryDrawReq(activityId, curRound, isUseMonthTicket, handler, handlerObj, errHandler)
	local req = ConsumeLotteryExtension_pb.PM_ConsumeLotteryDrawReq()

	req.activityId = activityId
	req.curRound = curRound
	req.isUseMonthTicket = isUseMonthTicket

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(ConsumeLotteryAgent.PM_ConsumeLotteryDrawRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function ConsumeLotteryAgent:handlePM_ConsumeLotteryDrawRes(status, msg)
	self:dispatch(ConsumeLotteryAgent.PM_ConsumeLotteryDrawRes, status, msg)
end

function ConsumeLotteryAgent:sendPM_ConsumeLotteryGetAddressInfoReq(activityId, handler, handlerObj, errHandler)
	local req = ConsumeLotteryExtension_pb.PM_ConsumeLotteryGetAddressInfoReq()

	req.activityId = activityId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(ConsumeLotteryAgent.PM_ConsumeLotteryGetAddressInfoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function ConsumeLotteryAgent:handlePM_ConsumeLotteryGetAddressInfoRes(status, msg)
	self:dispatch(ConsumeLotteryAgent.PM_ConsumeLotteryGetAddressInfoRes, status, msg)
end

function ConsumeLotteryAgent:sendPM_ConsumeLotteryUpdateAddressInfoReq(activityId, name, mobilePhone, qq, address, handler, handlerObj, errHandler)
	local req = ConsumeLotteryExtension_pb.PM_ConsumeLotteryUpdateAddressInfoReq()

	req.activityId = activityId
	req.name = name
	req.mobilePhone = mobilePhone
	req.qq = qq
	req.address = address

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(ConsumeLotteryAgent.PM_ConsumeLotteryUpdateAddressInfoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function ConsumeLotteryAgent:handlePM_ConsumeLotteryUpdateAddressInfoRes(status, msg)
	self:dispatch(ConsumeLotteryAgent.PM_ConsumeLotteryUpdateAddressInfoRes, status, msg)
end

ConsumeLotteryAgent.instance = ConsumeLotteryAgent.New()

return ConsumeLotteryAgent
