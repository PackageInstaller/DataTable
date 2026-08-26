-- chunkname: @modules/logic/versionactivity220/model/Activity220MO.lua

module("modules.logic.versionactivity220.model.Activity220MO", package.seeall)

local Activity220MO = pureTable("Activity220MO")

function Activity220MO:init(activityId)
	self.id = activityId
	self.activityId = activityId
end

function Activity220MO:updateInfo(info)
	self.episodeInfos = {}

	self:updateEpisodeInfos(info.episodes)
end

function Activity220MO:pushEpisodes(info)
	self:updateEpisodeInfos(info.episodes)
end

function Activity220MO:updateEpisodeInfos(episodes)
	for _, episodeInfo in ipairs(episodes) do
		self:updateEpisodeInfo(episodeInfo)
	end
end

function Activity220MO:updateEpisodeInfo(episode)
	local info = self:getEpisodeInfo(episode.episodeId)

	if not info then
		info = Activity220EpisodeMO.New()

		info:init(self.activityId, episode.episodeId)

		self.episodeInfos[episode.episodeId] = info
	end

	info:updateInfo(episode)
end

function Activity220MO:updateEpisodeProgress(episode)
	local info = self:getEpisodeInfo(episode.episodeId)

	if info then
		info:updateProgress(episode)
	end
end

function Activity220MO:finishEpisode(episode)
	local info = self:getEpisodeInfo(episode.episodeId)

	if info then
		info:finishEpisode(episode)
	end
end

function Activity220MO:unlockEpisodeBranch(episode)
	local info = self:getEpisodeInfo(episode.episodeId)

	if info then
		info:unlockBranchId(episode)
	end
end

function Activity220MO:getEpisodeInfo(episodeId)
	return self.episodeInfos[episodeId]
end

function Activity220MO:setNewFinishEpisode(episodeId)
	self._newFinishEpisode = episodeId
end

function Activity220MO:clearFinishEpisode()
	self._newFinishEpisode = 0
end

function Activity220MO:getNewFinishEpisode()
	return self._newFinishEpisode or 0
end

function Activity220MO:isEpisodeUnlock(episodeId)
	local info = self:getEpisodeInfo(episodeId)

	return info ~= nil
end

function Activity220MO:setCurEpisode(index, episodeId)
	self._curEpisodeIndex = index
	self._curEpisode = episodeId and episodeId or self._curEpisode
end

function Activity220MO:getCurEpisodeIndex()
	return self._curEpisodeIndex or 0
end

function Activity220MO:getCurEpisode()
	return self._curEpisode
end

function Activity220MO:isEpisodePass(episodeId)
	local info = self:getEpisodeInfo(episodeId)

	if info then
		return info:isEpisodePass()
	end

	return false
end

return Activity220MO
