-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/idiomchain/data/IdiomChainSubMo.lua

module("logic.extensions.idiomchain.data.IdiomChainSubMo", package.seeall)

local IdiomChainSubMo = class("IdiomChainSubMo")

function IdiomChainSubMo:ctor(activityId)
	self._activityId = activityId

	local data = IdiomChainConfig.instance:getActData(self._activityId)

	if data then
		self._maxDailyTimes = data.dailyTimes or 0
	end

	self:_resetData()
end

function IdiomChainSubMo:_resetData()
	self._serverKey = 0
	self._clientKey = 0
	self._dailyTimes = 0
	self._score = 0
	self._gainedPrizeIds = {}
end

function IdiomChainSubMo:dispose()
	self:_resetData()
end

function IdiomChainSubMo:handlePM_IdiomChainInfoRes(msg)
	self._dailyTimes = checknumber(msg.dailyTimes)
	self._score = checknumber(msg.score)

	table.clear(self._gainedPrizeIds)

	for _, v in ipairs(msg.gainedPrizeIds) do
		self._gainedPrizeIds[v] = true
	end
end

function IdiomChainSubMo:handlePM_IdiomChainGameStartRes(msg)
	self._serverKey = msg.serverKey
end

function IdiomChainSubMo:handlePM_IdiomChainGameEndRes(msg)
	self._clientKey = nil
	self._serverKey = nil
end

function IdiomChainSubMo:handlePM_IdiomChainGainPrizeRes(msg)
	self._gainedPrizeIds[msg.prizeId] = true
end

function IdiomChainSubMo:getScore()
	return self._score
end

function IdiomChainSubMo:isHasGainPrize(prizeId)
	return self._gainedPrizeIds[prizeId] == true
end

function IdiomChainSubMo:isEnoughGetPrize(prizeId)
	local data = IdiomChainConfig.instance:getPrizeData(self._activityId, prizeId)

	if data then
		if not data.needScore then
			local need = 0
			local cur = self:getScore()

			return need <= cur
		end
	end
end

function IdiomChainSubMo:isCanGetPrize(prizeId)
	return not self:isHasGainPrize(prizeId) and self:isEnoughGetPrize(prizeId)
end

function IdiomChainSubMo:getDailyTimes()
	return self._dailyTimes
end

function IdiomChainSubMo:getMaxDailyTimes()
	return self._maxDailyTimes
end

function IdiomChainSubMo:getLeftDailyTimes()
	local cur = self:getDailyTimes()
	local max = self:getMaxDailyTimes()

	return Mathf.Max(0, max - cur)
end

function IdiomChainSubMo:getEncryptedKey(isPass, gameTime)
	return GameUtil.getClientEncryptedKey(self._clientKey, self._serverKey, {
		isPass and 1 or 0,
		gameTime
	})
end

function IdiomChainSubMo:getServerKey()
	return self._serverKey
end

function IdiomChainSubMo:getClientKey()
	return self._clientKey
end

function IdiomChainSubMo:setClientKey(value)
	self._clientKey = value
end

return IdiomChainSubMo
