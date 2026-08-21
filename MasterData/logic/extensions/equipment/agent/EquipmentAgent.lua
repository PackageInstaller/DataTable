-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/agent/EquipmentAgent.lua

module("logic.extensions.equipment.agent.EquipmentAgent", package.seeall)

local M = class("EquipmentAgent", BaseAgent)

function M:ctor()
	M.super.ctor(self)
end

function M:sendEquipWearRequest(heroId, equipUuids)
	local req = EquipmentExtension_pb.EquipWearRequest()

	req.heroId = heroId

	for i, equipUuid in ipairs(equipUuids) do
		table.insert(req.equipUuids, equipUuid)
	end

	self:invoke({
		funcName = "handleEquipWearReply",
		sendData = req,
		handleCall = function(status, msg)
			if status == 0 then
				for i = 1, #equipUuids do
					local equip = ItemModel.instance:getItemDataByUuid(equipUuids[i])

					if equip then
						FloatWordMgr.instance:show(langF("tip_wear_success", equip:getName()))
					end
				end

				GlobalDispatcher:dispatchEvent(EventType.EQUIP_WEARED_SUCCESS)
			end
		end
	})
end

function M:sendEquipTakeOffRequest(equipUuids)
	local msg = EquipmentExtension_pb.EquipTakeOffRequest()

	for i, equipUuid in ipairs(equipUuids) do
		table.insert(msg.equipUuids, equipUuid)
	end

	self:sendMsg(msg)
end

function M:handleEquipTakeOffReply(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatchEvent(EventType.EQUIP_TAKE_OFF_SUCCESS)
	end
end

function M:sendEquipStrengthenRequest(equipUuid, costMaterials, costEquipUuids, costDiceUuids)
	local req = EquipmentExtension_pb.EquipStrengthenRequest()

	req.equipUuid = equipUuid

	for code, num in pairs(costMaterials) do
		local cost = EquipmentExtension_pb.CostNO()

		cost.code = code
		cost.num = num

		table.insert(req.costMaterials, cost)
	end

	for _, equipUuid in ipairs(costEquipUuids) do
		table.insert(req.costEquipUuids, equipUuid)
	end

	for _, diceUuid in ipairs(costDiceUuids) do
		table.insert(req.costDiceUuids, diceUuid)
	end

	self:invoke({
		funcName = "handleEquipStrengthenReply",
		sendData = req,
		handleCall = function(status, msg)
			if status == 0 then
				GlobalDispatcher:dispatchEvent(EventType.EQUIP_LV_UP_SUCESS, equipUuid)
			end
		end
	})
end

function M:sendEquipDecomposeRequest(equipUuids, BackpackShowType)
	local msg = EquipmentExtension_pb.EquipDecomposeRequest()

	for _, equipUuid in ipairs(equipUuids) do
		table.insert(msg.equipUuids, equipUuid)
	end

	self:invoke({
		funcName = "handleEquipDecomposeReply",
		sendData = msg,
		handleCall = function(status, msg)
			if status == 0 then
				if BackpackShowType then
					GlobalDispatcher:dispatchEvent(EventType.BACKPACK_PAGE_RECYCLE_REPLY, CommEnum.MainBackpackShowType.EquipShowType)
				else
					GlobalDispatcher:dispatchEvent(EventType.EQUIP_INTENCIFY_RECYCLE_REPLY)
				end
			end
		end
	})
end

function M:handleEquipDecomposeReply(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatchEvent(EventType.BACKPACK_PAGE_RECYCLE_REPLY, CommEnum.MainBackpackShowType.EquipShowType)
	end
end

function M:sendDiceDecomposeRequest(d6Uuids)
	local msg = EquipmentExtension_pb.DiceDecomposeRequest()

	for _, uuid in ipairs(d6Uuids) do
		table.insert(msg.diceUuids, uuid)
	end

	self:sendMsg(msg)
end

function M:handleDiceDecomposeReply(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatchEvent(EventType.BACKPACK_PAGE_RECYCLE_REPLY, CommEnum.MainBackpackShowType.D6ShowType)
	end
end

function M:sendDiceRollRequest(equipUuid, diceUuid, effectIndex)
	local msg = EquipmentExtension_pb.DiceRollRequest()

	msg.equipUuid = equipUuid
	msg.diceUuid = diceUuid
	msg.effectIndex = effectIndex

	self:sendMsg(msg)
end

function M:handleDiceRollReply(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatchEvent(EventType.EQUIP_TIMING_RESULT)
	end
end

function M:sendDiceReRollRequest(equipUuid, effectIndex)
	local msg = EquipmentExtension_pb.DiceReRollRequest()

	msg.equipUuid = equipUuid
	msg.effectIndex = effectIndex

	self:sendMsg(msg)
end

function M:handleDiceReRollReply(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatchEvent(EventType.EQUIP_RETIMING_RESULT)
	end
end

function M:sendEquipLockToggleRequest(equipUuid)
	local msg = EquipmentExtension_pb.EquipLockToggleRequest()

	msg.equipUuid = equipUuid

	self:sendMsg(msg)
end

function M:handleEquipLockToggleReply(status, msg)
	if status == 0 then
		-- block empty
	end
end

function M:sendDiceLockToggleRequest(diceUuid)
	local msg = EquipmentExtension_pb.DiceLockToggleRequest()

	msg.diceUuid = diceUuid

	self:sendMsg(msg)
end

function M:handleDiceLockToggleReply(status, msg)
	if status == 0 then
		-- block empty
	end
end

function M:handleEquipChangePush(status, msg)
	if status == 0 then
		local infos = msg.infos

		EquipController.instance:refreshEquipInfo(infos)
	end
end

function M:handleDiceChangePush(status, msg)
	if status == 0 then
		local infos = msg.infos

		EquipController.instance:refreshD6Info(infos)
	end
end

function M:sendEquipDiscardToggleRequest(equipUuid)
	local msg = EquipmentExtension_pb.EquipDiscardToggleRequest()

	msg.equipUuid = equipUuid

	self:sendMsg(msg)
end

function M:handleEquipDiscardToggleReply(status, msg)
	if status == 0 then
		-- block empty
	end
end

function M:sendDiceDiscardToggleRequest(diceUuid)
	local msg = EquipmentExtension_pb.DiceDiscardToggleRequest()

	msg.diceUuid = diceUuid

	self:sendMsg(msg)
end

function M:handleDiceDiscardToggleReply(status, msg)
	if status == 0 then
		-- block empty
	end
end

M.instance = M.New()

return M
