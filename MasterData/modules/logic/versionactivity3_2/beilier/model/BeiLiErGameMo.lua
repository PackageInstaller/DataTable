-- chunkname: @modules/logic/versionactivity3_2/beilier/model/BeiLiErGameMo.lua

module("modules.logic.versionactivity3_2.beilier.model.BeiLiErGameMo", package.seeall)

local BeiLiErGameMo = class("BeiLiErGameMo")

function BeiLiErGameMo:ctor(id)
	self.id = id
	self._puzzles = {}
	self._puzzleList = {}
	self._puzzleCoList = {}
	self._puzzleCoDict = {}
	self._curOrderIndex = 1
end

function BeiLiErGameMo:initGameMo(mo)
	if mo == nil then
		return
	end

	self._mo = mo
	self.id = mo.id

	self:_initConfig(mo)
	self:_initPuzzle()
end

function BeiLiErGameMo:_initConfig(mo)
	if not mo or not mo.fragment then
		return
	end

	local puzzleIdList = string.split(mo.fragment, "#")

	if mo.initialPosition then
		local initList = string.split(mo.initialPosition, "|")

		if mo.targetPosition then
			local correctList = string.split(mo.targetPosition, "|")

			for index, puzzleId in ipairs(puzzleIdList) do
				local initInfo = initList and initList[index]
				local correctInfo = correctList and correctList[index]

				if not initInfo then
					logError("碎片初始位置为空！请检查拼图碎片为%的配置！", puzzleId)
				end

				if not correctInfo then
					logError("碎片正确位置为空！请检查拼图碎片为%的配置！", puzzleId)
				end

				local mo = {
					id = tonumber(puzzleId),
					initCo = self:getSplitCo(initInfo),
					correctCo = self:getSplitCo(correctInfo)
				}

				table.insert(self._puzzleCoList, mo)

				self._puzzleCoDict[tonumber(puzzleId)] = mo
			end
		end
	end
end

function BeiLiErGameMo:getSplitCo(str)
	local co
	local temp = string.splitToNumber(str, "#")

	if temp then
		local x = temp[1]
		local y = temp[2]
		local rotation = temp[3]

		co = {
			x = x,
			y = y,
			rotation = rotation
		}
	end

	return co
end

function BeiLiErGameMo:_initPuzzle()
	if #self._puzzleCoList > 0 then
		for _, mo in pairs(self._puzzleCoList) do
			local puzzleMo = BeiLiErPuzzleMo.New(mo, BeiLiErEnum.PuzzleType.OutCrystal)

			puzzleMo:init()

			self._puzzles[mo.id] = puzzleMo

			table.insert(self._puzzleList, puzzleMo)
		end
	end
end

function BeiLiErGameMo:getAllPuzzle()
	return self._puzzles
end

function BeiLiErGameMo:getPuzzleById(id)
	if self._puzzles == nil then
		return nil
	end

	return self._puzzles[id]
end

function BeiLiErGameMo:destroy()
	if self._puzzles ~= nil then
		for _, puzzle in pairs(self._puzzles) do
			if puzzle then
				puzzle:destroy()
			end
		end

		self._puzzles = nil
	end
end

function BeiLiErGameMo:getOnPlacePuzzleMo(puzzleId)
	local mo = self._puzzleCoDict[puzzleId]

	if mo then
		local puzzleMo = BeiLiErPuzzleMo.New(mo, BeiLiErEnum.PuzzleType.OnCrystal)

		puzzleMo:init()

		return puzzleMo
	end
end

function BeiLiErGameMo:resetGame()
	if self._puzzleList and #self._puzzleList > 0 then
		for index, mo in ipairs(self._puzzleList) do
			mo:init()
		end
	end
end

return BeiLiErGameMo
