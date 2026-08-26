-- chunkname: @modules/logic/sp01/assassin2/outside/model/AssassinHeroMO.lua

module("modules.logic.sp01.assassin2.outside.model.AssassinHeroMO", package.seeall)

local AssassinHeroMO = class("AssassinHeroMO")

function AssassinHeroMO:ctor(assassinHeroId)
	self.id = assassinHeroId
	self.careerId = nil
	self.carryItemDict = {}
	self.hasServerInfo = false

	local trialId = AssassinConfig.instance:getAssassinHeroTrialId(self.id)

	self.heroMo = HeroMo.New()

	self.heroMo:initFromTrial(trialId)

	local playerHeroMo = HeroModel.instance:getByHeroId(self.heroMo.heroId)
	local assassinHeroSkillLv = self.heroMo.exSkillLevel

	self.heroMo.exSkillLevel = math.max((playerHeroMo or nil) and playerHeroMo.exSkillLevel, assassinHeroSkillLv)
end

function AssassinHeroMO:updateServerInfo(serverInfo)
	if not serverInfo or serverInfo.heroId ~= self.id then
		return
	end

	self.careerId = serverInfo.careerId

	self:updateCarryItemList(serverInfo.itemList)

	self.hasServerInfo = true
end

function AssassinHeroMO:updateCarryItemList(itemList)
	self.carryItemDict = {}

	for _, itemData in ipairs(itemList) do
		self.carryItemDict[itemData.index] = itemData.itemType
	end
end

function AssassinHeroMO:getAssassinHeroId()
	return self.id
end

function AssassinHeroMO:getHeroMo()
	return self.heroMo
end

function AssassinHeroMO:getHeroId()
	return self.heroMo.heroId
end

function AssassinHeroMO:getAssassinHeroName()
	local nameCN = self.heroMo:getHeroName() or ""

	if not self.heroMo.config.nameEng then
		local nameEN = ""

		return nameCN, nameEN
	end
end

function AssassinHeroMO:getAssassinHeroSkin()
	local playerHeroMo = HeroModel.instance:getByHeroId(self.heroMo.heroId)

	return (playerHeroMo or nil) and playerHeroMo.skin
end

function AssassinHeroMO:getAssassinHeroShowLevel()
	if not self.heroMo.level then
		local level = 0
		local showLevel, rank = HeroConfig.instance:getShowLevel(level)

		return showLevel, rank
	end
end

function AssassinHeroMO:getAssassinHeroSkillLevel()
	return self.heroMo.exSkillLevel
end

function AssassinHeroMO:getAssassinHeroEquipMo()
	return self.heroMo:getTrialEquipMo()
end

function AssassinHeroMO:getAssassinHeroCommonCareer()
	return self.heroMo.config.career
end

function AssassinHeroMO:getAssassinHeroAttributeList()
	local result = {}
	local attrDict = {}
	local trialEquipMo = self.heroMo:getTrialEquipMo()
	local trialEquipUid = trialEquipMo.uid
	local equipMO = HeroGroupTrialModel.instance:getEquipMo(trialEquipUid)

	attrDict = equipMO and self.heroMo:getTotalBaseAttrDict({
		trialEquipUid
	}) or self.heroMo:getTotalBaseAttrDict({
		trialEquipUid
	}, nil, nil, nil, trialEquipMo)

	for _, attrId in ipairs(CharacterEnum.BaseAttrIdList) do
		local attrData = {}

		attrData.id = attrId
		attrData.value = attrDict[attrId] or 0
		result[#result + 1] = attrData
	end

	return result
end

function AssassinHeroMO:getAssassinCareerId()
	return self.careerId
end

function AssassinHeroMO:getCarryItemId(index)
	local itemType = self.carryItemDict[index]

	return (AssassinItemModel.instance:getItemIdByItemType(itemType))
end

function AssassinHeroMO:getItemCarryIndex(targetItemId)
	for index, itemType in pairs(self.carryItemDict) do
		local itemId = AssassinItemModel.instance:getItemIdByItemType(itemType)

		if targetItemId == itemId then
			return index
		end
	end
end

function AssassinHeroMO:isCarryItemFull()
	local careerId = self:getAssassinCareerId()
	local bagCapacity = AssassinConfig.instance:getAssassinCareerCapacity(careerId)
	local curEquipCount = 0

	for _, _ in pairs(self.carryItemDict) do
		curEquipCount = curEquipCount + 1
	end

	return bagCapacity <= curEquipCount
end

function AssassinHeroMO:findEmptyItemGridIndex()
	local result
	local careerId = self:getAssassinCareerId()
	local bagCapacity = AssassinConfig.instance:getAssassinCareerCapacity(careerId)

	for index = 1, bagCapacity do
		local itemType = self.carryItemDict[index]

		if not itemType then
			result = index

			break
		end
	end

	return result
end

function AssassinHeroMO:isUnlocked()
	return self.hasServerInfo
end

return AssassinHeroMO
