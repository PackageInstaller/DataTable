-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/agent/EquipmentAgent.lua

module("logic.extensions.equipment.agent.EquipmentAgent", package.seeall)

local EquipmentAgent = class("EquipmentAgent", BaseAgent)

EquipmentAgent.EQM_LoadAllEquipmentsRes = "EquipmentAgent_EQM_LoadAllEquipmentsRes"
EquipmentAgent.EQM_EquipRes = "EquipmentAgent_EQM_EquipRes"
EquipmentAgent.EQM_UpgradeRes = "EquipmentAgent_EQM_UpgradeRes"
EquipmentAgent.EQM_OneKeyEquipRes = "EquipmentAgent_EQM_OneKeyEquipRes"
EquipmentAgent.EQM_OneKeyUnloadRes = "EquipmentAgent_EQM_OneKeyUnloadRes"
EquipmentAgent.EQM_UnloadRes = "EquipmentAgent_EQM_UnloadRes"
EquipmentAgent.EQM_NotifyEquipmentsChangeRes = "EquipmentAgent_EQM_NotifyEquipmentsChangeRes"
EquipmentAgent.EQM_BreakoutRes = "EquipmentAgent_EQM_BreakoutRes"

function EquipmentAgent:ctor()
	return
end

function EquipmentAgent:setExtId(extId)
	EquipmentAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function EquipmentAgent:sendEQM_LoadAllEquipmentsReq(handler, handlerObj, errHandler)
	local req = EquipmentExtension_pb.EQM_LoadAllEquipmentsReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(EquipmentAgent.EQM_LoadAllEquipmentsRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function EquipmentAgent:handleEQM_LoadAllEquipmentsRes(status, msg)
	forcePrint("=====RoleDataRequestor:_loadAllPetEquips===back")
	self:dispatch(EquipmentAgent.EQM_LoadAllEquipmentsRes, status, msg)
end

function EquipmentAgent:sendEQM_EquipReq(petId, equipmentId, handler, handlerObj, errHandler)
	local req = EquipmentExtension_pb.EQM_EquipReq()

	req.petId = petId
	req.equipmentId = equipmentId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(EquipmentAgent.EQM_EquipRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function EquipmentAgent:handleEQM_EquipRes(status, msg)
	self:dispatch(EquipmentAgent.EQM_EquipRes, status, msg)
end

function EquipmentAgent:sendEQM_UpgradeReq(equipmentId, usingEquipmentIds_i32_Ary, usingMaterials_pb_Ary, handler, handlerObj, errHandler)
	local req = EquipmentExtension_pb.EQM_UpgradeReq()

	req.equipmentId = equipmentId

	for i, v1 in ipairs(usingEquipmentIds_i32_Ary) do
		req.usingEquipmentIds:append(v1)
	end

	if usingMaterials_pb_Ary ~= nil then
		for i, v2 in ipairs(usingMaterials_pb_Ary) do
			local usingMaterials = req.usingMaterials:add()

			usingMaterials:ParseFromString(v2:SerializeToString())
		end
	end

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(EquipmentAgent.EQM_UpgradeRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function EquipmentAgent:handleEQM_UpgradeRes(status, msg)
	self:dispatch(EquipmentAgent.EQM_UpgradeRes, status, msg)
end

function EquipmentAgent:sendEQM_OneKeyEquipReq(petId, equipmentIds_i32_Ary, decorationId, handler, handlerObj, errHandler)
	local req = EquipmentExtension_pb.EQM_OneKeyEquipReq()

	req.petId = petId

	for i, v3 in ipairs(equipmentIds_i32_Ary) do
		req.equipmentIds:append(v3)
	end

	if decorationId ~= nil then
		req.decorationId = decorationId
	end

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(EquipmentAgent.EQM_OneKeyEquipRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function EquipmentAgent:handleEQM_OneKeyEquipRes(status, msg)
	self:dispatch(EquipmentAgent.EQM_OneKeyEquipRes, status, msg)
end

function EquipmentAgent:sendEQM_OneKeyUnloadReq(petIdList)
	local req = EquipmentExtension_pb.EQM_OneKeyUnloadReq()

	for _, v in ipairs(petIdList) do
		req.petId:append(v)
	end

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:sendMsg(req)
	end
end

function EquipmentAgent:handleEQM_OneKeyUnloadRes(status, msg)
	self:dispatch(EquipmentAgent.EQM_OneKeyUnloadRes, status, msg)
end

function EquipmentAgent:sendEQM_UnloadReq(petId, equipmentId, handler, handlerObj, errHandler)
	local req = EquipmentExtension_pb.EQM_UnloadReq()

	req.petId = petId
	req.equipmentId = equipmentId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(EquipmentAgent.EQM_UnloadRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function EquipmentAgent:handleEQM_UnloadRes(status, msg)
	self:dispatch(EquipmentAgent.EQM_UnloadRes, status, msg)
end

function EquipmentAgent:handleEQM_NotifyEquipmentsChangeRes(status, msg)
	self:dispatch(EquipmentAgent.EQM_NotifyEquipmentsChangeRes, status, msg)
end

function EquipmentAgent:sendEQM_BreakoutReq(mainEquipmentId, otherEquipmentIds_i32_Ary, usingMaterials_pb_Ary, handler, handlerObj, errHandler)
	local req = EquipmentExtension_pb.EQM_BreakoutReq()

	req.mainEquipmentId = mainEquipmentId

	for i, v4 in ipairs(otherEquipmentIds_i32_Ary) do
		req.otherEquipmentIds:append(v4)
	end

	if usingMaterials_pb_Ary ~= nil then
		for i, v5 in ipairs(usingMaterials_pb_Ary) do
			local usingMaterials = req.usingMaterials:add()

			usingMaterials:ParseFromString(v5:SerializeToString())
		end
	end

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(EquipmentAgent.EQM_BreakoutRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function EquipmentAgent:handleEQM_BreakoutRes(status, msg)
	self:dispatch(EquipmentAgent.EQM_BreakoutRes, status, msg)
end

function EquipmentAgent:sendEQM_BatchBreakoutReq(infoList)
	local req = EquipmentExtension_pb.EQM_BatchBreakoutReq()

	for i, v in ipairs(infoList) do
		local info = req.infoList:add()

		info:ParseFromString(v:SerializeToString())
	end

	self:sendMsg(req)
end

function EquipmentAgent:handleEQM_BatchBreakoutRes(status, msg)
	if status == 0 then
		PetEquipController.instance:handleEQM_BatchBreakoutRes(msg)
	end
end

function EquipmentAgent:sendEQM_SetAutoDecomposeReq(quality)
	local req = EquipmentExtension_pb.EQM_SetAutoDecomposeReq()

	req.quality = quality
	PetEquipModel.instance.equipRecycleQua = quality

	self:sendMsg(req)
end

function EquipmentAgent:handleEQM_SetAutoDecomposeRes(status, msg)
	if status == 0 then
		PetEquipController.instance:_updateEquipRecycleRed()
	end
end

EquipmentAgent.instance = EquipmentAgent.New()

return EquipmentAgent
