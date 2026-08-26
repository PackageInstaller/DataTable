-- chunkname: @modules/logic/versionactivity2_8/dungeonboss/config/VersionActivity2_8BossConfig.lua

module("modules.logic.versionactivity2_8.dungeonboss.config.VersionActivity2_8BossConfig", package.seeall)

local VersionActivity2_8BossConfig = class("VersionActivity2_8BossConfig", BaseConfig)

function VersionActivity2_8BossConfig:reqConfigNames()
	return {
		"story_mode_battle_field",
		"single_mode_episode",
		"boss_fight_mode_const"
	}
end

function VersionActivity2_8BossConfig:onInit()
	self._taskDict = {}
end

function VersionActivity2_8BossConfig:onConfigLoaded(configName, configTable)
	if configName == "story_mode_battle_field" then
		self:_initStoryModeBattleField()
	end
end

function VersionActivity2_8BossConfig:_initStoryModeBattleField()
	self._storyEpisodeMapId = {}

	local configList = lua_story_mode_battle_field.configList

	for k, v in pairs(configList) do
		local episodeIds = string.split(v.episodeIds, "#")
		local chapterMapIds = string.split(v.chapterMapIds, "#")

		for i, episodeId in ipairs(episodeIds) do
			local mapId = chapterMapIds[i]

			self._storyEpisodeMapId[tonumber(episodeId)] = tonumber(mapId)
		end
	end
end

function VersionActivity2_8BossConfig:getEpisodeMapId(episodeId)
	return self._storyEpisodeMapId[episodeId]
end

function VersionActivity2_8BossConfig:getHeroGroupId(episodeId)
	for k, v in pairs(lua_story_mode_battle_field.configList) do
		if string.find(v.episodeIds, episodeId) then
			return v.heroGroupTypeId
		end
	end
end

VersionActivity2_8BossConfig.instance = VersionActivity2_8BossConfig.New()

return VersionActivity2_8BossConfig
