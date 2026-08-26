-- chunkname: @modules/logic/story/model/StoryStepOptionMo.lua

module("modules.logic.story.model.StoryStepOptionMo", package.seeall)

local StoryStepOptionMo = pureTable("StoryStepOptionMo")

function StoryStepOptionMo:ctor()
	self.condition = false
	self.conditionType = 0
	self.conditionValue = ""
	self.conditionValue2 = {
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		""
	}
	self.branchTxts = {
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		""
	}
	self.type = 0
	self.feedbackType = 0
	self.feedbackValue = 0
	self.back = false
	self.id = 0
	self.followId = 0
end

function StoryStepOptionMo:init(info)
	self.condition = info[1]
	self.conditionType = info[2]
	self.conditionValue = info[3]
	self.conditionValue2 = info[4]
	self.branchTxts = info[5]
	self.type = info[6]
	self.feedbackType = info[7]
	self.feedbackValue = info[8]
	self.back = info[9]
	self.id = info[10]
	self.followId = info[11]
end

return StoryStepOptionMo
