-- chunkname: @modules/logic/versionactivity2_0/dungeon/config/VersionActivity2_0DungeonConfig.lua

module("modules.logic.versionactivity2_0.dungeon.config.VersionActivity2_0DungeonConfig", package.seeall)

local VersionActivity2_0DungeonConfig = class("VersionActivity2_0DungeonConfig", BaseConfig)

local function getStoryEpisodeCo(episodeId)
	local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)

	if episodeConfig.chapterId ~= VersionActivity2_0DungeonEnum.DungeonChapterId.ElementFight then
		if episodeConfig.chapterId == VersionActivity2_0DungeonEnum.DungeonChapterId.Hard then
			episodeId = episodeId - 10000
			episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)
		else
			while episodeConfig.chapterId ~= VersionActivity2_0DungeonEnum.DungeonChapterId.Story do
				episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeConfig.preEpisode)
			end
		end
	end

	return episodeConfig
end

function VersionActivity2_0DungeonConfig:getEpisodeMapConfig(episodeId)
	local episodeCo = getStoryEpisodeCo(episodeId)

	return DungeonConfig.instance:getChapterMapCfg(VersionActivity2_0DungeonEnum.DungeonChapterId.Story, episodeCo.preEpisode)
end

function VersionActivity2_0DungeonConfig:checkElementBelongMapId(elementCo, mapId)
	local belongMapIdList = {
		elementCo.mapId
	}

	return tabletool.indexOf(belongMapIdList, mapId)
end

function VersionActivity2_0DungeonConfig:getEpisodeIndex(episodeId)
	local episodeConfig = getStoryEpisodeCo(episodeId)

	return DungeonConfig.instance:getChapterEpisodeIndexWithSP(episodeConfig.chapterId, episodeConfig.id)
end

function VersionActivity2_0DungeonConfig:getStoryEpisodeCo(episodeId)
	return getStoryEpisodeCo(episodeId)
end

function VersionActivity2_0DungeonConfig:getEpisodeIdByElementId(elementId)
	local elementCo = DungeonConfig.instance:getChapterMapElement(elementId)

	return elementCo.mapId
end

VersionActivity2_0DungeonConfig.instance = VersionActivity2_0DungeonConfig.New()

return VersionActivity2_0DungeonConfig
