-- chunkname: @modules/logic/versionactivity2_4/dungeon/config/VersionActivity2_4DungeonConfig.lua

module("modules.logic.versionactivity2_4.dungeon.config.VersionActivity2_4DungeonConfig", package.seeall)

local VersionActivity2_4DungeonConfig = class("VersionActivity2_4DungeonConfig", BaseConfig)

local function getStoryEpisodeCo(episodeId)
	local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)

	if episodeConfig.chapterId ~= VersionActivity2_4DungeonEnum.DungeonChapterId.ElementFight then
		if episodeConfig.chapterId == VersionActivity2_4DungeonEnum.DungeonChapterId.Hard then
			episodeId = episodeId - 10000
			episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)
		else
			while episodeConfig.chapterId ~= VersionActivity2_4DungeonEnum.DungeonChapterId.Story do
				episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeConfig.preEpisode)
			end
		end
	end

	return episodeConfig
end

function VersionActivity2_4DungeonConfig:getEpisodeMapConfig(episodeId)
	local episodeCo = getStoryEpisodeCo(episodeId)

	return DungeonConfig.instance:getChapterMapCfg(VersionActivity2_4DungeonEnum.DungeonChapterId.Story, episodeCo.preEpisode)
end

function VersionActivity2_4DungeonConfig:checkElementBelongMapId(elementCo, mapId)
	local belongMapIdList = {
		elementCo.mapId
	}

	return tabletool.indexOf(belongMapIdList, mapId)
end

function VersionActivity2_4DungeonConfig:getEpisodeIndex(episodeId)
	local episodeConfig = getStoryEpisodeCo(episodeId)

	return DungeonConfig.instance:getChapterEpisodeIndexWithSP(episodeConfig.chapterId, episodeConfig.id)
end

function VersionActivity2_4DungeonConfig:getStoryEpisodeCo(episodeId)
	return getStoryEpisodeCo(episodeId)
end

function VersionActivity2_4DungeonConfig:getEpisodeIdByElementId(elementId)
	local elementCo = DungeonConfig.instance:getChapterMapElement(elementId)

	return elementCo.mapId
end

VersionActivity2_4DungeonConfig.instance = VersionActivity2_4DungeonConfig.New()

return VersionActivity2_4DungeonConfig
