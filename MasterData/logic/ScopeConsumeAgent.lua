-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firstcharge/agent/ScopeConsumeAgent.lua

module("logic.extensions.scopeconsume.agent.ScopeConsumeAgent", package.seeall)

local ScopeConsumeAgent = class("ScopeConsumeAgent", BaseAgent)

ScopeConsumeAgent.PM_GetScopeConsumeInfoRes = "ScopeConsumeAgent_PM_GetScopeConsumeInfoRes"
ScopeConsumeAgent.PM_ScopeConsumeGainGiftRes = "ScopeConsumeAgent_PM_ScopeConsumeGainGiftRes"

function ScopeConsumeAgent:ctor()
	return
end

function ScopeConsumeAgent:setExtId(extId)
	ScopeConsumeAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function ScopeConsumeAgent:sendPM_GetScopeConsumeInfoReq(handler, handlerObj, errHandler)
	local req = ScopeConsumeExtension_pb.PM_GetScopeConsumeInfoReq()

	self:sendMsg(req)
	self:addEventOnce(ScopeConsumeAgent.PM_GetScopeConsumeInfoRes, handler, handlerObj, errHandler)
end

function ScopeConsumeAgent:handlePM_GetScopeConsumeInfoRes(status, msg)
	self:dispatch(ScopeConsumeAgent.PM_GetScopeConsumeInfoRes, status, msg)
end

function ScopeConsumeAgent:sendPM_ScopeConsumeGainGiftReq(activityId, index, day, handler, handlerObj, errHandler)
	local req = ScopeConsumeExtension_pb.PM_ScopeConsumeGainGiftReq()

	req.activityId = activityId
	req.index = index

	if day ~= nil then
		req.day = day
	end

	self:sendMsg(req)
	self:addEventOnce(ScopeConsumeAgent.PM_ScopeConsumeGainGiftRes, handler, handlerObj, errHandler)
end

function ScopeConsumeAgent:handlePM_ScopeConsumeGainGiftRes(status, msg)
	self:dispatch(ScopeConsumeAgent.PM_ScopeConsumeGainGiftRes, status, msg)
end

ScopeConsumeAgent.instance = ScopeConsumeAgent.New()

return ScopeConsumeAgent
