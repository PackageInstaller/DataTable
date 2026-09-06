-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sourcemon/agent/SourcemonAgent.lua

module("logic.extensions.sourcemon.agent.SourcemonAgent", package.seeall)

local SourcemonAgent = class("SourcemonAgent", BaseAgent)

SourcemonAgent.PM_LoadUserSourcemonRes = "SourcemonAgent_PM_LoadUserSourcemonRes"
SourcemonAgent.PM_EquipSourcemonReq = "SourcemonAgent_PM_EquipSourcemonReq"
SourcemonAgent.PM_PetSwallowSourcemonRes = "SourcemonAgent_PM_PetSwallowSourcemonRes"
SourcemonAgent.PM_UserSourcemonChangeNotifyRes = "SourcemonAgent_PM_UserSourcemonChangeNotifyRes"

function SourcemonAgent:ctor()
	return
end

function SourcemonAgent:setExtId(extId)
	SourcemonAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function SourcemonAgent:sendPM_LoadUserSourcemonReq(handler, handlerObj, errHandler)
	local req = SourcemonExtension_pb.PM_LoadUserSourcemonReq()

	self:sendMsg(req)
	self:addEventOnce(SourcemonAgent.PM_LoadUserSourcemonRes, handler, handlerObj, errHandler)
end

function SourcemonAgent:handlePM_LoadUserSourcemonRes(status, msg)
	self:dispatch(SourcemonAgent.PM_LoadUserSourcemonRes, status, msg)
end

function SourcemonAgent:sendPM_EquipSourcemonReq(petId, slotId, sourcemonId, handler, handlerObj, errHandler)
	local req = SourcemonExtension_pb.PM_EquipSourcemonReq()

	req.petId = petId
	req.slotId = slotId
	req.sourcemonId = sourcemonId

	self:sendMsg(req)
	self:addEventOnce(SourcemonAgent.PM_EquipSourcemonReq, handler, handlerObj, errHandler)
end

function SourcemonAgent:handlePM_EquipSourcemonReq(status, msg)
	self:dispatch(SourcemonAgent.PM_EquipSourcemonReq, status, msg)
end

function SourcemonAgent:sendPM_PetSwallowSourcemonReq(petId, slotId, sourcemonId, isBatchSwallow, handler, handlerObj, errHandler)
	local req = SourcemonExtension_pb.PM_PetSwallowSourcemonReq()

	req.petId = petId
	req.slotId = slotId
	req.sourcemonId = sourcemonId
	req.isBatchSwallow = isBatchSwallow

	self:sendMsg(req)
	self:addEventOnce(SourcemonAgent.PM_PetSwallowSourcemonRes, handler, handlerObj, errHandler)
end

function SourcemonAgent:handlePM_PetSwallowSourcemonRes(status, msg)
	self:dispatch(SourcemonAgent.PM_PetSwallowSourcemonRes, status, msg)
end

function SourcemonAgent:handlePM_UserSourcemonChangeNotifyRes(status, msg)
	self:dispatch(SourcemonAgent.PM_UserSourcemonChangeNotifyRes, status, msg)
end

SourcemonAgent.instance = SourcemonAgent.New()

return SourcemonAgent
