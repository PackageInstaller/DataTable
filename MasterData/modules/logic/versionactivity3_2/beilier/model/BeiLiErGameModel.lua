-- chunkname: @modules/logic/versionactivity3_2/beilier/model/BeiLiErGameModel.lua

module("modules.logic.versionactivity3_2.beilier.model.BeiLiErGameModel", package.seeall)

local BeiLiErGameModel = class("BeiLiErGameModel", BaseModel)

function BeiLiErGameModel:onInit()
	self:reInit()
end

function BeiLiErGameModel:reInit()
	self._curGameIdStr = nil
	self._curGameId = nil
	self._curLevelIndex = nil
	self._tipCount = 3
end

function BeiLiErGameModel:getGameConfig()
	return {
		gameId = 11
	}
end

function BeiLiErGameModel:getBeiLiErLevelDataByLevelId(gameId)
	local config = {
		[11] = {
			correctpuzzles = "-34.5#39.5#1|224#170#2|265#-315#3|-281#325#4",
			correctbg = "",
			initpuzzles = "860#-311#3|1023#-102#1|345#111#4|-502#400#2",
			isSpecical = false,
			id = 11,
			bg = "",
			puzzles = "1#2#3#4"
		}
	}

	return config[gameId]
end

function BeiLiErGameModel:initGameData(gameId)
	self:clear()

	self._gameIdList = {}
	self._curGameId = gameId
	self._gameConfig = BeiLiErConfig.instance:getBeiLiErGameConfigById(gameId)

	self:_initLevel()

	local gameId = self._gameIdList[self._curLevelIndex]

	self:_initGameMo(gameId)
	self:_onStart()
end

function BeiLiErGameModel.sortFunc(a, b)
	return a < b
end

function BeiLiErGameModel:_initLevel()
	if self._gameConfig ~= nil then
		for _, co in pairs(self._gameConfig) do
			if co and co.puzzleid then
				table.insert(self._gameIdList, co.puzzleid)
			end
		end
	end

	table.sort(self._gameIdList, BeiLiErGameModel.sortFunc)

	self._level = {}
	self._curLevelIndex = 1

	for index, _ in ipairs(self._gameIdList) do
		self._level[index] = false
	end
end

function BeiLiErGameModel:_initGameMo(gameId)
	self._gameMo = BeiLiErGameMo.New(gameId)

	local gamedata = self._gameConfig[gameId]

	self._gameMo:initGameMo(gamedata)
end

function BeiLiErGameModel:_onStart()
	self._tipCount = BeiLiErEnum.GameId2TipCount[self._curGameId]
end

function BeiLiErGameModel:setMaxTipCount()
	self._tipCount = 99
end

function BeiLiErGameModel:getCurGameId()
	return self._curGameId
end

function BeiLiErGameModel:getGameMo()
	return self._gameMo
end

function BeiLiErGameModel:getCurGameConfig()
	return self._gameConfig
end

function BeiLiErGameModel:getAllPuzzle()
	if self._gameMo == nil then
		return nil
	end

	return self._gameMo:getAllPuzzle()
end

function BeiLiErGameModel:getPuzzleById(id)
	if self._gameMo == nil then
		return nil
	end

	return self._gameMo:getPuzzleById(id)
end

function BeiLiErGameModel:getCurrentLevelIndex()
	return self._curLevelIndex
end

function BeiLiErGameModel:getCurrentLevelComplete()
	return self._level[self._curLevelIndex]
end

function BeiLiErGameModel:getCurrentLevelId()
	return self._gameIdList[self._curLevelIndex]
end

function BeiLiErGameModel:checkHaveNextLevel()
	local index = self._curLevelIndex + 1
	local gameId = self._gameIdList[index]

	if gameId then
		return true
	else
		return false
	end
end

function BeiLiErGameModel:setNextLevelGame()
	self._curLevelIndex = self._curLevelIndex + 1

	local gameId = self._gameIdList[self._curLevelIndex]

	self:_initGameMo(gameId)
	self:_onStart()
end

function BeiLiErGameModel:setCurrentPuzzleId(puzzle)
	self._curPuzzleId = puzzle
end

function BeiLiErGameModel:getCurrentPuzzleId()
	return self._curPuzzleId
end

function BeiLiErGameModel:getCurrentPuzzleMo()
	if not self._curPuzzleId then
		return
	end

	return self:getPuzzleById(self._curPuzzleId)
end

function BeiLiErGameModel:getNextPuzzleMoId()
	if self._tipCount > 0 then
		local puzzleMoList = self:getAllPuzzle()

		for _, mo in pairs(puzzleMoList) do
			if not mo:checkIsCorrect() then
				self._tipCount = self._tipCount - 1

				return mo.id
			end
		end
	end

	return nil
end

function BeiLiErGameModel:getTipCount()
	return self._tipCount
end

function BeiLiErGameModel:destroy()
	self:clear()

	if self._gameMo then
		self._gameMo:destroy()

		self._gameMo = nil
	end
end

function BeiLiErGameModel:checkCurrentPuzzleInPlace()
	if not self._curPuzzleId then
		return
	end

	local puzzleMo = self:getPuzzleById(self._curPuzzleId)

	return puzzleMo:checkCorrectPlace()
end

function BeiLiErGameModel:checkGameFinish()
	local correctCount = 0
	local targetCount = 0
	local puzzleMoList = self._gameMo:getAllPuzzle()

	for index, mo in pairs(puzzleMoList) do
		if mo:checkIsCorrect() then
			correctCount = correctCount + 1
		end

		targetCount = targetCount + 1
	end

	if correctCount == targetCount then
		return true
	end

	return false
end

function BeiLiErGameModel:getCorrectCount()
	local correctCount = 0
	local puzzleMoList = self._gameMo:getAllPuzzle()

	for index, mo in pairs(puzzleMoList) do
		if mo:checkIsCorrect() then
			correctCount = correctCount + 1
		end
	end

	return correctCount
end

function BeiLiErGameModel:checkIsBeforeLastPuzzle()
	local correctCount = 0
	local targetCount = 0
	local puzzleMoList = self._gameMo:getAllPuzzle()

	for index, mo in pairs(puzzleMoList) do
		if mo:checkIsCorrect() then
			correctCount = correctCount + 1
		end

		targetCount = targetCount + 1
	end

	if targetCount - correctCount == 1 then
		return true
	end

	return false
end

function BeiLiErGameModel:getCorrectPuzzleList()
	local list = {}
	local puzzleMoList = self._gameMo:getAllPuzzle()

	for index, mo in pairs(puzzleMoList) do
		if mo:checkIsCorrect() then
			table.insert(list, mo.id)
		end
	end

	return list
end

BeiLiErGameModel.instance = BeiLiErGameModel.New()

return BeiLiErGameModel
