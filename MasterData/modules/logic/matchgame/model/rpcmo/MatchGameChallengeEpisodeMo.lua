-- chunkname: @modules/logic/matchgame/model/rpcmo/MatchGameChallengeEpisodeMo.lua

module("modules.logic.matchgame.model.rpcmo.MatchGameChallengeEpisodeMo", package.seeall)

local MatchGameChallengeEpisodeMo = class("MatchGameChallengeEpisodeMo")

function MatchGameChallengeEpisodeMo:init(info)
	self.episodeId = info.episodeId
	self.episodeCo = lua_activity244_episode.configDict[self.episodeId]
	self.matchLevelId = self.episodeCo.matchLevelId
	self.levelCo = lua_activity244_episode_level.configDict[self.matchLevelId]
	self.maxScore = info.maxScore
	self.nextRoundTime = tonumber(info.nextRoundTime)
	self.isUnlock = info.isUnlock
end

function MatchGameChallengeEpisodeMo:isOpen()
	return self.nextRoundTime == 0 and self.isUnlock
end

return MatchGameChallengeEpisodeMo
