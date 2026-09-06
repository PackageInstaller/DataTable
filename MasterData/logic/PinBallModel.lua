-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pinball/model/PinBallModel.lua

module("logic.extensions.pinball.model.PinBallModel", package.seeall)

local PinBallModel = class("PinBallModel", BaseModel)

function PinBallModel:onInit()
	self:onReset()
end

function PinBallModel:onReset()
	self._infos = {}
	self._clientKey = {}
	self._serverKey = {}
end

function PinBallModel:getInfo(activityId)
	return self._infos[activityId]
end

function PinBallModel:handlePM_PinBallGetInfoRes(msg)
	self._infos[msg.activityId] = GameUtil.pbToTable(msg)
end

function PinBallModel:handlePM_PinBallStartGameRes(msg)
	self._serverKey[msg.activityId] = msg.serverKey
end

function PinBallModel:handlePM_PinBallEndGameRes(msg)
	local info = self._infos[msg.activityId]

	info.totalScore = msg.totalScore
end

function PinBallModel:handlePM_PinBallGainPrizeRes(msg)
	local info = self._infos[msg.activityId]

	info.gainPrizeIds = info.gainPrizeIds or {}

	table.insertto(info.gainPrizeIds, msg.prizeIds)
end

function PinBallModel:getClientKey(activityId)
	local clientKey = math.random(1, ServerTime.now()) + activityId

	self._clientKey[activityId] = clientKey

	return clientKey
end

function PinBallModel:getEncryptedKey(activityId, stageId, score, gainPrizeList)
	local clientKey = self._clientKey[activityId]
	local serverKey = self._serverKey[activityId]
	local serverResList = {}

	for _, num in pairs(gainPrizeList) do
		table.insert(serverResList, num)
	end

	table.insert(serverResList, stageId)
	table.insert(serverResList, score)

	return (GameUtil.getClientEncryptedKey(clientKey, serverKey, serverResList))
end

function PinBallModel:onSweepRes(msg)
	local info = self._infos[msg.activityId]

	info.totalScore = msg.totalScore
	info.todayGameTimes = msg.todayGameTimes
end

PinBallModel.instance = PinBallModel.New()

return PinBallModel
