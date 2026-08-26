-- chunkname: @modules/logic/versionactivity3_9/bird/model/V3a9BirdLevelMO.lua

module("modules.logic.versionactivity3_9.bird.model.V3a9BirdLevelMO", package.seeall)

local V3a9BirdLevelMO = pureTable("V3a9BirdLevelMO")

function V3a9BirdLevelMO:init(co)
	self._co = co
	self._episodeId = co.episodeId
	self._isFinished = false
	self._bestScore = 0
	self._bestStar = 0
	self._bestTimeMs = 0
end

function V3a9BirdLevelMO:initInfo(info)
	if info then
		self._isFinished = info.isFinished or false
	end

	if info then
		self._bestScore = info.bestScore or 0
	end

	if info then
		self._bestStar = info.bestStar or 0
	end

	if info then
		self._bestTimeMs = info.bestTimeMs or 0
	end
end

function V3a9BirdLevelMO:isUnlock()
	return true
end

function V3a9BirdLevelMO:getEpisodeId()
	return self._episodeId
end

function V3a9BirdLevelMO:getCo()
	return self._co
end

function V3a9BirdLevelMO:isFinished()
	return self._isFinished
end

function V3a9BirdLevelMO:getStarCount()
	return self._bestStar
end

function V3a9BirdLevelMO:getBestScore()
	return self._bestScore
end

function V3a9BirdLevelMO:getBestTimeMs()
	return self._bestTimeMs
end

function V3a9BirdLevelMO:getPassReward()
	if not self._rewardList then
		local clearBonus = self._co.clearBonus

		if clearBonus > 0 then
			self._rewardList = ItemConfig.instance:getRewardGroupRateInfoList(clearBonus)
		end
	end

	return self._rewardList
end

return V3a9BirdLevelMO
