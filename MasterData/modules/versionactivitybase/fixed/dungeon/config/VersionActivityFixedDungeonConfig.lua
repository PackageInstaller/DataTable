-- chunkname: @modules/versionactivitybase/fixed/dungeon/config/VersionActivityFixedDungeonConfig.lua

module("modules.versionactivitybase.fixed.dungeon.config.VersionActivityFixedDungeonConfig", package.seeall)

local VersionActivityFixedDungeonConfig = class("VersionActivityFixedDungeonConfig", BaseConfig)

local function getStoryEpisodeCo(episodeId)
	local bigVersion, smallVersion = VersionActivityFixedDungeonController.instance:getEnterVerison()
	local actDungeonEnum = VersionActivityFixedHelper.getVersionActivityDungeonEnum(bigVersion, smallVersion)
	local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)

	if episodeConfig.chapterId ~= actDungeonEnum.DungeonChapterId.ElementFight then
		if episodeConfig.chapterId == actDungeonEnum.DungeonChapterId.Hard then
			episodeId = episodeId - 10000
			episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)
		else
			while episodeConfig.chapterId ~= actDungeonEnum.DungeonChapterId.Story do
				episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeConfig.preEpisode)
			end
		end
	end

	return episodeConfig
end

function VersionActivityFixedDungeonConfig:getEpisodeMapConfig(episodeId)
	local bigVersion, smallVersion = VersionActivityFixedDungeonController.instance:getEnterVerison()
	local actDungeonEnum = VersionActivityFixedHelper.getVersionActivityDungeonEnum(bigVersion, smallVersion)
	local episodeCo = getStoryEpisodeCo(episodeId)

	return DungeonConfig.instance:getChapterMapCfg(actDungeonEnum.DungeonChapterId.Story, episodeCo.preEpisode)
end

function VersionActivityFixedDungeonConfig:checkElementBelongMapId(elementCo, mapId)
	local belongMapIdList = {
		elementCo.mapId
	}

	return tabletool.indexOf(belongMapIdList, mapId)
end

function VersionActivityFixedDungeonConfig:getEpisodeIndex(episodeId, episodeType)
	local episodeConfig = getStoryEpisodeCo(episodeId)

	return DungeonConfig.instance:getChapterEpisodeIndexWithSPType(episodeConfig.chapterId, episodeConfig.id, episodeType)
end

function VersionActivityFixedDungeonConfig:getStoryEpisodeCo(episodeId)
	return getStoryEpisodeCo(episodeId)
end

function VersionActivityFixedDungeonConfig:getEpisodeIdByElementId(elementId)
	local elementCo = DungeonConfig.instance:getChapterMapElement(elementId)

	return elementCo.mapId
end

VersionActivityFixedDungeonConfig.instance = VersionActivityFixedDungeonConfig.New()

return VersionActivityFixedDungeonConfig
