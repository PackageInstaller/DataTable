-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/model/hero/equip/HeroEquip.lua

require("dm.gameplay.develop.model.hero.equip.EquipSkill")

HeroEquip = class("HeroEquip", objectlua.Object, _M)

HeroEquip:has("_id", {
	is = "rw"
})
HeroEquip:has("_equipId", {
	is = "rw"
})
HeroEquip:has("_levelId", {
	is = "rw"
})
HeroEquip:has("_starId", {
	is = "rw"
})
HeroEquip:has("_heroId", {
	is = "rw"
})
HeroEquip:has("_exp", {
	is = "rw"
})
HeroEquip:has("_unlock", {
	is = "rw"
})
HeroEquip:has("_config", {
	is = "rw"
})
HeroEquip:has("_effect", {
	is = "rw"
})
HeroEquip:has("_skillLevel", {
	is = "rw"
})
HeroEquip:has("_skill", {
	is = "rw"
})
HeroEquip:has("_rarity", {
	is = "r"
})
HeroEquip:has("_limitLevelTotalGold", {
	is = "r"
})
HeroEquip:has("_preHeroCombat", {
	is = "rw"
})
HeroEquip:has("_overflowStarExp", {
	is = "rw"
})

local HeroEquipExpItem = ConfigReader:getDataByNameIdAndKey("ConfigValue", "HeroEquipExpItem", "content")
local HeroEquipResolve = ConfigReader:getDataByNameIdAndKey("ConfigValue", "HeroEquipResolve", "content")
local HeroEquipSkillLevel = ConfigReader:getDataByNameIdAndKey("ConfigValue", "HeroEquipSkillLevel", "content")

function HeroEquip:initialize(id)
	super.initialize(self)

	self._id = id
	self._equipId = ""
	self._heroId = ""
	self._levelId = ""
	self._starId = ""
	self._exp = 0
	self._skillLevel = 0
	self._unlock = true
	self._config = {}
	self._levelConfig = {}
	self._starConfig = {}
	self._effect = nil
	self._skill = nil
	self._rarity = 0
	self._limitLevelTotalGold = 0
	self._preHeroCombat = 0
	self._overflowStarExp = 0
	self._preHeroId = nil
	self._preAttrListCache = nil
	self._attrListCache1 = nil
	self._attrListCache2 = nil
	self._resolveCache = {
		goldNum = 0,
		equips = {},
		items = {}
	}
	self._heroEquipExpItemList = {}

	for i, v in pairs(HeroEquipExpItem) do
		self._heroEquipExpItemList[#self._heroEquipExpItemList + 1] = {
			id = i,
			exp = v
		}
	end

	table.sort(self._heroEquipExpItemList, function(a, b)
		return a.exp > b.exp
	end)

	self._SKILL_MAX_LEVEL = table.nums(HeroEquipSkillLevel)
end

function HeroEquip:initSkillData()
	local skillId = self:getSkillId()

	if skillId ~= "" and not self._skill then
		self._skill = EquipSkill:new(skillId)
	end
end

function HeroEquip:synchronize(data)
	if not data then
		return
	end

	local hasAttrChanged = false
	local hasResolveChanged = false

	if data.heroEquipBaseId then
		self._equipId = data.heroEquipBaseId

		self:syncConfig()
	end

	if data.heroId then
		self._heroId = data.heroId
		hasAttrChanged = true
	end

	if data.levelId then
		self._levelId = data.levelId

		self:syncLevelConfig()

		hasAttrChanged = true
		hasResolveChanged = true
	end

	if data.heroEquipStar then
		self._starId = data.heroEquipStar

		self:syncStarConfig()

		hasAttrChanged = true
	end

	if data.exp then
		self._exp = data.exp
		hasAttrChanged = true
		hasResolveChanged = true
	end

	if data.lock ~= nil then
		self._unlock = not data.lock
	end

	if data.skillLevel then
		self._skillLevel = data.skillLevel
	end

	if data.rarity then
		self._rarity = data.rarity
		hasAttrChanged = true
	end

	if data.overflowStarExp then
		self._overflowStarExp = data.overflowStarExp
	end

	self:refreshSkill()
	self:refreshLimitLevelGold()

	if hasResolveChanged then
		self:refreshResolveCache()
	end

	if hasAttrChanged then
		self._preHeroId = nil
		self._preAttrListCache = nil
		self._attrListCache1 = nil
		self._attrListCache2 = nil

		self:rCreateEffect()
	end
end

function HeroEquip:refreshSkill()
	if self._skill then
		local skillLevel = self._skillLevel

		self._skill:synchronize({
			level = skillLevel
		})
	end
end

function HeroEquip:refreshLimitLevelGold()
	self._limitLevelTotalGold = 0

	local levelMax = self:getMaxLevel()
	local level = self:getLevel()
	local levelId = self._levelId

	while level < levelMax do
		local gold = ConfigReader:getDataByNameIdAndKey("HeroEquipExp", levelId, "Gold")

		self._limitLevelTotalGold = self._limitLevelTotalGold + gold
		levelId = ConfigReader:getDataByNameIdAndKey("HeroEquipExp", levelId, "NextId")
		level = ConfigReader:getDataByNameIdAndKey("HeroEquipExp", levelId, "ShowLevel")
	end
end

function HeroEquip:syncConfig()
	self._config = ConfigReader:getRecordById("HeroEquipBase", self._equipId)

	self:initSkillData()

	if self._config.URUPSkillLV then
		self._SKILL_MAX_LEVEL = table.nums(self._config.URUPSkillLV)
	end

	if self._config.Rareity == 13 or self._config.Rareity == 12 or self._config.Rareity == 11 then
		self._SKILL_MAX_LEVEL = 7
	end
end

function HeroEquip:syncLevelConfig()
	self._levelConfig = ConfigReader:getRecordById("HeroEquipExp", self._levelId)
end

function HeroEquip:syncStarConfig()
	self._starConfig = ConfigReader:getRecordById("HeroEquipStar", self._starId)
end

function HeroEquip:isMaxLevel()
	return self:getLevelNextId() == ""
end

function HeroEquip:isMaxStar()
	return self:getStarNextId() == ""
end

function HeroEquip:isStarMaxExp()
	local level = self:getLevel()
	local levelMax = self:getMaxLevel()
	local exp = self:getExp()
	local expMax = self:getLevelNextExp()

	if levelMax <= level then
		return true
	end

	return false
end

function HeroEquip:getLevelByExp(exp)
	if exp == 0 then
		return self:getLevel(), 0
	end

	local level = self:getLevel()
	local curLevel = self:getLevel()
	local curLevelId = self:getLevelId()
	local levelMax = self:getMaxLevel()
	local curExp = self:getExp()
	local maxNeedExp = 0
	local gold = 0
	local tempExp = exp - curExp

	for i = curLevel, levelMax do
		if exp < maxNeedExp then
			break
		end

		level = i

		local nextLevelConfig = ConfigReader:getRecordById("HeroEquipExp", curLevelId)
		local nextLevelId = nextLevelConfig.NextId

		if nextLevelId == "" then
			break
		end

		local nextExp = nextLevelConfig.Exp
		local nextGold = nextLevelConfig.Gold

		maxNeedExp = maxNeedExp + nextExp
		curLevelId = nextLevelId

		if level == curLevel then
			if tempExp - (nextExp - curExp) >= 0 then
				tempExp = tempExp - (nextExp - curExp)
				gold = gold + math.ceil(nextGold * ((nextExp - curExp) / nextExp))
			else
				gold = gold + math.ceil(nextGold * (tempExp / nextExp))
			end
		elseif tempExp - nextExp >= 0 then
			tempExp = tempExp - nextExp
			gold = gold + nextGold
		else
			gold = gold + math.ceil(nextGold * (tempExp / nextExp))
		end
	end

	return level, gold
end

function HeroEquip:getMaxExp()
	local curLevel = self:getLevel()
	local curLevelId = self:getLevelId()
	local levelMax = self:getMaxLevel()
	local maxNeedExp = 0

	for i = curLevel, levelMax do
		local nextLevelId = ConfigReader:getDataByNameIdAndKey("HeroEquipExp", curLevelId, "NextId")

		if nextLevelId == "" then
			break
		end

		maxNeedExp = maxNeedExp + (ConfigReader:getDataByNameIdAndKey("HeroEquipExp", curLevelId, "Exp") or 0)
		curLevelId = nextLevelId
	end

	return maxNeedExp
end

function HeroEquip:refreshResolveCache()
	self._resolveCache.goldNum = 0
	self._resolveCache.equips = {}
	self._resolveCache.items = {}

	local curExp = self:getExp()
	local nextExp = self:getLevelNextExp()
	local curExpGold = nextExp == 0 and 0 or curExp / nextExp * self:getLevelGold()
	local goldNum = (self:getLevelTotalGold() + curExpGold) * HeroEquipResolve.goldBack
	local totalExp = curExp + self:getLevelTotalExp()
	local equipsExp = totalExp * HeroEquipResolve.expBack
	local length = #self._heroEquipExpItemList
	local minExp = self._heroEquipExpItemList[length].exp

	for i = 1, length do
		local targetExp = self._heroEquipExpItemList[i].exp
		local targetId = self._heroEquipExpItemList[i].id
		local equipNum = math.modf(equipsExp / targetExp)

		if equipNum > 0 then
			self._resolveCache.items[#self._resolveCache.items + 1] = {
				id = targetId,
				amount = equipNum
			}
		end

		equipsExp = math.fmod(equipsExp, targetExp)

		if equipsExp < minExp then
			break
		end
	end

	local resolveItem = self:getResolveItem()

	for id, amount in pairs(resolveItem) do
		if id == CurrencyIdKind.kGold then
			goldNum = goldNum + amount
		end

		self._resolveCache.items[#self._resolveCache.items + 1] = {
			id = id,
			amount = amount
		}
	end

	self._resolveCache.goldNum = goldNum
end

function HeroEquip:getResolveItems()
	return self._resolveCache.goldNum, self._resolveCache.items, self._resolveCache.equips
end

function HeroEquip:getStarPreData()
	local data = {
		maxLevel = self:getMaxLevel(),
		star = self:getStar()
	}
	local nextStarId = self:getStarNextId()

	if nextStarId ~= "" then
		data.maxLevel = ConfigReader:getDataByNameIdAndKey("HeroEquipStar", nextStarId, "MaxLevel")
		data.star = ConfigReader:getDataByNameIdAndKey("HeroEquipStar", nextStarId, "StarLevel")
	else
		data = nil
	end

	return data
end

function HeroEquip:getAttrPreListByLevel(level)
	if self:isMaxLevel() then
		return {}
	end

	level = level or self:getLevel()

	local attr = self:createBastAttr(nil, level)
	local effectAttr = HeroEquipAttr:createEffect(self, level)

	for attrType, v in pairs(effectAttr) do
		if attr[attrType] then
			attr[attrType].attrNum = attr[attrType].attrNum + v.attrNum
		else
			attr[attrType] = v
		end
	end

	for attrType, v in pairs(attr) do
		if AttributeCategory:getAttNameAttend(attrType) == "" then
			attr[attrType].attrNum = math.round(attr[attrType].attrNum)
		end
	end

	return attr
end

function HeroEquip:getAttrListShow()
	if self._attrListCache1 then
		return self._attrListCache1
	end

	local attr = self:createBastAttr(nil)

	for attrType, v in pairs(self._effect) do
		if attr[attrType] then
			attr[attrType].attrNum = attr[attrType].attrNum + v.attrNum
		else
			attr[attrType] = v
		end
	end

	self._attrListCache1 = {}

	for i, v in pairs(attr) do
		if AttributeCategory:getAttNameAttend(v.attrType) == "" then
			v.attrNum = math.round(v.attrNum)
		end

		self._attrListCache1[#self._attrListCache1 + 1] = v
	end

	table.sort(self._attrListCache1, function(a, b)
		return a.index < b.index
	end)

	return self._attrListCache1
end

function HeroEquip:getAttrList()
	if self._attrListCache2 then
		return self._attrListCache2
	end

	local heroId = self:getHeroId() ~= "" and self:getHeroId() or nil

	self._attrListCache2 = self:createBastAttr(heroId)

	for attrType, v in pairs(self._effect) do
		if self._attrListCache2[attrType] then
			self._attrListCache2[attrType].attrNum = self._attrListCache2[attrType].attrNum + v.attrNum
		else
			self._attrListCache2[attrType] = v
		end
	end

	return self._attrListCache2
end

function HeroEquip:getPreAttrList(heroId)
	if self._preHeroId ~= heroId then
		self._preHeroId = heroId
	elseif self._preAttrListCache then
		return self._preAttrListCache
	end

	self._preAttrListCache = self:createBastAttr(heroId)

	for attrType, v in pairs(self._effect) do
		if self._preAttrListCache[attrType] then
			self._preAttrListCache[attrType].attrNum = self._preAttrListCache[attrType].attrNum + v.attrNum
		else
			self._preAttrListCache[attrType] = v
		end
	end

	return self._preAttrListCache
end

function HeroEquip:createBastAttr(heroId, level)
	local params = {
		level = level,
		rarity = self:getRarity(),
		star = self:getStar(),
		heroId = heroId
	}

	return (HeroEquipAttr:getBaseAttrNum(self, params))
end

function HeroEquip:_createEffect()
	self._effect = HeroEquipAttr:createEffect(self)
end

function HeroEquip:rCreateEffect()
	self:_createEffect()
end

function HeroEquip:getName()
	return Strings:get(self._config.Name)
end

function HeroEquip:getDesc()
	return Strings:get(self._config.Desc)
end

local EquipIconFile = "asset/items/"

function HeroEquip:getIcon()
	return EquipIconFile .. self._config.Icon .. ".png"
end

function HeroEquip:getPosition()
	return self._config.Position
end

function HeroEquip:getOccupation()
	return self._config.Profession
end

function HeroEquip:getOccupationDesc()
	return self._config.ProfessionDesc
end

function HeroEquip:getOccupationType()
	return self._config.ProfessionType
end

function HeroEquip:getAttrATK()
	return self._config.ATK
end

function HeroEquip:getAttrDEF()
	return self._config.DEF
end

function HeroEquip:getAttrHP()
	return self._config.HP
end

function HeroEquip:getAttrSPEED()
	return self._config.SPEED
end

function HeroEquip:getAttrEffect()
	return self._config.AttrEffect or {}
end

function HeroEquip:getSkillId()
	return self._config.Skill
end

function HeroEquip:getSort()
	return self._config.Sort
end

function HeroEquip:getTypeSort()
	return self._config.Rank
end

function HeroEquip:getLevelNextId()
	return self._levelConfig.NextId
end

function HeroEquip:getLevelNextExp()
	return self._levelConfig.Exp or 0
end

function HeroEquip:getLevelTotalExp()
	return self._levelConfig.TotalExp
end

function HeroEquip:getLevel()
	return self._levelConfig.ShowLevel
end

function HeroEquip:getLevelGold()
	return self._levelConfig.Gold or 0
end

function HeroEquip:getLimitLevelTotalGold()
	return self._limitLevelTotalGold
end

function HeroEquip:getLevelTotalGold()
	return self._levelConfig.TotalGold or 0
end

function HeroEquip:getMaxLevel()
	return self._starConfig.MaxLevel
end

function HeroEquip:getStarNextId()
	return self._starConfig.NextId
end

function HeroEquip:getStar()
	return self._starConfig.StarLevel
end

function HeroEquip:getCommonItemId()
	return self._starConfig.CommonItem
end

function HeroEquip:getGoldNum()
	return {
		itemId = CurrencyIdKind.kGold,
		amount = self._starConfig.GoldNum
	}
end

function HeroEquip:getEquipStarExp()
	return self._starConfig.EquipStarExp
end

function HeroEquip:getEquipItemNum()
	return self._starConfig.EquipItemNum
end

function HeroEquip:getEquipNeedControl()
	return self._starConfig.EquipNeedControl
end

function HeroEquip:getIncludeEquipStarExp()
	return self._starConfig.IncludeEquipStarExp
end

local HeroEquipStarExpRate = ConfigReader:getDataByNameIdAndKey("ConfigValue", "HeroEquipStarExpRate", "content")

function HeroEquip:getSameEquipStarExp()
	return self:getIncludeEquipStarExp() * HeroEquipStarExpRate
end

local typeItem = {
	[HeroEquipType.kWeapon] = "WeaponItem",
	[HeroEquipType.kTops] = "TopsItem",
	[HeroEquipType.kShoes] = "ShoesItem",
	[HeroEquipType.kDecoration] = "DecorationItem"
}

function HeroEquip:getStarItem()
	local type = self:getPosition()
	local items = self._starConfig[typeItem[type]]
	local costItems = {}

	for id, v in pairs(items) do
		costItems[#costItems + 1] = {
			itemId = id,
			amount = v
		}
	end

	table.sort(costItems, function(a, b)
		return a.itemId < b.itemId
	end)

	return costItems
end

function HeroEquip:getResolveItem()
	return self._starConfig.ResolveItem
end

function HeroEquip:canSkillUp()
	if not self._skill then
		return false
	end

	if self._config.URUPSkillLV then
		if self._config.URUPSkillLV[1] and self:getLevel() >= self._config.URUPSkillLV[1] then
			return true
		end
	elseif HeroEquipSkillLevel[1] and self:getLevel() >= HeroEquipSkillLevel[1] then
		return true
	end

	return false
end

function HeroEquip:isHaveSkill()
	return self._skill ~= nil
end

function HeroEquip:isSkillMaxLevel()
	if self._skill and self._skill:getLevel() >= self._SKILL_MAX_LEVEL then
		return true
	end

	return false
end

function HeroEquip:getUnLockSkillLevel()
	if self._config.URUPSkillLV then
		return self._config.URUPSkillLV[1]
	else
		return HeroEquipSkillLevel[1]
	end
end

function HeroEquip:getIsUseEquipItemNum()
	return self._starConfig.EquipItemNum == "1"
end
