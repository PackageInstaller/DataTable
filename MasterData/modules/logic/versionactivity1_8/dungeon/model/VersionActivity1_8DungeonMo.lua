-- chunkname: @modules/logic/versionactivity1_8/dungeon/model/VersionActivity1_8DungeonMo.lua

module("modules.logic.versionactivity1_8.dungeon.model.VersionActivity1_8DungeonMo", package.seeall)

local VersionActivity1_8DungeonMo = pureTable("VersionActivity1_8DungeonMo", VersionActivityDungeonBaseMo)

function VersionActivity1_8DungeonMo:updateEpisodeId(episodeId)
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
			local isInSideMission = self:getIsInSideMission()

			if isInSideMission then
				local lastEpisodeCfg = episodeList[#episodeList]

				tmpEpisodeId = lastEpisodeCfg and lastEpisodeCfg.id
			end
		else
			local dungeonMo

			for _, episodeCfg in ipairs(episodeList) do
				if (episodeCfg and DungeonModel.instance:getEpisodeInfo(episodeCfg.id) or nil) and self:checkEpisodeUnLock(episodeCfg) then
					tmpEpisodeId = episodeCfg.id
				end
			end
		end
	end

	self.episodeId = tmpEpisodeId and tmpEpisodeId or VersionActivityDungeonBaseController.instance:getChapterLastSelectEpisode(self.chapterId)
end

function VersionActivity1_8DungeonMo:getIsInSideMission()
	local result = false
	local isUnlockedSideMission = Activity157Model.instance:getIsSideMissionUnlocked()

	if not isUnlockedSideMission then
		return result
	end

	local episodeList = DungeonConfig.instance:getChapterEpisodeCOList(self.chapterId)
	local lastEpisodeCfg = episodeList[#episodeList]
	local lastEpisodeId = lastEpisodeCfg and lastEpisodeCfg.id

	if not lastEpisodeId then
		return result
	end

	local actId = Activity157Model.instance:getActId()
	local mapCfg = VersionActivity1_8DungeonConfig.instance:getEpisodeMapConfig(lastEpisodeId)
	local elementCoList = VersionActivity1_8DungeonModel.instance:getElementCoList(mapCfg.id)

	for _, elementCo in ipairs(elementCoList) do
		local elementId = elementCo.id
		local act157MissionId = Activity157Config.instance:getMissionIdByElementId(actId, elementId)

		if act157MissionId then
			::label_2_0::

			local isSideMission = Activity157Config.instance:isSideMission(actId, act157MissionId)

			if isSideMission then
				local act157MissionGroupId = Activity157Config.instance:getMissionGroup(actId, act157MissionId)
				local isFinish = Activity157Model.instance:isFinishMission(act157MissionGroupId, act157MissionId)

				if not isFinish then
					result = true

					break
				end
			end
		end
	end

	return result
end

function VersionActivity1_8DungeonMo:checkEpisodeUnLock(episodeCo)
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

return VersionActivity1_8DungeonMo
