-- chunkname: @modules/logic/story/model/StoryStepNavigateMo.lua

module("modules.logic.story.model.StoryStepNavigateMo", package.seeall)

local StoryStepNavigateMo = pureTable("StoryStepNavigateMo")

function StoryStepNavigateMo:ctor()
	self.navigateType = 1
	self.navigateTxts = {
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		""
	}
	self.navigateChapterEn = ""
	self.navigateLogo = ""
end

function StoryStepNavigateMo:init(info)
	self.navigateType = info[1]
	self.navigateTxts = info[2]
	self.navigateChapterEn = info[3]
	self.navigateLogo = info[4]
end

return StoryStepNavigateMo
