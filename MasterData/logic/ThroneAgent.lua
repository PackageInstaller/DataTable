-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/throne/agent/ThroneAgent.lua

module("logic.extensions.throne.agent.ThroneAgent", package.seeall)

local ThroneAgent = class("ThroneAgent", BaseAgent)

ThroneAgent.PM_LoadAllThronesRes = "ThroneAgent_PM_LoadAllThronesRes"
ThroneAgent.PM_GetThronePanelOtherInfoRes = "ThroneAgent_PM_GetThronePanelOtherInfoRes"
ThroneAgent.PM_UpgradeThroneRes = "ThroneAgent_PM_UpgradeThroneRes"
ThroneAgent.PM_GainThroneDailyPrizeRes = "ThroneAgent_PM_GainThroneDailyPrizeRes"
ThroneAgent.PM_GainThroneAchievementPrizeRes = "ThroneAgent_PM_GainThroneAchievementPrizeRes"
ThroneAgent.PM_NotifyThronesChangeRes = "ThroneAgent_PM_NotifyThronesChangeRes"
ThroneAgent.PM_OneClickUpgradeThroneReq = "ThroneAgent_PM_OneClickUpgradeThroneReq"

function ThroneAgent:ctor()
	return
end

function ThroneAgent:setExtId(extId)
	ThroneAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function ThroneAgent:sendPM_LoadAllThronesReq(handler, handlerObj, errHandler)
	local req = ThroneExtension_pb.PM_LoadAllThronesReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(ThroneAgent.PM_LoadAllThronesRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function ThroneAgent:handlePM_LoadAllThronesRes(status, msg)
	forcePrint("=====RoleDataRequestor:_loadThroneInfo===back")
	self:dispatch(ThroneAgent.PM_LoadAllThronesRes, status, msg)
end

function ThroneAgent:sendPM_GetThronePanelOtherInfoReq(handler, handlerObj, errHandler)
	local req = ThroneExtension_pb.PM_GetThronePanelOtherInfoReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(ThroneAgent.PM_GetThronePanelOtherInfoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function ThroneAgent:handlePM_GetThronePanelOtherInfoRes(status, msg)
	self:dispatch(ThroneAgent.PM_GetThronePanelOtherInfoRes, status, msg)
end

function ThroneAgent:sendPM_UpgradeThroneReq(throneId, handler, handlerObj, errHandler)
	local req = ThroneExtension_pb.PM_UpgradeThroneReq()

	req.throneId = throneId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(ThroneAgent.PM_UpgradeThroneRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function ThroneAgent:handlePM_UpgradeThroneRes(status, msg)
	self:dispatch(ThroneAgent.PM_UpgradeThroneRes, status, msg)
end

function ThroneAgent:sendPM_GainThroneDailyPrizeReq(handler, handlerObj, errHandler)
	local req = ThroneExtension_pb.PM_GainThroneDailyPrizeReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(ThroneAgent.PM_GainThroneDailyPrizeRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function ThroneAgent:handlePM_GainThroneDailyPrizeRes(status, msg)
	self:dispatch(ThroneAgent.PM_GainThroneDailyPrizeRes, status, msg)
end

function ThroneAgent:sendPM_GainThroneAchievementPrizeReq(id, handler, handlerObj, errHandler)
	local req = ThroneExtension_pb.PM_GainThroneAchievementPrizeReq()

	req.id = id

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(ThroneAgent.PM_GainThroneAchievementPrizeRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function ThroneAgent:handlePM_GainThroneAchievementPrizeRes(status, msg)
	self:dispatch(ThroneAgent.PM_GainThroneAchievementPrizeRes, status, msg)
end

function ThroneAgent:handlePM_NotifyThronesChangeRes(status, msg)
	self:dispatch(ThroneAgent.PM_NotifyThronesChangeRes, status, msg)
end

function ThroneAgent:sendPM_OneClickUpgradeThroneReq(handler, handlerObj, errHandler)
	local req = ThroneExtension_pb.PM_OneClickUpgradeThroneReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(ThroneAgent.PM_OneClickUpgradeThroneReq, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function ThroneAgent:handlePM_OneClickUpgradeThroneRes(status, msg)
	self:dispatch(ThroneAgent.PM_OneClickUpgradeThroneReq, status, msg)
end

ThroneAgent.instance = ThroneAgent.New()

return ThroneAgent
