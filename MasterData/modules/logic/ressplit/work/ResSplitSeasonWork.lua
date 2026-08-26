-- chunkname: @modules/logic/ressplit/work/ResSplitSeasonWork.lua

module("modules.logic.ressplit.work.ResSplitSeasonWork", package.seeall)

local ResSplitSeasonWork = class("ResSplitSeasonWork", BaseWork)

function ResSplitSeasonWork:onStart(context)
	for seasonId, _ in pairs(ResSplitModel.instance.includeSeasonDic) do
		local episodeConfig = SeasonConfig.instance:getSeasonEpisodeCos(seasonId)
		local retailConfig = SeasonConfig.instance:getSeasonRetailCos(seasonId)
		local specialConfig = SeasonConfig.instance:getSeasonSpecialCos(seasonId)
		local episodeIdDic = {}

		for layer, config in pairs(episodeConfig) do
			episodeIdDic[config.episodeId] = true

			ResSplitModel.instance:addIncludeStory(config.afterStoryId)
		end

		for stage, config in pairs(retailConfig) do
			local arr = string.splitToNumber(config.retailEpisodeIdPool, "#")

			for _, episodeId in pairs(arr) do
				episodeIdDic[episodeId] = true
			end
		end

		for layer, config in pairs(specialConfig) do
			episodeIdDic[config.episodeId] = true
		end

		for id, v in pairs(episodeIdDic) do
			ResSplitHelper.addEpisodeRes(id)
		end

		local seasonOpenStorysArr = SeasonConfig.instance:getStoryIds(seasonId)

		for i, v in ipairs(seasonOpenStorysArr) do
			ResSplitModel.instance:addIncludeStory(v)
		end
	end

	self:onDone(true)
end

return ResSplitSeasonWork
