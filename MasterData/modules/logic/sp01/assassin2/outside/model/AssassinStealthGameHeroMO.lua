-- chunkname: @modules/logic/sp01/assassin2/outside/model/AssassinStealthGameHeroMO.lua

module("modules.logic.sp01.assassin2.outside.model.AssassinStealthGameHeroMO", package.seeall)

local AssassinStealthGameHeroMO = class("AssassinStealthGameHeroMO")

function AssassinStealthGameHeroMO:updateData(heroData)
	self.uid = heroData.uid
	self.heroId = heroData.heroId
	self.careerId = heroData.careerId
	self.hp = heroData.hp
	self.isDead = heroData.isDead
	self.actionPoint = heroData.actionPoint

	self:setItemByList(heroData.items)
	self:setBuffByList(heroData.buffs)

	self.gridId = heroData.gridId
	self.pos = heroData.pos
	self.maxActionPoint = heroData.maxActionPoint
	self.isStealth = heroData.state

	self:setSkillUseCount(heroData.roundSkillCounts, heroData.totalSkillCounts)
	self:setItemUseCount(heroData.roundItemCounts)
end

function AssassinStealthGameHeroMO:setItemByList(itemDataList)
	self._carryItemDict = {}

	for _, itemData in ipairs(itemDataList) do
		local itemMo = AssassinItemMO.New(itemData)
		local itemId = itemMo:getId()

		self._carryItemDict[itemId] = itemMo
	end
end

function AssassinStealthGameHeroMO:AddItem(itemId, count)
	local itemMo = self:getItemMo(itemId)

	if itemMo then
		itemMo:addCount(count)
	else
		itemMo = AssassinItemMO.New({
			itemId = itemId,
			count = count
		})
		self._carryItemDict[itemId] = itemMo
	end
end

function AssassinStealthGameHeroMO:setBuffByList(buffDataList)
	self._buffDict = {}

	for _, buffData in ipairs(buffDataList) do
		self._buffDict[buffData.id] = buffData.duration
	end
end

function AssassinStealthGameHeroMO:setSkillUseCount(roundUse, totalUse)
	self._skillRoundUseCountDict = {}

	for _, data in ipairs(roundUse) do
		self._skillRoundUseCountDict[data.key] = data.value
	end

	self._skillTotalUseCountDict = {}

	for _, data in ipairs(totalUse) do
		self._skillTotalUseCountDict[data.key] = data.value
	end
end

function AssassinStealthGameHeroMO:setItemUseCount(roundUse)
	self._itemRoundUseCountDict = {}

	for _, data in ipairs(roundUse) do
		self._itemRoundUseCountDict[data.key] = data.value
	end
end

function AssassinStealthGameHeroMO:getUid()
	return self.uid
end

function AssassinStealthGameHeroMO:getHeroId()
	return self.heroId
end

function AssassinStealthGameHeroMO:getCareerId()
	return self.careerId
end

function AssassinStealthGameHeroMO:getActionPoint()
	return self.actionPoint
end

function AssassinStealthGameHeroMO:getMaxActionPoint()
	return self.maxActionPoint
end

function AssassinStealthGameHeroMO:getStatus()
	local result = AssassinEnum.HeroStatus.Stealth

	if self.isDead ~= 0 then
		result = AssassinEnum.HeroStatus.Dead
	elseif self.isStealth ~= 0 then
		result = AssassinEnum.HeroStatus.Expose
	else
		local mapId = AssassinStealthGameModel.instance:getMapId()
		local curGridId, curPointIndex = self:getPos()
		local pointType = AssassinConfig.instance:getGridPointType(mapId, curGridId, curPointIndex)

		if pointType == AssassinEnum.StealthGamePointType.HayStack or pointType == AssassinEnum.StealthGamePointType.Garden then
			result = AssassinEnum.HeroStatus.Hide
		end
	end

	return result
end

function AssassinStealthGameHeroMO:getHp()
	return self.hp or 0
end

function AssassinStealthGameHeroMO:getPos()
	return self.gridId, self.pos
end

function AssassinStealthGameHeroMO:getActiveSkillId()
	local heroId = self:getHeroId()
	local careerId = self:getCareerId()
	local skillId = AssassinConfig.instance:getAssassinActiveSkillIdByHeroCareer(heroId, careerId)

	if skillId then
		::label_15_0::

		local isStealthGameSkill = AssassinConfig.instance:getIsStealthGameSkill(skillId)

		if isStealthGameSkill then
			return skillId
		end
	end
end

function AssassinStealthGameHeroMO:getItemMo(itemId, nilError)
	local result = self._carryItemDict[itemId]

	if not result and nilError then
		logError(string.format("AssassinStealthGameHeroMO:getItemMo error, itemMo is nil, heroUid:%s, itemId:%s", self.uid, itemId))
	end

	return result
end

function AssassinStealthGameHeroMO:getItemIdList()
	local result = {}

	for itemId, itemMo in pairs(self._carryItemDict) do
		local count = itemMo:getCount()

		if count > 0 then
			result[#result + 1] = itemId
		end
	end

	return result
end

function AssassinStealthGameHeroMO:getItemCount(itemId)
	local itemMo = self:getItemMo(itemId)

	return (itemMo or nil) and itemMo:getCount()
end

function AssassinStealthGameHeroMO:hasSkillProp(skillPropId, isSkill, nilError)
	local result = false

	if isSkill then
		local skillId = self:getActiveSkillId()

		result = skillId and skillId == skillPropId
	else
		local count = self:getItemCount(skillPropId)

		result = count > 0
	end

	if not result and nilError then
		string.format("hero not has skill prop, heroUid:%s, skillPropId:%s, isSkill:%s", self.uid, skillPropId, isSkill)
	end

	return true
end

function AssassinStealthGameHeroMO:getSkillPropRoundUseCount(skillPropId, isSkill)
	return isSkill and (self._skillRoundUseCountDict[skillPropId] or 0) or self._itemRoundUseCountDict[skillPropId] or 0
end

function AssassinStealthGameHeroMO:getSkillPropTotalUseCount(skillPropId, isSkill)
	return (isSkill or nil) and (self._skillTotalUseCountDict[skillPropId] or 0)
end

return AssassinStealthGameHeroMO
