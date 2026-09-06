-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/vip/agent/VipAgent.lua

module("logic.extensions.vip.agent.VipAgent", package.seeall)

local VipAgent = class("VipAgent", BaseAgent)

VipAgent.PM_GetVipInfoRes = "VipAgent_PM_GetVipInfoRes"
VipAgent.PM_GainVipDailyBonusRes = "VipAgent_PM_GainVipDailyBonusRes"
VipAgent.PM_GainVipFreeBonusRes = "VipAgent_PM_GainVipFreeBonusRes"
VipAgent.PM_VipExpDailyChangeRes = "VipAgent_PM_VipExpDailyChangeRes"

function VipAgent:ctor()
	return
end

function VipAgent:setExtId(extId)
	VipAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function VipAgent:sendPM_GetVipInfoReq(handler, handlerObj, errHandler)
	local req = VipExtension_pb.PM_GetVipInfoReq()

	self:sendMsg(req)
	self:addEventOnce(VipAgent.PM_GetVipInfoRes, handler, handlerObj, errHandler)
end

function VipAgent:handlePM_GetVipInfoRes(status, msg)
	self:dispatch(VipAgent.PM_GetVipInfoRes, status, msg)
end

function VipAgent:sendPM_GainVipDailyBonusReq(vipLevel, handler, handlerObj, errHandler)
	local req = VipExtension_pb.PM_GainVipDailyBonusReq()

	req.vipLevel = vipLevel

	self:sendMsg(req)
	self:addEventOnce(VipAgent.PM_GainVipDailyBonusRes, handler, handlerObj, errHandler)
end

function VipAgent:handlePM_GainVipDailyBonusRes(status, msg)
	self:dispatch(VipAgent.PM_GainVipDailyBonusRes, status, msg)
end

function VipAgent:sendPM_GainVipOnceFreeBonusReq(vipLevel, handler, handlerObj, errHandler)
	local req = VipExtension_pb.PM_GainVipOnceFreeBonusReq()

	req.vipLevel = vipLevel

	self:sendMsg(req)
	self:addEventOnce(VipAgent.PM_GainVipFreeBonusRes, handler, handlerObj, errHandler)
end

function VipAgent:handlePM_GainVipFreeBonusRes(status, msg)
	self:dispatch(VipAgent.PM_GainVipFreeBonusRes, status, msg)
end

function VipAgent:handlePM_VipExpDailyChangeRes(status, msg)
	self:dispatch(VipAgent.PM_VipExpDailyChangeRes, status, msg)
end

VipAgent.instance = VipAgent.New()

return VipAgent
