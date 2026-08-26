-- chunkname: @modules/logic/chessgame/model/ChessGameModel.lua

module("modules.logic.chessgame.model.ChessGameModel", package.seeall)

local ChessGameModel = class("ChessGameModel", BaseModel)

function ChessGameModel:ctor()
	self.nowMapResPath = nil
	self.nowMapIndex = 1
end

function ChessGameModel:clear()
	self.nowMapResPath = nil
	self.nowMapIndex = 1
	self._completedCount = 1
	self._optList = {}
	self._catchObj = nil
	self._finishInteract = nil
	self._operations = {}
	self._result = nil
	self._isPlayingStory = nil
	self._catchList = nil
	self._isTalking = nil
end

function ChessGameModel:initData(actId, episodeId, mapIndex)
	local mapGroupId = ChessConfig.instance:getEpisodeCo(actId, episodeId).mapIds

	self._optList = {}
	self.currentmapCo = ChessGameConfig.instance:getMapCo(mapGroupId)

	local resPath = self.currentmapCo[mapIndex].path

	self:setNowMapResPath(resPath)
end

function ChessGameModel:setNowMapResPath(resPath)
	self.nowMapResPath = resPath
end

function ChessGameModel:getNowMapResPath()
	return self.nowMapResPath
end

function ChessGameModel:setNowMapIndex(mapIndex)
	self.nowMapIndex = mapIndex
end

function ChessGameModel:getNowMapIndex()
	return self.nowMapIndex
end

function ChessGameModel:addOperations(operation)
	table.insert(self._operations, operation)
end

function ChessGameModel:getOperations()
	return self._operations
end

function ChessGameModel:cleanOperations()
	for k, v in pairs(self._operations) do
		self._operations[k] = nil
	end
end

function ChessGameModel:setResult(result)
	self._result = result
end

function ChessGameModel:onInit()
	self._mapTileMOList = {}
end

function ChessGameModel:appendOpt(optdata)
	table.insert(self._optList, optdata)
end

function ChessGameModel:getOptList()
	return self._optList
end

function ChessGameModel:cleanOptList()
	for k, v in pairs(self._optList) do
		self._optList[k] = nil
	end
end

function ChessGameModel:setCompletedCount(count)
	self._completedCount = count
end

function ChessGameModel:getCompletedCount()
	return self._completedCount
end

function ChessGameModel:addRollBackNum()
	self._rollbackNum = self._rollbackNum or 0
	self._rollbackNum = self._rollbackNum + 1
end

function ChessGameModel:clearRollbackNum()
	self._rollbackNum = 0
end

function ChessGameModel:getRollBackNum()
	return self._rollbackNum
end

function ChessGameModel:getRound()
	return self._round or 0
end

function ChessGameModel:addRound()
	if self._round then
		self._round = self._round + 1 or 1
	end
end

function ChessGameModel:clearRound()
	self._round = 0
end

function ChessGameModel:setGameState(state)
	self._gameState = state
end

function ChessGameModel:getGameState()
	return self._gameState
end

function ChessGameModel:setPlayingStory(state)
	self._isPlayingStory = state
end

function ChessGameModel:getPlayingStory()
	return self._isPlayingStory
end

function ChessGameModel:setCatchObj(obj)
	self._catchObj = obj
end

function ChessGameModel:getCatchObj()
	return self._catchObj
end

function ChessGameModel:insertCatchObjCanWalkList(pos)
	self._catchList = self._catchList or {}

	table.insert(self._catchList, pos)
end

function ChessGameModel:checkPosCatchObjCanWalk(pos)
	if not self._catchList then
		return false
	end

	for index, pos1 in ipairs(self._catchList) do
		if pos.x == pos1.x and pos.y == pos1.y then
			return true
		end
	end

	return false
end

function ChessGameModel:cleanCatchObjCanWalkList()
	self._catchList = nil
end

function ChessGameModel:setTalk(isTalking)
	self._isTalking = isTalking
end

function ChessGameModel:isTalking()
	return self._isTalking
end

ChessGameModel.instance = ChessGameModel.New()

return ChessGameModel
