-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/starequipment/agent/StarEquipmentAgent.lua

module("logic.extensions.starequipment.agent.StarEquipmentAgent", package.seeall)

local StarEquipmentAgent = class("StarEquipmentAgent", BaseAgent)

StarEquipmentAgent.SE_EquipRes = "StarEquipmentAgent_SE_EquipRes"
StarEquipmentAgent.SE_UpgradeRes = "StarEquipmentAgent_SE_UpgradeRes"
StarEquipmentAgent.SE_SwitchRes = "StarEquipmentAgent_SE_SwitchRes"
StarEquipmentAgent.SE_BreakThroughRes = "StarEquipmentAgent_SE_BreakThroughRes"
StarEquipmentAgent.SE_GetSettingsRes = "StarEquipmentAgent_SE_GetSettingsRes"
StarEquipmentAgent.SE_SaveSettingsReq = "StarEquipmentAgent_SE_SaveSettingsReq"
StarEquipmentAgent.SE_BatchEquipRes = "StarEquipmentAgent_SE_BatchEquipRes"
StarEquipmentAgent.SE_StarLevelUpRes = "StarEquipmentAgent_SE_StarLevelUpRes"

function StarEquipmentAgent:ctor()
	return
end

function StarEquipmentAgent:setExtId(extId)
	StarEquipmentAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function StarEquipmentAgent:sendSE_EquipReq(petId, index, equipmentId, handler, handlerObj, errHandler)
	local req = StarEquipmentExtension_pb.SE_EquipReq()

	req.petId = petId
	req.index = index
	req.equipmentId = equipmentId

	self:sendMsg(req)
	self:addEventOnce(StarEquipmentAgent.SE_EquipRes, handler, handlerObj, errHandler)
end

function StarEquipmentAgent:handleSE_EquipRes(status, msg)
	self:dispatch(StarEquipmentAgent.SE_EquipRes, status, msg)
end

function StarEquipmentAgent:sendSE_UpgradeReq(petId, index, equipmentId, commonMaterialCount, otherEquipments_pb_Ary, handler, handlerObj, errHandler)
	local req = StarEquipmentExtension_pb.SE_UpgradeReq()

	req.petId = petId
	req.index = index
	req.equipmentId = equipmentId
	req.commonMaterialCount = commonMaterialCount

	for i, v1 in ipairs(otherEquipments_pb_Ary) do
		local otherEquipments = req.otherEquipments:add()

		otherEquipments:ParseFromString(v1:SerializeToString())
	end

	self:sendMsg(req)
	self:addEventOnce(StarEquipmentAgent.SE_UpgradeRes, handler, handlerObj, errHandler)
end

function StarEquipmentAgent:handleSE_UpgradeRes(status, msg)
	self:dispatch(StarEquipmentAgent.SE_UpgradeRes, status, msg)
end

function StarEquipmentAgent:sendSE_SwitchReq(petId, index, equipmentId, handler, handlerObj, errHandler)
	local req = StarEquipmentExtension_pb.SE_SwitchReq()

	req.petId = petId
	req.index = index
	req.equipmentId = equipmentId

	self:sendMsg(req)
	self:addEventOnce(StarEquipmentAgent.SE_SwitchRes, handler, handlerObj, errHandler)
end

function StarEquipmentAgent:handleSE_SwitchRes(status, msg)
	self:dispatch(StarEquipmentAgent.SE_SwitchRes, status, msg)
end

function StarEquipmentAgent:sendSE_BreakThroughReq(petId, index, equipmentId, handler, handlerObj, errHandler)
	local req = StarEquipmentExtension_pb.SE_BreakThroughReq()

	req.petId = petId
	req.index = index
	req.equipmentId = equipmentId

	self:sendMsg(req)
	self:addEventOnce(StarEquipmentAgent.SE_BreakThroughRes, handler, handlerObj, errHandler)
end

function StarEquipmentAgent:handleSE_BreakThroughRes(status, msg)
	self:dispatch(StarEquipmentAgent.SE_BreakThroughRes, status, msg)
end

function StarEquipmentAgent:sendSE_GetSettingsReq(handler, handlerObj, errHandler)
	local req = StarEquipmentExtension_pb.SE_GetSettingsReq()

	self:sendMsg(req)
	self:addEventOnce(StarEquipmentAgent.SE_GetSettingsRes, handler, handlerObj, errHandler)
end

function StarEquipmentAgent:handleSE_GetSettingsRes(status, msg)
	self:dispatch(StarEquipmentAgent.SE_GetSettingsRes, status, msg)
end

function StarEquipmentAgent:sendSE_SaveSettingsReq(autoSelectBit, handler, handlerObj, errHandler)
	local req = StarEquipmentExtension_pb.SE_SaveSettingsReq()

	req.autoSelectBit = autoSelectBit

	self:sendMsg(req)
	self:addEventOnce(StarEquipmentAgent.SE_SaveSettingsReq, handler, handlerObj, errHandler)
end

function StarEquipmentAgent:handleSE_SaveSettingsReq(status, msg)
	self:dispatch(StarEquipmentAgent.SE_SaveSettingsReq, status, msg)
end

function StarEquipmentAgent:sendSE_BatchEquipReq(petId, equipmentIds_i32_Ary, handler, handlerObj, errHandler)
	local req = StarEquipmentExtension_pb.SE_BatchEquipReq()

	req.petId = petId

	for i, v2 in ipairs(equipmentIds_i32_Ary) do
		req.equipmentIds:append(v2)
	end

	self:sendMsg(req)
	self:addEventOnce(StarEquipmentAgent.SE_BatchEquipRes, handler, handlerObj, errHandler)
end

function StarEquipmentAgent:handleSE_BatchEquipRes(status, msg)
	self:dispatch(StarEquipmentAgent.SE_BatchEquipRes, status, msg)
end

function StarEquipmentAgent:sendSE_StarLevelUpReq(petId, handler, handlerObj, errHandler)
	local req = StarEquipmentExtension_pb.SE_StarLevelUpReq()

	req.petId = petId

	self:sendMsg(req)
	self:addEventOnce(StarEquipmentAgent.SE_StarLevelUpRes, handler, handlerObj, errHandler)
end

function StarEquipmentAgent:handleSE_StarLevelUpRes(status, msg)
	self:dispatch(StarEquipmentAgent.SE_StarLevelUpRes, status, msg)
end

StarEquipmentAgent.instance = StarEquipmentAgent.New()

return StarEquipmentAgent
