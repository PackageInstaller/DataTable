-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petskin/agent/PetSkinAgent.lua

module("logic.extensions.petskin.agent.PetSkinAgent", package.seeall)

local PetSkinAgent = class("PetSkinAgent", BaseAgent)

PetSkinAgent.PM_LoadAllPetSkinInfoRes = "PetSkinAgent_PM_LoadAllPetSkinInfoRes"
PetSkinAgent.PM_UsePetSkinRes = "PetSkinAgent_PM_UsePetSkinRes"
PetSkinAgent.PM_NotifySkinInfoChangedRes = "PetSkinAgent_PM_NotifySkinInfoChangedRes"
PetSkinAgent.PM_NotifyPresentSkinRes = "PetSkinAgent_PM_NotifyPresentSkinRes"
PetSkinAgent.PM_BatchUsePetSkinRes = "PetSkinAgent_PM_BatchUsePetSkinRes"

function PetSkinAgent:ctor()
	return
end

function PetSkinAgent:setExtId(extId)
	PetSkinAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function PetSkinAgent:sendPM_LoadAllPetSkinInfoReq(otherUserId, handler, handlerObj, errHandler)
	local req = PetSkinExtension_pb.PM_LoadAllPetSkinInfoReq()

	if otherUserId then
		req.otherUserId = otherUserId
	end

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(PetSkinAgent.PM_LoadAllPetSkinInfoRes, handler, handlerObj, errHandler)
	end

	self:sendMsg(req)
end

function PetSkinAgent:handlePM_LoadAllPetSkinInfoRes(status, msg)
	self:dispatch(PetSkinAgent.PM_LoadAllPetSkinInfoRes, status, msg)
end

function PetSkinAgent:sendPM_UsePetSkinReq(skinId, petId, handler, handlerObj, errHandler)
	local req = PetSkinExtension_pb.PM_UsePetSkinReq()

	req.skinId = skinId
	req.petId = petId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(PetSkinAgent.PM_UsePetSkinRes, handler, handlerObj, errHandler)
	end

	self:sendMsg(req)
end

function PetSkinAgent:handlePM_UsePetSkinRes(status, msg)
	self:dispatch(PetSkinAgent.PM_UsePetSkinRes, status, msg)
end

function PetSkinAgent:sendPM_ChangePetSkinBodyTypeReq(petId, bodyType)
	local req = PetSkinExtension_pb.PM_ChangePetSkinBodyTypeReq()

	req.petId = petId
	req.bodyType = bodyType

	self:sendMsg(req)
end

function PetSkinAgent:handlePM_ChangePetSkinBodyTypeRes(status, msg)
	if status == 0 then
		PetskinController.instance:changeBody(msg.newSkinId)
	end
end

function PetSkinAgent:sendPM_BatchUsePetSkinReq(useList)
	local req = PetSkinExtension_pb.PM_BatchUsePetSkinReq()

	for i, v in ipairs(useList) do
		local mo = req.useList:add()

		mo.skinId = v.skinId
		mo.petId = v.petId
	end

	self:sendMsg(req)
end

function PetSkinAgent:handlePM_BatchUsePetSkinRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(PetSkinAgent.PM_BatchUsePetSkinRes)
	end
end

function PetSkinAgent:sendPM_SetPetSkinOtherNameReq(skinId, otherName)
	local req = PetSkinExtension_pb.PM_SetPetSkinOtherNameReq()

	req.skinId = skinId
	req.otherName = otherName

	self:sendMsg(req)
end

function PetSkinAgent:handlePM_SetPetSkinOtherNameRes(status, msg)
	if status == 0 then
		local skinId = msg.skinId
		local otherName = msg.otherName

		PetskinModel.instance:setPetSkinOtherName(skinId, otherName)
		GlobalDispatcher:dispatch(GlobalNotify.SetPetSkinOtherNameRes)
	end
end

function PetSkinAgent:handlePM_NotifySkinInfoChangedRes(status, msg)
	self:dispatch(PetSkinAgent.PM_NotifySkinInfoChangedRes, status, msg)
end

function PetSkinAgent:handlePM_NotifyPresentSkinRes(status, msg)
	self:dispatch(PetSkinAgent.PM_NotifyPresentSkinRes, status, msg)
end

PetSkinAgent.instance = PetSkinAgent.New()

return PetSkinAgent
