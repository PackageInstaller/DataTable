-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elizabethgame/model/ElizabethgameModel.lua

module("logic.extensions.elizabethgame.view.ElizabethgameModel", package.seeall)

local ElizabethgameModel = class("ElizabethgameModel", BaseModel)

function ElizabethgameModel:ctor()
	return
end

function ElizabethgameModel:onInit()
	self:onReset()
end

function ElizabethgameModel:onReset()
	self._gameInfos = {}
	self._clientKeys = {}
	self._reliveTimes = 0
	self._severKey = 0
end

function ElizabethgameModel:getUsedTimes(activityId)
	if self._gameInfos[activityId] then
		return self._gameInfos[activityId].gameTimes
	end

	return 0
end

function ElizabethgameModel:updateGameInfo(msg)
	if self._gameInfos[msg.activityId] then
		self._gameInfos[msg.activityId].gameTimes = msg.gameTimes
		self._gameInfos[msg.activityId].flowerNums = msg.flowerNums
	end
end

function ElizabethgameModel:getBuyedTimes(activityId)
	if self._gameInfos[activityId] then
		return self._gameInfos[activityId].buyTimes
	end

	return 0
end

function ElizabethgameModel:getProgress(activityId)
	if self._gameInfos[activityId] then
		return self._gameInfos[activityId].flowerNums
	end

	return 0
end

function ElizabethgameModel:getGianPrizeIds(activityId)
	if self._gameInfos[activityId] then
		return self._gameInfos[activityId].gianPrizeIds
	end

	return {}
end

function ElizabethgameModel:gainPrizeRes(activityId, prizeId)
	if self._gameInfos[activityId] then
		self._gameInfos[activityId].gianPrizeIds:append(prizeId)
	end
end

function ElizabethgameModel:setGameInfo(msg)
	self._gameInfos[msg.activityId] = msg
end

function ElizabethgameModel:setServerKey(key)
	self._severKey = key
end

function ElizabethgameModel:getServerKey()
	return self._severKey
end

function ElizabethgameModel:setReliveTimes(value)
	self._reliveTimes = value
end

function ElizabethgameModel:getReliveTimes()
	return checknumber(self._reliveTimes)
end

function ElizabethgameModel:addUsedTimes(activityId)
	if self._gameInfos[activityId] then
		self._gameInfos[activityId].gameTimes = self._gameInfos[activityId].gameTimes + 1
	end
end

function ElizabethgameModel:addBuyedTimes(activityId, buyTimes)
	if self._gameInfos[activityId] then
		self._gameInfos[activityId].buyTimes = buyTimes
	end
end

function ElizabethgameModel:getEncryptedKey(activityId, clicks, scale)
	local serverResList = {
		clicks,
		scale
	}
	local clientKey = self:getClientKey(activityId)
	local serverKey = self:getServerKey(activityId)
	local encryptedKey = GameUtil.getClientEncryptedKey(clientKey, serverKey, serverResList)

	return tostring(encryptedKey)
end

function ElizabethgameModel:getClientKey(activityId)
	return self._clientKeys[activityId] or 0
end

function ElizabethgameModel:randomClientKey(activityId)
	local key = math.random(1, 9)

	self._clientKeys[activityId] = key

	return key
end

ElizabethgameModel.instance = ElizabethgameModel.New()

return ElizabethgameModel
