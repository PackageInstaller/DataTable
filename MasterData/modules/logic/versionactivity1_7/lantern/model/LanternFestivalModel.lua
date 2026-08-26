-- chunkname: @modules/logic/versionactivity1_7/lantern/model/LanternFestivalModel.lua

module("modules.logic.versionactivity1_7.lantern.model.LanternFestivalModel", package.seeall)

local LanternFestivalModel = class("LanternFestivalModel", BaseModel)

function LanternFestivalModel:onInit()
	self:reInit()
end

function LanternFestivalModel:reInit()
	self._loginCount = 0
	self._puzzleInfos = {}
end

function LanternFestivalModel:setActivity154Infos(info)
	self._loginCount = info.loginCount
	self._puzzleInfos = {}

	for _, v in ipairs(info.infos) do
		local mo = LanternFestivalPuzzleMo.New()

		mo:init(v)

		self._puzzleInfos[v.puzzleId] = mo
	end
end

function LanternFestivalModel:getLoginCount()
	return self._loginCount
end

function LanternFestivalModel:getPuzzleInfo(puzzleId)
	return self._puzzleInfos[puzzleId]
end

function LanternFestivalModel:updatePuzzleInfo(info)
	if self._puzzleInfos[info.puzzleId] then
		self._puzzleInfos[info.puzzleId]:reset(info)
	else
		local mo = LanternFestivalPuzzleMo.New()

		mo:init(info)

		self._puzzleInfos[info.puzzleId] = mo
	end
end

function LanternFestivalModel:isPuzzleUnlock(puzzleId)
	return self._puzzleInfos[puzzleId].state ~= LanternFestivalEnum.PuzzleState.Lock
end

function LanternFestivalModel:isPuzzleGiftGet(puzzleId)
	return self._puzzleInfos[puzzleId].state == LanternFestivalEnum.PuzzleState.RewardGet
end

function LanternFestivalModel:getPuzzleState(puzzleId)
	return self._puzzleInfos[puzzleId].state
end

function LanternFestivalModel:getPuzzleOptionState(puzzleId, optionId)
	for _, record in pairs(self._puzzleInfos[puzzleId].answerRecords) do
		if record == optionId then
			local answerId = LanternFestivalConfig.instance:getPuzzleCo(puzzleId).answerId

			if answerId == optionId then
				return LanternFestivalEnum.OptionState.Right
			else
				return LanternFestivalEnum.OptionState.Wrong
			end
		end
	end

	return LanternFestivalEnum.OptionState.UnAnswer
end

function LanternFestivalModel:getCurPuzzleId()
	if not self._curPuzzleId or self._curPuzzleId == 0 then
		local day = self._loginCount > 5 and 5 or self._loginCount

		self._curPuzzleId = LanternFestivalConfig.instance:getAct154Co(nil, day).puzzleId

		local maxPuzzle = 0

		for _, v in pairs(self._puzzleInfos) do
			if v.state == LanternFestivalEnum.PuzzleState.Solved or v.state == LanternFestivalEnum.PuzzleState.RewardGet then
				maxPuzzle = maxPuzzle > v.puzzleId and maxPuzzle or v.puzzleId
			end
		end

		if maxPuzzle > 0 then
			self._curPuzzleId = maxPuzzle
		end
	end

	return self._curPuzzleId
end

function LanternFestivalModel:setCurPuzzleId(id)
	self._curPuzzleId = id
end

function LanternFestivalModel:hasPuzzleCouldGetReward()
	for _, v in pairs(self._puzzleInfos) do
		if v.state ~= LanternFestivalEnum.PuzzleState.Lock and v.state ~= LanternFestivalEnum.PuzzleState.RewardGet then
			return true
		end
	end

	return false
end

function LanternFestivalModel:isAllPuzzleFinished()
	local act154Cos = LanternFestivalConfig.instance:getAct154Cos()

	for _, v in pairs(act154Cos) do
		if not self:isPuzzleGiftGet(v.puzzleId) then
			return false
		end
	end

	return true
end

function LanternFestivalModel:isAllPuzzleUnSolved()
	for _, v in pairs(self._puzzleInfos) do
		if v.state == LanternFestivalEnum.PuzzleState.Solved or v.state == LanternFestivalEnum.PuzzleState.RewardGet then
			return false
		end
	end

	return true
end

LanternFestivalModel.instance = LanternFestivalModel.New()

return LanternFestivalModel
