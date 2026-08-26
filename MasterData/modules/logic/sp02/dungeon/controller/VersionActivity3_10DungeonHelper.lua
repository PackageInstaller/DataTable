-- chunkname: @modules/logic/sp02/dungeon/controller/VersionActivity3_10DungeonHelper.lua

module("modules.logic.sp02.dungeon.controller.VersionActivity3_10DungeonHelper", package.seeall)

local VersionActivity3_10DungeonHelper = _M

function VersionActivity3_10DungeonHelper.getEpisodeMode(episodeId)
	local episodeCo = DungeonConfig.instance:getEpisodeCO(episodeId)

	return (ActivityConfig.instance:getChapterIdMode(episodeCo.chapterId))
end

function VersionActivity3_10DungeonHelper.calcEpisodeProgress(episodeId)
	local episodeMo = DungeonModel.instance:getEpisodeInfo(episodeId)

	if episodeMo then
		if not episodeMo.star then
			local star = 0
			local conditionCount = VersionActivity3_10DungeonHelper.getEpisodeConditionCount(episodeId)

			if conditionCount == 0 then
				return 0
			end

			return star / conditionCount
		end
	end
end

function VersionActivity3_10DungeonHelper.getEpisodeConditionCount(episodeId)
	local count = 0
	local firstConditionList = DungeonConfig.instance:getEpisodeWinConditionTextList(episodeId)
	local advanceCondition1 = DungeonConfig.instance:getEpisodeAdvancedConditionText(episodeId)
	local advanceCondition2 = DungeonConfig.instance:getEpisodeAdvancedCondition2Text(episodeId)

	if not string.nilorempty(advanceCondition1) then
		count = count + 1
	end

	if not string.nilorempty(advanceCondition2) then
		count = count + 1
	end

	if firstConditionList then
		if not #firstConditionList then
			local firstConditionCount = 0

			count = count + firstConditionCount

			return count
		end
	end
end

return VersionActivity3_10DungeonHelper
