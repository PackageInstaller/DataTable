-- chunkname: @modules/logic/versionactivity2_1/dungeon/config/VersionActivity2_1DungeonConfig.lua

module("modules.logic.versionactivity2_1.dungeon.config.VersionActivity2_1DungeonConfig", package.seeall)

local VersionActivity2_1DungeonConfig = class("VersionActivity2_1DungeonConfig", BaseConfig)

local function getStoryEpisodeCo(episodeId)
	local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)

	if episodeConfig.chapterId ~= VersionActivity2_1DungeonEnum.DungeonChapterId.ElementFight then
		if episodeConfig.chapterId == VersionActivity2_1DungeonEnum.DungeonChapterId.Hard then
			episodeId = episodeId - 10000
			episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)
		else
			while episodeConfig.chapterId ~= VersionActivity2_1DungeonEnum.DungeonChapterId.Story do
				episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeConfig.preEpisode)
			end
		end
	end

	return episodeConfig
end

function VersionActivity2_1DungeonConfig:getEpisodeMapConfig(episodeId)
	local episodeCo = getStoryEpisodeCo(episodeId)

	return DungeonConfig.instance:getChapterMapCfg(VersionActivity2_1DungeonEnum.DungeonChapterId.Story, episodeCo.preEpisode)
end

function VersionActivity2_1DungeonConfig:checkElementBelongMapId(elementCo, mapId)
	local belongMapIdList = {
		elementCo.mapId
	}

	return tabletool.indexOf(belongMapIdList, mapId)
end

function VersionActivity2_1DungeonConfig:getEpisodeIndex(episodeId)
	local episodeConfig = getStoryEpisodeCo(episodeId)

	return DungeonConfig.instance:getChapterEpisodeIndexWithSP(episodeConfig.chapterId, episodeConfig.id)
end

function VersionActivity2_1DungeonConfig:getStoryEpisodeCo(episodeId)
	return getStoryEpisodeCo(episodeId)
end

function VersionActivity2_1DungeonConfig:getEpisodeIdByElementId(elementId)
	local elementCo = DungeonConfig.instance:getChapterMapElement(elementId)

	return elementCo.mapId
end

VersionActivity2_1DungeonConfig.instance = VersionActivity2_1DungeonConfig.New()

return VersionActivity2_1DungeonConfig
