-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zeropay/agent/NewZeroPayAgent.lua

module("logic.extensions.newzeropay.agent.NewZeroPayAgent", package.seeall)

local NewZeroPayAgent = class("NewZeroPayAgent", BaseAgent)

NewZeroPayAgent.GetGiftInfoRes = "NewZeroPayAgent_GetGiftInfoRes"
NewZeroPayAgent.PM_NotifyBuyGiftRes = "NewZeroPayAgent_PM_NotifyBuyGiftRes"

function NewZeroPayAgent:ctor()
	return
end

function NewZeroPayAgent:setExtId(extId)
	NewZeroPayAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function NewZeroPayAgent:sendGetGiftInfoReq(handler, handlerObj, errHandler)
	local req = NewZeroPayExtension_pb.GetGiftInfoReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(NewZeroPayAgent.GetGiftInfoRes, handler, handlerObj, errHandler)
	end

	self:sendMsg(req)
end

function NewZeroPayAgent:handleGetGiftInfoRes(status, msg)
	self:dispatch(NewZeroPayAgent.GetGiftInfoRes, status, msg)
end

function NewZeroPayAgent:handlePM_NotifyBuyGiftRes(status, msg)
	self:dispatch(NewZeroPayAgent.PM_NotifyBuyGiftRes, status, msg)
end

NewZeroPayAgent.instance = NewZeroPayAgent.New()

return NewZeroPayAgent
