-- chunkname: @modules/logic/sp02/atomic/model/AtomicTalentMO.lua

module("modules.logic.sp02.atomic.model.AtomicTalentMO", package.seeall)

local AtomicTalentMO = pureTable("AtomicTalentMO")

function AtomicTalentMO:init()
	self.unlockDict = {}
	self.equipDict = {}
	self.unlockBranchDict = {}
	self.slotCount = AtomicConfig.instance:getConstValue(AtomicEnum.ConstId.TalentSlotCount, true)
end

function AtomicTalentMO:updateInfo(info)
	self.unlockDict = {}

	for i = 1, #info.unlockNodeIds do
		self:unlockTalent(info.unlockNodeIds[i])
	end

	self:updateEquipList(info.skillNodeIds)
	self:updateBranchList(info.unlockBranchIds)
end

function AtomicTalentMO:unlockTalent(nodeId)
	self.unlockDict[nodeId] = true
end

function AtomicTalentMO:updateEquipList(list)
	self.equipDict = {}

	for i = 1, #list do
		local nodeId = list[i]

		self.equipDict[nodeId] = i
	end
end

function AtomicTalentMO:updateBranchList(list)
	self.unlockBranchDict = {}

	for i = 1, #list do
		local branchId = list[i]

		self.unlockBranchDict[branchId] = i
	end
end

function AtomicTalentMO:isTalentUnlocked(nodeId)
	return self.unlockDict[nodeId] ~= nil
end

function AtomicTalentMO:isTalentEquipped(nodeId)
	local index = self.equipDict[nodeId]

	return index ~= nil, index
end

function AtomicTalentMO:getEquipTalentByIndex(index)
	for nodeId, idx in pairs(self.equipDict) do
		if idx == index then
			return nodeId
		end
	end

	return nil
end

function AtomicTalentMO:getEquipList()
	local list = {}

	for i = 1, self.slotCount do
		local nodeId = self:getEquipTalentByIndex(i)

		table.insert(list, nodeId or 0)
	end

	return list
end

function AtomicTalentMO:isBranchUnlocked(branchId)
	return self.unlockBranchDict[branchId] ~= nil
end

function AtomicTalentMO:getEmptyOrDefaultSlot()
	for i = 1, self.slotCount do
		local nodeId = self:getEquipTalentByIndex(i)

		if nodeId == nil then
			return i
		end
	end

	return self.slotCount, true
end

return AtomicTalentMO
