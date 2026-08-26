-- chunkname: @modules/logic/character/config/CharacterDataConfig.lua

module("modules.logic.character.config.CharacterDataConfig", package.seeall)

local CharacterDataConfig = class("CharacterDataConfig", BaseConfig)

CharacterDataConfig.DefaultSkinDataKey = 0

function CharacterDataConfig:ctor()
	self._voiceConfig = nil
	self._episodeConfig = nil
	self._shopVoiceConfig = nil
	self._dataConfig = {}
	self._characterDataSkinList = {}
	self._characterDrawingStateDict = {}

	local characterDrawingStateStr = PlayerPrefsHelper.getString(PlayerPrefsKey.CharacterDrawingState, "")

	if string.nilorempty(characterDrawingStateStr) then
		return
	end

	local characterDrawingState = string.split(characterDrawingStateStr, "|")

	if not characterDrawingState or #characterDrawingState < 1 then
		return
	end

	for _, characterState in ipairs(characterDrawingState) do
		if not string.nilorempty(characterState) then
			local characterDrawingStateParams = string.splitToNumber(characterState, "#")

			if characterDrawingStateParams and #characterDrawingStateParams == 2 then
				self._characterDrawingStateDict[characterDrawingStateParams[1]] = characterDrawingStateParams[2]
			end
		end
	end
end

function CharacterDataConfig:reqConfigNames()
	return {
		"character_data",
		"character_voice",
		"episode",
		"character_motion_cut",
		"character_motion_effect",
		"character_motion_effect_animator",
		"character_motion_effect_layer",
		"character_motion_play_cut",
		"character_shop_voice",
		"character_face_effect",
		"character_motion_special",
		"character_special_interaction_voice",
		"story_hero_to_character"
	}
end

function CharacterDataConfig:onConfigLoaded(configName, configTable)
	if configName == "character_data" then
		local heroData, heroSkinData, heroSkinTypeData, characterSkins

		for _, characterDataCo in ipairs(configTable.configList) do
			heroData = self._dataConfig[characterDataCo.heroId]

			if not self._dataConfig[characterDataCo.heroId] then
				heroData = {}
				self._dataConfig[characterDataCo.heroId] = heroData
			end

			heroSkinData = heroData[characterDataCo.skinId]

			if not heroData[characterDataCo.skinId] then
				heroSkinData = {}
				heroData[characterDataCo.skinId] = heroSkinData
			end

			heroSkinTypeData = heroSkinData[characterDataCo.type]

			if not heroSkinData[characterDataCo.type] then
				heroSkinTypeData = {}
				heroSkinData[characterDataCo.type] = heroSkinTypeData
			end

			heroSkinTypeData[characterDataCo.number] = characterDataCo
			characterSkins = self._characterDataSkinList[characterDataCo.heroId]

			if not self._characterDataSkinList[characterDataCo.heroId] then
				characterSkins = {}
				self._characterDataSkinList[characterDataCo.heroId] = characterSkins
			end

			if not tabletool.indexOf(characterSkins, characterDataCo.skinId) then
				table.insert(characterSkins, characterDataCo.skinId)
			end
		end

		local heroSKinDataMetaTable = {}

		function heroSKinDataMetaTable.__index(t, key)
			return t[CharacterDataConfig.DefaultSkinDataKey]
		end

		for _, heroDataDict in pairs(self._dataConfig) do
			setmetatable(heroDataDict, heroSKinDataMetaTable)
		end
	elseif configName == "character_voice" then
		self._voiceConfig = configTable

		if SLFramework.FrameworkSettings.IsEditor then
			CharacterVoiceConfigChecker.instance:checkConfig()
		end
	elseif configName == "episode" then
		self._episodeConfig = configTable
	elseif configName == "character_shop_voice" then
		self._shopVoiceConfig = configTable
	end
end

function CharacterDataConfig:getMotionSpecial(path)
	for i, v in ipairs(lua_character_motion_special.configList) do
		if string.find(path, v.heroResName) then
			return v
		end
	end
end

function CharacterDataConfig:getCharacterDrawingState(heroId)
	return self._characterDrawingStateDict[heroId] or 0
end

function CharacterDataConfig:setCharacterDrawingState(heroId, state)
	self._characterDrawingStateDict[heroId] = state

	local characterDrawingStateStr = ""
	local index = 1

	for heroId, s in pairs(self._characterDrawingStateDict) do
		if index > 1 then
			characterDrawingStateStr = characterDrawingStateStr .. "|"
		end

		local str = string.format("%d#%d", heroId, s)

		characterDrawingStateStr = characterDrawingStateStr .. str
		index = index + 1
	end

	PlayerPrefsHelper.setString(PlayerPrefsKey.CharacterDrawingState, characterDrawingStateStr)
end

function CharacterDataConfig:getCharacterDataCO(heroId, skinId, type, number)
	local heroSkinItemDict, heroSkinItemTypeDict, characterCo

	heroSkinItemTypeDict = self._dataConfig[heroId][skinId][type] or self._dataConfig[heroId][CharacterDataConfig.DefaultSkinDataKey][type]

	return heroSkinItemTypeDict[number] or self._dataConfig[heroId][CharacterDataConfig.DefaultSkinDataKey][type][number]
end

function CharacterDataConfig:getDataConfig()
	return self._dataConfig
end

function CharacterDataConfig:geCharacterSkinIdList(heroId)
	return self._characterDataSkinList[heroId]
end

function CharacterDataConfig:getCharacterVoiceCO(heroId, audioId)
	return self._voiceConfig.configDict[heroId] and self._voiceConfig.configDict[heroId][audioId]
end

function CharacterDataConfig:getCharacterTypeVoicesCO(heroId, type, targetSkinId)
	local voicesCO = {}
	local configs = self._voiceConfig.configDict[heroId]

	if configs then
		for audioId, config in pairs(configs) do
			if config.type == type and self:_checkSkin(config, targetSkinId) then
				table.insert(voicesCO, config)
			end
		end
	end

	return voicesCO
end

function CharacterDataConfig:_checkSkin(config, targetSkinId)
	if not config then
		return false
	end

	if string.nilorempty(config.skins) or not targetSkinId then
		return true
	end

	return string.find(config.skins, targetSkinId)
end

function CharacterDataConfig:getCharacterVoicesCo(heroId)
	return self._voiceConfig.configDict[heroId]
end

function CharacterDataConfig:checkVoiceSkin(config, targetSkinId)
	return (config or nil) and (string.nilorempty(config.skins) and true or string.find(config.skins, targetSkinId))
end

function CharacterDataConfig:getMonsterHp(monsterId, isSimple)
	local templateStr = isSimple and "templateEasy" or "template"
	local levelStr = isSimple and "levelEasy" or "level"
	local monsterConfig = lua_monster.configDict[monsterId]

	if monsterConfig then
		local useNewCal = true

		if isSimple then
			local templateEasy = monsterConfig[templateStr]

			if templateEasy and templateEasy > 0 then
				useNewCal = false
			end
		end

		if useNewCal then
			local tempHp = self:calculateMonsterHpNewFunc(monsterConfig)

			if tempHp then
				return tempHp
			end
		end

		local monsterTemplateConfig = lua_monster_template.configDict[monsterConfig[templateStr]]

		if monsterTemplateConfig then
			return monsterTemplateConfig.life + monsterConfig[levelStr] * monsterTemplateConfig.lifeGrow
		end
	end

	return 0
end

function CharacterDataConfig:calculateMonsterHpNewFunc(monsterConfig)
	local skillTemplateConfig = lua_monster_skill_template.configDict[monsterConfig.skillTemplate]

	if skillTemplateConfig and skillTemplateConfig.instance > 0 then
		local instanceConfig = lua_monster_instance.configDict[skillTemplateConfig.instance]

		if not instanceConfig then
			return
		end

		local subConfig = lua_monster_sub.configDict[instanceConfig.sub]

		if not subConfig then
			return
		end

		local level = monsterConfig.level_true

		if level <= 0 then
			level = instanceConfig.level
		end

		local levelConfig = lua_monster_level.configDict[level]

		if not levelConfig then
			return
		end

		local jobConfig = lua_monster_job.configDict[subConfig.job]

		if not jobConfig then
			return
		end

		local life = subConfig.life / 10000 * (jobConfig.life_base * levelConfig.base + jobConfig.life_equip_base * levelConfig.equip_base) / 10000 * instanceConfig.life / 10000

		life = math.floor(life)

		if instanceConfig.multiHp > 1 then
			life = life / instanceConfig.multiHp
		end

		return life
	end
end

function CharacterDataConfig:getMonsterAttributeScoreList(monsterId)
	local monsterConfig = lua_monster.configDict[monsterId]
	local skillTemplateConfig = lua_monster_skill_template.configDict[monsterConfig.skillTemplate]

	if not skillTemplateConfig then
		return {}
	end

	if skillTemplateConfig and skillTemplateConfig.instance > 0 then
		local instanceConfig = lua_monster_instance.configDict[skillTemplateConfig.instance]

		if instanceConfig then
			local subConfig = lua_monster_sub.configDict[instanceConfig.sub]

			if subConfig then
				return string.splitToNumber(subConfig.score, "#")
			end
		end
	end

	return string.splitToNumber(skillTemplateConfig.template, "#")
end

function CharacterDataConfig:getChapterNameFromId(chapterId)
	return self._episodeConfig.configDict[chapterId].name
end

function CharacterDataConfig:getConditionStringName(config)
	local condition = config.unlockCondition
	local heroInfo = HeroModel.instance:getByHeroId(config.heroId)

	if heroInfo and config.type == CharacterEnum.VoiceType.GetSkin and string.nilorempty(condition) and not string.nilorempty(config.param) then
		return luaLang("hero_voice_skin_unlock")
	elseif heroInfo and config.type == CharacterEnum.VoiceType.BreakThrough and string.nilorempty(condition) then
		return luaLang("hero_voice_rank_reach_unlock")
	end

	if string.nilorempty(condition) then
		return ""
	end

	local locks = string.split(condition, "#")
	local lockValue = tonumber(locks[1])
	local showValue = tonumber(locks[2])

	if lockValue == 1 then
		return string.format(luaLang("hero_hint_reach_unlock"), showValue)
	elseif lockValue == 2 then
		return string.format(luaLang("hero_rank_reach_unlock"), showValue)
	elseif lockValue == 3 then
		return string.format(luaLang("hero_lv_reach_unlock"), self:getChapterNameFromId(showValue))
	elseif lockValue == 4 then
		return string.format(luaLang("condition_reach_unlock"), showValue)
	else
		logError("未指定的条件类型 " .. lockValue)

		return ""
	end
end

function CharacterDataConfig:checkLockCondition(config)
	local lockCO = config.unlockConditine
	local islock = false

	if lockCO ~= "" then
		local locks = string.splitToNumber(lockCO, "#")
		local heroinfo = HeroModel.instance:getByHeroId(config.heroId)
		local unLockType, unLockValue = locks[1], locks[2]

		if unLockType == CharacterEnum.CharacterDataUnLockType.Faith then
			islock = self:_checkNum(unLockValue, HeroConfig.instance:getFaithPercent(heroinfo.faith)[1] * 100)
		elseif unLockType == CharacterEnum.CharacterDataUnLockType.RankLevel then
			islock = self:_checkNum(unLockValue, heroinfo.rank)
		elseif unLockType == CharacterEnum.CharacterDataUnLockType.Level then
			islock = self:_checkNum(unLockValue, heroinfo.level)
		elseif unLockType == CharacterEnum.CharacterDataUnLockType.SkillLevel then
			islock = self:_checkNum(unLockValue, heroinfo.exSkillLevel)
		elseif unLockType == CharacterEnum.CharacterDataUnLockType.TalentLevel then
			islock = self:_checkNum(unLockValue, heroinfo.talent)
		elseif unLockType == CharacterEnum.CharacterDataUnLockType.Episode then
			local playerinfo = PlayerModel.instance:getPlayinfo()

			islock = self:_checkNum(tonumber(unLockValue), playerinfo.lastEpisodeId)
		else
			logError("未知的解锁条件类型, " .. tostring(unLockType))

			islock = false
		end
	end

	return islock
end

function CharacterDataConfig:_checkNum(num1, num2)
	return num2 < num1
end

function CharacterDataConfig:getCharacterShopVoicesCo(heroId)
	return self._shopVoiceConfig.configDict[heroId]
end

function CharacterDataConfig:getCharacterShopVoiceCO(heroId, audioId)
	local cos = self:getCharacterShopVoicesCo(heroId)

	return cos and cos[audioId]
end

CharacterDataConfig.instance = CharacterDataConfig.New()

return CharacterDataConfig
