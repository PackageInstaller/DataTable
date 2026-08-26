-- chunkname: @modules/logic/story/model/StoryProcessInfoMo.lua

module("modules.logic.story.model.StoryProcessInfoMo", package.seeall)

local StoryProcessInfoMo = pureTable("StoryProcessInfoMo")

function StoryProcessInfoMo:ctor()
	self.storyId = nil
	self.stepId = nil
	self.favor = nil
end

function StoryProcessInfoMo:init(co)
	self.storyId = co.storyId
	self.stepId = co.stepId
	self.favor = co.favor
end

return StoryProcessInfoMo
