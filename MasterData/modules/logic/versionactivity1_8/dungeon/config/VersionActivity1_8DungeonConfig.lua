-- chunkname: @modules/logic/versionactivity1_8/dungeon/config/VersionActivity1_8DungeonConfig.lua

module("modules.logic.versionactivity1_8.dungeon.config.VersionActivity1_8DungeonConfig", package.seeall)

local VersionActivity1_8DungeonConfig = class("VersionActivity1_8DungeonConfig", BaseConfig)

local function getStoryEpisodeCo(episodeId)
	local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)

	if episodeConfig.chapterId ~= VersionActivity1_8DungeonEnum.DungeonChapterId.ElementFight then
		if episodeConfig.chapterId == VersionActivity1_8DungeonEnum.DungeonChapterId.Hard then
			episodeId = episodeId - 10000
			episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)
		else
			while episodeConfig.chapterId ~= VersionActivity1_8DungeonEnum.DungeonChapterId.Story do
				episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeConfig.preEpisode)
			end
		end
	end

	return episodeConfig
end

function VersionActivity1_8DungeonConfig:getEpisodeMapConfig(episodeId)
	local episodeCo = getStoryEpisodeCo(episodeId)

	return DungeonConfig.instance:getChapterMapCfg(VersionActivity1_8DungeonEnum.DungeonChapterId.Story, episodeCo.preEpisode)
end

function VersionActivity1_8DungeonConfig:getEpisodeIndex(episodeId)
	local episodeConfig = getStoryEpisodeCo(episodeId)

	return DungeonConfig.instance:getChapterEpisodeIndexWithSP(episodeConfig.chapterId, episodeConfig.id)
end

function VersionActivity1_8DungeonConfig:checkElementBelongMapId(elementCo, mapId)
	local belongMapIdList = {
		elementCo.mapId
	}

	return tabletool.indexOf(belongMapIdList, mapId)
end

function VersionActivity1_8DungeonConfig:getStoryEpisodeCo(episodeId)
	return getStoryEpisodeCo(episodeId)
end

VersionActivity1_8DungeonConfig.instance = VersionActivity1_8DungeonConfig.New()

return VersionActivity1_8DungeonConfig
