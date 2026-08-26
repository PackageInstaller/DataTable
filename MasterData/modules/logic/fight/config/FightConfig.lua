-- chunkname: @modules/logic/fight/config/FightConfig.lua

module("modules.logic.fight.config.FightConfig", package.seeall)

local FightConfig = class("FightConfig", BaseConfig)

function FightConfig:ctor()
	self._skillCurrCardLvDict = nil
	self._skillNextCardLvDict = nil
	self._skillPrevCardLvDict = nil
	self._skillHeroIdDict = nil
	self._skillMonsterIdDict = nil
	self._skinSkillTLDict = nil
	self._buffFeatureDict = {}
	self._buffFeatureDictDict = {}
	self._buffId2FeatureIdList = {}
	self._restrainDict = nil
	self._monsterId2UniqueId = {}
end

function FightConfig:reqConfigNames()
	local list = {
		"card_description",
		"stance",
		"stance_pata_switch_scene",
		"character",
		"monster",
		"monster_group",
		"monster_template",
		"skin",
		"monster_skin",
		"skill",
		"skill_effect",
		"skill_buff",
		"skill_bufftype",
		"buff_act",
		"skin_spine_action",
		"fight_effect",
		"fight_voice",
		"skill_behavior",
		"fight_technique",
		"skill_behavior_condition",
		"battle_dialog",
		"monster_skill_template",
		"fight_music",
		"monster_guide_focus",
		"fight_timeline_speed",
		"fight_transition_act",
		"fight_stacked_buff_combine",
		"fight_die_act_enemyus",
		"skill_specialbuff",
		"fight_skill_delay",
		"fight_prompt",
		"trigger_action",
		"fight_summon_show",
		"fight_assembled_monster",
		"fight_monster_display_condition",
		"fight_effect_buff_skin",
		"fight_buff_effect_to_skin",
		"fight_debut_show",
		"stance_hp_offset",
		"bossrush_skin_effect",
		"fight_monster_use_character_effect",
		"fight_buff_use_poison_ui_effect",
		"summoned",
		"fight_summoned_stance",
		"fight_next_round_get_card",
		"fight_skin_special_behaviour",
		"fight_replace_timeline",
		"magic_circle",
		"magic_circle_by_skill_flow",
		"fight_dead_entity_mgr",
		"fight_buff_reject_act",
		"boss_action",
		"boss_action_list",
		"fight_monster_unique_index",
		"fight_boss_evolution_client",
		"fight_replay_enter_scene_root_active",
		"fight_buff_replace_spine_act",
		"hero_upgrade",
		"hero_upgrade_options",
		"fight_upgrade_show_skillid",
		"card_enchant",
		"fight_camera_player_turn_offset",
		"resonance",
		"polarization",
		"fight_buff_layer_effect",
		"fight_buff_layer_effect_nana",
		"fight_skin_replay_lasthit",
		"resistances_attribute",
		"fight_skin_dead_performance",
		"ai_monster_target",
		"ai_monster_card_tag",
		"assist_boss_stance",
		"fight_skin_replace_magic_effect",
		"simple_polarization",
		"fight_card_pre_delete",
		"ai_mark_skill",
		"monster_instance",
		"monster_sub",
		"monster_level",
		"monster_job",
		"card_heat",
		"fight_float_effect",
		"fight_task",
		"fight_monster_skin_idle_map",
		"fight_replace_buff_act_effect",
		"fight_replace_skill_behavior_effect",
		"skill_next",
		"fight_xcjl_const",
		"fight_she_fa_ignite",
		"fight_dnsz",
		"fight_6_buff_effect",
		"fight_lzl_buff_float",
		"fight_buff_layer_effect_enemy_skin",
		"fight_buff_type_id_2_scene_effect",
		"fight_card_choice",
		"buff_mat_variant",
		"character_rank_replace",
		"fight_skin_scale_by_z",
		"fight_luxi_upgrade_effect",
		"fight_kill",
		"fight_common_buff_effect_2_skin",
		"fight_buff2special_behaviour",
		"fight_tower_500m_boss_behaviour",
		"fight_gao_si_niao_buffeffect_electric_level",
		"fight_sp_500m_model",
		"fight_ignore_hide_front_effect",
		"monster_skin_custom_click_box",
		"fight_appear_timeline_extend",
		"fight_yi_suo_er_de_ball",
		"fight_jgz_const",
		"fight_jia_la_bo_na_ball",
		"fight_jia_la_bo_na_line",
		"fight_jia_la_bo_na_ball_audio",
		"fight_rouge2_music",
		"fight_rouge2_music_ball_skill",
		"fight_rouge2_check_relic",
		"fight_rouge2_level",
		"fight_rouge2_relic_type",
		"zongmao_boss_stage_buffid_effect",
		"battle_selection",
		"fight_skill_force_use",
		"fight_change_buff_effect_by_skin",
		"magic_wqsz",
		"toughnessskill",
		"fight_ya_mi_hu_ti_effect",
		"fight_monster_3d",
		"fight_camera_rorate_when_idle",
		"fight_scene_level_camera_shadow",
		"fight_spell_show_type",
		"skill_target_type_define",
		"fight_direct_switch_battle_when_end",
		"fight_dian_ji_shi_buff_effect",
		"fight_effect_follow_entity_visible",
		"fight_effect_group",
		"fight_skin_entity_enter_timeline",
		"fight_na_xi_suo_si_immunity_effect"
	}

	if SLFramework.FrameworkSettings.IsEditor then
		table.insert(list, "activity174_test_bot")
		table.insert(list, "activity174_test_role")
		table.insert(list, "editor_skill_tag")
		table.insert(list, "editor_role_sources")
		table.insert(list, "auto_fight_role_tool")
		table.insert(list, "auto_fight_team_tool")
		table.insert(list, "auto_fight_tool_const")
	end

	return list
end

function FightConfig:getSkinCO(skinId)
	local skinCO = lua_skin.configDict[skinId]

	skinCO = skinCO or lua_monster_skin.configDict[skinId]

	return skinCO
end

function FightConfig:getAudioId(skinId, fightAudioType)
	local skinCO = self:getSkinCO(skinId)
	local showTemplate = skinCO and skinCO.showTemplate
	local skinVoiceConf = showTemplate and lua_fight_voice.configDict[showTemplate]

	if skinVoiceConf then
		return skinVoiceConf["audio_type" .. fightAudioType]
	end
end

function FightConfig:onConfigLoaded(configName, configTable)
	if configName == "fight_effect" then
		self._restrainDict = {}

		for _, oneCO in ipairs(configTable.configList) do
			local careerTb = {}

			self._restrainDict[oneCO.id] = careerTb

			for i = 1, 6 do
				careerTb[i] = oneCO["career" .. i]
			end
		end
	elseif configName == "skill" then
		self._hasLoadSkill = true

		self:_rebuildSkillEffect()
	elseif configName == "skill_effect" then
		self._hasLoadSkillEffect = true

		self:_rebuildSkillEffect()
	elseif configName == "monster" then
		self._hasLoadMonster = true

		self:_rebuildMonsterSkin()
	elseif configName == "skin" then
		self._hasLoadSkin = true

		self:_rebuildMonsterSkin()
	elseif configName == "skill_buff" then
		-- block empty
	elseif configName == "fight_buff_reject_act" then
		self:_dealFightBuffRejectAct()
	elseif configName == "monster_group" then
		self:_checkMonsterGroupBoss0()
	elseif configName == "skin_spine_action" then
		-- block empty
	elseif configName == "character" then
		local function errorFunc(_, key, value)
			logError("Can't modify config field: " .. key)
		end

		for _, config in ipairs(configTable.configList) do
			local metatable = getmetatable(config)

			metatable.__newindex = nil
			config.skill = string.split(config.skill, ",")[1]

			if config.id == 3135 then
				config.skill = "1#31350111#31350112#31350113|2#31350121#31350122#31350123"
			end

			metatable.__newindex = errorFunc
		end
	end
end

function FightConfig:_rebuildSkillEffect()
	if not self._hasLoadSkill or not self._hasLoadSkillEffect then
		return
	end

	local skillMetatable = getmetatable(lua_skill.configList[1])
	local metatable = {}

	function metatable.__index(t, key)
		local value = skillMetatable.__index(t, key)

		if not value then
			local skillEffect = t.skillEffect
			local skillEffectCO = lua_skill_effect.configDict[skillEffect]

			if skillEffectCO then
				if isDebugBuild or SLFramework.FrameworkSettings.IsEditor then
					if key == "desc" and not FightConfig.instance:isSetDescFlag() then
						logError("获取调用效果 desc 字段， 必须使用 FightConfig.getSkillEffectDesc 函数")
					end

					value = skillEffectCO[key]
				else
					value = skillEffectCO[key]
				end
			else
				logError(t.id .. " 技能效果模版不存在：" .. skillEffect)
			end
		end

		return value
	end

	metatable.__newindex = skillMetatable.__newindex

	for _, skillCO in ipairs(lua_skill.configList) do
		setmetatable(skillCO, metatable)
	end

	self:_rebuildSkillEffectTab()
end

function FightConfig:_rebuildMonsterSkin()
	if not self._hasLoadMonster or not self._hasLoadSkin then
		return
	end

	local monsterMetatable = getmetatable(lua_monster.configList[1])
	local metatable = {}

	function metatable.__index(t, key)
		local value = monsterMetatable.__index(t, key)

		if key == "career" then
			if value and value > 0 then
				return value
			end
		elseif value then
			return value
		end

		local skillTemplate = t.skillTemplate
		local templateCO = lua_monster_skill_template.configDict[skillTemplate]

		if not templateCO then
			logError(t.id .. " 技能效果模版不存在：" .. skillTemplate)

			return nil
		end

		value = templateCO[key]

		if templateCO[key] then
			if key == "uniqueSkill" then
				local monsterId = t.id
				local uniqueSkillIndex = t.uniqueSkillLevel

				if not self._monsterId2UniqueId[monsterId] then
					local uniqueSkillList = {}
					local uniqueSkill
					local skills = FightStrUtil.instance:getSplitCache(templateCO.uniqueSkill, "|")
					local indexConfig = lua_fight_monster_unique_index.configDict[monsterId]

					if indexConfig then
						uniqueSkillIndex = indexConfig.index
					end

					for _, skill in ipairs(skills) do
						uniqueSkill = FightStrUtil.instance:getSplitToNumberCache(skill, "#")

						table.insert(uniqueSkillList, uniqueSkill[uniqueSkillIndex <= #uniqueSkill and uniqueSkillIndex or #uniqueSkill])
					end

					self._monsterId2UniqueId[monsterId] = uniqueSkillList
				end

				value = self._monsterId2UniqueId[monsterId]
			end

			return value
		end

		local skinId = t.skinId
		local skinCO = FightConfig.instance:getSkinCO(skinId)

		return skinCO[key]
	end

	metatable.__newindex = monsterMetatable.__newindex

	for _, monsterCO in ipairs(lua_monster.configList) do
		setmetatable(monsterCO, metatable)
	end

	if isDebugBuild then
		self:checkMonsterEffectPath()
		self:checkSkinEffectPath()
	end
end

function FightConfig:checkMonsterEffectPath()
	for _, monsterCO in ipairs(lua_monster.configList) do
		local effect = monsterCO.effect

		if not string.nilorempty(effect) then
			local effectArr = string.split(effect, "#")

			for i, effect in ipairs(effectArr) do
				if not string.match(effect, "^buff/") then
					logError(string.format("怪物表 id ： %s, 特效配置不在buff目录下. effect : %s", monsterCO.id, monsterCO.effect))

					break
				end
			end
		end
	end
end

function FightConfig:checkSkinEffectPath()
	for _, skinCo in ipairs(lua_skin.configList) do
		local effect = skinCo.effect

		if not string.nilorempty(effect) then
			local effectArr = string.split(effect, "#")

			for i, effect in ipairs(effectArr) do
				if not string.match(effect, "^buff/") then
					logError(string.format("皮肤表 id ： %s, 特效配置不在buff目录下. effect : %s", skinCo.id, skinCo.effect))

					break
				end
			end
		end
	end
end

function FightConfig:checkSpineBornPath()
	for _, spineCo in ipairs(lua_skin_spine_action.configList) do
		if spineCo.actionName == SpineAnimState.born then
			local effect = spineCo.effect

			if not string.nilorempty(effect) then
				local effectArr = FightStrUtil.instance:getSplitCache(effect, "#")

				for i, effect in ipairs(effectArr) do
					if not string.match(effect, "^buff/") then
						logError(string.format("皮肤表, 战斗动作表现表 id ： %s, born 特效 配置不在buff目录下. effect : %s", spineCo.id, spineCo.effect))

						break
					end
				end
			end
		end
	end
end

function FightConfig:getSkinSkillTimeline(skinId, skillId)
	self:_checkskinSkill()

	local skinSkillDict = skinId and self._skinSkillTLDict[skinId]

	if skinSkillDict then
		local timeline = skinSkillDict[skillId]

		if timeline then
			return timeline
		end
	end

	local skillCO = lua_skill.configDict[skillId]

	if not skillCO then
		return
	end

	return skillCO.timeline
end

function FightConfig:_filterSpeicalSkillIds(passiveSkillIds, isSpecial)
	local specialIds = {}
	local normalIds = {}

	for i = 1, #passiveSkillIds do
		local id = passiveSkillIds[i]

		if lua_skill_specialbuff.configDict[id] then
			local co = lua_skill_specialbuff.configDict[id]

			if co.isSpecial == 1 then
				table.insert(specialIds, passiveSkillIds[i])
			else
				table.insert(normalIds, passiveSkillIds[i])
			end
		else
			table.insert(normalIds, passiveSkillIds[i])
		end
	end

	return isSpecial and specialIds or normalIds
end

function FightConfig:getSkillLv(skillId)
	self:_checkSkill()

	local skillConfig = lua_skill.configDict[skillId]

	if not skillConfig then
		logError("技能表找不到id:" .. tostring(skillId))

		return 1
	end

	if lua_skill_next.configDict[skillId] then
		return skillConfig.skillRank
	end

	if FightCardDataHelper.isBigSkill(skillId) then
		local specialCo = lua_fight_spell_show_type.configDict[skillId]

		if specialCo then
			return 0
		end

		return FightEnum.UniqueSkillCardLv
	end

	if skillId == FightEnum.UniversalCard1 then
		return 1
	elseif skillId == FightEnum.UniversalCard2 then
		return 2
	end

	return skillConfig.skillRank
end

function FightConfig:getSkillNextLvId(skillId)
	self:_checkSkill()

	return self._skillNextCardLvDict[skillId]
end

function FightConfig:getSkillPrevLvId(skillId)
	self:_checkSkill()

	return self._skillPrevCardLvDict[skillId]
end

function FightConfig:isActiveSkill(skillId)
	if skillId <= 0 then
		return false
	end

	self:_checkSkill()

	if self._skillHeroIdDict[skillId] or self._skillMonsterIdDict[skillId] then
		return true
	end

	return false
end

function FightConfig:getRestrain(career1, career2)
	local careerList = self._restrainDict[career1]

	if careerList then
		return careerList[career2]
	end
end

function FightConfig:getBuffTag(buffName)
	local typeId

	for _, buffco in ipairs(lua_skill_buff.configList) do
		if buffco.name == buffName then
			typeId = buffco.typeId

			break
		end
	end

	if not typeId then
		return ""
	end

	local buffTypeCo = lua_skill_bufftype.configDict[typeId]
	local buffTagCO = buffTypeCo and lua_skill_buff_desc.configDict[buffTypeCo.type]

	if buffTagCO then
		return buffTagCO.name
	end

	return ""
end

function FightConfig:restrainedBy(career)
	if not self._restrainDict then
		return nil
	end

	for k_career, careerTab in pairs(self._restrainDict) do
		if careerTab[career] and careerTab[career] > 1000 then
			return k_career
		end
	end

	return nil
end

function FightConfig:restrained(career)
	local tb = self._restrainDict[career]

	if not tb then
		return nil
	end

	for k, v in pairs(tb) do
		if v > 1000 then
			return k
		end
	end

	return nil
end

function FightConfig:getSkillHeroId(skillId)
	self:_checkSkill()

	return self._skillHeroIdDict[skillId]
end

function FightConfig:setSkillDict(skillCurrCardLvDict, skillNextCardLvDict, skillPrevCardLvDict, skillHeroIdDict, skillMonsterIdDict)
	self._skillCurrCardLvDict = skillCurrCardLvDict
	self._skillNextCardLvDict = skillNextCardLvDict
	self._skillPrevCardLvDict = skillPrevCardLvDict
	self._skillHeroIdDict = skillHeroIdDict
	self._skillMonsterIdDict = skillMonsterIdDict
	self.parseSkill = true
end

function FightConfig:isParsedSkill()
	return self.parseSkill
end

function FightConfig:_checkSkill()
	if self.parseSkill then
		return
	end

	self.parseSkill = true
	self._skillCurrCardLvDict = {}
	self._skillNextCardLvDict = {}
	self._skillPrevCardLvDict = {}
	self._skillHeroIdDict = {}
	self._skillMonsterIdDict = {}

	for _, heroCO in ipairs(lua_character.configList) do
		if not string.nilorempty(heroCO.skill) then
			local activeSkills = FightStrUtil.instance:getSplitString2Cache(heroCO.skill, true)

			for _, oneSkills in ipairs(activeSkills) do
				local s1, s2, s3 = oneSkills[2], oneSkills[3], oneSkills[4]

				self._skillCurrCardLvDict[s1] = 1
				self._skillCurrCardLvDict[s2] = 2
				self._skillCurrCardLvDict[s3] = 3
				self._skillNextCardLvDict[s1] = s2
				self._skillNextCardLvDict[s2] = s3
				self._skillPrevCardLvDict[s2] = s1
				self._skillPrevCardLvDict[s3] = s2

				local heroId = heroCO.id

				self._skillHeroIdDict[s1] = heroId
				self._skillHeroIdDict[s2] = heroId
				self._skillHeroIdDict[s3] = heroId
			end
		end
	end

	for _, exSkillCO in ipairs(lua_skill_ex_level.configList) do
		local heroId = exSkillCO.heroId
		local skillGroup1 = exSkillCO.skillGroup1

		if not string.nilorempty(skillGroup1) then
			local temp = FightStrUtil.instance:getSplitToNumberCache(skillGroup1, "|")

			for level, skillId in ipairs(temp) do
				self._skillHeroIdDict[skillId] = heroId
				self._skillCurrCardLvDict[skillId] = level
			end
		end

		local skillGroup2 = exSkillCO.skillGroup2

		if not string.nilorempty(skillGroup2) then
			local temp = FightStrUtil.instance:getSplitToNumberCache(skillGroup2, "|")

			for level, skillId in ipairs(temp) do
				self._skillHeroIdDict[skillId] = heroId
				self._skillCurrCardLvDict[skillId] = level
			end
		end

		local skillId = exSkillCO.skillEx

		self._skillHeroIdDict[skillId] = heroId
	end

	for _, monsterCO in ipairs(lua_monster.configList) do
		local monsterId = monsterCO.id
		local activeSkill = FightStrUtil.instance:getSplitString2Cache(monsterCO.activeSkill, true, "|", "#")

		if activeSkill then
			for _, ids in ipairs(activeSkill) do
				local lv = 1

				for _, skillId in ipairs(ids) do
					local skillCO = lua_skill.configDict[skillId]

					if skillCO then
						self._skillMonsterIdDict[skillId] = monsterId
						self._skillCurrCardLvDict[skillId] = lv
						lv = lv + 1
					end
				end
			end
		end

		local uniqueSkill = monsterCO.uniqueSkill

		if uniqueSkill and #uniqueSkill > 0 then
			for _, skillId in ipairs(uniqueSkill) do
				self._skillMonsterIdDict[skillId] = monsterId
			end
		end
	end
end

function FightConfig:_checkskinSkill()
	if self._skinSkillTLDict then
		return
	end

	self._skinSkillTLDict = {}

	self:_doCheckskinSkill(lua_skin.configList)
	self:_doCheckskinSkill(lua_monster_skin.configList)
end

function FightConfig:_doCheckskinSkill(configList)
	for _, skinCO in ipairs(configList) do
		if not string.nilorempty(skinCO.skills) then
			local skillTLDict = {}
			local skillTLs = FightStrUtil.instance:getSplitString2Cache(skinCO.skills, false, "|", "#")

			for _, skillTL in ipairs(skillTLs) do
				local skillId = tonumber(skillTL[1])
				local tlId = skillTL[2]

				if skillId and tlId then
					skillTLDict[skillId] = tlId
				end
			end

			self._skinSkillTLDict[skinCO.id] = skillTLDict
		end
	end
end

function FightConfig:getSkillEffectCO(skillId)
	local skillCO = lua_skill.configDict[skillId]

	return skillCO and lua_skill_effect.configDict[skillCO.skillEffect]
end

function FightConfig:getPassiveSkills(monsterId)
	local passiveSkills
	local monsterCO = lua_monster.configDict[monsterId]

	if monsterCO and monsterCO.passiveSkill then
		passiveSkills = tabletool.copy(FightStrUtil.instance:getSplitToNumberCache(monsterCO.passiveSkill, (string.find(monsterCO.passiveSkill, "#") or nil) and "#"))

		for i = #passiveSkills, monsterCO.passiveSkillCount + 1, -1 do
			passiveSkills[i] = nil
		end
	end

	if not string.nilorempty(monsterCO.passiveSkillsEx) then
		local exList = FightStrUtil.instance:getSplitToNumberCache(monsterCO.passiveSkillsEx, (string.find(monsterCO.passiveSkillsEx, "#") or nil) and "#")

		for _, exSkillId in ipairs(exList) do
			passiveSkills = passiveSkills or {}

			table.insert(passiveSkills, exSkillId)
		end
	end

	return passiveSkills
end

function FightConfig:getPassiveSkillsAfterUIFilter(monsterId)
	local monsterCO = lua_monster.configDict[monsterId]
	local passiveSkillIds = FightConfig.instance:getPassiveSkills(monsterId)
	local filterSkills = FightStrUtil.instance:getSplitToNumberCache(monsterCO.uiFilterSkill, "|")

	for i, v in ipairs(filterSkills) do
		local index = tabletool.indexOf(passiveSkillIds, v)

		if index then
			table.remove(passiveSkillIds, index)
		end
	end

	return passiveSkillIds
end

function FightConfig:getMonsterGuideFocusConfig(id, invokeType, param, monster)
	if lua_monster_guide_focus.configDict[id] and lua_monster_guide_focus.configDict[id][invokeType] and lua_monster_guide_focus.configDict[id][invokeType][param] then
		return lua_monster_guide_focus.configDict[id][invokeType][param][monster]
	end
end

function FightConfig:getNewMonsterConfig(monsterConfig)
	return not string.nilorempty(monsterConfig.highPriorityName) or not string.nilorempty(monsterConfig.highPriorityNameEng) or not string.nilorempty(monsterConfig.highPriorityDes)
end

function FightConfig:getMonsterName(monsterCo)
	return (self:getNewMonsterConfig(monsterCo) or nil) and (monsterCo.highPriorityName or monsterCo.name)
end

function FightConfig:getBuffFeatures(buffId)
	local featureDict = self._buffFeatureDictDict[buffId]

	if not featureDict then
		featureDict = {}

		local buffCO = lua_skill_buff.configDict[buffId]

		if buffCO then
			local featureSp = string.split(buffCO.features, "|")

			if featureSp then
				for _, featureStr in ipairs(featureSp) do
					local arr = string.split(featureStr, "#")
					local featureId = tonumber(arr[1])
					local buffActCO = featureId and lua_buff_act.configDict[featureId]

					if buffActCO and buffActCO.type then
						featureDict[buffActCO.type] = {
							featureType = buffActCO.type,
							featureStr = featureStr
						}
					end
				end
			end
		end

		self._buffFeatureDictDict[buffId] = featureDict
	end

	return featureDict
end

function FightConfig:hasBuffFeature(buffId, featureName)
	return self:getBuffFeatures(buffId)[featureName]
end

function FightConfig:getSkinSpineActionDict(skinId, actName)
	local skinCO = self:getSkinCO(skinId)

	if not skinCO then
		return
	end

	local showTemplate = skinCO.showTemplate
	local spineActionDict = lua_skin_spine_action.configDict[showTemplate]

	if actName and spineActionDict and not spineActionDict[actName] then
		spineActionDict = nil
	end

	if not spineActionDict and lua_skin.configDict[showTemplate] then
		local normal_skin = skinCO.id - skinCO.id % 10 + 1
		local normal_skin_config = FightConfig.instance:getSkinCO(normal_skin)

		if normal_skin_config then
			spineActionDict = lua_skin_spine_action.configDict[normal_skin_config.showTemplate]
		end
	end

	return spineActionDict
end

function FightConfig:getSummonedConfig(id, level)
	return lua_summoned.configDict[id] and lua_summoned.configDict[id][level]
end

function FightConfig:getRejectActBuffTypeList(act)
	return self._rejectSpineAct and self._rejectSpineAct[act]
end

function FightConfig:_dealFightBuffRejectAct()
	self._rejectSpineAct = {}

	for i, config in ipairs(lua_fight_buff_reject_act.configList) do
		local actList = string.split(config.rejectAct, "#")

		for index, name in ipairs(actList) do
			self._rejectSpineAct[name] = self._rejectSpineAct[name] or {}

			table.insert(self._rejectSpineAct[name], config.id)
		end
	end
end

function FightConfig:_checkMonsterGroupBoss0()
	if isDebugBuild then
		local errorList

		for _, monsterGroupCO in ipairs(lua_monster_group.configList) do
			if monsterGroupCO.bossId == "0" then
				errorList = errorList or {}

				table.insert(errorList, monsterGroupCO.id)
			end
		end

		if errorList then
			logError("以下怪物组配错了 bossId = 0，请检查是否有误\n" .. table.concat(errorList, ","))
		end
	end
end

FightConfig.DescNameTag = "{name}"

function FightConfig:getSkillEffectDesc(monsterName, effectCo)
	if not effectCo then
		return ""
	end

	if isDebugBuild or SLFramework.FrameworkSettings.IsEditor then
		self:setGetDescFlag(true)

		local desc = effectCo.desc

		self:setGetDescFlag(false)

		if string.match(desc, FightConfig.DescNameTag) and string.nilorempty(monsterName) then
			local msg = "monster name is nil or empty str, please check !!!"

			msg = msg .. string.format("effectId : %s, effect desc : %s", effectCo.id, desc)

			logError(msg)

			return desc
		end

		if string.nilorempty(monsterName) then
			return desc
		end

		return string.gsub(desc, FightConfig.DescNameTag, monsterName)
	end

	local desc = effectCo.desc

	if string.nilorempty(monsterName) then
		return desc
	end

	return string.gsub(desc, FightConfig.DescNameTag, monsterName)
end

function FightConfig:getEntitySkillDesc(entityId, skillConfig, skillId)
	skillConfig = skillConfig or lua_skill.configDict[skillId]

	if not skillConfig then
		if skillId then
			logError("技能表找不到id : " .. tostring(skillId))
		end

		return ""
	end

	local entityName = self:getEntityName(entityId)

	return self:getSkillEffectDesc(entityName, skillConfig)
end

function FightConfig:getEntityName(entityId)
	local entityMO = FightDataHelper.entityMgr:getById(entityId)
	local entityConfig = entityMO and entityMO:getCO()

	return (entityConfig or nil) and (entityConfig.name or "")
end

function FightConfig:_rebuildSkillEffectTab()
	if isDebugBuild or SLFramework.FrameworkSettings.IsEditor then
		local metatable = getmetatable(lua_skill_effect.configList[1])
		local newMetaTable = {}

		function newMetaTable.__index(t, k)
			if k == "desc" and not FightConfig.instance:isSetDescFlag() then
				logError("获取调用效果 desc 字段， 必须使用 FightConfig.getSkillEffectDesc 函数")
			end

			return metatable.__index(t, k)
		end

		newMetaTable.__newindex = metatable.__newindex

		for _, skillCO in ipairs(lua_skill_effect.configList) do
			setmetatable(skillCO, newMetaTable)
		end
	end
end

function FightConfig:setGetDescFlag(enable)
	self.descFlag = enable
end

function FightConfig:isSetDescFlag()
	return self.descFlag
end

function FightConfig:getMultiHpListByMonsterId(monsterId, isSimple)
	local monsterConfig = lua_monster.configDict[monsterId]

	if not monsterConfig then
		return nil
	end

	local hp = CharacterDataConfig.instance:getMonsterHp(monsterId, isSimple)
	local skillTemplateConfig = lua_monster_skill_template.configDict[monsterConfig.skillTemplate]

	if skillTemplateConfig and skillTemplateConfig.instance > 0 then
		local instanceConfig = lua_monster_instance.configDict[skillTemplateConfig.instance]

		if instanceConfig and instanceConfig.multiHp > 1 then
			local list = {}

			for i = 1, instanceConfig.multiHp do
				table.insert(list, hp)
			end

			return list
		end
	end

	local templateConfig = lua_monster_template.configDict[monsterConfig.template]
	local multiHp = templateConfig and templateConfig.multiHp

	if string.nilorempty(multiHp) then
		return nil
	end

	local multiHpNum = #string.split(multiHp, "#")
	local list = {}

	for i = 1, multiHpNum do
		table.insert(list, hp)
	end

	return list
end

function FightConfig:getJGZTitle()
	return lua_fight_jgz_const.configDict[5].value2
end

function FightConfig:getJGZDesc()
	return lua_fight_jgz_const.configDict[6].value2
end

function FightConfig:getRouge2MusicCo(musicType)
	local co = lua_fight_rouge2_music.configDict[musicType]

	if not co then
		logError("not found music config : " .. tostring(musicType))

		co = lua_fight_rouge2_music.configList[1]
	end

	return co
end

function FightConfig:getCoverType(skillId, entityId)
	if not skillId then
		return FightEnum.CoverType.Normal
	end

	local specialCo = lua_fight_spell_show_type.configDict[skillId]

	if specialCo then
		return FightEnum.CoverType.Normal
	end

	local skillCardLv = FightCardDataHelper.getSkillLv(entityId, skillId)

	return (skillCardLv == FightEnum.UniqueSkillCardLv or nil) and (FightEnum.CoverType.Unique or FightEnum.CoverType.Normal)
end

function FightConfig:getCareerList(career)
	if not career then
		return LuaUtil.emptyTable
	end

	self.careerCacheDict = self.careerCacheDict or {}

	local list = self.careerCacheDict[career]

	if list then
		return list
	end

	local co = lua_fight_effect_group.configDict[career]

	list = co and string.splitToNumber(co.career, "#") or {
		career
	}
	self.careerCacheDict[career] = list

	return list
end

FightConfig.instance = FightConfig.New()

return FightConfig
