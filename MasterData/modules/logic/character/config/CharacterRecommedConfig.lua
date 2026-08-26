-- chunkname: @modules/logic/character/config/CharacterRecommedConfig.lua

module("modules.logic.character.config.CharacterRecommedConfig", package.seeall)

local CharacterRecommedConfig = class("CharacterRecommedConfig", BaseConfig)

function CharacterRecommedConfig:reqConfigNames()
	return {
		"character_recommend"
	}
end

function CharacterRecommedConfig:onInit()
	self._heroConfigDict = {}
end

function CharacterRecommedConfig:onConfigLoaded(configName, configTable)
	if configName == "character_recommend" then
		self._heroConfigDict = configTable.configDict

		CharacterRecommedModel.instance:initMO(self._heroConfigDict)
	end
end

function CharacterRecommedConfig:getAllHeroConfigs()
	return self._heroConfigDict
end

function CharacterRecommedConfig:getHeroConfig(heroId)
	return self._heroConfigDict[heroId]
end

CharacterRecommedConfig.instance = CharacterRecommedConfig.New()

return CharacterRecommedConfig
