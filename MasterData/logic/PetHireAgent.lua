-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pethire/agent/PetHireAgent.lua

module("logic.extensions.pethire.agent.PetHireAgent", package.seeall)

local PetHireAgent = class("PetHireAgent", BaseAgent)

function PetHireAgent:ctor()
	return
end

function PetHireAgent:setExtId(extId)
	PetHireAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function PetHireAgent:sendPM_HirePetInfoReq()
	local req = PetHireExtension_pb.PM_HirePetInfoReq()

	self:sendMsg(req)
end

function PetHireAgent:handlePM_HirePetInfoRes(status, msg)
	forcePrint("=====RoleDataRequestor:_loadRequestHirePets===back2222")

	if status == 0 then
		PetHireController.instance:onSetAllHirePetInfo(msg)
	end
end

function PetHireAgent:sendPM_SetHirePetFormReq(req)
	self:sendMsg(req)
end

function PetHireAgent:handlePM_SetHirePetFormRes(status, msg)
	if status == 0 then
		PetHireController.instance:updateHrieForm(msg)
	end
end

function PetHireAgent:handlePM_NotifyHirePetChangedRes(status, msg)
	if checknumber(status) == 0 then
		PetHireModel.instance:onPetInfoChange(msg)
	end
end

PetHireAgent.instance = PetHireAgent.New()

return PetHireAgent
