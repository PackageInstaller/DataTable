-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fruitninja/data/FruitNinjaMo.lua

module("logic.extensions.fruitninja.data.FruitNinjaMo", package.seeall)

local FruitNinjaMo = class("FruitNinjaMo")

function FruitNinjaMo:ctor(activityId)
	self._activityId = activityId
	self._normalModeScore = 0
	self._gainPrizeIds = {}
	self._todayNormalGameTimes = 0
	self._challengeModeHistoryMaxScore = 0
	self._normalModeHistoryMaxScore = 0
	self._clientKey = nil
	self._serverKey = nil
end

function FruitNinjaMo:getActivityId()
	return self._activityId
end

function FruitNinjaMo:handlePM_FruitNinjaGetInfoRes(msg)
	self._normalModeScore = checknumber(msg.normalModeScore)
	self._todayNormalGameTimes = msg.todayNormalGameTimes
	self._challengeModeHistoryMaxScore = msg.challengeModeHistoryMaxScore
	self._normalModeHistoryMaxScore = msg.normalModeHistoryMaxScore

	table.clear(self._gainPrizeIds)

	for _, v in ipairs(msg.gainPrizeIds) do
		self._gainPrizeIds[v] = true
	end
end

function FruitNinjaMo:handlePM_FruitNinjaStartGameRes(msg)
	self._serverKey = msg.serverKey
end

function FruitNinjaMo:handlePM_FruitNinjaEndGameRes(msg)
	self._clientKey = nil
	self._serverKey = nil
	self._normalModeScore = checknumber(msg.normalModeScore)
	self._todayNormalGameTimes = msg.todayNormalGameTimes
	self._challengeModeHistoryMaxScore = msg.challengeModeHistoryMaxScore
end

function FruitNinjaMo:handlePM_FruitNinjaGainPrizeRes(msg)
	self._gainPrizeIds[msg.prizeId] = true
end

function FruitNinjaMo:handlePM_FruitNinjaViewRankRes(msg)
	return
end

function FruitNinjaMo:getNormalModeScore()
	return self._normalModeScore
end

function FruitNinjaMo:isHasGainPrizeNormal(prizeId)
	return self._gainPrizeIds[prizeId] == true
end

function FruitNinjaMo:isEnoughGetPrize(prizeId)
	local data = FruitNinjaConfig.instance:getProgressPrizeData(self._activityId, prizeId)

	if data then
		if not data.needScore then
			local need = 0
			local cur = self:getNormalModeScore()

			return need <= cur
		end
	end
end

function FruitNinjaMo:isCanGetPrizeNormal(prizeId)
	return not self:isHasGainPrizeNormal(prizeId) and self:isEnoughGetPrize(prizeId)
end

function FruitNinjaMo:getTodayNormalGameTimes()
	return self._todayNormalGameTimes
end

function FruitNinjaMo:getMaxNormalGameTimes()
	local data = FruitNinjaConfig.instance:getActData(self._activityId)

	return (data or nil) and (data.dailyGameTimes or 0)
end

function FruitNinjaMo:getLeftNormalGameTimes()
	local cur = self:getTodayNormalGameTimes()
	local max = self:getMaxNormalGameTimes()

	return Mathf.Max(0, max - cur)
end

function FruitNinjaMo:getHistoryMaxScore(mode)
	if mode == FruitNinjaEnum.GameMode_Nor then
		return self._normalModeHistoryMaxScore
	elseif mode == FruitNinjaEnum.GameMode_Ext then
		return self._challengeModeHistoryMaxScore
	else
		return 0
	end
end

function FruitNinjaMo:getClientKey()
	return self._clientKey
end

function FruitNinjaMo:setClientKey(value)
	self._clientKey = value
end

function FruitNinjaMo:getServerKey()
	return self._serverKey
end

function FruitNinjaMo:getEncryptedKey(mode, score)
	return (GameUtil.getClientEncryptedKey(self._clientKey, self._serverKey, {
		mode,
		score
	}))
end

return FruitNinjaMo
