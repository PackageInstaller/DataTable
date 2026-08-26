-- chunkname: @modules/logic/versionactivity1_5/dungeon/model/VersionActivity1_5DungeonMo.lua

module("modules.logic.versionactivity1_5.dungeon.model.VersionActivity1_5DungeonMo", package.seeall)

local VersionActivity1_5DungeonMo = pureTable("VersionActivity1_5DungeonMo", VersionActivityDungeonBaseMo)

function VersionActivity1_5DungeonMo:updateEpisodeId(episodeId)
	if episodeId then
		self.episodeId = episodeId

		local episodeCo = DungeonConfig.instance:getEpisodeCO(self.episodeId)

		if episodeCo.chapterId == self.activityDungeonConfig.story2ChapterId or episodeCo.chapterId == self.activityDungeonConfig.story3ChapterId then
			while episodeCo.chapterId ~= self.activityDungeonConfig.story1ChapterId do
				episodeCo = DungeonConfig.instance:getEpisodeCO(episodeCo.preEpisode)
			end
		end

		self.episodeId = episodeCo.id

		return
	end

	if DungeonModel.instance:hasPassAllChapterEpisode(self.chapterId) then
		self.episodeId = VersionActivityDungeonBaseController.instance:getChapterLastSelectEpisode(self.chapterId)
	else
		local episodeList = DungeonConfig.instance:getChapterEpisodeCOList(self.chapterId)
		local dungeonMo

		for _, config in ipairs(episodeList) do
			if (config and DungeonModel.instance:getEpisodeInfo(config.id) or nil) and self:checkEpisodeUnLock(config) then
				self.episodeId = config.id
			end
		end
	end
end

function VersionActivity1_5DungeonMo:checkEpisodeUnLock(episodeCo)
	if not episodeCo then
		return true
	end

	local listStr = episodeCo.elementList

	if string.nilorempty(listStr) then
		return true
	end

	local elementIdList = string.splitToNumber(listStr, "#")

	for _, elementId in ipairs(elementIdList) do
		if not DungeonMapModel.instance:elementIsFinished(elementId) then
			return false
		end
	end

	return true
end

return VersionActivity1_5DungeonMo
