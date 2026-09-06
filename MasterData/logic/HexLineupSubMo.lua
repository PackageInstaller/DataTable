-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hexlineup/data/HexLineupSubMo.lua

module("logic.extensions.hexlineup.data.HexLineupSubMo", package.seeall)

local HexLineupSubMo = class("HexLineupSubMo")

function HexLineupSubMo:ctor(activityId)
	self._activityId = activityId

	local actData = HexLineupConfig.instance:getActivityData(activityId)

	if actData then
		self._dailyGameLimit = actData.dailyGameLimit or 0
	end

	self:onReset()
end

function HexLineupSubMo:onReset()
	self._serverKey = 0
	self._clientKey = 0
	self._todayGameTimes = 0
	self._totalScore = 0
	self._gainedPrizeIds = {}
	self._limitModeMaxScore = 0
	self._endlessModeMaxScore = 0
	self._rankInfo = nil
end

function HexLineupSubMo:dispose()
	self:onReset()
end

function HexLineupSubMo:handlePM_HexLineupGetInfoRes(msg)
	self._todayGameTimes = msg.todayGameTimes
	self._totalScore = msg.totalScore
	self._limitModeMaxScore = msg.limitModeMaxScore
	self._endlessModeMaxScore = msg.endlessModeMaxScore
	self._gainedPrizeIds = {}

	for _, v in ipairs(msg.gainPrizeIds) do
		self._gainedPrizeIds[v] = true
	end
end

function HexLineupSubMo:handlePM_HexLineupStartGameRes(msg)
	self._serverKey = msg.serverKey
end

function HexLineupSubMo:handlePM_HexLineupEndGameRes(msg)
	self._clientKey = nil
	self._serverKey = nil

	local modeId = msg.modeId
	local score = msg.score

	self._totalScore = msg.totalScore

	if modeId == HexLineupEnum.ModeId_Limit and score > 0 then
		self._todayGameTimes = self._todayGameTimes + 1

		if score > self._limitModeMaxScore then
			self._limitModeMaxScore = score
		end
	end
end

function HexLineupSubMo:handlePM_HexLineupGainPrizeRes(msg)
	for _, v in ipairs(msg.prizeIds) do
		self._gainedPrizeIds[v] = true
	end
end

function HexLineupSubMo:handlePM_HexLineupSweepRes(msg)
	self._todayGameTimes = msg.todayGameTimes
	self._totalScore = msg.totalScore
end

function HexLineupSubMo:handlePM_HexLineupRankViewRes(msg)
	return
end

function HexLineupSubMo:getEncryptedKey(modeId, score)
	return GameUtil.getClientEncryptedKey(self._clientKey, self._serverKey, {
		modeId,
		score
	})
end

function HexLineupSubMo:getServerKey()
	return self._serverKey
end

function HexLineupSubMo:getClientKey()
	return self._clientKey
end

function HexLineupSubMo:setClientKey(value)
	self._clientKey = value
end

function HexLineupSubMo:getTodayGameTimes()
	return self._todayGameTimes
end

function HexLineupSubMo:getDailyGameLimit()
	return self._dailyGameLimit
end

function HexLineupSubMo:getLeftDailyTimes()
	return Mathf.Max(0, self._dailyGameLimit - self._todayGameTimes)
end

function HexLineupSubMo:getTotalScore()
	return self._totalScore
end

function HexLineupSubMo:getLimitModeMaxScore()
	return self._limitModeMaxScore
end

function HexLineupSubMo:getEndlessModeMaxScore()
	return self._endlessModeMaxScore
end

function HexLineupSubMo:isHasGainPrize(prizeId)
	return self._gainedPrizeIds[prizeId] == true
end

function HexLineupSubMo:isEnoughGetPrize(prizeId)
	local data = HexLineupConfig.instance:getProgressPrizeData(self._activityId, prizeId)

	if data then
		if not data.progress then
			local need = 0

			return need <= self._totalScore
		end
	end
end

function HexLineupSubMo:isCanGetPrize(prizeId)
	return not self:isHasGainPrize(prizeId) and self:isEnoughGetPrize(prizeId)
end

function HexLineupSubMo:isHasCanGetPrize()
	local datas = HexLineupConfig.instance:getProgressPrizeDatas(self._activityId)

	if datas then
		for _, data in pairs(datas) do
			if self:isCanGetPrize(data.prizeId) then
				return true
			end
		end
	end

	return false
end

function HexLineupSubMo:getPrizeState(prizeId)
	if self:isHasGainPrize(prizeId) then
		return GameEnum.PrizeState.IsHasGain
	elseif not self:isEnoughGetPrize(prizeId) then
		return GameEnum.PrizeState.IsNotEnough
	else
		return GameEnum.PrizeState.IsCanGet
	end
end

return HexLineupSubMo
