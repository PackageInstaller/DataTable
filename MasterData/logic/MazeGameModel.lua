-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mazegame/model/MazeGameModel.lua

module("logic.extensions.mazegame.model.MazeGameModel", package.seeall)

local MazeGameModel = class("MazeGameModel", BaseModel)

function MazeGameModel:onInit()
	self:onReset()
end

function MazeGameModel:onReset()
	self._infos = {}
	self._clientKey = {}
	self._serverKey = {}
end

function MazeGameModel:getInfo(activityId)
	return self._infos[activityId]
end

function MazeGameModel:handlePM_MazeGameInfoRes(msg)
	self._infos[msg.activityId] = GameUtil.pbToTable(msg)

	local info = self._infos[msg.activityId]

	info.todayPassStageTimes = msg.todayPassStageTimes
	info.passStageIds = msg.passStageIds or {}
end

function MazeGameModel:handlePM_MazeGameStartGameRes(msg)
	self._serverKey[msg.activityId] = msg.serverKey
end

function MazeGameModel:handlePM_MazeGameEndGameRes(msg)
	local info = self._infos[msg.activityId]

	info.todayPassStageTimes = msg.todayPassStageTimes
	info.passStageIds = msg.passStageIds
end

function MazeGameModel:getClientKey(activityId)
	local clientKey = math.random(1, ServerTime.now()) + activityId

	self._clientKey[activityId] = clientKey

	return clientKey
end

function MazeGameModel:getEncryptedKey(activityId, passOrNotNum)
	local clientKey = self._clientKey[activityId]
	local serverKey = self._serverKey[activityId]

	return (GameUtil.getClientEncryptedKey(clientKey, serverKey, {
		activityId,
		passOrNotNum
	}))
end

MazeGameModel.instance = MazeGameModel.New()

return MazeGameModel
