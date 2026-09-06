-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/energy/agent/EnergyAgent.lua

module("logic.extensions.energy.agent.EnergyAgent", package.seeall)

local EnergyAgent = class("EnergyAgent", BaseAgent)

EnergyAgent.PM_GetEnergyInfoRes = "EnergyAgent_PM_GetEnergyInfoRes"
EnergyAgent.PM_GetAllEnergyInfoRes = "EnergyAgent_PM_GetAllEnergyInfoRes"
EnergyAgent.PM_BuyEnergyRes = "EnergyAgent_PM_BuyEnergyRes"
EnergyAgent.PM_NotifyEnergyChangeRes = "EnergyAgent_PM_NotifyEnergyChangeRes"

function EnergyAgent:ctor()
	return
end

function EnergyAgent:setExtId(extId)
	EnergyAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function EnergyAgent:sendPM_GetEnergyInfoReq(id, handler, handlerObj, errHandler)
	local req = EnergyExtension_pb.PM_GetEnergyInfoReq()

	req.id = id

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(EnergyAgent.PM_GetEnergyInfoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function EnergyAgent:handlePM_GetEnergyInfoRes(status, msg)
	self:dispatch(EnergyAgent.PM_GetEnergyInfoRes, status, msg)
end

function EnergyAgent:sendPM_GetAllEnergyInfoReq(handler, handlerObj, errHandler)
	forcePrint("==========LoginController._enterGame=======EnergyAgent:sendPM_GetAllEnergyInfoReq====")

	local req = EnergyExtension_pb.PM_GetAllEnergyInfoReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(EnergyAgent.PM_GetAllEnergyInfoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function EnergyAgent:handlePM_GetAllEnergyInfoRes(status, msg)
	forcePrint("==========LoginController._enterGame=======EnergyAgent:sendPM_GetAllEnergyInfoReq====back")
	self:dispatch(EnergyAgent.PM_GetAllEnergyInfoRes, status, msg)
end

function EnergyAgent:sendPM_BuyEnergyReq(id, times, handler, handlerObj, errHandler)
	local req = EnergyExtension_pb.PM_BuyEnergyReq()

	req.id = id
	req.times = times

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(EnergyAgent.PM_BuyEnergyRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function EnergyAgent:handlePM_BuyEnergyRes(status, msg)
	self:dispatch(EnergyAgent.PM_BuyEnergyRes, status, msg)
end

function EnergyAgent:handlePM_NotifyEnergyChangeRes(status, msg)
	self:dispatch(EnergyAgent.PM_NotifyEnergyChangeRes, status, msg)
end

EnergyAgent.instance = EnergyAgent.New()

return EnergyAgent
