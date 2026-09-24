-- chunkname: @modules/logic/matchgame/model/rpcmo/MatchGameChallengeMo.lua

module("modules.logic.matchgame.model.rpcmo.MatchGameChallengeMo", package.seeall)

local MatchGameChallengeMo = class("MatchGameChallengeMo")

function MatchGameChallengeMo:init(info)
	self.episodeMap = GameUtil.rpcInfosToMap(info.challengeEpisodes, MatchGameChallengeEpisodeMo, "episodeId")
	self.currEpisodeIds = info.currEpisodeIds or {}
	self.currEpisodeIdMap = GameUtil.listToDict(self.currEpisodeIds)
	self.totalScore = tonumber(info.totalScore)
	self.receivedBonusId = info.receivedBonusId
	self.nextRoundTime = self:_calcNextRoundTime() or 0
end

function MatchGameChallengeMo:isUnlock()
	for _, episodeMo in pairs(self.episodeMap) do
		if episodeMo:isOpen() then
			return true
		end
	end
end

function MatchGameChallengeMo:getEpisodeMo(episodeId)
	return self.episodeMap and self.episodeMap[episodeId]
end

function MatchGameChallengeMo:isEpisodeOpen(episodeId)
	return self.currEpisodeIdMap and self.currEpisodeIdMap[episodeId] ~= nil
end

function MatchGameChallengeMo:_calcNextRoundTime()
	local minNextRoundTime

	for _, episodeMo in pairs(self.episodeMap) do
		local nextRoundTime = episodeMo.nextRoundTime

		if nextRoundTime and nextRoundTime ~= 0 and (not minNextRoundTime or nextRoundTime < minNextRoundTime) then
			minNextRoundTime = nextRoundTime
		end
	end

	return minNextRoundTime
end

return MatchGameChallengeMo
