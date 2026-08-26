-- chunkname: @modules/logic/versionactivity220/model/Activity220EpisodeMO.lua

module("modules.logic.versionactivity220.model.Activity220EpisodeMO", package.seeall)

local Activity220EpisodeMO = pureTable("Activity220EpisodeMO")

function Activity220EpisodeMO:init(activityId, episodeId)
	self.id = episodeId
	self.activityId = activityId
	self.episodeId = episodeId
	self.config = Activity220Config.instance:getEpisodeConfig(activityId, episodeId)
end

function Activity220EpisodeMO:updateInfo(info)
	self.isFinished = info.isFinished
	self.unlockBranchIds = {}

	for _, unlockBranchId in ipairs(info.unlockBranchIds) do
		self.unlockBranchIds[unlockBranchId] = true
	end

	self.progress = info.progress
end

function Activity220EpisodeMO:updateProgress(info)
	self.progress = info.progress
end

function Activity220EpisodeMO:finishEpisode(info)
	self.progress = info.progress
	self.isFinished = true
end

function Activity220EpisodeMO:unlockBranchId(info)
	self.unlockBranchIds[info.branchId] = true
end

function Activity220EpisodeMO:isEpisodePass()
	return self.isFinished
end

function Activity220EpisodeMO:isGame()
	return self.config.gameId ~= 0
end

function Activity220EpisodeMO:getStoryClear()
	return self.config.storyClear
end

return Activity220EpisodeMO
