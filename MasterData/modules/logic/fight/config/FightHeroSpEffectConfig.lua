-- chunkname: @modules/logic/fight/config/FightHeroSpEffectConfig.lua

module("modules.logic.fight.config.FightHeroSpEffectConfig", package.seeall)

local FightHeroSpEffectConfig = class("FightHeroSpEffectConfig", BaseConfig)

function FightHeroSpEffectConfig:ctor()
	return
end

function FightHeroSpEffectConfig:reqConfigNames()
	return {
		"fight_sp_effect_kkny_bear_damage",
		"fight_sp_effect_kkny_heal",
		"fight_sp_effect_kkny_bear_damage_hit",
		"fight_sp_effect_bkle",
		"fight_sp_effect_ly",
		"fight_sp_handcard_area_ly",
		"fight_sp_card_ly",
		"fight_sp_card_mask_ly",
		"fight_sp_effect_alf",
		"fight_sp_effect_alf_timeline",
		"fight_sp_effect_alf_add_card",
		"fight_sp_effect_alf_record_buff_effect",
		"fight_sp_effect_ddg",
		"fight_sp_effect_wuerlixi",
		"fight_sp_effect_wuerlixi_timeline",
		"fight_sp_effect_wuerlixi_float",
		"fight_sp_wuerlixi_monster_star_effect",
		"fight_sp_wuerlixi_monster_star_position_offset",
		"fight_luxi_skin_effect",
		"fight_sp_sm",
		"hero3124_buff_talent",
		"fight_ble_crystal",
		"fight_ble_crystal_desc",
		"fight_ble_skill_2_crystal",
		"fight_anan_focus_timeline",
		"fight_yaxian_timeline",
		"fight_hudie_special_effect",
		"fight_wmz_timeline",
		"fight_hsy_effect",
		"fight_sswl_skill1_effect",
		"fight_sswl_skill2_effect",
		"fight_sswl_unique_effect"
	}
end

function FightHeroSpEffectConfig:onConfigLoaded(configName, configTable)
	if configName == "fight_sp_effect_alf" then
		self.initAlfRandomList = {}

		for _, co in ipairs(configTable.configList) do
			if co.skinId == 0 then
				table.insert(self.initAlfRandomList, co)
			end
		end
	end
end

function FightHeroSpEffectConfig:getBKLEAddBuffEffect(skinId)
	if self.curSkin ~= skinId then
		self.curSkin = skinId

		self:initBKLERandomList(skinId)
	end

	if #self.BKLEEffectList == 0 then
		self:initBKLERandomList(skinId)
	end

	local len = #self.BKLEEffectList

	if len <= 1 then
		return table.remove(self.BKLEEffectList, 1)
	end

	local random = math.random(1, len)

	return table.remove(self.BKLEEffectList, random)
end

function FightHeroSpEffectConfig:initBKLERandomList(skinId)
	self.BKLEEffectList = self.BKLEEffectList or {}

	tabletool.clear(self.BKLEEffectList)

	local co = lua_fight_sp_effect_bkle.configDict[skinId]
	local list = FightStrUtil.instance:getSplitCache(co.path, "|")

	for k, v in pairs(list) do
		self.BKLEEffectList[k] = v
	end
end

function FightHeroSpEffectConfig:getLYEffectCo(skinId)
	local co = lua_fight_sp_effect_ly.configDict[skinId]

	co = co or lua_fight_sp_effect_ly.configDict[1]

	return co
end

function FightHeroSpEffectConfig:getRandomAlfASFDMissileRes()
	local alfSkinId = FightDataHelper.entityMgr:getHeroSkin(FightEnum.HeroId.ALF)
	local randomList = self:getALFRandomList(alfSkinId)
	local len = #randomList
	local randomValue = math.random(len)

	return table.remove(randomList, randomValue)
end

function FightHeroSpEffectConfig:getALFRandomList(skinId)
	skinId = skinId or 0
	self.alfRandomDict = self.alfRandomDict or {}

	local randomList = self.alfRandomDict[skinId]

	if not randomList then
		randomList = {}
		self.alfRandomDict[skinId] = randomList
	end

	for _, co in ipairs(lua_fight_sp_effect_alf.configList) do
		if co.skinId == skinId then
			table.insert(randomList, co)
		end
	end

	if #randomList < 1 then
		for _, co in ipairs(self.initAlfRandomList) do
			table.insert(randomList, co)
		end
	end

	return randomList
end

function FightHeroSpEffectConfig:isKSDLSpecialBuff(buffId)
	if not buffId then
		return false
	end

	self:initKSDLSpecialBuffCo()

	return self:getKSDLSpecialBuffRank(buffId) ~= nil
end

function FightHeroSpEffectConfig:getKSDLSpecialBuffRank(buffId)
	if not buffId then
		return
	end

	self:initKSDLSpecialBuffCo()

	return self.ksdlBuffDict[buffId]
end

function FightHeroSpEffectConfig:initKSDLSpecialBuffCo()
	if self.ksdlBuffDict then
		return self.ksdlBuffDict
	end

	self.ksdlBuffDict = {}

	for _, co in ipairs(lua_hero3124_buff_talent.configList) do
		self.ksdlBuffDict[co.buffId] = co.rank
	end

	return self.ksdlBuffDict
end

FightHeroSpEffectConfig.tempEntityMoList = {}

function FightHeroSpEffectConfig:getAlfCardAddEffect()
	local skinId = 0
	local entityMoList = FightHeroSpEffectConfig.tempEntityMoList
	local entityList = FightDataHelper.entityMgr:getMyNormalList(entityMoList)

	for _, entityMo in ipairs(entityList) do
		if entityMo.modelId == FightEnum.HeroId.ALF then
			skinId = entityMo.skin

			break
		end
	end

	local co = lua_fight_sp_effect_alf_add_card.configDict[skinId]

	co = co or lua_fight_sp_effect_alf_add_card.configList[1]

	return string.format("ui/viewres/fight/%s.prefab", co.effect)
end

function FightHeroSpEffectConfig:getBLECrystalCo(crystal)
	local co = lua_fight_ble_crystal.configDict[crystal]

	if not co then
		logError("贝丽尔水晶配置不存在 ：" .. tostring(crystal))

		co = lua_fight_ble_crystal.configList[1]
	end

	return co
end

function FightHeroSpEffectConfig:getBLECrystalDescAndTag(crystal, count)
	local co = fight_ble_crystal_desc.configDict[crystal]

	co = co and co[count]

	if not co then
		logError(string.format("crystal desc not found! crystal : %s, count : %s", crystal, count))

		co = fight_ble_crystal_desc.configList[1]
	end

	return co.desc, co.tag
end

function FightHeroSpEffectConfig:getSkill2CrystalCo(skillId)
	local co = lua_fight_ble_skill_2_crystal.configDict[skillId]

	if not co then
		logError("贝丽尔技能id对应水晶配置不存在， skillId：" .. tostring(skillId))

		co = lua_fight_ble_skill_2_crystal.configList[1]
	end

	return co
end

FightHeroSpEffectConfig.instance = FightHeroSpEffectConfig.New()

return FightHeroSpEffectConfig
