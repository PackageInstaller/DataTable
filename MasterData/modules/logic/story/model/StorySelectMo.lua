-- chunkname: @modules/logic/story/model/StorySelectMo.lua

module("modules.logic.story.model.StorySelectMo", package.seeall)

local StorySelectMo = pureTable("StorySelectMo")

function StorySelectMo:ctor()
	self.index = 0
	self.id = 0
	self.name = ""
	self.stepId = 0
	self.optionCo = nil
end

function StorySelectMo:init(index, id, name, stepId, optionCo)
	self.index = index
	self.id = id
	self.name = name
	self.stepId = stepId
	self.optionCo = optionCo
end

function StorySelectMo:setId(id)
	self.index = id
end

function StorySelectMo:setName(name)
	self.name = name
end

function StorySelectMo:setStepId(stepId)
	self.stepId = stepId
end

function StorySelectMo:setOptionCo(co)
	self.optionCo = co
end

return StorySelectMo
