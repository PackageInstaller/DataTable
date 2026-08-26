-- chunkname: @modules/logic/story/model/StoryStepMainHeroMo.lua

module("modules.logic.story.model.StoryStepMainHeroMo", package.seeall)

local StoryStepMainHeroMo = pureTable("StoryStepMainHeroMo")

function StoryStepMainHeroMo:ctor()
	self.mouses = {
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		""
	}
	self.anims = {
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		""
	}
	self.expressions = {
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		""
	}
end

function StoryStepMainHeroMo:init(info)
	self.mouses = info[1]
	self.anims = info[2]
	self.expressions = info[3]
end

return StoryStepMainHeroMo
