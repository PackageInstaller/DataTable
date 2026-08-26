-- chunkname: @modules/logic/character/config/HeroConfig.lua

module("modules.logic.character.config.HeroConfig", package.seeall)

local HeroConfig = class("HeroConfig", BaseConfig)

function HeroConfig:ctor()
	self.heroConfig = nil
	self.attributeConfig = nil
	self.battleTagConfig = nil
	self.friendLessConfig = nil
	self.talent_cube_attr_config = nil
	self.maxFaith = 0
end

function HeroConfig:reqConfigNames()
	return {
		"character",
		"character_attribute",
		"character_battle_tag",
		"friendless",
		"talent_cube_attr",
		"hero_trial",
		"hero_trial_attr",
		"hero_group_type",
		"character_limited",
		"character_limited_voice",
		"character_rank_replace",
		"fight_device",
		"device_power",
		"heduonie_specialcard_client"
	}
end

function HeroConfig:onConfigLoaded(configName, configTable)
	if configName == "character" then
		self.heroConfig = configTable

		self:processHeroConfig()
	elseif configName == "character_attribute" then
		self.attributeConfig = configTable

		self:processAttrConfig()
	elseif configName == "character_battle_tag" then
		self.battleTagConfig = configTable
	elseif configName == "friendless" then
		self.friendLessConfig = configTable

		for index = 1, #self.friendLessConfig.configDict do
			self.maxFaith = self.maxFaith + self.friendLessConfig.configDict[index].friendliness
		end
	elseif configName == "talent_cube_attr" then
		self.talent_cube_attr_config = configTable
	elseif configName == "hero_group_type" then
		self.heroGroupTypeDict = {}

		for _, v in pairs(configTable.configList) do
			local arr = string.splitToNumber(v.chapterIds, "#") or {}

			for _, chapterId in pairs(arr) do
				self.heroGroupTypeDict[chapterId] = v
			end
		end
	elseif configName == "hero_trial" then
		self.heroTrialConfig = configTable.configDict
	elseif configName == "character_rank_replace" then
		self.heroRankReplaceConfig = configTable.configDict
	end
end

function HeroConfig:getTrial104Equip(slot, trialId, template)
	template = template or 0

	if self.heroTrialConfig[trialId] then
		local trialCo = self.heroTrialConfig[trialId][template]

		if trialCo then
			return trialCo["act104EquipId" .. tostring(slot)]
		end
	end
end

function HeroConfig:getHeroCO(id)
	return self.heroConfig.configDict[id]
end

function HeroConfig:getHeroGroupTypeCo(chapterId)
	if not chapterId then
		return
	end

	return self.heroGroupTypeDict[chapterId] or lua_hero_group_type.configDict[ModuleEnum.HeroGroupServerType.Activity]
end

function HeroConfig:getHeroAttributesCO()
	return self.attributeConfig.configDict
end

function HeroConfig:getHeroAttributeCO(id)
	return self.attributeConfig.configDict[id]
end

function HeroConfig:getBattleTagConfigCO(id)
	return self.battleTagConfig.configDict[id]
end

function HeroConfig:getTalentCubeAttrConfig(id, level)
	return self.talent_cube_attr_config.configDict[id][level]
end

function HeroConfig:getTalentCubeMaxLevel(id)
	self.max_talent_level_dic = self.max_talent_level_dic or {}

	if self.max_talent_level_dic[id] then
		return self.max_talent_level_dic[id]
	end

	local level = 0

	for k, v in pairs(self.talent_cube_attr_config.configDict[id]) do
		if level <= v.level then
			level = v.level
		end
	end

	self.max_talent_level_dic[id] = level

	return level
end

function HeroConfig:getAnyRareCharacterCount(rare)
	local heros = self.heroConfig.configDict
	local count = 0

	for _, v in pairs(heros) do
		if v.rare == rare then
			count = count + 1
		end
	end

	return count
end

function HeroConfig:getAnyOnlineRareCharacterCount(rare, stat)
	local count = 0
	local allStat = CharacterEnum.StatType.All

	stat = stat or CharacterEnum.StatType.Normal

	for _, v in pairs(self.heroConfig.configDict) do
		if v.rare == rare and (stat == allStat or v.stat == stat) then
			if v.isOnline == "1" then
				count = count + 1
			elseif v.isOnline ~= "0" and TimeUtil.stringToTimestamp(v.isOnline) < ServerTime.now() then
				count = count + 1
			end
		end
	end

	return count
end

function HeroConfig:getFaithPercent(faith)
	if faith >= self.maxFaith then
		return {
			1,
			0
		}
	end

	local tempFaith = 0
	local percent = 0
	local nextFaith = 0

	for index = 1, #self.friendLessConfig.configDict do
		tempFaith = tempFaith + self.friendLessConfig.configDict[index].friendliness

		if faith <= tempFaith then
			if tempFaith == faith then
				percent = self.friendLessConfig.configDict[index].percentage
				nextFaith = self.friendLessConfig.configDict[index + 1].friendliness

				break
			end

			percent = self.friendLessConfig.configDict[index - 1].percentage
			nextFaith = tempFaith - faith

			break
		end
	end

	return {
		percent / 100,
		nextFaith
	}
end

function HeroConfig:getMaxRank(rare)
	if rare <= 3 then
		return 2
	else
		return 3
	end
end

function HeroConfig:getLevelUpItems(heroId, fromLevel, toLevel)
	local items = {}
	local heroConfig = self:getHeroCO(heroId)

	for level = fromLevel + 1, toLevel do
		local cosumeConfig = SkillConfig.instance:getcosumeCO(level, heroConfig.rare)
		local cosume = cosumeConfig.cosume
		local params = string.split(cosume, "|")

		for i = 1, #params do
			local param = string.split(params[i], "#")

			if not items[i] then
				local item = {}

				item.type = tonumber(param[1])
				item.id = tonumber(param[2])
				item.quantity = tonumber(param[3])
				item.name = ""
				items[i] = item
			else
				items[i].quantity = items[i].quantity + tonumber(param[3])
			end
		end
	end

	return items
end

function HeroConfig:getShowLevel(level)
	if not self._rankMaxLevels then
		local rankLevelParam = CommonConfig.instance:getConstStr(ConstEnum.RankMaxLevel)

		self._rankMaxLevels = string.splitToNumber(rankLevelParam, "#")
	end

	local one

	for i = #self._rankMaxLevels, 1, -1 do
		if self._rankMaxLevels[i] < level then
			return level - self._rankMaxLevels[i], i + 1
		end
	end

	return level, 1
end

function HeroConfig:getCommonLevelDisplay(level)
	local showLevel, rank = self:getShowLevel(level)

	if rank == 1 then
		return string.format(luaLang("rank_level_display1"), showLevel)
	elseif rank == 2 then
		return string.format(luaLang("rank_level_display2"), showLevel)
	elseif rank == 3 then
		return string.format(luaLang("rank_level_display3"), showLevel)
	elseif rank == 4 then
		return string.format(luaLang("rank_level_display4"), showLevel)
	else
		return string.format(luaLang("rank_level_display1"), showLevel)
	end
end

function HeroConfig:getLevelDisplayVariant(level)
	if level == 0 then
		return "？？？"
	end

	local showLevel, rank = self:getShowLevel(level)

	if rank == 1 then
		return string.format(luaLang("rank_level_display1"), showLevel)
	elseif rank == 2 then
		return string.format(luaLang("rank_level_display2"), showLevel)
	elseif rank == 3 then
		return string.format(luaLang("rank_level_display3"), showLevel)
	elseif rank == 4 then
		return string.format(luaLang("rank_level_display4"), showLevel)
	else
		return string.format(luaLang("rank_level_display1"), showLevel)
	end
end

function HeroConfig:processAttrConfig()
	self.attrConfigByAttrType = {}

	for k, v in pairs(self.attributeConfig.configDict) do
		self.attrConfigByAttrType[v.attrType] = v.id
	end

	self.attrConfigByAttrType.atk = 102
	self.attrConfigByAttrType.def = 103
	self.attrConfigByAttrType.mdef = 104
	self.attrConfigByAttrType.cri_dmg = 203
	self.attrConfigByAttrType.cri_def = 204
	self.attrConfigByAttrType.add_dmg = 205
	self.attrConfigByAttrType.drop_dmg = 206
end

function HeroConfig:getIDByAttrType(attr_type)
	return self.attrConfigByAttrType[attr_type]
end

function HeroConfig:getAttrTypeByID(id)
	return self.attributeConfig.configDict[id] and self.attributeConfig.configDict[id].attrType
end

function HeroConfig:talentGainTab2IDTab(gain_tab)
	local tab = {}

	for k, v in pairs(gain_tab) do
		local id = self:getIDByAttrType(k)

		tab[id] = {}
		tab[id].config_id = id
		tab[id].id = id
		tab[id].value = v.value
	end

	return tab
end

function HeroConfig:getHeroesList()
	local heroList = {}
	local allSplitCharacterIds = ResSplitConfig.instance:getAllCharacterIds()
	local isVerifing = VersionValidator.instance:isInReviewing()

	for _, heroCo in ipairs(self.heroConfig.configList) do
		if tonumber(heroCo.isOnline) == 1 and (isVerifing == false or allSplitCharacterIds[heroCo.id]) then
			table.insert(heroList, heroCo)
		end
	end

	return heroList
end

function HeroConfig:getHeroesByType(heroType)
	local heroList = {}
	local allSplitCharacterIds = ResSplitConfig.instance:getAllCharacterIds()
	local isVerifing = VersionValidator.instance:isInReviewing()

	for _, heroCo in ipairs(self.heroConfig.configList) do
		if tonumber(heroCo.isOnline) == 1 and heroCo.heroType == heroType and (isVerifing == false or allSplitCharacterIds[heroCo.id]) then
			table.insert(heroList, heroCo)
		end
	end

	return heroList
end

function HeroConfig.sortAttr(item1, item2)
	return HeroConfig.instance:getIDByAttrType(item1.key or item1.attrType) < HeroConfig.instance:getIDByAttrType(item2.key or item2.attrType)
end

local sortHeightForEquipView = {
	mdef = 4,
	def = 3,
	hp = 2,
	atk = 1
}

function HeroConfig.sortAttrForEquipView(item1, item2)
	return sortHeightForEquipView[item1.attrType] < sortHeightForEquipView[item2.attrType]
end

function HeroConfig:getHeroAttrRate(hero_id, arrtType)
	local lv_config = SkillConfig.instance:getherolevelCO(hero_id, 1)

	for i, v in ipairs(lua_character_grow.configList) do
		if lv_config[arrtType] < v[arrtType] then
			return v.id - 1 == 0 and 1 or v.id - 1
		end
	end

	return lua_character_grow.configList[#lua_character_grow.configList].id
end

function HeroConfig:getHeroRankReplaceConfig(heroId)
	return self.heroRankReplaceConfig[heroId]
end

function HeroConfig:processHeroConfig()
	self._battleTag2HeroMap = {}
	self._heroId2BattleTagList = {}
	self._sp2OriginalHeroDict = {}
	self._heroId2SpList = {}

	for _, heroCo in ipairs(self.heroConfig.configList) do
		local heroId = heroCo.id
		local battleTagList = string.split(heroCo.battleTag, "#")

		self._heroId2BattleTagList[heroId] = battleTagList

		if battleTagList then
			for _, tagId in ipairs(battleTagList) do
				self._battleTag2HeroMap[tagId] = self._battleTag2HeroMap[tagId] or {}

				table.insert(self._battleTag2HeroMap[tagId], heroCo)
			end
		end

		local originalHeroId, spHeroId
		local isSP = heroCo.isSP
		local statShareHeroId = heroCo.statShare

		if isSP then
			originalHeroId = statShareHeroId
			spHeroId = heroId

			local rewardCheckPattern = MaterialEnum.MaterialType.SpecialBlock .. "#%d+#%d+"

			if string.find(heroCo.birthdayBonus, rewardCheckPattern) then
				logError(string.format("HeroConfig:processHeroConfig error, SPHero:%s couldn't have birthday block", heroId))
			end
		else
			originalHeroId = heroId
			spHeroId = statShareHeroId
		end

		if statShareHeroId and statShareHeroId ~= 0 and not self._sp2OriginalHeroDict[spHeroId] then
			self._sp2OriginalHeroDict[spHeroId] = originalHeroId

			local spList = GameUtil.tabletool_checkDictTable(self._heroId2SpList, originalHeroId)

			table.insert(spList, spHeroId)
		end
	end
end

function HeroConfig:getSPHeroIdList(heroId, includeOriginalHero)
	local result = {}

	if includeOriginalHero then
		table.insert(result, heroId)
	end

	local spList = self._heroId2SpList[heroId]

	if spList then
		for _, spHeroId in ipairs(spList) do
			table.insert(result, spHeroId)
		end
	end

	return result
end

function HeroConfig:getSPOriginalHero(spHeroId)
	local heroCfg = self:getHeroCO(spHeroId)

	if heroCfg and heroCfg.isSP then
		return self._sp2OriginalHeroDict[spHeroId]
	end
end

function HeroConfig:getHeroListByBattleTag(battleTag)
	return self._battleTag2HeroMap and self._battleTag2HeroMap[battleTag]
end

function HeroConfig:getHeroBattleTagList(heroId)
	return self._heroId2BattleTagList and self._heroId2BattleTagList[heroId]
end

function HeroConfig:getHeroSpecialcardCo(heroId, skillLevel)
	local cos = self:getHeroSpecialcardCos(heroId)

	return cos and cos[skillLevel]
end

function HeroConfig:getHeroSpecialcardCos(heroId)
	return lua_heduonie_specialcard_client.configDict[heroId]
end

HeroConfig.instance = HeroConfig.New()

return HeroConfig
