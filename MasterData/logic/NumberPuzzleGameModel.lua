-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/numberpuzzlegame/model/NumberPuzzleGameModel.lua

module("logic.extensions.numberpuzzlegame.model.NumberPuzzleGameModel", package.seeall)

local NumberPuzzleGameModel = class("NumberPuzzleGameModel", BaseModel)

function NumberPuzzleGameModel:ctor()
	return
end

function NumberPuzzleGameModel:onInit()
	self:onReset()
end

function NumberPuzzleGameModel:onReset()
	self._gameMgrs = self._gameMgrs or {}

	self:destroyAllNumberPuzzleGameCtrl()

	self._passedStageIdOfNor = 0
	self._maxScore = 0
	self._extremeMaxGridId = 0
	self._extremeHangingEfficiency = 0
	self._extremeHangingScore = 0
	self._extremeHangingBalanceTime = 0
	self._extremePrizeIds = {}
	self._extremeUsedEnergy = 0
	self._clientKey = 0
	self._serverKey = 0
	self._rankInfos = nil
	self._myRank = 0
	self._myScore = 0
	self._extremeRankResMsg = nil
end

function NumberPuzzleGameModel:handlePM_2048InfoRes(msg)
	self._passedStageIdOfNor = msg.passedStageId
	self._maxScore = msg.maxScore
	self._extremeMaxGridId = msg.extremeMaxGridId
	self._extremeHangingEfficiency = msg.extremeHangingEfficiency
	self._extremeHangingScore = checknumber(msg.extremeHangingScore)
	self._extremeHangingBalanceTime = checknumber(msg.extremeHangingBalanceTime)
	self._extremePrizeIds = msg.extremePrizeIds
	self._extremeUsedEnergy = msg.extremeUsedEnergy
end

function NumberPuzzleGameModel:handlePM_2048StartGameRes(msg)
	self._serverKey = msg.serverKey
end

function NumberPuzzleGameModel:handlePM_2048EndGameRes(msg)
	self._clientKey = 0
	self._serverKey = 0
	self._extremeUsedEnergy = msg.extremeUsedEnergy
end

function NumberPuzzleGameModel:handlePM_2048EndRankRes(msg)
	self._rankInfos = msg.rankInfos
	self._myRank = msg.myRank
	self._myScore = msg.myScore
end

function NumberPuzzleGameModel:handlePM_2048OpenHangingEfficiencyRes(msg)
	self._extremeHangingEfficiency = msg.extremeHangingEfficiency
	self._extremeHangingScore = checknumber(msg.extremeHangingScore)
	self._extremeHangingBalanceTime = checknumber(msg.extremeHangingBalanceTime)
end

function NumberPuzzleGameModel:handlePM_2048ExtremeGainPrizeRes(msg)
	self._extremePrizeIds = msg.extremePrizeIds
end

function NumberPuzzleGameModel:handlePM_2048ExtremeRankRes(msg)
	self._extremeRankResMsg = msg
end

function NumberPuzzleGameModel:getNumberPuzzleGameCtrl(mapId)
	if self._gameMgrs[mapId] == nil then
		self._gameMgrs[mapId] = NumberPuzzleGameCtrl.New(mapId)
	end

	return self._gameMgrs[mapId]
end

function NumberPuzzleGameModel:destroyAllNumberPuzzleGameCtrl()
	if self._gameMgrs then
		for k, v in pairs(self._gameMgrs) do
			v:onDestroy()

			self._gameMgrs[k] = nil
		end
	end
end

function NumberPuzzleGameModel:getPassedStageIdOfNor()
	return self._passedStageIdOfNor or 0
end

function NumberPuzzleGameModel:getExtremeMaxGridId()
	return self._extremeMaxGridId
end

function NumberPuzzleGameModel:getExtremeHangingEfficiency()
	return self._extremeHangingEfficiency
end

function NumberPuzzleGameModel:getExtremeHangingScore()
	return self._extremeHangingScore
end

function NumberPuzzleGameModel:getExtremeHangingBalanceTime()
	return self._extremeHangingBalanceTime
end

function NumberPuzzleGameModel:getExtremeUsedEnergy()
	return self._extremeUsedEnergy
end

function NumberPuzzleGameModel:isHasGainPrizeExtreme(prizeId)
	return table.indexof(self._extremePrizeIds, prizeId) ~= false
end

function NumberPuzzleGameModel:setClientKey(clientKey)
	self._clientKey = clientKey
end

function NumberPuzzleGameModel:getClientKey()
	return self._clientKey
end

function NumberPuzzleGameModel:setServerKey(serverKey)
	self._serverKey = serverKey
end

function NumberPuzzleGameModel:getServerKey()
	return self._serverKey
end

function NumberPuzzleGameModel:getRankInfos()
	return self._rankInfos
end

function NumberPuzzleGameModel:getMyRank()
	return self._myRank
end

function NumberPuzzleGameModel:getMyScore()
	return self._myScore
end

function NumberPuzzleGameModel:getExtremeRankResMsg()
	return self._extremeRankResMsg
end

NumberPuzzleGameModel.instance = NumberPuzzleGameModel.New()

return NumberPuzzleGameModel
