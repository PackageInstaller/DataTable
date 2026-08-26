-- chunkname: @modules/logic/survival/model/shelter/SurvivalEquipBoxMo.lua

module("modules.logic.survival.model.shelter.SurvivalEquipBoxMo", package.seeall)

local SurvivalEquipBoxMo = pureTable("SurvivalEquipBoxMo")

function SurvivalEquipBoxMo:init(data)
	self.currPlanId = data.currPlanId
	self.maxTagId = data.maxTagId
	self.slots = {}

	for _, v in ipairs(data.slots) do
		local slotMo = SurvivalEquipSlotMo.New()

		slotMo:init(v, self)

		self.slots[slotMo.slotId] = slotMo
	end

	self.jewelrySlots = {}

	for _, v in ipairs(data.jewelrySlots) do
		local slotMo = SurvivalEquipSlotMo.New()

		slotMo:init(v, self)

		self.jewelrySlots[slotMo.slotId] = slotMo
	end

	self:calcAttrs()
end

function SurvivalEquipBoxMo:calcAttrs()
	self.values = {}

	for _, slotMO in pairs(self.slots) do
		for k, v in pairs(slotMO.values) do
			self.values[k] = self.values[k] and self.values[k] + v or v
		end
	end

	for _, slotMO in pairs(self.jewelrySlots) do
		for k, v in pairs(slotMO.values) do
			self.values[k] = self.values[k] and self.values[k] + v or v
		end
	end
end

function SurvivalEquipBoxMo:getAllScore()
	local value = 0

	for _, slotMO in pairs(self.slots) do
		value = value + slotMO:getScore()
	end

	for _, slotMO in pairs(self.jewelrySlots) do
		value = value + slotMO:getScore()
	end

	return value
end

return SurvivalEquipBoxMo
