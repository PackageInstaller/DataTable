-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zeropay/agent/ZeroPayAgent.lua

module("logic.extensions.zeropay.agent.ZeroPayAgent", package.seeall)

local ZeroPayAgent = class("ZeroPayAgent", BaseAgent)

ZeroPayAgent.PM_GetGiftInfoRes = "ZeroPayAgent_PM_GetGiftInfoRes"
ZeroPayAgent.PM_NotifyBuyGiftRes = "ZeroPayAgent_PM_NotifyBuyGiftRes"

function ZeroPayAgent:ctor()
	return
end

function ZeroPayAgent:setExtId(extId)
	ZeroPayAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function ZeroPayAgent:sendPM_GetGiftInfoReq(handler, handlerObj, errHandler)
	local req = ZeroPayExtension_pb.PM_GetGiftInfoReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(ZeroPayAgent.PM_GetGiftInfoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function ZeroPayAgent:handlePM_GetGiftInfoRes(status, msg)
	self:dispatch(ZeroPayAgent.PM_GetGiftInfoRes, status, msg)
end

function ZeroPayAgent:handlePM_NotifyBuyGiftRes(status, msg)
	self:dispatch(ZeroPayAgent.PM_NotifyBuyGiftRes, status, msg)
end

ZeroPayAgent.instance = ZeroPayAgent.New()

return ZeroPayAgent
