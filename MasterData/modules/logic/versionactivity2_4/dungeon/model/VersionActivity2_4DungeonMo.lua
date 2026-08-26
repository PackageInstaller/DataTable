-- chunkname: @modules/logic/versionactivity2_4/dungeon/model/VersionActivity2_4DungeonMo.lua

module("modules.logic.versionactivity2_4.dungeon.model.VersionActivity2_4DungeonMo", package.seeall)

local VersionActivity2_4DungeonMo = pureTable("VersionActivity2_4DungeonMo", VersionActivityDungeonBaseMo)

function VersionActivity2_4DungeonMo:updateEpisodeId(episodeId)
	local tmpEpisodeId

	if episodeId then
		tmpEpisodeId = episodeId

		local episodeCo = DungeonConfig.instance:getEpisodeCO(episodeId)

		if episodeCo.chapterId == self.activityDungeonConfig.story2ChapterId or episodeCo.chapterId == self.activityDungeonConfig.story3ChapterId then
			while episodeCo.chapterId ~= self.activityDungeonConfig.story1ChapterId do
				episodeCo = DungeonConfig.instance:getEpisodeCO(episodeCo.preEpisode)
			end
		end

		tmpEpisodeId = episodeCo.id
	else
		local episodeList = DungeonConfig.instance:getChapterEpisodeCOList(self.chapterId)
		local isPassAll = DungeonModel.instance:hasPassAllChapterEpisode(self.chapterId)

		if isPassAll then
			tmpEpisodeId = VersionActivityDungeonBaseController.instance:getChapterLastSelectEpisode(self.chapterId)
		else
			local dungeonMo

			for _, episodeCfg in ipairs(episodeList) do
				if (episodeCfg and DungeonModel.instance:getEpisodeInfo(episodeCfg.id) or nil) and self:checkEpisodeUnLock(episodeCfg) then
					tmpEpisodeId = episodeCfg.id
				end
			end
		end
	end

	self.episodeId = tmpEpisodeId
end

function VersionActivity2_4DungeonMo:checkEpisodeUnLock(episodeCo)
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

return VersionActivity2_4DungeonMo
