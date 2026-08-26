-- chunkname: @modules/logic/versionactivity2_5/dungeon/config/VersionActivity2_5DungeonConfig.lua

module("modules.logic.versionactivity2_5.dungeon.config.VersionActivity2_5DungeonConfig", package.seeall)

local VersionActivity2_5DungeonConfig = class("VersionActivity2_5DungeonConfig", BaseConfig)

local function getStoryEpisodeCo(episodeId)
	local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)

	if episodeConfig.chapterId ~= VersionActivity2_5DungeonEnum.DungeonChapterId.ElementFight then
		if episodeConfig.chapterId == VersionActivity2_5DungeonEnum.DungeonChapterId.Hard then
			episodeId = episodeId - 10000
			episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)
		else
			while episodeConfig.chapterId ~= VersionActivity2_5DungeonEnum.DungeonChapterId.Story do
				episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeConfig.preEpisode)
			end
		end
	end

	return episodeConfig
end

function VersionActivity2_5DungeonConfig:getEpisodeMapConfig(episodeId)
	local episodeCo = getStoryEpisodeCo(episodeId)

	return DungeonConfig.instance:getChapterMapCfg(VersionActivity2_5DungeonEnum.DungeonChapterId.Story, episodeCo.preEpisode)
end

function VersionActivity2_5DungeonConfig:checkElementBelongMapId(elementCo, mapId)
	local belongMapIdList = {
		elementCo.mapId
	}

	return tabletool.indexOf(belongMapIdList, mapId)
end

function VersionActivity2_5DungeonConfig:getEpisodeIndex(episodeId)
	local episodeConfig = getStoryEpisodeCo(episodeId)

	return DungeonConfig.instance:getChapterEpisodeIndexWithSP(episodeConfig.chapterId, episodeConfig.id)
end

function VersionActivity2_5DungeonConfig:getStoryEpisodeCo(episodeId)
	return getStoryEpisodeCo(episodeId)
end

function VersionActivity2_5DungeonConfig:getEpisodeIdByElementId(elementId)
	local elementCo = DungeonConfig.instance:getChapterMapElement(elementId)

	return elementCo.mapId
end

VersionActivity2_5DungeonConfig.instance = VersionActivity2_5DungeonConfig.New()

return VersionActivity2_5DungeonConfig
