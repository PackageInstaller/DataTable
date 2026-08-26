-- chunkname: @modules/logic/character/model/HeroDestinyStoneMO.lua

module("modules.logic.character.model.HeroDestinyStoneMO", package.seeall)

local HeroDestinyStoneMO = class("HeroDestinyStoneMO")

function HeroDestinyStoneMO:ctor(heroId)
	self.rank = 0
	self.level = 0
	self.curUseStoneId = 0
	self.unlockStoneIds = nil
	self.stoneMoList = nil
	self.upStoneId = nil
	self.heroId = heroId
	self.maxRank = 0
	self.maxLevel = {}

	local slotCos = CharacterDestinyConfig.instance:getDestinySlotCosByHeroId(heroId)

	if slotCos then
		for rank, cos in ipairs(slotCos) do
			self.maxRank = math.max(rank, self.maxRank)
			self.maxLevel[rank] = tabletool.len(cos)
		end
	end
end

function HeroDestinyStoneMO:refreshMo(rank, level, curUseStoneId, unlockStoneIds)
	self.rank = rank
	self.level = level
	self.curUseStoneId = curUseStoneId
	self.unlockStoneIds = unlockStoneIds or {}

	self:setStoneMo()
end

function HeroDestinyStoneMO:isUnlockSlot()
	return self.rank > 0
end

function HeroDestinyStoneMO:isCanUpSlotRank()
	local nextCo = self:getNextDestinySlotCo()

	return nextCo and nextCo.node == 1
end

function HeroDestinyStoneMO:isSlotMaxLevel()
	local nextCo = self:getNextDestinySlotCo()

	return not nextCo
end

function HeroDestinyStoneMO:isAllFacetUnlock()
	if not self.stoneMoList then
		return false
	end

	for _, mo in pairs(self.stoneMoList) do
		if not mo.isUnlock then
			return false
		end
	end

	return true
end

function HeroDestinyStoneMO:setUpStoneId(stoneId)
	self.upStoneId = stoneId
end

function HeroDestinyStoneMO:getUpStoneId()
	return self.upStoneId
end

function HeroDestinyStoneMO:clearUpStoneId()
	self.upStoneId = nil
end

function HeroDestinyStoneMO:checkAllUnlock()
	return self:isSlotMaxLevel() and self:isAllFacetUnlock()
end

function HeroDestinyStoneMO:setStoneMo()
	local _facetIds = CharacterDestinyConfig.instance:getFacetIdsByHeroId(self.heroId)

	self.stoneMoList = self.stoneMoList or {}

	if _facetIds then
		for _, stoneId in ipairs(_facetIds) do
			local mo = self.stoneMoList[stoneId]

			if not mo then
				mo = DestinyStoneMO.New()

				mo:initMo(stoneId)

				self.stoneMoList[stoneId] = mo
			end

			mo:refresUnlock(LuaUtil.tableContains(self.unlockStoneIds, stoneId))
			mo:refreshUse(stoneId == self.curUseStoneId)
		end
	end
end

function HeroDestinyStoneMO:getStoneMoList()
	return self.stoneMoList and self.stoneMoList
end

function HeroDestinyStoneMO:getStoneMo(stoneId)
	return self.stoneMoList and self.stoneMoList[stoneId]
end

function HeroDestinyStoneMO:refreshUseStone()
	for stoneId, mo in pairs(self.stoneMoList) do
		mo:refreshUse(stoneId == self.curUseStoneId)
	end
end

function HeroDestinyStoneMO:getCurUseStoneCo()
	if self.curUseStoneId ~= 0 then
		return CharacterDestinyConfig.instance:getDestinyFacets(self.curUseStoneId, self.rank)
	end
end

function HeroDestinyStoneMO:getCurUseStoneMo()
	if self.curUseStoneId ~= 0 then
		return (self:getStoneMo(self.curUseStoneId))
	end
end

function HeroDestinyStoneMO:getAddAttrValues()
	return (self:getAddAttrValueByLevel(self.rank, self.level))
end

function HeroDestinyStoneMO:getAddAttrValueByLevel(rank, level)
	return (CharacterDestinyConfig.instance:getCurDestinySlotAddAttr(self.heroId, rank, level))
end

function HeroDestinyStoneMO:getAddValueByAttrId(addValues, attrId, heroMo)
	addValues = addValues or self:getAddAttrValues()

	local num = addValues[attrId]

	if not num then
		local attrIds = CharacterDestinyEnum.DestinyUpBaseParseAttr[attrId]

		if attrIds then
			local _attrId = attrIds[1]

			if _attrId then
				num = addValues[_attrId] or 0

				local percentValue = self:getPercentAddValueByAttrId(addValues, attrId, heroMo) or 0

				num = num + percentValue

				return num
			end
		end
	else
		return num
	end

	return 0
end

function HeroDestinyStoneMO:getPercentAddValueByAttrId(addValues, attrId, heroMo)
	addValues = addValues or self:getAddAttrValues()

	if not heroMo then
		heroMo = HeroModel.instance:getById(self.heroId)

		if not heroMo then
			return 0
		end
	end

	local baseAttrDict = heroMo:getHeroBaseAttrDict()

	if not baseAttrDict[attrId] then
		local baseValue = 0
		local attrIds = CharacterDestinyEnum.DestinyUpBaseParseAttr[attrId]
		local _attrId = attrIds and attrIds[2]

		if not addValues[_attrId] then
			local percentValue = 0
			local value = baseValue * percentValue * 0.01

			return math.floor(value)
		end
	end
end

function HeroDestinyStoneMO:getRankLevelCount()
	return self.maxLevel[self.rank] or 0
end

function HeroDestinyStoneMO:getNextDestinySlotCo()
	return (CharacterDestinyConfig.instance:getNextDestinySlotCo(self.heroId, self.rank, self.level))
end

function HeroDestinyStoneMO:getCurStoneNameAndIcon()
	if self.curUseStoneId == 0 then
		return
	end

	local stoneMo = self:getStoneMo(self.curUseStoneId)

	return stoneMo:getNameAndIcon()
end

function HeroDestinyStoneMO:isCanPlayAttrUnlockAnim(stoneId, rank)
	if not self:isUnlockSlot() then
		return
	end

	if rank > self.rank then
		return
	end

	local stoneMo = self:getStoneMo(stoneId)

	if not stoneMo then
		return
	end

	if not stoneMo.isUnlock then
		return
	end

	local key = "HeroDestinyStoneMO_isCanPlayAttrUnlockAnim_" .. self.heroId .. "_" .. rank .. "_" .. stoneId
	local value = GameUtil.playerPrefsGetNumberByUserId(key, 0)

	if value == 0 then
		GameUtil.playerPrefsSetNumberByUserId(key, 1)

		return true
	end
end

function HeroDestinyStoneMO:getEquipReshapeStoneCo(stoneMo)
	local stoneMo = stoneMo or self:isEquipReshape()

	if not stoneMo then
		return
	end

	local stoneCo = stoneMo:getFacetCo(self.rank)

	if stoneCo and stoneCo.ex_level_exchange then
		return stoneCo
	end
end

function HeroDestinyStoneMO:getExpExchangeSkillCo(exp)
	if self.curUseStoneId ~= 0 then
		local co = self:getEquipReshapeStoneCo()

		if co then
			return (CharacterDestinyConfig.instance:getSkillExlevelTable(self.curUseStoneId, exp))
		end
	end
end

function HeroDestinyStoneMO:_replaceSkill(skillIdList)
	if skillIdList then
		HeroDestinyStoneMO.replaceSkillList(skillIdList, self.curUseStoneId, self.rank)
	end

	return skillIdList
end

function HeroDestinyStoneMO.replaceSkillList(skillIdList, destinyId, rank)
	if destinyId and destinyId ~= 0 then
		local co = CharacterDestinyConfig.instance:getDestinyFacets(destinyId, rank)

		if co then
			local exchangeSkills = co.exchangeSkills

			if not string.nilorempty(exchangeSkills) then
				local splitSkillId = GameUtil.splitString2(exchangeSkills, true)

				for i, v in pairs(skillIdList) do
					for _, skillId in ipairs(splitSkillId) do
						local orignSkillId = skillId[1]
						local newSkillId = skillId[2]

						if v == orignSkillId then
							skillIdList[i] = newSkillId
						end
					end
				end
			end
		end
	end

	return skillIdList
end

function HeroDestinyStoneMO:isEquipReshape()
	if self.curUseStoneId == 0 then
		return
	end

	local stoneMo = self:getStoneMo(self.curUseStoneId)

	if stoneMo and stoneMo:isReshape() then
		return stoneMo
	end
end

function HeroDestinyStoneMO:getEquipReshapeStoneSkillGroupStr(exp)
	local stoneMo = self:isEquipReshape()

	if not stoneMo then
		return
	end

	local stoneCo = stoneMo:getFacetCo(self.rank)

	if not stoneCo or string.nilorempty(stoneCo.desc1) then
		return
	end

	if not stoneCo then
		return
	end

	local splitGroup1 = string.split(stoneCo.skillGroup1, "|")
	local splitGroup2 = string.split(stoneCo.skillGroup2, "|")
	local skillEx = string.split(stoneCo.skillEx, "#")
	local skillGroup = string.format("1#%s|2#%s", splitGroup1[exp], splitGroup2[exp])
	local exSkill = skillEx[exp]

	return skillGroup, exSkill
end

function HeroDestinyStoneMO:hasReshapeStone()
	for _, mo in pairs(self.stoneMoList) do
		if mo:isReshape() then
			return true
		end
	end
end

function HeroDestinyStoneMO:isReshapeAllStone()
	for _, mo in pairs(self.stoneMoList) do
		if not mo:isReshape() then
			return false
		end
	end

	return true
end

function HeroDestinyStoneMO:getReshapeDesc()
	for _, mo in pairs(self.stoneMoList) do
		if mo:getReshapeDesc() then
			return mo:getReshapeDesc()
		end
	end
end

function HeroDestinyStoneMO:setRedDot(reddot)
	self.reddot = reddot
end

function HeroDestinyStoneMO:getRedDot()
	return self.reddot or 0
end

function HeroDestinyStoneMO:setTrial()
	if self.maxLevel and self.maxRank then
		self.level = self.maxLevel[self.maxRank] or 1
	end
end

return HeroDestinyStoneMO
