-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/familytech/agent/FamilyTechAgent.lua

module("logic.extensions.familytech.agent.FamilyTechAgent", package.seeall)

local FamilyTechAgent = class("FamilyTechAgent", BaseAgent)

FamilyTechAgent.PM_GetFamilyTechInfoRes = "FamilyTechAgent_PM_GetFamilyTechInfoRes"
FamilyTechAgent.PM_UnlockFamilyTechRes = "FamilyTechAgent_PM_UnlockFamilyTechRes"
FamilyTechAgent.PM_UpgradeFamilyTechRes = "FamilyTechAgent_PM_UpgradeFamilyTechRes"
FamilyTechAgent.PM_NotifyFamilyTechChangeRes = "FamilyTechAgent_PM_NotifyFamilyTechChangeRes"

function FamilyTechAgent:ctor()
	return
end

function FamilyTechAgent:setExtId(extId)
	FamilyTechAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function FamilyTechAgent:sendPM_GetFamilyTechInfoReq(handler, handlerObj, errHandler)
	local req = FamilyTechExtension_pb.PM_GetFamilyTechInfoReq()

	self:sendMsg(req)
	self:addEventOnce(FamilyTechAgent.PM_GetFamilyTechInfoRes, handler, handlerObj, errHandler)
end

function FamilyTechAgent:handlePM_GetFamilyTechInfoRes(status, msg)
	self:dispatch(FamilyTechAgent.PM_GetFamilyTechInfoRes, status, msg)
end

function FamilyTechAgent:sendPM_UnlockFamilyTechReq(techId, handler, handlerObj, errHandler)
	local req = FamilyTechExtension_pb.PM_UnlockFamilyTechReq()

	req.techId = techId

	self:sendMsg(req)
	self:addEventOnce(FamilyTechAgent.PM_UnlockFamilyTechRes, handler, handlerObj, errHandler)
end

function FamilyTechAgent:handlePM_UnlockFamilyTechRes(status, msg)
	self:dispatch(FamilyTechAgent.PM_UnlockFamilyTechRes, status, msg)
end

function FamilyTechAgent:sendPM_UpgradeFamilyTechReq(techId, handler, handlerObj, errHandler)
	local req = FamilyTechExtension_pb.PM_UpgradeFamilyTechReq()

	req.techId = techId

	self:sendMsg(req)
	self:addEventOnce(FamilyTechAgent.PM_UpgradeFamilyTechRes, handler, handlerObj, errHandler)
end

function FamilyTechAgent:handlePM_UpgradeFamilyTechRes(status, msg)
	self:dispatch(FamilyTechAgent.PM_UpgradeFamilyTechRes, status, msg)
end

function FamilyTechAgent:handlePM_NotifyFamilyTechChangeRes(status, msg)
	self:dispatch(FamilyTechAgent.PM_NotifyFamilyTechChangeRes, status, msg)
end

FamilyTechAgent.instance = FamilyTechAgent.New()

return FamilyTechAgent
