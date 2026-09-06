-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/duolalight/model/DuoLaLightModel.lua

module("logic.extensions.duolalight.model.DuoLaLightModel", package.seeall)

local DuoLaLightModel = class("DuoLaLightModel", BaseModel)

function DuoLaLightModel:ctor()
	return
end

function DuoLaLightModel:onInit()
	self:onReset()
end

function DuoLaLightModel:onReset()
	self._finishedDifficulties = {}
	self._diffInfos = {}
	self._clientKey = 0
	self._serverKey = 0
	self._sweepableDifficulty = {}
end

function DuoLaLightModel:handlePM_DuoLaGameInfoRes(msg)
	for _, v in ipairs(msg.difficulty) do
		self._diffInfos[v.difficultyId] = v
		self._finishedDifficulties[v.difficultyId] = checkbool(v.isFinished)
	end

	table.clear(self._sweepableDifficulty)
	table.insertto(self._sweepableDifficulty, msg.sweepableDifficulty)
end

function DuoLaLightModel:handlePM_DuoLaGameStartGameRes(msg)
	self._serverKey = msg.serverKey
end

function DuoLaLightModel:handlePM_DuoLaGameEndGameRes(msg)
	return
end

function DuoLaLightModel:handlePM_DuoLaGameSweepRes(msg)
	local difficultyId = msg.difficultyId

	table.insert(self._sweepableDifficulty, difficultyId)

	self._finishedDifficulties[difficultyId] = true
end

function DuoLaLightModel:getDiffInfo(difficultyId)
	return self._diffInfos[difficultyId]
end

function DuoLaLightModel:getGameIdOfDiff(difficultyId)
	local info = self:getDiffInfo(difficultyId)

	return checknumber(info and info.gameId)
end

function DuoLaLightModel:isFinishedOfDiff(difficultyId)
	return checkbool(self._finishedDifficulties[difficultyId])
end

function DuoLaLightModel:isSweepable(difficultyId)
	return table.indexof(self._sweepableDifficulty, difficultyId) ~= false
end

function DuoLaLightModel:setClientKey(clientKey)
	self._clientKey = clientKey
end

function DuoLaLightModel:getClientKey()
	return self._clientKey
end

function DuoLaLightModel:setServerKey(serverKey)
	self._serverKey = serverKey
end

function DuoLaLightModel:getServerKey()
	return self._serverKey
end

DuoLaLightModel.instance = DuoLaLightModel.New()

return DuoLaLightModel
