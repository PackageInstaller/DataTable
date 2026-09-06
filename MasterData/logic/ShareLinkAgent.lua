-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/share/agent/ShareLinkAgent.lua

module("logic.extensions.sharelink.agent.ShareLinkAgent", package.seeall)

local ShareLinkAgent = class("ShareLinkAgent", BaseAgent)

ShareLinkAgent.PM_GetShareLinkDataRes = "ShareLinkAgent_PM_GetShareLinkDataRes"
ShareLinkAgent.PM_GainShareLinkPrizeRes = "ShareLinkAgent_PM_GainShareLinkPrizeRes"

function ShareLinkAgent:ctor()
	return
end

function ShareLinkAgent:setExtId(extId)
	ShareLinkAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function ShareLinkAgent:sendPM_GetShareLinkDataReq(id, handler, handlerObj, errHandler)
	local req = ShareLinkExtension_pb.PM_GetShareLinkDataReq()

	req.id = id

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(ShareLinkAgent.PM_GetShareLinkDataRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function ShareLinkAgent:handlePM_GetShareLinkDataRes(status, msg)
	self:dispatch(ShareLinkAgent.PM_GetShareLinkDataRes, status, msg)
end

function ShareLinkAgent:sendPM_GainShareLinkPrizeReq(id, handler, handlerObj, errHandler)
	local req = ShareLinkExtension_pb.PM_GainShareLinkPrizeReq()

	req.id = id

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(ShareLinkAgent.PM_GainShareLinkPrizeRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function ShareLinkAgent:handlePM_GainShareLinkPrizeRes(status, msg)
	self:dispatch(ShareLinkAgent.PM_GainShareLinkPrizeRes, status, msg)
end

ShareLinkAgent.instance = ShareLinkAgent.New()

return ShareLinkAgent
