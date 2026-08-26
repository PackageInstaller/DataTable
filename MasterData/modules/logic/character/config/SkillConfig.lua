-- chunkname: @modules/logic/character/config/SkillConfig.lua

module("modules.logic.character.config.SkillConfig", package.seeall)

local SkillConfig = class("SkillConfig", BaseConfig)

function SkillConfig:ctor()
	self.passiveskillConfig = nil
	self.exskillConfig = nil
	self.levelConfig = nil
	self.rankConfig = nil
	self.cosumeConfig = nil
	self.talentConfig = nil
	self.growConfig = nil
	self.skillBuffDescConfig = nil
	self.skillBuffDescConfigByName = nil
	self.heroUpgradeBreakLevelConfig = nil
end

function SkillConfig:reqConfigNames()
	return {
		"character_level",
		"skill_ex_level",
		"character_rank",
		"character_talent",
		"character_grow",
		"skill_passive_level",
		"character_cosume",
		"skill_eff_desc",
		"fight_const",
		"skill_buff_desc",
		"hero_upgrade_breaklevel",
		"fight_card_footnote",
		"skill_energy"
	}
end

function SkillConfig:onConfigLoaded(configName, configTable)
	if configName == "character_talent" then
		self.talentConfig = configTable
	elseif configName == "skill_ex_level" then
		local function errorFunc(_, key, value)
			logError("Can't modify config field: " .. key)
		end

		for _, config in ipairs(configTable.configList) do
			local metatable = getmetatable(config)

			metatable.__newindex = nil

			local str = string.split(config.skillGroup1, ",")[1]

			config.skillGroup1 = str
			str = string.split(config.skillGroup2, ",")[1]
			config.skillGroup2 = str
			metatable.__newindex = errorFunc
		end

		self.exskillConfig = configTable
	elseif configName == "skill_passive_level" then
		self.passiveskillConfig = configTable
	elseif configName == "character_level" then
		self.levelConfig = configTable
	elseif configName == "character_rank" then
		self.rankConfig = configTable
	elseif configName == "character_cosume" then
		self.cosumeConfig = configTable
	elseif configName == "character_grow" then
		self.growConfig = configTable
	elseif configName == "skill_eff_desc" then
		self.skillEffectDescConfig = configTable
	elseif configName == "skill_buff_desc" then
		self.skillBuffDescConfig = configTable
	elseif configName == "hero_upgrade_breaklevel" then
		self.heroUpgradeBreakLevelConfig = configTable
	elseif configName == "fight_card_footnote" then
		self.fightCardFootnoteConfig = configTable
	end
end

function SkillConfig:getGrowCo()
	return self.growConfig.configDict
end

function SkillConfig:getGrowCO(id)
	return self.growConfig.configDict[id]
end

function SkillConfig:gettalentCO(heroid, talentid)
	return self.talentConfig.configDict[heroid][talentid]
end

function SkillConfig:getherotalentsCo(heroid)
	return self.talentConfig.configDict[heroid]
end

function SkillConfig:getpassiveskillCO(heroid, skilllevel)
	return self.passiveskillConfig.configDict[heroid][skilllevel]
end

function SkillConfig:getpassiveskillsCO(heroid)
	return self.passiveskillConfig.configDict[heroid]
end

function SkillConfig:getHeroExSkillLevelByLevel(heroId, level)
	local passiveLevel = 0
	local rank = 1
	local ranksCO = self:getheroranksCO(heroId)

	for i = 1, #ranksCO do
		local effect = GameUtil.splitString2(ranksCO[i].effect, true)
		local find = false

		for _, v in pairs(effect) do
			if v[1] == 1 and level <= v[2] then
				rank = i
				find = true

				break
			end
		end

		if find then
			for _, v in pairs(effect) do
				if v[1] == 2 then
					passiveLevel = v[2]

					break
				end
			end
		end

		if find then
			break
		end
	end

	return passiveLevel, rank
end

function SkillConfig:getPassiveSKillsCoByExSkillLevel(heroid, exSkillLevel)
	exSkillLevel = exSkillLevel or 1

	local passiveSkillDict = self:getpassiveskillsCO(heroid)

	passiveSkillDict = tabletool.copy(passiveSkillDict)

	local exSkillCo

	for i = exSkillLevel, 1, -1 do
		exSkillCo = self:getherolevelexskillCO(heroid, i)

		if not string.nilorempty(exSkillCo.passiveSkill) then
			self:_handleReplacePassiveSkill(exSkillCo.passiveSkill, passiveSkillDict)
		end
	end

	local heroMo = HeroModel.instance:getByHeroId(heroid)

	if heroMo and heroMo.destinyStoneMo then
		local stoneCo = heroMo.destinyStoneMo:getCurUseStoneCo()

		if stoneCo then
			local exchangeSkills = stoneCo.exchangeSkills

			if not string.nilorempty(exchangeSkills) then
				local splitSkillId = GameUtil.splitString2(exchangeSkills, true)

				for i, v in pairs(passiveSkillDict) do
					for _, skillId in ipairs(splitSkillId) do
						local orignSkillId = skillId[1]
						local newSkillId = skillId[2]

						if v.skillPassive == orignSkillId then
							passiveSkillDict[i] = {}
							passiveSkillDict[i].skillPassive = newSkillId
						end
					end
				end
			end
		end

		for i = 1, exSkillLevel do
			local co = heroMo.destinyStoneMo:getExpExchangeSkillCo(i)

			if co and not string.nilorempty(co.exchangeSkill) then
				self:_handleReplacePassiveSkill(co.exchangeSkill, passiveSkillDict)
			end
		end
	end

	return passiveSkillDict
end

function SkillConfig:_handleReplacePassiveSkill(passiveSkill, skillIdDict)
	local skillList = string.split(passiveSkill, "|")
	local tempSkillList, oldSkillId, newSkillId

	for _, tempSkillStr in ipairs(skillList) do
		tempSkillList = string.splitToNumber(tempSkillStr, "#")

		for key, passiveSkillCo in pairs(skillIdDict) do
			if passiveSkillCo.skillPassive == tempSkillList[1] then
				skillIdDict[key] = {
					skillPassive = tempSkillList[2]
				}

				break
			end
		end
	end
end

function SkillConfig:getherolevelexskillCO(heroid, skilllevel)
	local exSkillCoDict = self.exskillConfig.configDict[heroid]

	if not exSkillCoDict then
		logError(string.format("ex skill not found heroid : %s `s config ", heroid))

		return nil
	end

	local exSkillCo = exSkillCoDict[skilllevel]

	if exSkillCo == nil then
		logError(string.format("ex skill config gei nil, heroid : %s, skillLevel : %s", heroid, skilllevel))
	end

	return exSkillCoDict[skilllevel]
end

function SkillConfig:getheroexskillco(heroid)
	return self.exskillConfig.configDict[heroid]
end

function SkillConfig:getExSkillLevel(exSkillId)
	if not self._exSkillLevel then
		self._exSkillLevel = {}

		for _, co in ipairs(self.exskillConfig.configList) do
			self._exSkillLevel[co.skillEx] = co.skillLevel
		end
	end

	return self._exSkillLevel[exSkillId]
end

function SkillConfig:getherolevelCO(heroid, level)
	return self.levelConfig.configDict[heroid][level]
end

function SkillConfig:getherolevelsCO(heroid)
	return self.levelConfig.configDict[heroid]
end

function SkillConfig:getherorankCO(heroid, rank)
	return self.rankConfig.configDict[heroid][rank]
end

function SkillConfig:getheroranksCO(heroid)
	return self.rankConfig.configDict[heroid]
end

function SkillConfig:getHeroRankAttribute(heroid, rank)
	local attribute = {}

	attribute.hp = 0
	attribute.atk = 0
	attribute.def = 0
	attribute.mdef = 0
	attribute.technic = 0

	local rankConfigs = self:getheroranksCO(heroid)

	for _, rankConfig in pairs(rankConfigs) do
		if rank >= rankConfig.rank then
			local rankAttribute = self:getHeroAttributeByRankConfig(rankConfig)

			attribute.hp = attribute.hp + rankAttribute.hp
			attribute.atk = attribute.atk + rankAttribute.atk
			attribute.def = attribute.def + rankAttribute.def
			attribute.mdef = attribute.mdef + rankAttribute.mdef
			attribute.technic = attribute.technic + rankAttribute.technic
		end
	end

	return attribute
end

function SkillConfig:getHeroAttributeByRankConfig(rankConfig)
	local rankAttribute = {}

	rankAttribute.hp = 0
	rankAttribute.atk = 0
	rankAttribute.def = 0
	rankAttribute.mdef = 0
	rankAttribute.technic = 0

	local param = rankConfig.effect

	if string.nilorempty(param) then
		return rankAttribute
	end

	local params = string.split(param, "|")

	for i, effectParam in ipairs(params) do
		local effect = string.split(effectParam, "#")

		if tonumber(effect[1]) == 4 then
			local value = tonumber(effect[2])
			local mul = value / 1000
			local levelConfig = self:getherolevelCO(rankConfig.heroId, 1)

			rankAttribute.hp = rankAttribute.hp + math.floor(levelConfig.hp * mul)
			rankAttribute.atk = rankAttribute.atk + math.floor(levelConfig.atk * mul)
			rankAttribute.def = rankAttribute.def + math.floor(levelConfig.def * mul)
			rankAttribute.mdef = rankAttribute.mdef + math.floor(levelConfig.mdef * mul)
			rankAttribute.technic = rankAttribute.technic + math.floor(levelConfig.technic * mul)
		end
	end

	return rankAttribute
end

function SkillConfig:getcosumeCO(level, rare)
	return self.cosumeConfig.configDict[level][rare]
end

function SkillConfig:getSkillEffectDescsCo()
	return self.skillEffectDescConfig.configDict
end

function SkillConfig:getSkillEffectDescCo(effId)
	return self.skillEffectDescConfig.configDict[effId]
end

function SkillConfig:getSkillEffectDescCoByName(name)
	if not self.skillBuffDescConfigByName then
		self.skillBuffDescConfigByName = {}

		for i, v in ipairs(self.skillEffectDescConfig.configList) do
			self.skillBuffDescConfigByName[v.name] = v
		end
	end

	local co = self.skillBuffDescConfigByName[name]

	if not co then
		logError(string.format("技能概要 '%s' 不存在!!!", tostring(name)))
	end

	return co
end

function SkillConfig:processSkillDesKeyWords(str)
	return string.gsub(str, "<id:(.-)>", "")
end

function SkillConfig:getSkillBuffDescsCo()
	return self.skillBuffDescConfig.configDict
end

function SkillConfig:getSkillBuffDescCo(buffId)
	return self.skillBuffDescConfig.configDict[buffId]
end

function SkillConfig:isGetNewSkin(heroId, rank)
	local rankCo = self:getherorankCO(heroId, rank)

	if not rankCo then
		logError("获取角色升级信息失败， heroId : " .. tostring(heroId) .. ", rank : " .. tostring(rank))

		return false
	end

	local effects = string.split(rankCo.effect, "|")

	for i = 1, #effects do
		local effect = string.splitToNumber(effects[i], "#")

		if effect[1] == 3 then
			return true
		end
	end

	return false
end

function SkillConfig:getBaseAttr(hero_id, level)
	local attr_tab = {}
	local level_config = self:getherolevelCO(hero_id, level)

	if not level_config then
		local temp_dic = self:getherolevelsCO(hero_id)
		local cur_stage, next_stage
		local temp_list = {}

		for k, v in pairs(temp_dic) do
			table.insert(temp_list, v)
		end

		table.sort(temp_list, function(item1, item2)
			return item1.level < item2.level
		end)

		for i, v in ipairs(temp_list) do
			if level > v.level then
				cur_stage = v.level
				next_stage = temp_list[i + 1].level
			end
		end

		local cur_state_config = self:getherolevelCO(hero_id, cur_stage)
		local next_stage_config = self:getherolevelCO(hero_id, next_stage)

		attr_tab.hp = self:_lerpAttr(cur_state_config.hp, next_stage_config.hp, cur_stage, next_stage, level)
		attr_tab.atk = self:_lerpAttr(cur_state_config.atk, next_stage_config.atk, cur_stage, next_stage, level)
		attr_tab.def = self:_lerpAttr(cur_state_config.def, next_stage_config.def, cur_stage, next_stage, level)
		attr_tab.mdef = self:_lerpAttr(cur_state_config.mdef, next_stage_config.mdef, cur_stage, next_stage, level)
		attr_tab.technic = self:_lerpAttr(cur_state_config.technic, next_stage_config.technic, cur_stage, next_stage, level)
		attr_tab.cri = self:_lerpAttr(cur_state_config.cri, next_stage_config.cri, cur_stage, next_stage, level)
		attr_tab.recri = self:_lerpAttr(cur_state_config.recri, next_stage_config.recri, cur_stage, next_stage, level)
		attr_tab.cri_dmg = self:_lerpAttr(cur_state_config.cri_dmg, next_stage_config.cri_dmg, cur_stage, next_stage, level)
		attr_tab.cri_def = self:_lerpAttr(cur_state_config.cri_def, next_stage_config.cri_def, cur_stage, next_stage, level)
		attr_tab.add_dmg = self:_lerpAttr(cur_state_config.add_dmg, next_stage_config.add_dmg, cur_stage, next_stage, level)
		attr_tab.drop_dmg = self:_lerpAttr(cur_state_config.drop_dmg, next_stage_config.drop_dmg, cur_stage, next_stage, level)
	else
		attr_tab.hp = level_config.hp
		attr_tab.atk = level_config.atk
		attr_tab.def = level_config.def
		attr_tab.mdef = level_config.mdef
		attr_tab.technic = level_config.technic
		attr_tab.cri = level_config.cri
		attr_tab.recri = level_config.recri
		attr_tab.cri_dmg = level_config.cri_dmg
		attr_tab.cri_def = level_config.cri_def
		attr_tab.add_dmg = level_config.add_dmg
		attr_tab.drop_dmg = level_config.drop_dmg
	end

	return attr_tab
end

function SkillConfig:_lerpAttr(minAttr, maxAttr, minStage, maxStage, level)
	return math.floor((maxAttr - minAttr) * (level - minStage) / (maxStage - minStage)) + minAttr
end

function SkillConfig:getTalentDamping()
	if self.talent_damping then
		return self.talent_damping
	end

	self.talent_damping = {}

	local tab = string.split(lua_fight_const.configDict[10][2], "|")

	for i, v in ipairs(tab) do
		local arr = string.splitToNumber(v, "#")

		table.insert(self.talent_damping, arr)
	end

	return self.talent_damping
end

function SkillConfig:getExSkillDesc(skillExCo, heroId)
	if skillExCo == nil then
		return ""
	end

	local desc = skillExCo.desc

	heroId = heroId or skillExCo.heroId

	local matchInfos = {}

	for k, v in string.gmatch(desc, "▩(%d)%%s<(%d)>") do
		local info = self:_matchChioceSkill(k, v, heroId)

		if info then
			table.insert(matchInfos, info)
		end
	end

	local _, matchInfo = next(matchInfos)

	if matchInfo then
		return desc, matchInfo.skillName, matchInfo.skillIndex, matchInfos
	end

	local _, _, skillIndex = string.find(desc, "▩(%d)%%s")

	if not skillIndex then
		logError("not fount skillIndex in desc : " .. desc)

		return desc
	end

	skillIndex = tonumber(skillIndex)

	local skillId

	if skillIndex == 0 then
		skillId = SkillConfig.instance:getpassiveskillsCO(heroId)[1].skillPassive
	else
		local skillIds = SkillConfig.instance:getHeroBaseSkillIdDict(heroId, true)

		skillId = skillIds and skillIds[skillIndex]
	end

	if not skillId then
		logError("not fount skillId, skillIndex : " .. skillIndex)

		return desc
	end

	return desc, lua_skill.configDict[skillId].name, skillIndex
end

function SkillConfig:_getHeroWeaponReplaceSkill(heroId)
	local heroMo = HeroModel.instance:getByHeroId(heroId)

	if heroMo and heroMo.extraMo then
		local weaponMo = heroMo.extraMo:getWeaponMo()

		if weaponMo then
			return weaponMo:getReplaceSkill()
		end
	end
end

function SkillConfig:_matchChioceSkill(skillIndex, choiceSkillIndex, heroId)
	if choiceSkillIndex and skillIndex then
		skillIndex = tonumber(skillIndex)
		choiceSkillIndex = tonumber(choiceSkillIndex)

		local skillId

		if skillIndex == 0 then
			skillId = self:getpassiveskillsCO(heroId)[1].skillPassive
		else
			local skillIds = self:getHeroBaseSkillIdDict(heroId, true)

			skillId = skillIds and skillIds[skillIndex]
		end

		local choiceSkillId = self:getFightCardChoiceSkillIdByIndex(skillId, choiceSkillIndex)

		if choiceSkillId then
			local skillName = lua_skill.configDict[choiceSkillId].name

			return {
				skillId = skillId,
				skillName = skillName,
				skillIndex = skillIndex,
				choiceSkillIndex = choiceSkillIndex
			}
		end
	end
end

function SkillConfig:getHeroBaseSkillIdDict(heroId, isCheckReplaceRankSkill, heroMo)
	local skillStr, exSkillStr, isReplaceSkill = self:_getHeroSkillAndExSkill(heroId, isCheckReplaceRankSkill, heroMo)

	return self:getHeroBaseSkillIdDictByStr(skillStr, exSkillStr), isReplaceSkill
end

function SkillConfig:_getHeroSkillAndExSkill(heroId, isCheckReplaceRankSkill, heroMo)
	local heroCo = HeroConfig.instance:getHeroCO(heroId)
	local skillStr = heroCo.skill
	local exSkillStr = heroCo.exSkill
	local deviceMo = self:getHeroDeviceMO(heroId, heroMo)

	if deviceMo then
		skillStr, exSkillStr = deviceMo:getSkillIdsStr()
	end

	if isCheckReplaceRankSkill then
		local rankReplaceCo = HeroConfig.instance:getHeroRankReplaceConfig(heroId)

		if rankReplaceCo then
			skillStr = rankReplaceCo.skill
			exSkillStr = rankReplaceCo.exSkill

			return rankReplaceCo.skill, rankReplaceCo.exSkill
		end
	end

	local skill, exSkill = self:_getHeroWeaponReplaceSkill(heroId)

	if skill or exSkill then
		skillStr = skill or skillStr
		exSkillStr = exSkill or exSkillStr

		return skillStr, exSkillStr, true
	end

	return skillStr, exSkillStr
end

function SkillConfig:getHeroBaseSkillIdDictByStr(skillStr, exSkill)
	local skillIdDict = {}
	local skills = string.split(skillStr, "|")
	local skillId, skillKey, splitSkill

	for i = 1, #skills do
		local _skillId = string.split(skills[i], ",")

		splitSkill = string.splitToNumber(_skillId[1], "#")

		if splitSkill[1] then
			skillIdDict[splitSkill[1]] = splitSkill[2]
		end
	end

	skillIdDict[3] = exSkill

	return skillIdDict
end

function SkillConfig:getHeroAllSkillIdDict(heroId, isCheckReplaceRankSkill, heroMo)
	local skillStr, exSkillStr, isReplaceSkill = self:_getHeroSkillAndExSkill(heroId, isCheckReplaceRankSkill, heroMo)

	return self:getHeroAllSkillIdDictByStr(skillStr, exSkillStr), isReplaceSkill
end

function SkillConfig:getHeroAllSkillIdDictByStr(skill, exSkill)
	local skillIdDict = {}
	local skills = string.split(skill, "|")
	local skillKey, splitSkill

	for i = 1, #skills do
		local _skillId = string.split(skills[i], ",")

		splitSkill = string.splitToNumber(_skillId[1], "#")
		skillIdDict[table.remove(splitSkill, 1)] = splitSkill
	end

	skillIdDict[3] = {
		exSkill
	}

	return skillIdDict
end

function SkillConfig:_isNeedReplaceExSkill(heroMo, rank)
	if heroMo and lua_character_rank_replace.configDict[heroMo.heroId] then
		if not heroMo.rank then
			local limitedCo = lua_character_limited.configDict[heroMo.skin]
			local specialLive2d = string.split(limitedCo.specialLive2d, "#")
			local rank = specialLive2d[2] and tonumber(specialLive2d[2]) or 3

			return ((rank or nil) and rank) > rank - 1
		end
	end

	return true
end

function SkillConfig:getHeroBaseSkillIdDictByExSkillLevel(heroId, showAttributeOption, heroMo, balanceHelper)
	if heroMo and heroMo.trialAttrCo then
		local SkillIdDict = self:getHeroBaseSkillIdDictByStr(heroMo.trialAttrCo.activeSkill, heroMo.trialAttrCo.uniqueSkill)

		SkillIdDict = self:_checkReplaceSkill(SkillIdDict, heroMo)

		return SkillIdDict
	end

	local rank = heroMo and heroMo.rank

	if balanceHelper and balanceHelper.getIsBalanceMode() then
		local balanceLv, balanceRank, balanceTalent = balanceHelper.getHeroBalanceInfo(heroId)

		if balanceRank then
			rank = balanceRank
		end
	end

	if rank then
		::label_44_0::

		local isCheckReplaceRankSkill = true
		local isCheckReplaceRankSkill

		if rank <= CharacterModel.instance:getReplaceSkillRank(heroMo) - 1 then
			isCheckReplaceRankSkill = false
		end

		local baseSkillIdDict = self:getHeroBaseSkillIdDict(heroId, isCheckReplaceRankSkill, heroMo)

		heroMo = heroMo or HeroModel.instance:getByHeroId(heroId)

		if self:_isNeedReplaceExSkill(heroMo, rank) then
			baseSkillIdDict = self:getHeroExBaseSkillIdDict(heroId, heroMo, baseSkillIdDict, showAttributeOption)
		end

		baseSkillIdDict = self:_checkDestinyEffect(baseSkillIdDict, heroMo)

		return baseSkillIdDict
	end
end

function SkillConfig:getHeroExBaseSkillIdDict(heroId, heroMo, baseSkillIdDict, showAttributeOption)
	showAttributeOption = showAttributeOption or CharacterEnum.showAttributeOption.ShowCurrent

	local exSkillLevel = 0

	exSkillLevel = showAttributeOption == CharacterEnum.showAttributeOption.ShowMax and CharacterModel.instance:getMaxexskill(heroId) or showAttributeOption == CharacterEnum.showAttributeOption.ShowMin and 0 or heroMo.exSkillLevel

	if heroMo and heroMo.destinyStoneMo then
		local co = heroMo.destinyStoneMo:getExpExchangeSkillCo(exSkillLevel)

		if co then
			if not string.nilorempty(co.skillGroup1) then
				baseSkillIdDict[1] = string.splitToNumber(co.skillGroup1, "|")[1]
			end

			if not string.nilorempty(co.skillGroup2) then
				baseSkillIdDict[2] = string.splitToNumber(co.skillGroup2, "|")[1]
			end

			if co.skillEx ~= 0 then
				baseSkillIdDict[3] = co.skillEx
			end

			baseSkillIdDict = self:_checkReplaceSkill(baseSkillIdDict, heroMo)

			return baseSkillIdDict
		end
	end

	if exSkillLevel < 1 then
		baseSkillIdDict = self:_checkReplaceSkill(baseSkillIdDict, heroMo)

		return baseSkillIdDict
	end

	exSkillLevel = math.min(exSkillLevel, CharacterEnum.MaxSkillExLevel)

	local skillExLevelCo

	for i = 1, exSkillLevel do
		skillExLevelCo = self:getherolevelexskillCO(heroId, i)

		if not string.nilorempty(skillExLevelCo.skillGroup1) then
			baseSkillIdDict[1] = string.splitToNumber(skillExLevelCo.skillGroup1, "|")[1]
		end

		if not string.nilorempty(skillExLevelCo.skillGroup2) then
			baseSkillIdDict[2] = string.splitToNumber(skillExLevelCo.skillGroup2, "|")[1]
		end

		if skillExLevelCo.skillEx ~= 0 then
			baseSkillIdDict[3] = skillExLevelCo.skillEx
		end
	end

	baseSkillIdDict = self:_checkReplaceSkill(baseSkillIdDict, heroMo)

	return baseSkillIdDict
end

function SkillConfig:_checkReplaceSkill(skillIdList, heroMo)
	if skillIdList and heroMo then
		skillIdList = heroMo:checkReplaceSkill(skillIdList)
	end

	return skillIdList
end

function SkillConfig:_checkDestinyEffect(skillIdList, heroMo)
	if skillIdList and heroMo and heroMo.destinyStoneMo then
		skillIdList = heroMo.destinyStoneMo:_replaceSkill(skillIdList)
	end

	return skillIdList
end

function SkillConfig:getHeroAllSkillIdDictByExSkillLevel(heroId, showAttributeOption, heroMo, exSkillLv, isCheckOverRank, balanceHelper)
	if heroMo and heroMo.trialAttrCo then
		return self:getHeroAllSkillIdDictByStr(heroMo.trialAttrCo.activeSkill, heroMo.trialAttrCo.uniqueSkill)
	end

	local rank = heroMo and heroMo.rank

	if balanceHelper and balanceHelper.getIsBalanceMode() then
		local balanceLv, balanceRank, balanceTalent = balanceHelper.getHeroBalanceInfo(heroId)

		if balanceRank then
			rank = balanceRank
		end
	end

	if not isCheckOverRank and rank then
		::label_48_1::

		local isCheckOverRank = true
		local isCheckOverRank

		if rank <= CharacterModel.instance:getReplaceSkillRank(heroMo) - 1 then
			isCheckOverRank = false
		end

		local allSkillIdDict, isReplaceSkill = self:getHeroAllSkillIdDict(heroId, isCheckOverRank, heroMo)

		if isReplaceSkill then
			return allSkillIdDict
		end

		heroMo = heroMo or HeroModel.instance:getByHeroId(heroId)

		if not self:_isNeedReplaceExSkill(heroMo, rank) then
			return allSkillIdDict
		end

		showAttributeOption = showAttributeOption or CharacterEnum.showAttributeOption.ShowCurrent

		local exSkillLevel = 0

		if showAttributeOption == CharacterEnum.showAttributeOption.ShowMax then
			exSkillLevel = CharacterModel.instance:getMaxexskill(heroId)
		elseif showAttributeOption == CharacterEnum.showAttributeOption.ShowMin then
			exSkillLevel = 0
		elseif exSkillLv then
			exSkillLevel = exSkillLv
		elseif heroMo then
			exSkillLevel = heroMo.exSkillLevel
		end

		if heroMo and heroMo.destinyStoneMo then
			local co = heroMo.destinyStoneMo:getExpExchangeSkillCo(exSkillLevel)

			if co then
				if not string.nilorempty(co.skillGroup1) then
					allSkillIdDict[1] = string.splitToNumber(co.skillGroup1, "|")
				end

				if not string.nilorempty(co.skillGroup2) then
					allSkillIdDict[2] = string.splitToNumber(co.skillGroup2, "|")
				end

				if co.skillEx ~= 0 then
					allSkillIdDict[3] = {
						co.skillEx
					}
				end

				allSkillIdDict = self:_checkReplaceSkill(allSkillIdDict, heroMo)

				return allSkillIdDict
			end
		end

		if exSkillLevel < 1 then
			return allSkillIdDict
		end

		local skillExLevelCo

		for i = 1, exSkillLevel do
			skillExLevelCo = self:getherolevelexskillCO(heroId, i)

			if not string.nilorempty(skillExLevelCo.skillGroup1) then
				allSkillIdDict[1] = string.splitToNumber(skillExLevelCo.skillGroup1, "|")
			end

			if not string.nilorempty(skillExLevelCo.skillGroup2) then
				allSkillIdDict[2] = string.splitToNumber(skillExLevelCo.skillGroup2, "|")
			end

			if skillExLevelCo.skillEx ~= 0 then
				allSkillIdDict[3] = {
					skillExLevelCo.skillEx
				}
			end
		end

		allSkillIdDict = self:_checkReplaceSkill(allSkillIdDict, heroMo)

		return allSkillIdDict
	end
end

function SkillConfig:getRankLevelByLevel(heroId, level)
	local rankConfigDict = self.rankConfig.configDict[heroId]

	if not rankConfigDict then
		return 0
	end

	local rankCoList = {}

	for _, rankCo in pairs(rankConfigDict) do
		table.insert(rankCoList, rankCo)
	end

	table.sort(rankCoList, function(a, b)
		return a.rank < b.rank
	end)

	local rank = 1

	for _, rankCo in ipairs(rankCoList) do
		local rankLevelToMaxLevel = 0

		for _, effect in pairs(GameUtil.splitString2(rankCo.effect, true, "|", "#")) do
			if effect[1] == 1 then
				rankLevelToMaxLevel = effect[2]

				break
			end
		end

		if level <= rankLevelToMaxLevel then
			return rankCo.rank
		end
	end

	return rank
end

function SkillConfig:getConstNum(constId)
	local constStr = self:getConstStr(constId)

	if string.nilorempty(constStr) then
		return 0
	else
		return tonumber(constStr)
	end
end

function SkillConfig:getConstStr(constId)
	local constCO = lua_fight_const.configDict[constId]

	if not constCO then
		printError("fight const not exist: ", constId)

		return nil
	end

	local value = constCO.value

	if not string.nilorempty(value) then
		return value
	end

	return constCO.value2
end

function SkillConfig:getHeroUpgradeSkill(skillList)
	if not skillList then
		return false, {}
	end

	local upList = {}

	for i, skillId in ipairs(skillList) do
		local config = self.heroUpgradeBreakLevelConfig.configDict[skillId]

		if config then
			upList[#upList + 1] = config.upgradeSkillId
		end
	end

	return #upList > 0, upList
end

function SkillConfig:getFightCardChoice(skillDict)
	if not skillDict then
		return
	end

	local skillIdDict = {}

	for _, skillId in ipairs(skillDict) do
		local skillCo = lua_fight_card_choice.configDict[skillId]

		if not skillCo then
			return
		end

		local skills = string.splitToNumber(skillCo.choiceSkIlls, "#")

		for i, _skillId in ipairs(skills) do
			skillIdDict[i] = skillIdDict[i] or {}

			table.insert(skillIdDict[i], _skillId)
		end
	end

	return skillIdDict
end

function SkillConfig:getFightCardChoiceSkillIdByIndex(skillId, index)
	local config = lua_fight_card_choice.configDict[skillId]

	if config then
		local choiceSkills = string.splitToNumber(config.choiceSkIlls, "#")

		return choiceSkills[index]
	end
end

function SkillConfig:getFightCardFootnoteConfig(skillId)
	return self.fightCardFootnoteConfig.configDict[skillId]
end

function SkillConfig:getHeroDeviceMO(heroId, heroMo)
	if heroMo and heroMo:getDeviceMo() then
		return heroMo:getDeviceMo()
	end

	self._heroDeviceMO = self._heroDeviceMO or {}

	local mo = self._heroDeviceMO[heroId]

	if not mo then
		local heroCo = HeroConfig.instance:getHeroCO(heroId)
		local deviceId = heroCo and heroCo.deviceId

		if deviceId and deviceId > 0 then
			mo = HeroDeviceMO.New(heroId)

			mo:refreshDevice(deviceId)

			self._heroDeviceMO[heroId] = mo
		end
	end

	return mo
end

SkillConfig.instance = SkillConfig.New()

return SkillConfig
