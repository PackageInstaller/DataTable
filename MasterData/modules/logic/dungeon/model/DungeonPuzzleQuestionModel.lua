-- chunkname: @modules/logic/dungeon/model/DungeonPuzzleQuestionModel.lua

module("modules.logic.dungeon.model.DungeonPuzzleQuestionModel", package.seeall)

local DungeonPuzzleQuestionModel = class("DungeonPuzzleQuestionModel", BaseModel)

function DungeonPuzzleQuestionModel:reInit()
	self:release()
end

function DungeonPuzzleQuestionModel:initByElementCo(elementCo)
	self._cfgElement = elementCo

	if self._cfgElement and self._cfgElement.param then
		self._cfgQuestion = DungeonConfig.instance:getPuzzleQuestionCo(tonumber(self._cfgElement.param))

		if self._cfgQuestion then
			local splitKey = "#"

			self._answer = string.split(self._cfgQuestion.answer, splitKey)
			self._desc = string.split(self._cfgQuestion.desc, splitKey)
			self._descEn = string.split(self._cfgQuestion.descEn, splitKey)
			self._title = string.split(self._cfgQuestion.title, splitKey)
			self._titleEn = string.split(self._cfgQuestion.titleEn, splitKey)
			self._question = string.split(self._cfgQuestion.question, splitKey)
			self._questionCount = #self._question

			if self:CheckConfigAvailable() then
				self._isReady = true

				self:initAnswer()
			else
				logError("DungeonPuzzleQuestion confg error, id = " .. tostring(self._cfgQuestion.id))
			end
		else
			logError("DungeonPuzzleQuestion confg not found, element id = " .. tostring(self._cfgElement.id))
		end
	end
end

function DungeonPuzzleQuestionModel:initAnswer()
	local secSplitKey = "|"
	local result = {}

	for i, originStr in ipairs(self._answer) do
		local answerList = string.split(originStr, secSplitKey)
		local resultSet = {}

		for j, answerStr in ipairs(answerList) do
			resultSet[answerStr] = true
		end

		result[i] = resultSet
	end

	self._answer = result
end

function DungeonPuzzleQuestionModel:CheckConfigAvailable()
	return #self._desc == DungeonPuzzleEnum.hintCount and #self._descEn == DungeonPuzzleEnum.hintCount and #self._title == DungeonPuzzleEnum.hintCount and #self._titleEn == DungeonPuzzleEnum.hintCount and #self._question == #self._answer
end

function DungeonPuzzleQuestionModel:getHint(index)
	return self._title[index], self._titleEn[index], self._desc[index], self._descEn[index]
end

function DungeonPuzzleQuestionModel:getQuestion(index)
	return self._question[index]
end

function DungeonPuzzleQuestionModel:getQuestionTitle()
	return self._cfgQuestion.questionTitle, self._cfgQuestion.questionTitleEn
end

function DungeonPuzzleQuestionModel:getQuestionCount()
	return self._questionCount
end

function DungeonPuzzleQuestionModel:getIsReady()
	return self._isReady
end

function DungeonPuzzleQuestionModel:release()
	self._cfgElement = nil
	self._cfgQuestion = nil
	self._answer = nil
	self._desc = nil
	self._descEn = nil
	self._question = nil
	self._questionEn = nil
	self._isReady = false
end

function DungeonPuzzleQuestionModel:getAnswers(index)
	return self._answer[index]
end

function DungeonPuzzleQuestionModel:getElementCo()
	return self._cfgElement
end

DungeonPuzzleQuestionModel.instance = DungeonPuzzleQuestionModel.New()

return DungeonPuzzleQuestionModel
