-- chunkname: @modules/logic/versionactivity3_5/lorentz/model/LorentzGameMo.lua

module("modules.logic.versionactivity3_5.lorentz.model.LorentzGameMo", package.seeall)

local LorentzGameMo = class("LorentzGameMo")

function LorentzGameMo:ctor(id)
	self.id = id
	self._puzzles = {}
	self._puzzleList = {}
	self._puzzleCoList = {}
	self._puzzleCoDict = {}
	self._curOrderIndex = 1
end

function LorentzGameMo:initGameMo(mo)
	if mo == nil then
		return
	end

	self._mo = mo
	self.id = mo.id

	self:_initConfig(mo)
	self:_initPuzzle()
end

function LorentzGameMo:_initConfig(mo)
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
					logError(string.format("碎片初始位置为空！请检查拼图碎片为%s的配置！", puzzleId))
				end

				if not correctInfo then
					logError(string.format("碎片正确位置为空！请检查拼图碎片为%s的配置！", puzzleId))
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

function LorentzGameMo:getSplitCo(str)
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

function LorentzGameMo:_initPuzzle()
	if #self._puzzleCoList > 0 then
		for _, mo in pairs(self._puzzleCoList) do
			local puzzleMo = LorentzPuzzleMo.New(mo, LorentzEnum.PuzzleType.OutCrystal)

			puzzleMo:init()

			self._puzzles[mo.id] = puzzleMo

			table.insert(self._puzzleList, puzzleMo)
		end
	end
end

function LorentzGameMo:getAllPuzzle()
	return self._puzzles
end

function LorentzGameMo:getPuzzleById(id)
	if self._puzzles == nil then
		return nil
	end

	return self._puzzles[id]
end

function LorentzGameMo:destroy()
	if self._puzzles ~= nil then
		for _, puzzle in pairs(self._puzzles) do
			if puzzle then
				puzzle:destroy()
			end
		end

		self._puzzles = nil
	end
end

function LorentzGameMo:getOnPlacePuzzleMo(puzzleId)
	local mo = self._puzzleCoDict[puzzleId]

	if mo then
		local puzzleMo = LorentzPuzzleMo.New(mo, LorentzEnum.PuzzleType.OnCrystal)

		puzzleMo:init()

		return puzzleMo
	end
end

function LorentzGameMo:resetGame()
	if self._puzzleList and #self._puzzleList > 0 then
		for index, mo in ipairs(self._puzzleList) do
			mo:init()
		end
	end
end

return LorentzGameMo
