-- chunkname: @modules/logic/character/config/CharacterExtraConfig.lua

module("modules.logic.character.config.CharacterExtraConfig", package.seeall)

local CharacterExtraConfig = class("CharacterExtraConfig")

function CharacterExtraConfig:reqConfigNames()
	return {
		"hero3124_skill_talent",
		"fight_eziozhuangbei",
		"fight_eziozhuangbei_icon"
	}
end

function CharacterExtraConfig:onInit()
	return
end

function CharacterExtraConfig:onConfigLoaded(configName, configTable)
	if configName == "hero3124_skill_talent" then
		self:_initSkillTalentConfig(configTable)
	elseif configName == "fight_eziozhuangbei" then
		self._ezioWeaponGroupConfig = configTable
	elseif configName == "fight_eziozhuangbei_icon" then
		self:_initEzioWeaponConfig(configTable)
	end
end

function CharacterExtraConfig:_initSkillTalentConfig(configTable)
	self._skillTalentCo = {}

	for _, co in ipairs(configTable.configList) do
		self._skillTalentCo[co.sub] = self._skillTalentCo[co.sub] or {}
		self._skillTalentCo[co.sub][co.level] = co
	end
end

function CharacterExtraConfig:getSkillTalentCoBySubLevel(sub, level)
	local cos = self._skillTalentCo[sub]

	return cos and cos[level]
end

function CharacterExtraConfig:getSkillTalentCoById(id)
	return lua_hero3124_skill_talent.configDict[id]
end

function CharacterExtraConfig:getSkillTalentCos()
	return self._skillTalentCo
end

function CharacterExtraConfig:getEzioWeaponGroupConfigTable()
	return self._ezioWeaponGroupConfig
end

function CharacterExtraConfig:getEzioWeaponGroupCos(mainId, subId, exSkillLevel)
	if not self._ezioWeaponGroupConfig then
		return
	end

	local mainCos = self._ezioWeaponGroupConfig.configDict[mainId]

	if not mainCos then
		return
	end

	local subCos = mainCos[subId]

	if not subCos then
		return
	end

	return subCos[exSkillLevel]
end

function CharacterExtraConfig:_initEzioWeaponConfig(configTable)
	self._ezioWeaponConfig = {}

	for _, co in ipairs(configTable.configList) do
		self._ezioWeaponConfig[co.type] = self._ezioWeaponConfig[co.type] or {}

		table.insert(self._ezioWeaponConfig[co.type], co)
	end
end

function CharacterExtraConfig:getEzioWeaponCosByType(type)
	return self._ezioWeaponConfig[type]
end

function CharacterExtraConfig:getEzioWeaponCoById(id)
	return lua_fight_eziozhuangbei_icon.configDict[id]
end

function CharacterExtraConfig:getEzioWeaponConfigs()
	return self._ezioWeaponConfig
end

CharacterExtraConfig.instance = CharacterExtraConfig.New()

return CharacterExtraConfig
