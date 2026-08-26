-- chunkname: @modules/logic/character/config/EffectivenessConfig.lua

module("modules.logic.character.config.EffectivenessConfig", package.seeall)

local EffectivenessConfig = class("EffectivenessConfig", BaseConfig)

function EffectivenessConfig:ctor()
	self.subValue = 0.7
end

function EffectivenessConfig:reqConfigNames()
	return {
		"hero_effectiveness",
		"equip_effectiveness",
		"talent_effectiveness",
		"talent_scheme"
	}
end

function EffectivenessConfig:onConfigLoaded(configName, configTable)
	return
end

EffectivenessConfig.HeroRareRareEnum = {
	SR = 4,
	Other = 3,
	SSR = 5
}
EffectivenessConfig.EquipRareRareEnum = {
	SR = 4,
	Other = 3,
	SSR = 5
}

function EffectivenessConfig:calculateHeroEffectiveness(heroMo, isSub)
	local co = lua_hero_effectiveness.configDict[heroMo.level]
	local heroCo = heroMo.config
	local value = heroCo.rare == EffectivenessConfig.HeroRareRareEnum.SSR and co.ssr or heroCo.rare == EffectivenessConfig.HeroRareRareEnum.SR and co.sr or co.r

	if isSub then
		return value * self.subValue
	end

	return value
end

function EffectivenessConfig:calculateHeroAverageEffectiveness(heroMoList, subHeroList)
	local resultValue = 0

	for i = 1, #heroMoList do
		resultValue = resultValue + self:calculateHeroEffectiveness(heroMoList[i])
	end

	for i = 1, #subHeroList do
		resultValue = resultValue + self:calculateHeroEffectiveness(subHeroList[i], true)
	end

	return resultValue / (#heroMoList + #subHeroList)
end

function EffectivenessConfig:calculateEquipEffectiveness(equipMo, isSub)
	local co = lua_equip_effectiveness.configDict[equipMo.level]
	local equipCo = equipMo.config
	local value = equipCo.rare == EffectivenessConfig.EquipRareRareEnum.SSR and co.ssr or equipCo.rare == EffectivenessConfig.EquipRareRareEnum.SR and co.sr or co.r

	if isSub then
		return value * self.subValue
	end

	return value
end

function EffectivenessConfig:calculateEquipAverageEffectiveness(equipMoList)
	local resultValue = 0

	for i, equipMo in ipairs(equipMoList) do
		resultValue = i == 4 and resultValue + self:calculateEquipEffectiveness(equipMo, true) or resultValue + self:calculateEquipEffectiveness(equipMo)
	end

	return (#equipMoList ~= 0 or nil) and (resultValue / #equipMoList or 0)
end

function EffectivenessConfig:calculateTalentEffectiveness(heroMo, isSub)
	local co = lua_talent_effectiveness.configDict[heroMo.talent]
	local heroCo = heroMo.config
	local value = heroCo.rare == EffectivenessConfig.HeroRareRareEnum.SSR and co.ssr or heroCo.rare == EffectivenessConfig.HeroRareRareEnum.SR and co.sr or co.r

	if isSub then
		return value * self.subValue
	end

	return value
end

function EffectivenessConfig:calculateTalentAverageEffectiveness(heroMoList, subHeroList)
	local resultValue = 0

	for i = 1, #heroMoList do
		resultValue = resultValue + self:calculateTalentEffectiveness(heroMoList[i])
	end

	for i = 1, #subHeroList do
		resultValue = resultValue + self:calculateTalentEffectiveness(subHeroList[i], true)
	end

	return resultValue / (#heroMoList + #subHeroList)
end

EffectivenessConfig.instance = EffectivenessConfig.New()

return EffectivenessConfig
