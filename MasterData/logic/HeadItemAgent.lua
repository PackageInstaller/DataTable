-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/headitem/agent/HeadItemAgent.lua

module("logic.extensions.headitem.agent.HeadItemAgent", package.seeall)

local HeadItemAgent = class("HeadItemAgent", BaseAgent)

HeadItemAgent.PM_LoadAllHeadItemRes = "HeadItemAgent_PM_LoadAllHeadItemRes"
HeadItemAgent.PM_ChangeHeadIconRes = "HeadItemAgent_PM_ChangeHeadIconRes"
HeadItemAgent.PM_ChangeHeadFrameRes = "HeadItemAgent_PM_ChangeHeadFrameRes"
HeadItemAgent.PM_notifyHeadIconChangeRes = "HeadItemAgent_PM_notifyHeadIconChangeRes"
HeadItemAgent.PM_notifyHeadFrameChangeRes = "HeadItemAgent_PM_notifyHeadFrameChangeRes"

function HeadItemAgent:ctor()
	return
end

function HeadItemAgent:setExtId(extId)
	HeadItemAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function HeadItemAgent:sendPM_LoadAllHeadItemReq(handler, handlerObj, errHandler)
	local req = HeadItemExtension_pb.PM_LoadAllHeadItemReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(HeadItemAgent.PM_LoadAllHeadItemRes, handler, handlerObj, errHandler)
	end

	self:sendMsg(req)
end

function HeadItemAgent:handlePM_LoadAllHeadItemRes(status, msg)
	self:dispatch(HeadItemAgent.PM_LoadAllHeadItemRes, status, msg)
end

function HeadItemAgent:sendPM_ChangeHeadIconReq(headIconId, handler, handlerObj, errHandler)
	local req = HeadItemExtension_pb.PM_ChangeHeadIconReq()

	req.headIconId = headIconId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(HeadItemAgent.PM_ChangeHeadIconRes, handler, handlerObj, errHandler)
	end

	self:sendMsg(req)
end

function HeadItemAgent:handlePM_ChangeHeadIconRes(status, msg)
	self:dispatch(HeadItemAgent.PM_ChangeHeadIconRes, status, msg)
end

function HeadItemAgent:sendPM_ChangeHeadFrameReq(headFrameId, handler, handlerObj, errHandler)
	local req = HeadItemExtension_pb.PM_ChangeHeadFrameReq()

	req.headFrameId = headFrameId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(HeadItemAgent.PM_ChangeHeadFrameRes, handler, handlerObj, errHandler)
	end

	self:sendMsg(req)
end

function HeadItemAgent:handlePM_ChangeHeadFrameRes(status, msg)
	self:dispatch(HeadItemAgent.PM_ChangeHeadFrameRes, status, msg)
end

function HeadItemAgent:handlePM_notifyHeadIconChangeRes(status, msg)
	self:dispatch(HeadItemAgent.PM_notifyHeadIconChangeRes, status, msg)
end

function HeadItemAgent:handlePM_notifyHeadFrameChangeRes(status, msg)
	self:dispatch(HeadItemAgent.PM_notifyHeadFrameChangeRes, status, msg)
end

HeadItemAgent.instance = HeadItemAgent.New()

return HeadItemAgent
