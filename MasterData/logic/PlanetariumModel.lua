-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/planetarium/model/PlanetariumModel.lua

module("logic.extensions.planetarium.model.PlanetariumModel", package.seeall)

local PlanetariumModel = class("PlanetariumModel", BaseModel)

function PlanetariumModel:ctor()
	return
end

function PlanetariumModel:onInit()
	self:onReset()
end

function PlanetariumModel:onReset()
	self.stageId = 1
	self.serverKey = 0
	self.finishNum = 0
	self.dailyFinished = false
	self.gainPrizeIds = {}
end

function PlanetariumModel:setGameInfo(msg)
	self.stageId = msg.stageId
	self.dailyFinished = msg.dailyFinished
	self.finishNum = msg.finishNum

	GameUtil.pbToTable(msg.gainPrizeIds, self.gainPrizeIds)
end

function PlanetariumModel:getStageId()
	return self.stageId or 1
end

function PlanetariumModel:getDailyFinish()
	return checkbool(self.dailyFinished)
end

function PlanetariumModel:getFinishNum()
	return self.finishNum or 0
end

function PlanetariumModel:getGainPrize()
	return self.gainPrizeIds
end

function PlanetariumModel:isGainPrize(prizeId)
	return TableUtil.isHad(self.gainPrizeIds, prizeId)
end

function PlanetariumModel:setServerKey(msg)
	self.serverKey = msg.serverKey
end

function PlanetariumModel:getServerKey()
	return self.serverKey
end

PlanetariumModel.instance = PlanetariumModel.New()

return PlanetariumModel
