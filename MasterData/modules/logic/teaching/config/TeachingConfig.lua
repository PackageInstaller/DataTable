-- chunkname: @modules/logic/teaching/config/TeachingConfig.lua

module("modules.logic.teaching.config.TeachingConfig", package.seeall)

local TeachingConfig = class("TeachingConfig", BaseConfig)

function TeachingConfig:reqConfigNames()
	return {
		"teaching",
		"teaching_episode"
	}
end

function TeachingConfig:onInit()
	return
end

function TeachingConfig:onConfigLoaded(configName, configTable)
	return
end

function TeachingConfig:getEpisodeDescByTeachId(teachId)
	local episodeDesc = {}
	local count = tabletool.len(lua_teaching_episode.configList)

	for i = 1, count do
		local episode = lua_teaching_episode.configList[i]

		if episode.teaching == teachId then
			table.insert(episodeDesc, episode.detail)
		end
	end

	return episodeDesc
end

function TeachingConfig:getFirstEpisodeIdByTeachId(teachId)
	local count = tabletool.len(lua_teaching_episode.configList)

	for i = 1, count do
		local episode = lua_teaching_episode.configList[i]

		if episode.teaching == teachId and episode.preEpisode == 0 then
			return episode.id
		end
	end

	return nil
end

function TeachingConfig:getTeachingConfig(teachId)
	return lua_teaching.configDict[teachId]
end

function TeachingConfig:getTeachingConfigByBattleTag(battleTag)
	local allConfig = self:getAllTeachingConfig()
	local count = tabletool.len(allConfig)

	for i = 1, count do
		local teachingConfig = allConfig[i]

		if teachingConfig.battleTag == battleTag then
			return teachingConfig
		end
	end

	return nil
end

function TeachingConfig:getAllTeachingConfig()
	return lua_teaching.configList
end

TeachingConfig.instance = TeachingConfig.New()

return TeachingConfig
