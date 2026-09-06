-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fishinggame/model/FishingGameModel.lua

module("logic.extensions.fishinggame.model.FishingGameModel", package.seeall)

local FishingGameModel = class("FishingGameModel", BaseModel)

function FishingGameModel:onInit()
	self:onReset()
end

function FishingGameModel:onReset()
	self._infos = {}
	self._clientKey = {}
	self._serverKey = {}
end

function FishingGameModel:getInfo(activityId)
	return self._infos[activityId]
end

function FishingGameModel:handlePM_FishingGameGetInfoRes(msg)
	self._infos[msg.activityId] = GameUtil.pbToTable(msg)

	local info = self._infos[msg.activityId]

	info.gainPrizeIds = info.gainPrizeIds or {}
end

function FishingGameModel:handlePM_FishingGameStartGameRes(msg)
	self._serverKey[msg.activityId] = msg.encryptedKey
end

function FishingGameModel:handlePM_FishingGameEndGameRes(msg)
	local info = self._infos[msg.activityId]

	info.score = msg.score
	info.todayTimes = msg.todayTimes
	info.maxScore = math.max(checknumber(info.maxScore), checknumber(msg.addScore))
end

function FishingGameModel:handlePM_FishingGameGainPrizeRes(msg)
	local info = self._infos[msg.activityId]

	info.gainPrizeIds = info.gainPrizeIds or {}

	if msg.prizeId then
		for i, v in ipairs(msg.prizeId) do
			table.insert(info.gainPrizeIds, v)
		end
	end
end

function FishingGameModel:handlePM_FishingGameAnnuitySweepRes(msg)
	local info = self._infos[msg.activityId]

	info.score = msg.score
	info.todayTimes = msg.todayTimes
end

function FishingGameModel:getClientKey(activityId)
	local clientKey = math.random(1, ServerTime.now()) + activityId

	self._clientKey[activityId] = clientKey

	return clientKey
end

function FishingGameModel:getEncryptedKey(activityId, score)
	local clientKey = self._clientKey[activityId]
	local serverKey = self._serverKey[activityId]

	return GameUtil.getClientEncryptedKey(clientKey, serverKey, {
		activityId,
		score
	})
end

FishingGameModel.instance = FishingGameModel.New()

return FishingGameModel
