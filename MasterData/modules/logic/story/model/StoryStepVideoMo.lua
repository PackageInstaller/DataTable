-- chunkname: @modules/logic/story/model/StoryStepVideoMo.lua

module("modules.logic.story.model.StoryStepVideoMo", package.seeall)

local StoryStepVideoMo = pureTable("StoryStepVideoMo")

function StoryStepVideoMo:ctor()
	self.video = ""
	self.delayTimes = {
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0
	}
	self.orderType = 0
	self.loop = false
	self.layer = 6
end

function StoryStepVideoMo:init(info)
	self.video = info[1]
	self.delayTimes = info[2]
	self.orderType = info[3]
	self.loop = info[4]
	self.layer = info[5]
end

return StoryStepVideoMo
