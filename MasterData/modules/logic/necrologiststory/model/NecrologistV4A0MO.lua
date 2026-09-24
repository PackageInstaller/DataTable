-- chunkname: @modules/logic/necrologiststory/model/NecrologistV4A0MO.lua

module("modules.logic.necrologiststory.model.NecrologistV4A0MO", package.seeall)

local NecrologistV4A0MO = class("NecrologistV4A0MO", NecrologistStoryGameBaseMO)

function NecrologistV4A0MO:onInit()
	return
end

function NecrologistV4A0MO:onUpdateData()
	local data = self:getData()

	self.questionDict = {}

	if data.questionList then
		for _, questionData in ipairs(data.questionList) do
			self.questionDict[questionData.id] = questionData.option
		end
	end

	self.lastShowResult = data.lastShowResult
end

function NecrologistV4A0MO:onSaveData()
	local data = self:getData()

	data.questionList = {}

	for questionId, option in pairs(self.questionDict) do
		table.insert(data.questionList, {
			id = questionId,
			option = option
		})
	end

	data.lastShowResult = self.lastShowResult
end

function NecrologistV4A0MO:setLastShowResult(result)
	if self.lastShowResult == result then
		return
	end

	self.lastShowResult = result

	self:setDataDirty()
end

function NecrologistV4A0MO:hasResult()
	return self.lastShowResult and self.lastShowResult ~= 0
end

function NecrologistV4A0MO:isSameResult(resultConfig)
	return self.lastShowResult == resultConfig.id
end

function NecrologistV4A0MO:onStoryStateChange(storyId, state)
	if state == NecrologistStoryEnum.StoryState.Finish then
		HeroStoryRpc.instance:sendHeroStoryCommonTaskRequest(NecrologistStoryEnum.TaskParam.V4A0EpisodeFinishCount, 1)
	end
end

function NecrologistV4A0MO:setQuestionOption(questionId, option)
	if not self.questionDict[questionId] and not self:hasResult() then
		HeroStoryRpc.instance:sendHeroStoryCommonTaskRequest(NecrologistStoryEnum.TaskParam.V4A0EpisodeFinishCount, 1)
	end

	if self:isLevelListComplete() then
		self.questionDict = {}
	end

	self.questionDict[questionId] = option

	self:setDataDirty()
end

function NecrologistV4A0MO:getQuestionOption(questionId)
	return self.questionDict[questionId]
end

function NecrologistV4A0MO:isBaseFinished(baseId)
	local config = NecrologistStoryV4A0Config.instance:getBaseConfig(baseId)

	if not config then
		return true
	end

	if config.storyId ~= 0 then
		return self:isStoryFinish(config.storyId)
	end

	if config.questionId ~= 0 then
		return self:getQuestionOption(config.questionId) ~= nil
	end

	return true
end

function NecrologistV4A0MO:isLevelListComplete()
	local baseList = NecrologistStoryV4A0Config.instance:getBaseList()

	for _, baseConfig in ipairs(baseList) do
		if not self:isBaseFinished(baseConfig.id) then
			return false
		end
	end

	return true
end

function NecrologistV4A0MO:isComplete()
	if self:hasResult() then
		return true
	end

	local baseList = NecrologistStoryV4A0Config.instance:getBaseList()

	for _, baseConfig in ipairs(baseList) do
		if not self:isBaseFinished(baseConfig.id) then
			return false
		end
	end

	return true
end

function NecrologistV4A0MO:getResultConfig()
	local dict = {}

	for k, v in pairs(self.questionDict) do
		local config = NecrologistStoryV4A0Config.instance:getOptionConfig(v)

		if config then
			dict[config.type] = dict[config.type] or 0
			dict[config.type] = dict[config.type] + 1
		end
	end

	local list = NecrologistStoryV4A0Config.instance:getResultList()

	for _, resultConfig in ipairs(list) do
		if self:checkScore(resultConfig.score1, dict) then
			return resultConfig
		end
	end
end

function NecrologistV4A0MO:checkScore(score, dict)
	if string.nilorempty(score) then
		return true
	end

	local param = string.splitToNumber(score, "#")
	local curType = param[1]

	if not dict[curType] then
		if dict[curType] > param[2] then
			return true
		end

		if dict[curType] == param[2] then
			for k, v in pairs(dict) do
				if k ~= curType and v > 1 then
					return false
				end
			end

			return true
		end

		return false
	end
end

return NecrologistV4A0MO
