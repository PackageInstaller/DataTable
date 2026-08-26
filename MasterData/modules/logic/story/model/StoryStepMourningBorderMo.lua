-- chunkname: @modules/logic/story/model/StoryStepMourningBorderMo.lua

module("modules.logic.story.model.StoryStepMourningBorderMo", package.seeall)

local StoryStepMourningBorderMo = pureTable("StoryStepMourningBorderMo")

function StoryStepMourningBorderMo:ctor()
	self.borderType = 0
	self.borderTimes = {
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0
	}
end

function StoryStepMourningBorderMo:init(info)
	self.borderType = info[1]
	self.borderTimes = info[2]
end

return StoryStepMourningBorderMo
