-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/powercrystal/agent/PowerCrystalAgent.lua

module("logic.extensions.powercrystal.agent.PowerCrystalAgent", package.seeall)

local PowerCrystalAgent = class("PowerCrystalAgent", BaseAgent)

PowerCrystalAgent.PM_PowerCrystalGetInfoRes = "PowerCrystalAgent_PM_PowerCrystalGetInfoRes"
PowerCrystalAgent.PM_PowerCrystalPutInSlotRes = "PowerCrystalAgent_PM_PowerCrystalPutInSlotRes"
PowerCrystalAgent.PM_PowerCrystalTakeOutOfSlotRes = "PowerCrystalAgent_PM_PowerCrystalTakeOutOfSlotRes"
PowerCrystalAgent.PM_PowerCrystalClearSlotCdRes = "PowerCrystalAgent_PM_PowerCrystalClearSlotCdRes"
PowerCrystalAgent.PM_PowerCrystalUnlockSlotRes = "PowerCrystalAgent_PM_PowerCrystalUnlockSlotRes"

function PowerCrystalAgent:ctor()
	return
end

function PowerCrystalAgent:setExtId(extId)
	PowerCrystalAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function PowerCrystalAgent:sendPM_PowerCrystalGetInfoReq(handler, handlerObj, errHandler)
	local req = PowerCrystalExtension_pb.PM_PowerCrystalGetInfoReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(PowerCrystalAgent.PM_PowerCrystalGetInfoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function PowerCrystalAgent:handlePM_PowerCrystalGetInfoRes(status, msg)
	self:dispatch(PowerCrystalAgent.PM_PowerCrystalGetInfoRes, status, msg)
end

function PowerCrystalAgent:sendPM_PowerCrystalPutInSlotReq(slotId, petId, handler, handlerObj, errHandler)
	local req = PowerCrystalExtension_pb.PM_PowerCrystalPutInSlotReq()

	req.slotId = slotId
	req.petId = petId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(PowerCrystalAgent.PM_PowerCrystalPutInSlotRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function PowerCrystalAgent:handlePM_PowerCrystalPutInSlotRes(status, msg)
	self:dispatch(PowerCrystalAgent.PM_PowerCrystalPutInSlotRes, status, msg)
end

function PowerCrystalAgent:sendPM_PowerCrystalTakeOutOfSlotReq(slotId, handler, handlerObj, errHandler)
	local req = PowerCrystalExtension_pb.PM_PowerCrystalTakeOutOfSlotReq()

	req.slotId = slotId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(PowerCrystalAgent.PM_PowerCrystalTakeOutOfSlotRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function PowerCrystalAgent:handlePM_PowerCrystalTakeOutOfSlotRes(status, msg)
	self:dispatch(PowerCrystalAgent.PM_PowerCrystalTakeOutOfSlotRes, status, msg)
end

function PowerCrystalAgent:sendPM_PowerCrystalClearSlotCdReq(slotId, handler, handlerObj, errHandler)
	local req = PowerCrystalExtension_pb.PM_PowerCrystalClearSlotCdReq()

	req.slotId = slotId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(PowerCrystalAgent.PM_PowerCrystalClearSlotCdRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function PowerCrystalAgent:handlePM_PowerCrystalClearSlotCdRes(status, msg)
	self:dispatch(PowerCrystalAgent.PM_PowerCrystalClearSlotCdRes, status, msg)
end

function PowerCrystalAgent:sendPM_PowerCrystalUnlockSlotReq(slotId, handler, handlerObj, errHandler)
	local req = PowerCrystalExtension_pb.PM_PowerCrystalUnlockSlotReq()

	req.slotId = slotId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(PowerCrystalAgent.PM_PowerCrystalUnlockSlotRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function PowerCrystalAgent:handlePM_PowerCrystalUnlockSlotRes(status, msg)
	self:dispatch(PowerCrystalAgent.PM_PowerCrystalUnlockSlotRes, status, msg)
end

PowerCrystalAgent.instance = PowerCrystalAgent.New()

return PowerCrystalAgent
