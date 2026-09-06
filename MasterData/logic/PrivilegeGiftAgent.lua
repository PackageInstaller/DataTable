-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/privilege/agent/PrivilegeGiftAgent.lua

module("logic.extensions.privilegegift.agent.PrivilegeGiftAgent", package.seeall)

local PrivilegeGiftAgent = class("PrivilegeGiftAgent", BaseAgent)

PrivilegeGiftAgent.PM_GetUserPrivilegeInfoRes = "PrivilegeGiftAgent_PM_GetUserPrivilegeInfoRes"
PrivilegeGiftAgent.PM_NotifyBuyPrivilegeGiftRes = "PrivilegeGiftAgent_PM_NotifyBuyPrivilegeGiftRes"
PrivilegeGiftAgent.PM_NotifyPrivilegeDayChangeRes = "PrivilegeGiftAgent_PM_NotifyPrivilegeDayChangeRes"

function PrivilegeGiftAgent:ctor()
	return
end

function PrivilegeGiftAgent:setExtId(extId)
	PrivilegeGiftAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function PrivilegeGiftAgent:sendPM_GetUserPrivilegeInfoReq(handler, handlerObj, errHandler)
	local req = PrivilegeGiftExtension_pb.PM_GetUserPrivilegeInfoReq()

	self:sendMsg(req)
	self:addEventOnce(PrivilegeGiftAgent.PM_GetUserPrivilegeInfoRes, handler, handlerObj, errHandler)
end

function PrivilegeGiftAgent:handlePM_GetUserPrivilegeInfoRes(status, msg)
	self:dispatch(PrivilegeGiftAgent.PM_GetUserPrivilegeInfoRes, status, msg)
end

function PrivilegeGiftAgent:handlePM_NotifyBuyPrivilegeGiftRes(status, msg)
	self:dispatch(PrivilegeGiftAgent.PM_NotifyBuyPrivilegeGiftRes, status, msg)
end

function PrivilegeGiftAgent:handlePM_NotifyPrivilegeDayChangeRes(status, msg)
	self:dispatch(PrivilegeGiftAgent.PM_NotifyPrivilegeDayChangeRes, status, msg)
end

PrivilegeGiftAgent.instance = PrivilegeGiftAgent.New()

return PrivilegeGiftAgent
