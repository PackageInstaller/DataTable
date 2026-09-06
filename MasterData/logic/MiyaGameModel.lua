-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/model/MiyaGameModel.lua

module("logic.extensions.timelimitedchallenge.model.MiyaGameModel", package.seeall)

local MiyaGameModel = class("MiyaGameModel", TLCBaseGameModel)

function MiyaGameModel:ctor()
	return
end

function MiyaGameModel:onInit()
	return
end

function MiyaGameModel:onReset()
	self._dailyPrizeReceived = false
	self._curDifficulty = 0
	self._curModeId = 0
	self._rivalId = 0
	self._buyProcess = 0
	self._worldZdl = 0
end

function MiyaGameModel:getChallengeId()
	return 4
end

function MiyaGameModel:getCurDifficulty()
	return self._curDifficulty
end

function MiyaGameModel:setCurDifficulty(value)
	self._curDifficulty = checknumber(value)
end

function MiyaGameModel:getDailyPrizeReceived()
	return self._dailyPrizeReceived == true
end

function MiyaGameModel:setDailyPrizeReceived(value)
	self._dailyPrizeReceived = value
end

function MiyaGameModel:getCurModeId()
	return self._curModeId
end

function MiyaGameModel:setCurModeId(value)
	self._curModeId = checknumber(value)
end

function MiyaGameModel:setRivalId(value)
	self._rivalId = value
end

function MiyaGameModel:getRivalId()
	return self._rivalId
end

function MiyaGameModel:getBuyProcess()
	return self._buyProcess
end

function MiyaGameModel:setBuyProcess(value)
	self._buyProcess = math.max(0, checknumber(value))
end

function MiyaGameModel:setWorldZdl(value)
	self._worldZdl = checknumber(value)
end

function MiyaGameModel:getWorldZdl()
	return self._worldZdl
end

MiyaGameModel.instance = MiyaGameModel.New()

return MiyaGameModel
