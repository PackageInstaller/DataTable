-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eternaldragon/model/EternalDragonModel.lua

module("logic.extensions.eternaldragon.model.EternalDragonModel", package.seeall)

local EternalDragonModel = class("EternalDragonModel", BaseModel)

function EternalDragonModel:ctor()
	return
end

function EternalDragonModel:onInit()
	self:onReset()
end

function EternalDragonModel:onReset()
	self._infoResMsg = nil
	self._changSetIdOfWater = nil
	self._changSetIdOfDisple = nil
	self._changSetIdOfCut = nil
	self._clientKey = nil
	self._serverKey = nil
end

function EternalDragonModel:handlePM_EternalDragonInfoRes(msg)
	self._infoResMsg = msg
end

function EternalDragonModel:handlePM_EternalDragonWaterRes(msg)
	self._changSetIdOfWater = msg.changeSetId
end

function EternalDragonModel:handlePM_EternalDragonStartGameRes(msg)
	EternalDragonModel.instance:saveServerKeyOfGame(msg.serverKey)
end

function EternalDragonModel:handlePM_EternalDragonEndGameRes(msg)
	self._changSetIdOfDisple = msg.changeSetId
end

function EternalDragonModel:handlePM_EternalDragonCuttingRes(msg)
	self._changSetIdOfCut = msg.changeSetId
end

function EternalDragonModel:handlePM_EternalDragonGainPrizeRes(msg)
	return
end

function EternalDragonModel:getScore()
	return self._infoResMsg.score
end

function EternalDragonModel:getLeftWaterTimes()
	return self._infoResMsg.waterTimes
end

function EternalDragonModel:getGameTimes()
	return self._infoResMsg.gameTimes
end

function EternalDragonModel:getGainPrizeIds()
	return self._infoResMsg.gainPrizeIds
end

function EternalDragonModel:isHasGainPrizeIds(id)
	return table.indexof(self._infoResMsg.gainPrizeIds, id) ~= false
end

function EternalDragonModel:popChangSetIdOfWater()
	self._changSetIdOfWater = nil

	return self._changSetIdOfWater
end

function EternalDragonModel:popChangSetIdOfDisple()
	self._changSetIdOfDisple = nil

	return self._changSetIdOfDisple
end

function EternalDragonModel:popChangSetIdOfCut()
	self._changSetIdOfCut = nil

	return self._changSetIdOfCut
end

function EternalDragonModel:saveClientKeyOfGame(clientKey)
	self._clientKey = clientKey
end

function EternalDragonModel:getClientKeyOfGame()
	return self._clientKey
end

function EternalDragonModel:saveServerKeyOfGame(serverKey)
	self._serverKey = serverKey
end

function EternalDragonModel:getServerKeyOfGame()
	return self._serverKey
end

EternalDragonModel.instance = EternalDragonModel.New()

return EternalDragonModel
