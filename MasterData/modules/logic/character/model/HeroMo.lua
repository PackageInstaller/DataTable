-- chunkname: @modules/logic/character/model/HeroMo.lua

module("modules.logic.character.model.HeroMo", package.seeall)

local HeroMo = pureTable("HeroMo")

function HeroMo:ctor()
	self.id = 0
	self.uid = 0
	self.userId = 0
	self.heroId = 0
	self.heroName = ""
	self.createTime = 0
	self.level = 0
	self.exp = 0
	self.rank = 0
	self.breakThrough = 0
	self.skin = 0
	self.faith = 0
	self.activeSkillLevel = 0
	self.passiveSkillLevel = 0
	self.exSkillLevel = 0
	self.voice = nil
	self.voiceHeard = nil
	self.skinInfoList = nil
	self.baseAttr = nil
	self.equipAttrList = nil
	self.isNew = false
	self.itemUnlock = nil
	self.talent = 0
	self.config = nil
	self.talentCubeInfos = nil
	self.defaultEquipUid = 0
	self.birthdayCount = 0
	self.talentStyleUnlock = nil
	self.isFavor = false
	self.destinyStoneMo = nil
	self.trialCo = nil
	self.trialAttrCo = nil
	self.trialEquipMo = nil
	self.isPosLock = false
	self.duplicateCount = 0
	self.belongOtherPlayer = false
	self.otherPlayerEquipMo = nil
	self.extraStr = nil
	self.deviceMo = nil
end

function HeroMo:init(info, config)
	self:update(info)

	self.config = config
end

function HeroMo:isTrial()
	return not not self.trialCo
end

function HeroMo:setIsBelongOtherPlayer(isOther)
	self.belongOtherPlayer = not not isOther
end

function HeroMo:isOtherPlayerHero()
	return self.belongOtherPlayer
end

function HeroMo:setOtherPlayerEquipMo(equipMo)
	self.otherPlayerEquipMo = equipMo
end

function HeroMo:getOtherPlayerEquipMo()
	return self.otherPlayerEquipMo
end

function HeroMo:setOtherPlayerIsOpenTalent(isOpenTalent)
	self.otherPlayerIsOpenTalent = isOpenTalent
end

function HeroMo:getOtherPlayerIsOpenTalent()
	return self.otherPlayerIsOpenTalent
end

function HeroMo:getOtherPlayerTalentStyle()
	return self.style
end

function HeroMo:setOtherPlayerTalentStyle(style)
	self.style = style
end

function HeroMo:getTrialEquipMo()
	local trialEquipMo

	return (self:isTrial() or nil) and self.trialEquipMo
end

function HeroMo:isOwnHero()
	local isTrial = self:isTrial()
	local isOtherPlayerHero = self:isOtherPlayerHero()

	return not isTrial and not isOtherPlayerHero
end

function HeroMo:fakeTrial(equipMo)
	self.trialEquipMo = equipMo
	self.trialCo = true
end

function HeroMo:getHeroName()
	if self.trialAttrCo then
		return self.trialAttrCo.name
	end

	return self.config.name
end

function HeroMo:getpassiveskillsCO()
	if self.trialAttrCo then
		local list = {}
		local arr = string.splitToNumber(self.trialAttrCo.passiveSkill, "|")

		for index, skillId in ipairs(arr) do
			table.insert(list, {
				uiFilterSkill = "",
				heroId = self.heroId,
				skillLevel = index,
				skillPassive = skillId,
				skillGroup = index
			})
		end

		return list
	end

	return SkillConfig.instance:getpassiveskillsCO(self.heroId)
end

function HeroMo:isNoShowExSkill()
	if self.trialAttrCo then
		return self.trialAttrCo.noShowExSkill == 1
	end

	return false
end

function HeroMo:initFromTrial(id, templateId, pos)
	templateId = templateId or 0
	self.isPosLock = pos ~= nil

	local trialCo = lua_hero_trial.configDict[id][templateId]

	self.trialCo = trialCo

	if trialCo.attrId > 0 then
		self.trialAttrCo = lua_hero_trial_attr.configDict[trialCo.attrId]
	end

	local heroCo = HeroConfig.instance:getHeroCO(trialCo.heroId)
	local heroInfo = HeroDef_pb.HeroInfo()

	heroInfo.uid = tostring(tonumber(trialCo.id .. "." .. trialCo.trialTemplate) - 1099511627776)
	heroInfo.level = trialCo.level
	heroInfo.heroId = trialCo.heroId
	heroInfo.defaultEquipUid = tostring(-trialCo.equipId)

	local passiveLevel, rank = SkillConfig.instance:getHeroExSkillLevelByLevel(trialCo.heroId, trialCo.level)

	heroInfo.rank = rank

	local fixTalent = 1

	for talent = trialCo.talent, 1, -1 do
		local talentCo = lua_character_talent.configDict[heroInfo.heroId][talent]

		if talentCo and talentCo.requirement <= heroInfo.rank then
			fixTalent = talent

			break
		end
	end

	heroInfo.talent = fixTalent
	heroInfo.exSkillLevel = trialCo.exSkillLv

	for i = 1, passiveLevel do
		table.insert(heroInfo.passiveSkillLevel, i)
	end

	heroInfo.skin = trialCo.skin > 0 and trialCo.skin or heroCo.skinId

	local baseAttr = SkillConfig.instance:getBaseAttr(trialCo.heroId, trialCo.level)

	heroInfo.baseAttr.attack = baseAttr.atk
	heroInfo.baseAttr.defense = baseAttr.def
	heroInfo.baseAttr.hp = baseAttr.hp
	heroInfo.baseAttr.mdefense = baseAttr.mdef
	heroInfo.baseAttr.technic = baseAttr.technic
	heroInfo.exAttr.addDmg = baseAttr.add_dmg
	heroInfo.exAttr.cri = baseAttr.cri
	heroInfo.exAttr.criDef = baseAttr.cri_def
	heroInfo.exAttr.dropDmg = baseAttr.drop_dmg
	heroInfo.exAttr.recri = baseAttr.recri
	heroInfo.exAttr.criDmg = baseAttr.cri_dmg

	if self.trialAttrCo then
		heroInfo.baseAttr.hp = heroInfo.baseAttr.hp + self.trialAttrCo.life
		heroInfo.baseAttr.attack = heroInfo.baseAttr.attack + self.trialAttrCo.attack
		heroInfo.baseAttr.defense = heroInfo.baseAttr.defense + self.trialAttrCo.defense
		heroInfo.baseAttr.mdefense = heroInfo.baseAttr.mdefense + self.trialAttrCo.mdefense
		heroInfo.baseAttr.technic = heroInfo.baseAttr.technic + self.trialAttrCo.technic
		heroInfo.exAttr.cri = heroInfo.exAttr.cri + self.trialAttrCo.cri
		heroInfo.exAttr.recri = heroInfo.exAttr.recri + self.trialAttrCo.recri
		heroInfo.exAttr.dropDmg = heroInfo.exAttr.dropDmg + self.trialAttrCo.dropDmg
		heroInfo.exAttr.criDef = heroInfo.exAttr.criDef + self.trialAttrCo.criDef
		heroInfo.exAttr.addDmg = heroInfo.exAttr.addDmg + self.trialAttrCo.addDmg
		heroInfo.exAttr.dropDmg = heroInfo.exAttr.dropDmg + self.trialAttrCo.dropDmg
	end

	if trialCo.equipId > 0 then
		local trialEquipMo = EquipMO.New()

		trialEquipMo:initByTrialCO(trialCo)

		self.trialEquipMo = trialEquipMo
	end

	if heroInfo.rank >= CharacterEnum.TalentRank and heroInfo.talent > 0 then
		local talentCO = lua_character_talent.configDict[heroInfo.heroId][heroInfo.talent]
		local talentMould = talentCO.talentMould
		local starMould = string.splitToNumber(talentCO.exclusive, "#")[1]
		local talenScheme = lua_talent_scheme.configDict[heroInfo.talent][talentMould][starMould].talenScheme
		local dict = GameUtil.splitString2(talenScheme, true, "#", ",")
		local templateInfo = HeroDef_pb.TalentTemplateInfo()

		templateInfo.id = 1

		for k, v in ipairs(dict) do
			local cubeInfo = HeroDef_pb.TalentCubeInfo()

			cubeInfo.cubeId = v[1]
			cubeInfo.direction = v[2] or 0
			cubeInfo.posX = v[3] or 0
			cubeInfo.posY = v[4] or 0

			table.insert(templateInfo.talentCubeInfos, cubeInfo)
		end

		table.insert(heroInfo.talentTemplates, templateInfo)
	end

	self:init(heroInfo, heroCo)

	self.destinyStoneMo = self.destinyStoneMo or HeroDestinyStoneMO.New(self.heroId)

	self.destinyStoneMo:refreshMo(trialCo.facetslevel, 1, trialCo.facetsId)
	self.destinyStoneMo:setTrial()

	self.extraMo = self.extraMo or CharacterExtraMO.New(self)

	self.extraMo:refreshMo(trialCo.special)
end

function HeroMo:initFromConfig(config)
	self.heroId = config.id
	self.heroName = config.name
	self.level = 1
	self.exp = 0
	self.rank = 0
	self.breakthrough = 0
	self.skin = config.skinId
	self.config = config
end

function HeroMo:update(info)
	self.heroId = info.heroId
	self.skin = info.skin

	if not info.uid then
		return
	end

	self.id = info.uid
	self.uid = info.uid
	self.userId = info.userId
	self.heroName = info.heroName
	self.createTime = info.createTime
	self.level = info.level
	self.exp = info.exp
	self.rank = info.rank
	self.breakthrough = info.breakthrough
	self.faith = info.faith
	self.activeSkillLevel = info.activeSkillLevel
	self.passiveSkillLevel = info.passiveSkillLevel
	self.exSkillLevel = info.exSkillLevel
	self.voice = self:_getListInfo(info.voice)
	self.voiceHeard = self:_getListInfo(info.voiceHeard)
	self.skinInfoList = self:_getListInfo(info.skinInfoList, SkinInfoMO)
	self.baseAttr = self:_getAttrlist(info.baseAttr, HeroAttributeMO)
	self.exAttr = self:_getAttrlist(info.exAttr, HeroExAttributeMO)
	self.spAttr = self:_getAttrlist(info.spAttr, HeroSpecialAttributeMO)
	self.equipAttrList = self:_getListInfo(info.equipAttrList, HeroEquipAttributeMO)
	self.itemUnlock = self:_getListInfo(info.itemUnlock)
	self.isNew = info.isNew
	self.talent = info.talent
	self.defaultEquipUid = info.defaultEquipUid
	self.birthdayCount = info.birthdayCount
	self.duplicateCount = info.duplicateCount
	self.talentTemplates = info.talentTemplates
	self.useTalentTemplateId = info.useTalentTemplateId == 0 and 1 or info.useTalentTemplateId
	self.talentCubeInfos = self:setTalentCubeInfos(self.talentTemplates)
	self.talentStyleUnlock = info.talentStyleUnlock
	self.isShowTalentStyleRed = info.talentStyleRed == 1
	self.isFavor = info.isFavor
	self.destinyStoneMo = self.destinyStoneMo or HeroDestinyStoneMO.New(self.heroId)

	self.destinyStoneMo:refreshMo(info.destinyRank, info.destinyLevel, info.destinyStone, info.destinyStoneUnlock)
	self.destinyStoneMo:setRedDot(info.redDot)
	self:setIsBelongOtherPlayer(info.belongOtherPlayer)

	self.extraMo = self.extraMo or CharacterExtraMO.New(self)

	self.extraMo:refreshMo(info.extraStr)

	self.deviceMo = self:getDeviceMo()
end

function HeroMo:_getListInfo(originList, cls)
	local list = {}

	if originList then
		if not #originList then
			local count = 0

			for i = 1, count do
				local mo = originList[i]

				if cls then
					mo = cls.New()

					mo:init(originList[i])
				end

				table.insert(list, mo)
			end

			return list
		end
	end
end

function HeroMo:_getAttrlist(originList, cls)
	if cls then
		local mo = cls.New()

		mo:init(originList)
	end

	return originList
end

function HeroMo:levelUp(info)
	self.level = info.level
	self.heroId = info.heroId
end

function HeroMo:rankUp(info)
	self.rank = info.rank
	self.heroId = info.heroId
end

function HeroMo:talentUp(info)
	self.talent = info.talent
	self.heroId = info.heroId

	self.talentCubeInfos:setOwnData(self.heroId, self.talent)
end

function HeroMo:addVoice(heroId, voiceId)
	if heroId == self.heroId then
		table.insert(self.voice, voiceId)
	end
end

function HeroMo:setItemUnlock(info)
	if info.heroId == self.heroId then
		table.insert(self.itemUnlock, info.itemId)
	end
end

function HeroMo:setTalentCubeInfos(data)
	local talentCubeData

	for i, v in ipairs(data) do
		if v.id == self.useTalentTemplateId then
			talentCubeData = v.talentCubeInfos

			break
		end
	end

	self.talentCubeInfos = self.talentCubeInfos or HeroTalentCubeInfosMO.New()

	self.talentCubeInfos:init(talentCubeData or {})
	self.talentCubeInfos:setOwnData(self.heroId, self.talent)

	return self.talentCubeInfos
end

function HeroMo:getTalentGain(cus_level, cus_rank, cus_cube_level, talentCubeInfos)
	local gain_dic = {}
	local isOtherPlayerHero = self:isOtherPlayerHero()

	if isOtherPlayerHero and not self:getOtherPlayerIsOpenTalent() then
		return gain_dic
	end

	talentCubeInfos = talentCubeInfos or self.talentCubeInfos

	if not talentCubeInfos then
		logError("英雄数据找不到共鸣数据")
	end

	local data = talentCubeInfos.data_list
	local type_dic = {}

	for i, v in ipairs(data) do
		type_dic[v.cubeId] = type_dic[v.cubeId] or {}

		table.insert(type_dic[v.cubeId], v)
	end

	local damping_tab = SkillConfig.instance:getTalentDamping()

	for k, v in pairs(type_dic) do
		if #v >= damping_tab[1][1] then
			if #v >= damping_tab[2][1] then
				if not damping_tab[2][2] then
					local damping = damping_tab[1][2]

					if not damping_tab[1][2] then
						local gain_tab = {}

						for index, item in ipairs(v) do
							self:getTalentStyleCubeAttr(item.cubeId, gain_tab, cus_level, cus_rank, cus_cube_level, talentCubeInfos)
						end

						for key, value in pairs(gain_tab) do
							if damping then
								gain_tab[key] = value * (damping / 1000)
							end

							if gain_tab[key] > 0 then
								gain_dic[key] = gain_dic[key] or {}
								gain_dic[key].key = key
								gain_dic[key].value = (gain_dic[key].value or 0) + gain_tab[key]
							end
						end
					end
				end
			end
		end
	end

	return gain_dic
end

function HeroMo:getTalentStyleCubeAttr(cube_id, gain_tab, cus_level, cus_rank, cus_cube_level, talentCubeInfos)
	if cube_id == self.talentCubeInfos.own_main_cube_id then
		cube_id = self:getHeroUseStyleCubeId()
	end

	self:getTalentAttrGainSingle(cube_id, gain_tab, cus_level, cus_rank, cus_cube_level, talentCubeInfos)
end

function HeroMo:getTalentAttrGainSingle(cube_id, gain_tab, cus_level, cus_rank, cus_cube_level, talentCubeInfos)
	local talent_config = cus_cube_level and HeroConfig.instance:getTalentCubeAttrConfig(cube_id, cus_cube_level) or self:getCurTalentLevelConfig(cube_id, talentCubeInfos)
	local reference_level = talent_config.calculateType == 1 and CharacterModel.instance:getMaxLevel(self.heroId) or cus_level or self.level
	local base_attr_tab = SkillConfig.instance:getBaseAttr(self.heroId, reference_level)
	local rank_attr = SkillConfig.instance:getHeroRankAttribute(self.heroId, talent_config.calculateType == 1 and CharacterModel.instance:getMaxRank(self.heroId) or cus_rank or self.rank)

	gain_tab.hp = (gain_tab.hp or 0) + (rank_attr.hp + base_attr_tab.hp) * talent_config.hp / 1000
	gain_tab.atk = (gain_tab.atk or 0) + (rank_attr.atk + base_attr_tab.atk) * talent_config.atk / 1000
	gain_tab.def = (gain_tab.def or 0) + (rank_attr.def + base_attr_tab.def) * talent_config.def / 1000
	gain_tab.mdef = (gain_tab.mdef or 0) + (rank_attr.mdef + base_attr_tab.mdef) * talent_config.mdef / 1000
	gain_tab.cri = (gain_tab.cri or 0) + talent_config.cri
	gain_tab.recri = (gain_tab.recri or 0) + talent_config.recri
	gain_tab.cri_dmg = (gain_tab.cri_dmg or 0) + talent_config.cri_dmg
	gain_tab.cri_def = (gain_tab.cri_def or 0) + talent_config.cri_def
	gain_tab.add_dmg = (gain_tab.add_dmg or 0) + talent_config.add_dmg
	gain_tab.drop_dmg = (gain_tab.drop_dmg or 0) + talent_config.drop_dmg
	gain_tab.revive = (gain_tab.revive or 0) + talent_config.revive
	gain_tab.absorb = (gain_tab.absorb or 0) + talent_config.absorb
	gain_tab.clutch = (gain_tab.clutch or 0) + talent_config.clutch
	gain_tab.heal = (gain_tab.heal or 0) + talent_config.heal
	gain_tab.defenseIgnore = (gain_tab.defenseIgnore or 0) + talent_config.defenseIgnore
	gain_tab.normalSkillRate = (gain_tab.normalSkillRate or 0) + talent_config.normalSkillRate

	for k, v in pairs(gain_tab) do
		if gain_tab[k] == 0 then
			gain_tab[k] = nil
		elseif talent_config.calculateType == 1 then
			gain_tab[k] = math.floor(gain_tab[k])
		end
	end
end

function HeroMo:getCurTalentLevelConfig(cube_id, talentCubeInfos)
	talentCubeInfos = talentCubeInfos or self.talentCubeInfos

	local cubeMo = talentCubeInfos.own_cube_dic[cube_id]

	cubeMo = cubeMo or talentCubeInfos:getMainCubeMo()

	return HeroConfig.instance:getTalentCubeAttrConfig(cube_id, cubeMo.level)
end

function HeroMo:clearCubeData()
	self.talentCubeInfos:clearData()
	self.talentCubeInfos:setOwnData(self.heroId, self.talent)
end

function HeroMo:getAttrValueWithoutTalentByID(attr_id)
	local talent_gain = HeroConfig.instance:talentGainTab2IDTab(self:getTalentGain())
	local attr_config = HeroConfig.instance:getHeroAttributeCO(attr_id)

	if attr_config.type == 1 then
		return self.baseAttr[attr_config.attrType] - (talent_gain[attr_config.id] and math.floor(talent_gain[attr_config.id].value) or 0)
	elseif attr_config.type == 2 then
		return self.exAttr[attr_config.attrType] - (talent_gain[attr_config.id] and math.floor(talent_gain[attr_config.id].value) or 0)
	elseif attr_config.type == 3 then
		return self.spAttr[attr_config.attrType] - (talent_gain[attr_config.id] and math.floor(talent_gain[attr_config.id].value) or 0)
	end
end

function HeroMo:getAttrValueWithoutTalentByAttrType(attr_type)
	return self:getAttrValueWithoutTalentByID(HeroConfig.instance:getIDByAttrType(attr_type))
end

function HeroMo:hasDefaultEquip()
	if self:isTrial() and self.defaultEquipUid ~= "0" then
		return self.trialEquipMo
	end

	if self:isOtherPlayerHero() then
		return self:getOtherPlayerEquipMo()
	end

	return self.defaultEquipUid ~= "0" and EquipModel.instance:getEquip(self.defaultEquipUid)
end

function HeroMo:getHeroLevelConfig(level)
	level = level or self.level

	local lvCo = SkillConfig.instance:getherolevelCO(self.heroId, level)

	if not lvCo then
		local stages = SkillConfig.instance:getherolevelsCO(self.heroId)
		local stageLevels = {}

		for _, stage in pairs(stages) do
			table.insert(stageLevels, stage.level)
		end

		table.sort(stageLevels, function(x, y)
			return x < y
		end)

		local minStage = stageLevels[1]
		local maxStage = stageLevels[#stageLevels]

		for i = 1, #stageLevels - 1 do
			if level > stageLevels[i] and level < stageLevels[i + 1] then
				minStage = stageLevels[i]
				maxStage = stageLevels[i + 1]

				break
			end
		end

		local minAttr = SkillConfig.instance:getherolevelCO(self.heroId, minStage)
		local maxAttr = SkillConfig.instance:getherolevelCO(self.heroId, maxStage)

		lvCo = {}

		for _, attrName in pairs(CharacterEnum.AttrIdToAttrName) do
			lvCo[attrName] = self:lerpAttr(minAttr[attrName], maxAttr[attrName], minStage, maxStage, level)
		end
	end

	lvCo = self:addTrialUpAttr(lvCo)

	return lvCo
end

function HeroMo:addTrialUpAttr(lvCo)
	if not self.trialAttrCo then
		return lvCo
	end

	local cloneCo = {}

	for _, attrName in pairs(CharacterEnum.AttrIdToAttrName) do
		cloneCo[attrName] = lvCo[attrName]
	end

	cloneCo.cri = cloneCo.cri + self.trialAttrCo.cri
	cloneCo.recri = cloneCo.recri + self.trialAttrCo.recri
	cloneCo.cri_dmg = cloneCo.cri_dmg + self.trialAttrCo.dropDmg
	cloneCo.cri_def = cloneCo.cri_def + self.trialAttrCo.criDef
	cloneCo.add_dmg = cloneCo.add_dmg + self.trialAttrCo.addDmg
	cloneCo.drop_dmg = cloneCo.drop_dmg + self.trialAttrCo.dropDmg

	return cloneCo
end

function HeroMo:getHeroBaseAttrDict(level, rankLevel)
	level = level or self.level
	rankLevel = rankLevel or self.rank

	local lvCo = self:getHeroLevelConfig(level)
	local result = {}
	local rankAttrDict = SkillConfig.instance:getHeroRankAttribute(self.heroId, rankLevel)

	for _, attrId in pairs(CharacterEnum.BaseAttrIdList) do
		local attrName = CharacterEnum.AttrIdToAttrName[attrId]

		result[attrId] = lvCo[attrName] + rankAttrDict[attrName]
	end

	self:addTrialBaseAttr(result)

	return result
end

function HeroMo:lerpAttr(minAttr, maxAttr, minStage, maxStage, level)
	return math.floor((maxAttr - minAttr) * (level - minStage) / (maxStage - minStage)) + minAttr
end

function HeroMo:getTotalBaseAttrDict(equipUidList, level, rankLevel, isBalance, trialEquipMo, getHeroBalanceInfo)
	level = level or self.level
	rankLevel = rankLevel or self.rank

	local talentCubeInfos, equipLv

	if isBalance then
		getHeroBalanceInfo = getHeroBalanceInfo or HeroGroupBalanceHelper.getHeroBalanceInfo

		local balanceLv, rank, fixTalent, talentCubeInfo, equipLevel = HeroGroupBalanceHelper.getHeroBalanceInfo(self.heroId)

		level = balanceLv
		rankLevel = rank
		talentCubeInfos = talentCubeInfo
		equipLv = equipLevel
	end

	local baseAttrDict = self:getHeroBaseAttrDict(level, rankLevel)
	local equipAttrDict = {}
	local equipBreakAddAttrDict = {}

	for _, attrId in ipairs(CharacterEnum.BaseAttrIdList) do
		equipAttrDict[attrId] = 0
		equipBreakAddAttrDict[attrId] = 0
	end

	if equipUidList and trialEquipMo then
		self:_calcEquipAttr(trialEquipMo, equipAttrDict, equipBreakAddAttrDict)
	end

	if equipUidList and #equipUidList > 0 then
		for _, equipUid in ipairs(equipUidList) do
			if tonumber(equipUid) < 0 then
				local equipMO = HeroGroupTrialModel.instance:getEquipMo(equipUid)

				self:_calcEquipAttr(equipMO, equipAttrDict, equipBreakAddAttrDict)

				if self.heroId == CharacterEnum.TwinssychubeHeroId then
					if equipMO then
						::label_42_0::

						local otherEquipId = EquipModel.instance:getOtherTwinssychubeEquipId(equipMO.equipId)
						local otherEquipMo = EquipModel.instance:getTwinssychubeEquipMo(otherEquipId)

						if otherEquipMo then
							self:_calcEquipAttr(otherEquipMo, equipAttrDict, equipBreakAddAttrDict)
						end
					end
				end
			else
				local equipMO = EquipModel.instance:getEquip(equipUid)

				self:_calcEquipAttr(equipMO, equipAttrDict, equipBreakAddAttrDict, equipLv)

				if self.heroId == CharacterEnum.TwinssychubeHeroId then
					local otherEquipMo

					if trialEquipMo then
						do
							local otherEquipId = EquipModel.instance:getOtherTwinssychubeEquipId(trialEquipMo.equipId)

							if otherEquipId then
								otherEquipMo = EquipMO.New()

								local co = {
									equipId = otherEquipId,
									equipLv = trialEquipMo.level,
									equipRefine = trialEquipMo.refineLv
								}

								otherEquipMo:initByTrialCO(co)
							end
						end
					end

					if equipMO then
						::label_42_1::

						do
							local otherEquipId = EquipModel.instance:getOtherTwinssychubeEquipId(equipMO.equipId)

							otherEquipMo = EquipModel.instance:getTwinssychubeEquipMo(otherEquipId)
						end

						if otherEquipMo then
							self:_calcEquipAttr(otherEquipMo, equipAttrDict, equipBreakAddAttrDict, equipLv)
						end
					end
				end
			end
		end

		for _, attrId in ipairs(CharacterEnum.BaseAttrIdList) do
			equipAttrDict[attrId] = equipAttrDict[attrId] + math.floor(equipBreakAddAttrDict[attrId] / 1000 * baseAttrDict[attrId])
		end
	end

	local talentValues = {}
	local isOtherPlayerHero = self:isOtherPlayerHero()

	if rankLevel > 1 and (isOtherPlayerHero or nil) and self:getOtherPlayerIsOpenTalent() then
		talentValues = self:getTalentGain(level, rankLevel, nil, talentCubeInfos)
		talentValues = HeroConfig.instance:talentGainTab2IDTab(talentValues)

		for attrId, _ in pairs(talentValues) do
			local config = HeroConfig.instance:getHeroAttributeCO(attrId)

			talentValues[attrId].value = config.type ~= 1 and talentValues[attrId].value / 10 or math.floor(talentValues[attrId].value)
		end
	end

	local destinyStoneValues = self.destinyStoneMo:getAddAttrValues()
	local attrDict = {}

	for _, attrId in ipairs(CharacterEnum.BaseAttrIdList) do
		local destinyStoneAddValue = self.destinyStoneMo and self.destinyStoneMo:getAddValueByAttrId(destinyStoneValues, attrId, self) or 0

		attrDict[attrId] = baseAttrDict[attrId] + equipAttrDict[attrId] + ((talentValues[attrId] or nil) and (talentValues[attrId].value or 0)) + destinyStoneAddValue
	end

	return attrDict
end

function HeroMo:addTrialBaseAttr(result)
	if not self.trialAttrCo then
		return
	end

	result[CharacterEnum.AttrId.Hp] = result[CharacterEnum.AttrId.Hp] + self.trialAttrCo.life
	result[CharacterEnum.AttrId.Attack] = result[CharacterEnum.AttrId.Attack] + self.trialAttrCo.attack
	result[CharacterEnum.AttrId.Defense] = result[CharacterEnum.AttrId.Defense] + self.trialAttrCo.defense
	result[CharacterEnum.AttrId.Mdefense] = result[CharacterEnum.AttrId.Mdefense] + self.trialAttrCo.mdefense
	result[CharacterEnum.AttrId.Technic] = result[CharacterEnum.AttrId.Technic] + self.trialAttrCo.technic
end

function HeroMo.getTalentCubeInfos(heroId, talentLv)
	local infos = {}
	local talentCO = lua_character_talent.configDict[heroId][talentLv]
	local talentMould = talentCO.talentMould
	local starMould = string.splitToNumber(talentCO.exclusive, "#")[1]
	local talenScheme = lua_talent_scheme.configDict[talentLv][talentMould][starMould].talenScheme
	local dict = GameUtil.splitString2(talenScheme, true, "#", ",")

	for k, v in ipairs(dict) do
		local cubeInfo = HeroDef_pb.TalentCubeInfo()

		cubeInfo.cubeId = v[1]
		cubeInfo.direction = v[2] or 0
		cubeInfo.posX = v[3] or 0
		cubeInfo.posY = v[4] or 0

		table.insert(infos, cubeInfo)
	end

	local talentCubeInfos = HeroTalentCubeInfosMO.New()

	talentCubeInfos:init(infos)
	talentCubeInfos:setOwnData(heroId, talentLv)

	return talentCubeInfos
end

function HeroMo:getCachotTotalBaseAttrDict(equipUidList, level, rankLevel, cus_cube_level, talentCubeInfos, equipModifyCallback, equipModifyCallbackObj)
	level = level or self.level
	rankLevel = rankLevel or self.rank

	local equipLv
	local baseAttrDict = self:getHeroBaseAttrDict(level, rankLevel)
	local equipAttrDict = {}
	local equipBreakAddAttrDict = {}

	for _, attrId in ipairs(CharacterEnum.BaseAttrIdList) do
		equipAttrDict[attrId] = 0
		equipBreakAddAttrDict[attrId] = 0
	end

	if equipUidList and #equipUidList > 0 then
		for _, equipUid in ipairs(equipUidList) do
			if tonumber(equipUid) < 0 then
				local equipMO = HeroGroupTrialModel.instance:getEquipMo(equipUid)

				self:_calcEquipAttr(equipMO, equipAttrDict, equipBreakAddAttrDict)
			else
				local equipMO = EquipModel.instance:getEquip(equipUid)

				equipMO = equipMO and equipModifyCallback(equipModifyCallbackObj, equipMO)

				self:_calcEquipAttr(equipMO, equipAttrDict, equipBreakAddAttrDict, equipLv)
			end
		end

		for _, attrId in ipairs(CharacterEnum.BaseAttrIdList) do
			equipAttrDict[attrId] = equipAttrDict[attrId] + math.floor(equipBreakAddAttrDict[attrId] / 1000 * baseAttrDict[attrId])
		end
	end

	local talentValues = {}

	if rankLevel > 1 then
		talentValues = self:getTalentGain(level, rankLevel, cus_cube_level, talentCubeInfos)
		talentValues = HeroConfig.instance:talentGainTab2IDTab(talentValues)

		for attrId, _ in pairs(talentValues) do
			local config = HeroConfig.instance:getHeroAttributeCO(attrId)

			talentValues[attrId].value = config.type ~= 1 and talentValues[attrId].value / 10 or math.floor(talentValues[attrId].value)
		end
	end

	local attrDict = {}

	for _, attrId in ipairs(CharacterEnum.BaseAttrIdList) do
		attrDict[attrId] = baseAttrDict[attrId] + equipAttrDict[attrId] + ((talentValues[attrId] or nil) and (talentValues[attrId].value or 0))
	end

	return attrDict
end

function HeroMo:_calcEquipAttr(equipMO, equipAttrDict, equipBreakAddAttrDict, equipLv)
	if not equipMO then
		return
	end

	if equipLv and equipLv > equipMO.level then
		local newEquipMo = EquipMO.New()

		newEquipMo:initByConfig(nil, equipMO.equipId, equipLv, equipMO.refineLv)

		equipMO = newEquipMo
	end

	local hp, atk, def, mdef = EquipConfig.instance:getEquipAddBaseAttr(equipMO)

	equipAttrDict[CharacterEnum.AttrId.Attack] = equipAttrDict[CharacterEnum.AttrId.Attack] + atk
	equipAttrDict[CharacterEnum.AttrId.Hp] = equipAttrDict[CharacterEnum.AttrId.Hp] + hp
	equipAttrDict[CharacterEnum.AttrId.Defense] = equipAttrDict[CharacterEnum.AttrId.Defense] + def
	equipAttrDict[CharacterEnum.AttrId.Mdefense] = equipAttrDict[CharacterEnum.AttrId.Mdefense] + mdef

	local attrId, value = EquipConfig.instance:getEquipCurrentBreakLvAttrEffect(equipMO.config, equipMO.breakLv)

	if attrId then
		equipBreakAddAttrDict[attrId] = (equipBreakAddAttrDict[attrId] or 0) + value
	end
end

function HeroMo:getTotalBaseAttrList(equipUidList, level, rankLevel)
	local attrDict = self:getTotalBaseAttrDict(equipUidList, level, rankLevel)
	local attrList = {}

	for _, attrId in ipairs(CharacterEnum.BaseAttrIdList) do
		table.insert(attrList, attrDict[attrId])
	end

	return attrList
end

function HeroMo:setIsBalance(isBalance)
	self._isBalance = isBalance
end

function HeroMo:getIsBalance()
	return self._isBalance or false
end

function HeroMo:getMeetingYear()
	local birth

	if self.config and not string.nilorempty(self.config.roleBirthday) then
		birth = string.splitToNumber(self.config.roleBirthday, "/")
	end

	if not birth then
		return
	end

	local createTimeStamp = self.createTime / 1000
	local meetingDateTime = os.date("!*t", createTimeStamp + ServerTime.serverUtcOffset())
	local meetingYear = meetingDateTime.year
	local meetingYearBirthday = {
		hour = 5,
		min = 0,
		sec = 0,
		year = meetingYear,
		month = birth[1],
		day = birth[2]
	}
	local localBirthdayTimestamp = os.time(meetingYearBirthday)
	local serverBirthdayTimestamp = localBirthdayTimestamp - ServerTime.clientToServerOffset() - ServerTime.getDstOffset()
	local result = 0

	if createTimeStamp < serverBirthdayTimestamp then
		result = 1
	end

	local serverDateTime = os.date("*t", ServerTime.nowInLocal())
	local nowYear = serverDateTime.year

	result = nowYear - meetingYear + result

	return result
end

function HeroMo:getHeroUseCubeStyleId()
	if self:isOtherPlayerHero() then
		return self:getOtherPlayerTalentStyle()
	end

	if self.talentTemplates and self.useTalentTemplateId and self.talentTemplates[self.useTalentTemplateId] then
		return self.talentTemplates[self.useTalentTemplateId].style or 0
	end

	return 0
end

function HeroMo:getHeroUseStyleCubeId()
	local style = self:getHeroUseCubeStyleId()
	local styleList = HeroResonanceConfig.instance:getTalentStyle(self.talentCubeInfos.own_main_cube_id)

	if styleList and styleList[style] then
		return styleList[style]._replaceId
	end

	return self.talentCubeInfos.own_main_cube_id
end

function HeroMo:isCanOpenDestinySystem(isShowToast)
	if not self:isTrial() and not CharacterDestinyModel.instance:isOpenDestinySystem(isShowToast) then
		return false
	end

	if not self:isHasDestinySystem() then
		return false
	end

	local openLevel = self:getUnlockDestinyLevel()

	if openLevel > self.level then
		if isShowToast then
			local showLevel, rank = HeroConfig.instance:getShowLevel(openLevel)

			GameFacade.showToast(ToastEnum.CharacterDestinyUnlockLevel, GameUtil.getNum2Chinese(rank - 1), showLevel)
		end

		return false
	end

	return true
end

function HeroMo:getUnlockDestinyLevel()
	if not self.config.rare then
		local rare = 5
		local constId = CharacterDestinyEnum.DestinyStoneOpenLevelConstId[rare]
		local openLevel = CommonConfig.instance:getConstStr(constId)

		return tonumber(openLevel)
	end
end

function HeroMo:isHasDestinySystem()
	return CharacterDestinyConfig.instance:hasDestinyHero(self.heroId)
end

function HeroMo:checkReplaceSkill(skillIdList)
	if self.destinyStoneMo then
		skillIdList = self.destinyStoneMo:_replaceSkill(skillIdList)
	end

	if self.extraMo then
		skillIdList = self.extraMo:getReplaceSkills(skillIdList)
	end

	return skillIdList
end

function HeroMo:getRecommendEquip()
	if self.recommendEquips then
		return self.recommendEquips
	end

	self.recommendEquips = {}

	if not self.config or string.nilorempty(self.config.equipRec) then
		return self.recommendEquips
	end

	self.recommendEquips = string.splitToNumber(self.config.equipRec, "#")

	return self.recommendEquips
end

function HeroMo:getHeroType()
	local rankReplaceCo = lua_character_rank_replace.configDict[self.heroId]

	if rankReplaceCo then
		local limitedCo = lua_character_limited.configDict[self.skin]

		if limitedCo and not string.nilorempty(limitedCo.specialLive2d) then
			local specialLive2d = string.split(limitedCo.specialLive2d, "#")

			if tonumber(specialLive2d[1]) == 1 then
				local rank = specialLive2d[2] and tonumber(specialLive2d[2]) or 3

				if self.rank > rank - 1 then
					return rankReplaceCo.heroType
				end
			end
		end
	end

	return self.config.heroType
end

function HeroMo:getHeroDestinyStoneMo()
	return self.destinyStoneMo
end

function HeroMo:getHeroBattleTag()
	if self.destinyStoneMo then
		local stoneMo = self.destinyStoneMo:getCurUseStoneMo()

		if stoneMo then
			local _battleTag = stoneMo.conusmeCo.tag

			if not string.nilorempty(_battleTag) then
				return _battleTag
			end
		end
	end

	return self.config.battleTag
end

function HeroMo:getTalentTxtByHeroType()
	local heroType = self:getHeroType()

	return CharacterEnum.TalentTxtByHeroType[heroType]
end

function HeroMo:getDeviceId()
	if self.destinyStoneMo then
		local exSkillCo = self.destinyStoneMo:getExpExchangeSkillCo(self.exSkillLevel)

		if exSkillCo and exSkillCo.deviceId > 0 then
			return exSkillCo.deviceId
		end

		local stoneCo = self.destinyStoneMo:getCurUseStoneCo()

		if stoneCo and not string.nilorempty(stoneCo.deviceAdd) then
			local devices = GameUtil.splitString2(stoneCo.deviceAdd, true)

			for _, v in pairs(devices) do
				if v[1] == self.exSkillLevel then
					return v[2]
				end
			end
		end
	end

	local exSkillCos = SkillConfig.instance:getheroexskillco(self.heroId)
	local exSkillCo = exSkillCos and exSkillCos[self.exSkillLevel]

	if exSkillCo and exSkillCo.deviceId > 0 then
		return exSkillCo.deviceId
	end

	return self.config and self.config.deviceId
end

function HeroMo:getDeviceMo()
	local deviceId = self:getDeviceId()

	if deviceId and deviceId > 0 then
		self.deviceMo = self.deviceMo or HeroDeviceMO.New(self.heroId)

		self.deviceMo:setHeroMo(self)
		self.deviceMo:refreshDevice(deviceId)

		return self.deviceMo
	end
end

function HeroMo:getCareer()
	return self.config and self.config.career
end

return HeroMo
