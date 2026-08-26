-- chunkname: @modules/logic/herogrouppreset/config/HeroGroupPresetConfig.lua

module("modules.logic.herogrouppreset.config.HeroGroupPresetConfig", package.seeall)

local HeroGroupPresetConfig = class("HeroGroupPresetConfig", BaseConfig)

function HeroGroupPresetConfig:reqConfigNames()
	return {
		"hero_team"
	}
end

function HeroGroupPresetConfig:onInit()
	return
end

function HeroGroupPresetConfig:onConfigLoaded(configName, configTable)
	if configName == "hero_team" then
		self:_initHeroTeam()
	end
end

function HeroGroupPresetConfig:_initHeroTeam()
	self._heroTeamList = {}

	for i, v in ipairs(lua_hero_team.configList) do
		if v.isDisplay == 1 then
			table.insert(self._heroTeamList, v)
		end
	end

	table.sort(self._heroTeamList, function(a, b)
		return a.sort < b.sort
	end)
end

function HeroGroupPresetConfig:getHeroTeamList()
	return self._heroTeamList
end

HeroGroupPresetConfig.instance = HeroGroupPresetConfig.New()

return HeroGroupPresetConfig
