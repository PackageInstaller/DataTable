-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firstcharge/agent/ScopeConsumePlusAgent.lua

module("logic.extensions.scopeconsumeplus.agent.ScopeConsumePlusAgent", package.seeall)

local ScopeConsumePlusAgent = class("ScopeConsumePlusAgent", BaseAgent)

function ScopeConsumePlusAgent:ctor()
	return
end

function ScopeConsumePlusAgent:setExtId(extId)
	ScopeConsumePlusAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function ScopeConsumePlusAgent:sendPM_GetScopePlusConsumeInfoReq(activityId)
	local req = ScopeConsumePlusExtension_pb.PM_GetScopePlusConsumeInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function ScopeConsumePlusAgent:handlePM_GetScopePlusConsumeInfoRes(status, msg)
	if status == 0 then
		FirstChargePlusController.instance:_getInfoRes(msg)
	end
end

function ScopeConsumePlusAgent:sendPM_ScopeConsumePlusGainGiftReq(activityId, prizeId)
	local req = ScopeConsumePlusExtension_pb.PM_ScopeConsumePlusGainGiftReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function ScopeConsumePlusAgent:handlePM_ScopeConsumePlusGainGiftRes(status, msg)
	if status == 0 then
		FirstChargePlusController.instance:updatePrize(msg)
	end
end

function ScopeConsumePlusAgent:sendPM_ScopeConsumePlusGainSignPrizeReq(activityId, day)
	local req = ScopeConsumePlusExtension_pb.PM_ScopeConsumePlusGainSignPrizeReq()

	req.activityId = activityId
	req.day = day

	self:sendMsg(req)
end

function ScopeConsumePlusAgent:handlePM_ScopeConsumePlusGainSignPrizeRes(status, msg)
	if status == 0 then
		FirstChargePlusController.instance:updateDay(msg)
	end
end

ScopeConsumePlusAgent.instance = ScopeConsumePlusAgent.New()

return ScopeConsumePlusAgent
