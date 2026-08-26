-- chunkname: @modules/logic/story/model/StoryStepModel.lua

module("modules.logic.story.model.StoryStepModel", package.seeall)

local StoryStepModel = class("StoryStepModel", BaseModel)

function StoryStepModel:onInit()
	self._stepList = {}
end

function StoryStepModel:setStepList(infos)
	self._stepList = {}

	if infos then
		for _, info in pairs(infos) do
			local stepMo = StoryStepMo.New()

			stepMo:init(info)
			table.insert(self._stepList, stepMo)
		end
	end

	self:setList(self._stepList)
end

function StoryStepModel:getStepList()
	return self._stepList
end

function StoryStepModel:getStepListById(stepId)
	for _, v in pairs(self._stepList) do
		if v.id == stepId then
			return v
		end
	end

	return nil
end

function StoryStepModel:getStepFavor(stepId)
	local config = self:getStepListById(stepId).optList
	local favor = 0

	for _, v in pairs(config) do
		if v.feedbackType == 1 then
			favor = favor + v.feedbackValue
		end
	end

	return favor
end

StoryStepModel.instance = StoryStepModel.New()

return StoryStepModel
