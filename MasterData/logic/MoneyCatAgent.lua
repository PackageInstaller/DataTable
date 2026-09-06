-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/solicitwealth/agent/MoneyCatAgent.lua

module("logic.extensions.moneycat.agent.MoneyCatAgent", package.seeall)

local MoneyCatAgent = class("MoneyCatAgent", BaseAgent)

MoneyCatAgent.MoneyCatInfoRes = "MoneyCatAgent_MoneyCatInfoRes"
MoneyCatAgent.MakeMoneyRes = "MoneyCatAgent_MakeMoneyRes"

function MoneyCatAgent:ctor()
	return
end

function MoneyCatAgent:setExtId(extId)
	MoneyCatAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function MoneyCatAgent:sendMoneyCatInfoReq(handler, handlerObj, errHandler)
	local req = MoneyCatExtension_pb.MoneyCatInfoReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(MoneyCatAgent.MoneyCatInfoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function MoneyCatAgent:handleMoneyCatInfoRes(status, msg)
	if status == 0 then
		SolicitWealthModel.instance:handleMoneyCatInfoRes(msg)
	end

	self:dispatch(MoneyCatAgent.MoneyCatInfoRes, status, msg)
end

function MoneyCatAgent:sendMakeMoneyReq(times, handler, handlerObj, errHandler)
	local req = MoneyCatExtension_pb.MakeMoneyReq()

	req.times = times

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(MoneyCatAgent.MakeMoneyRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function MoneyCatAgent:handleMakeMoneyRes(status, msg)
	self:dispatch(MoneyCatAgent.MakeMoneyRes, status, msg)
end

MoneyCatAgent.instance = MoneyCatAgent.New()

return MoneyCatAgent
