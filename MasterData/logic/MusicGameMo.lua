-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/musicgame/data/MusicGameMo.lua

module("logic.extensions.musicgame.data.MusicGameMo", package.seeall)

local MusicGameMo = class("MusicGameMo")

function MusicGameMo:ctor(activityId)
	self._activityId = activityId
	self._todayTimes = 0
	self._addScore = 0
	self._score = 0
	self._gainedPrizeIds = {}
	self._maxScores = {}
	self._clientKey = nil
	self._serverKey = nil
end

function MusicGameMo:getActivityId()
	return self._activityId
end

function MusicGameMo:handlePM_MusicGameInfoRes(msg)
	self._todayTimes = msg.todayTimes

	self:updateScore(msg.score)
	table.clear(self._gainedPrizeIds)
	table.insertto(self._gainedPrizeIds, msg.gainedPrizeIds)

	for _, v in ipairs(msg.maxScorePair) do
		self._maxScores[v.left] = v.right
	end
end

function MusicGameMo:handlePM_MusicGameStartRes(msg)
	self._serverKey = msg.serverKey
end

function MusicGameMo:handlePM_MusicGameEndRes(msg)
	self._clientKey = nil
	self._serverKey = nil
end

function MusicGameMo:handlePM_MusicGameGainPrizeRes(msg)
	table.insert(self._gainedPrizeIds, msg.prizeId)
end

function MusicGameMo:handlePM_MusicGameSweepRes(msg)
	self._todayTimes = msg.todayTimes

	self:updateScore(msg.score)

	local maxScore = self:getMaxScore(msg.gameTypeId)

	self._maxScores[msg.gameTypeId] = Mathf.Max(maxScore, msg.score)
end

function MusicGameMo:getTodayTimes()
	return self._todayTimes
end

function MusicGameMo:getMaxTimes()
	local data = MusicGameConfig.instance:getActData(self._activityId)

	return (data or nil) and (data.dailyTimes or 0)
end

function MusicGameMo:getLeftTimes()
	local cur = self:getTodayTimes()
	local max = self:getMaxTimes()

	return Mathf.Max(max - cur, 0)
end

function MusicGameMo:updateScore(value)
	self._addScore = value - self._score
	self._score = value
end

function MusicGameMo:getScore()
	return self._score
end

function MusicGameMo:getAddScore()
	return self._addScore
end

function MusicGameMo:getMaxScore(gameTypeId)
	return checknumber(self._maxScores[gameTypeId])
end

function MusicGameMo:isHasGainPrize(prizeId)
	return table.indexof(self._gainedPrizeIds, prizeId) ~= false
end

function MusicGameMo:isEnoughGetPrize(prizeId)
	local data = MusicGameConfig.instance:getPrizeData(self._activityId, prizeId)

	if data then
		if not data.progress then
			local need = 0
			local cur = self:getScore()

			return need <= cur
		end
	end
end

function MusicGameMo:getClientKey()
	return self._clientKey
end

function MusicGameMo:setClientKey(value)
	self._clientKey = value
end

function MusicGameMo:getServerKey()
	return self._serverKey
end

return MusicGameMo
