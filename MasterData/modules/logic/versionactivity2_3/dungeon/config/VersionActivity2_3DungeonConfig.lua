-- chunkname: @modules/logic/versionactivity2_3/dungeon/config/VersionActivity2_3DungeonConfig.lua

module("modules.logic.versionactivity2_3.dungeon.config.VersionActivity2_3DungeonConfig", package.seeall)

local VersionActivity2_3DungeonConfig = class("VersionActivity2_3DungeonConfig", BaseConfig)

local function getStoryEpisodeCo(episodeId)
	local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)

	if episodeConfig.chapterId ~= VersionActivity2_3DungeonEnum.DungeonChapterId.ElementFight then
		if episodeConfig.chapterId == VersionActivity2_3DungeonEnum.DungeonChapterId.Hard then
			episodeId = episodeId - 10000
			episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)
		else
			while episodeConfig.chapterId ~= VersionActivity2_3DungeonEnum.DungeonChapterId.Story do
				episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeConfig.preEpisode)
			end
		end
	end

	return episodeConfig
end

function VersionActivity2_3DungeonConfig:getEpisodeMapConfig(episodeId)
	local episodeCo = getStoryEpisodeCo(episodeId)

	return DungeonConfig.instance:getChapterMapCfg(VersionActivity2_3DungeonEnum.DungeonChapterId.Story, episodeCo.preEpisode)
end

function VersionActivity2_3DungeonConfig:checkElementBelongMapId(elementCo, mapId)
	local belongMapIdList = {
		elementCo.mapId
	}

	return tabletool.indexOf(belongMapIdList, mapId)
end

function VersionActivity2_3DungeonConfig:getEpisodeIndex(episodeId)
	local episodeConfig = getStoryEpisodeCo(episodeId)

	return DungeonConfig.instance:getChapterEpisodeIndexWithSP(episodeConfig.chapterId, episodeConfig.id)
end

function VersionActivity2_3DungeonConfig:getStoryEpisodeCo(episodeId)
	return getStoryEpisodeCo(episodeId)
end

function VersionActivity2_3DungeonConfig:getEpisodeIdByElementId(elementId)
	local elementCo = DungeonConfig.instance:getChapterMapElement(elementId)

	return elementCo.mapId
end

VersionActivity2_3DungeonConfig.instance = VersionActivity2_3DungeonConfig.New()

return VersionActivity2_3DungeonConfig
