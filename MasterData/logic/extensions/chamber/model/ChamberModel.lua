-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chamber/model/ChamberModel.lua

module("logic.extensions.chamber.model.ChamberModel", package.seeall)

local M = class("ChamberModel", BaseModel)

M.MAX_SLOT_NUM = 6

function M:onInit()
	self._isClockOpen = false
	self._selectedIdx = 0
	self._dictSlot = {}

	for i = 1, self.MAX_SLOT_NUM do
		self._dictSlot[i] = ChamberSlotMO.New(i)
	end
end

function M:onReset()
	self._isClockOpen = false
	self._selectedIdx = 0

	for _, mo in pairs(self._dictSlot) do
		mo:clear()
	end
end

function M:updateAllSlotByAgent(msg)
	if msg.slots then
		for _, slot in ipairs(msg.slots) do
			self:mountSlot(slot.slotId, slot.uuid)

			local mo = self:getSlot(slot.slotId)

			mo:setCount(slot.count)
		end
	end
end

function M:mountSlot(idx, uuid)
	if checknumber(uuid) > 0 then
		local mo = self:getSlot(idx)

		mo:setItemUUID(uuid)
	end
end

function M:unmountSlot(idx)
	local mo = self:getSlot(idx)

	mo:setItemUUID(nil)
end

function M:getSlot(idx)
	return self._dictSlot[idx]
end

function M:geSlotList()
	return self._dictSlot
end

function M:isItemInSlot(uuid)
	local isUsed = false
	local idx = 0

	for i, slotMO in pairs(self._dictSlot) do
		if checknumber(slotMO:getItemUUID()) == tonumber(uuid) then
			isUsed = true
			idx = i

			break
		end
	end

	return isUsed, idx
end

function M:getAllEntrys()
	local entrys = {}

	for i, slotMO in pairs(self._dictSlot) do
		if slotMO:getItemUUID() then
			local COs = slotMO:getEntrys()

			table.insertto(entrys, COs)
		end
	end

	table.sort(entrys, function(coA, coB)
		if coA:getPN() ~= coB:getPN() then
			return coA:getPN() > coB:getPN()
		end

		return coA:getId() < coB:getId()
	end)

	return entrys
end

function M:getUsedSlotUUIdsInBattle(dungeonType)
	local uuIds = {}
	local dic = self:geSlotList()

	for k, slot in pairs(dic) do
		if slot:getItemUUID() then
			local uuid = slot:getItemUUID()
			local itemData = ItemModel.instance:getItemDataByUuid(tostring(uuid))

			if itemData then
				local cfg = itemData:getItemInfo()

				if self:_isItemActiveInLevel(cfg, dungeonType) then
					local entryCOs = ChamberConfig.instance:getItemEntrysByUuid(uuid)

					for i, entryCO in ipairs(entryCOs) do
						if entryCO:isSkillAdd() then
							table.insert(uuIds, uuid)

							break
						end
					end
				end
			end
		end
	end

	return uuIds
end

function M:_isItemActiveInLevel(cfg, dungeonType)
	local dungeonTypeList = cfg.dungeonType

	if not dungeonTypeList then
		return true
	end

	for i, tType in ipairs(dungeonTypeList) do
		if tType == dungeonType then
			return true
		end
	end

	return false
end

function M:setAnimState(state)
	self._curAnimState = state
end

function M:getAnimState()
	return self._curAnimState
end

function M:setIsClockOpen(isClockOpen)
	self._isClockOpen = isClockOpen
end

function M:isClockOpen()
	return self._isClockOpen
end

function M:setSelectedIdx(selectedIdx)
	self._selectedIdx = selectedIdx
end

function M:getSelectedIdx()
	return self._selectedIdx
end

M.instance = M.New()

return M
