-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/numberpuzzlegame/view/data/NumberPuzzleGameDetailMo.lua

module("logic.extensions.numberpuzzlegame.view.data.NumberPuzzleGameDetailMo", package.seeall)

local NumberPuzzleGameDetailMo = class("NumberPuzzleGameDetailMo")

function NumberPuzzleGameDetailMo:ctor(mapId)
	self._mapId = mapId
	self._totalScore = 0
	self._maxTotalScore = 0
	self._maxTotalScoreLimit = -1
	self._maxGbId = 0
	self._curStep = 0
	self._gridMergeCountMap = {}
	self._startUpEnergy = 0
	self._leftEnergy = 0
end

function NumberPuzzleGameDetailMo:onReset()
	self._totalScore = 0
	self._curStep = 0

	table.clear(self._gridMergeCountMap)

	self._leftEnergy = self._startUpEnergy
end

function NumberPuzzleGameDetailMo:onDestroy()
	return
end

function NumberPuzzleGameDetailMo:getMaxTotalScoreLimit()
	return self._maxTotalScoreLimit
end

function NumberPuzzleGameDetailMo:setMaxTotalScoreLimit(value)
	self._maxTotalScoreLimit = value
end

function NumberPuzzleGameDetailMo:getTotalScore()
	return self._totalScore
end

function NumberPuzzleGameDetailMo:setTotalScore(score)
	self._totalScore = self._maxTotalScoreLimit >= 0 and Mathf.Min(score, self._maxTotalScoreLimit) or score

	self:updateMaxTotalScore(self._totalScore)
end

function NumberPuzzleGameDetailMo:addTotalScore(delta)
	self:setTotalScore(self:getTotalScore() + delta)
end

function NumberPuzzleGameDetailMo:getGameMode()
	return self._gameMode
end

function NumberPuzzleGameDetailMo:setGameMode(value)
	self._gameMode = value
end

function NumberPuzzleGameDetailMo:getCurStep()
	return self._curStep
end

function NumberPuzzleGameDetailMo:setCurStep(step)
	self._curStep = step
end

function NumberPuzzleGameDetailMo:addCurStep(delta)
	self:setCurStep(self:getCurStep() + delta)
end

function NumberPuzzleGameDetailMo:getGridMergeCount(gridId)
	return self._gridMergeCountMap[gridId] or 0
end

function NumberPuzzleGameDetailMo:setGridMergeCount(gridId, count)
	self._gridMergeCountMap[gridId] = count
end

function NumberPuzzleGameDetailMo:addGridMergeCount(gridId, delta)
	self:setGridMergeCount(gridId, self:getGridMergeCount(gridId) + delta)
end

function NumberPuzzleGameDetailMo:getMaxTotalScore()
	return self._maxTotalScore
end

function NumberPuzzleGameDetailMo:updateMaxTotalScore(score)
	self._maxTotalScore = Mathf.Max(self._maxTotalScore, score)

	if self._maxTotalScoreLimit >= 0 then
		self._maxTotalScore = Mathf.Min(self._maxTotalScore, self._maxTotalScoreLimit)
	end
end

function NumberPuzzleGameDetailMo:getStartUpEnergy()
	return self._startUpEnergy
end

function NumberPuzzleGameDetailMo:setStartUpEnergy(value)
	self._startUpEnergy = value
end

function NumberPuzzleGameDetailMo:getLeftEnergy()
	return self._leftEnergy
end

function NumberPuzzleGameDetailMo:setLeftEnergy(value)
	self._leftEnergy = value
end

function NumberPuzzleGameDetailMo:updateLeftEnergy(delta)
	self._leftEnergy = Mathf.Max(self._leftEnergy + delta, 0)
end

function NumberPuzzleGameDetailMo:getMaxGbId()
	return self._maxGbId
end

function NumberPuzzleGameDetailMo:setMaxGbId(value)
	self._maxGbId = value
end

function NumberPuzzleGameDetailMo:mergeGrid(gridId)
	local gbId = NumberPuzzleGameConfig.instance:getGbId(self._mapId, gridId)

	self._maxGbId = Mathf.Max(self._maxGbId, gbId)

	local data = NumberPuzzleGameConfig.instance:getNpgGridLibData(self._mapId, gridId)

	self:addTotalScore(data.score)
	self:addGridMergeCount(gridId, 1)
end

return NumberPuzzleGameDetailMo
