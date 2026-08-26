-- chunkname: @modules/logic/versionactivity3_3/arcade/model/game/entity/ArcadeGameCollectionMO.lua

module("modules.logic.versionactivity3_3.arcade.model.game.entity.ArcadeGameCollectionMO", package.seeall)

local ArcadeGameCollectionMO = class("ArcadeGameCollectionMO")

function ArcadeGameCollectionMO:ctor(uid, id, usedTimes, durability)
	self.uid = uid
	self.id = id
	self._skillSetMO = ArcadeGameSkillSetMO.New(uid, self)
	self._usedTimes = usedTimes or 0

	local var_1_0

	if not durability then
		::label_1_0::

		var_1_0 = ArcadeConfig.instance:getCollectionDurability(self.id)
		var_1_0 = var_1_0 or 0
	end

	self._totalDurability = var_1_0

	local skillList = ArcadeConfig.instance:getCollectionPassiveSkillList(self.id)

	for _, skillId in ipairs(skillList) do
		self._skillSetMO:addSkillById(skillId)
	end
end

function ArcadeGameCollectionMO:getUid()
	return self.uid
end

function ArcadeGameCollectionMO:getId()
	return self.id
end

function ArcadeGameCollectionMO:getType()
	return ArcadeConfig.instance:getCollectionType(self.id)
end

function ArcadeGameCollectionMO:getHasDurabilityValue()
	local type = self:getType()
	local cfgDurability = ArcadeConfig.instance:getCollectionDurability(self.id) or 0

	return type == ArcadeGameEnum.CollectionType.Weapon and cfgDurability > 0
end

function ArcadeGameCollectionMO:getSkillSetMO()
	return self._skillSetMO
end

function ArcadeGameCollectionMO:getUsedTimes()
	return self._usedTimes
end

function ArcadeGameCollectionMO:getTotalDurability()
	return self._totalDurability
end

function ArcadeGameCollectionMO:getRemainDurability()
	local result = 0
	local hasDurabilityValue = self:getHasDurabilityValue()

	if hasDurabilityValue then
		local useTimes = self:getUsedTimes()

		result = math.max(0, self._totalDurability - useTimes)
	end

	return result
end

function ArcadeGameCollectionMO:addDurability(value)
	local hasDurabilityValue = self:getHasDurabilityValue()

	if hasDurabilityValue then
		self._totalDurability = math.max(0, self._totalDurability + tonumber(value))
	end
end

function ArcadeGameCollectionMO:addUsedTimes(value)
	local hasDurabilityValue = self:getHasDurabilityValue()

	if hasDurabilityValue then
		self._usedTimes = math.max(0, self._usedTimes + tonumber(value))
		self._usedTimes = math.min(self._totalDurability, self._usedTimes)
	end
end

function ArcadeGameCollectionMO:getIsCollection()
	return true
end

return ArcadeGameCollectionMO
