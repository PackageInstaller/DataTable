-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/qixilinkgame/model/QiXiLinkGameModel.lua

module("logic.extensions.qixilinkgame.model.QiXiLinkGameModel", package.seeall)

local QiXiLinkGameModel = class("QiXiLinkGameModel", BaseModel)

QiXiLinkGameModel.ReadFlag = "QiXiLinkGameModel.ReadFlag"

function QiXiLinkGameModel:onInit()
	self:onReset()
end

function QiXiLinkGameModel:onReset()
	self._infos = {}
end

function QiXiLinkGameModel:getInfo(activityId)
	return self._infos[activityId]
end

function QiXiLinkGameModel:handlePM_LinkendlessGameInfoRes(msg)
	self._infos[msg.activityId] = GameUtil.pbToTable(msg)
end

function QiXiLinkGameModel:handlePM_LinkendlessGameStartGameRes(msg)
	local info = self._infos[msg.activityId]

	info.serverKey = msg.serverKey
end

function QiXiLinkGameModel:handlePM_LinkendlessGameEndGameRes(msg)
	local info = self._infos[msg.activityId]

	info.totalScore = msg.totalScore
	info.maxScore = msg.maxScore
	info.dailyTimes = msg.dailyTimes
end

function QiXiLinkGameModel:handlePM_LinkendlessGameSweepRes(msg)
	local info = self._infos[msg.activityId]

	info.totalScore = msg.totalScore
	info.dailyTimes = msg.dailyTimes
end

function QiXiLinkGameModel:handlePM_LinkendlessGameGainProgressPrizeRes(msg)
	local info = self._infos[msg.activityId]

	info.prizeId = msg.prizeId
	info.gainPrizeIds = info.gainPrizeIds or {}

	table.insert(info.gainPrizeIds, msg.prizeId)
end

function QiXiLinkGameModel:getHistoryMaxScore(activityId)
	local info = self._infos[activityId]

	return info.maxScore
end

function QiXiLinkGameModel:getTodayGameTimes(activityId)
	local info = self._infos[activityId]

	return info.dailyTimes
end

function QiXiLinkGameModel:getClientKey(activityId)
	local clientKey = math.random(1, ServerTime.now()) + activityId
	local info = self._infos[activityId]

	info.clientKey = clientKey

	return clientKey
end

function QiXiLinkGameModel:getEncryptedKey(activityId, score)
	local info = self._infos[activityId]

	return (GameUtil.getClientEncryptedKey(info.clientKey, info.serverKey, {
		activityId,
		score
	}))
end

QiXiLinkGameModel.instance = QiXiLinkGameModel.New()

return QiXiLinkGameModel
