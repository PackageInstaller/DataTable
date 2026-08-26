-- chunkname: @modules/logic/versionactivity/view/VersionActivityDungeonMapLevelView.lua

module("modules.logic.versionactivity.view.VersionActivityDungeonMapLevelView", package.seeall)

local VersionActivityDungeonMapLevelView = class("VersionActivityDungeonMapLevelView", VersionActivityDungeonBaseMapLevelView)

function VersionActivityDungeonMapLevelView:getEpisodeIndex()
	local mode = ActivityConfig.instance:getChapterIdMode(self.originEpisodeConfig.chapterId)

	if mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard then
		return VersionActivityDungeonMapLevelView.super.getEpisodeIndex(self)
	end

	local episodeList = DungeonConfig.instance:getVersionActivityBrotherEpisodeByEpisodeCo(self.originEpisodeConfig)

	return DungeonConfig.instance:getEpisodeLevelIndex(episodeList[1])
end

return VersionActivityDungeonMapLevelView
