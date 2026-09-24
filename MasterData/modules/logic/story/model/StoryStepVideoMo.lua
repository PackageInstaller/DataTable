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
	self.effectTimes = {
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0
	}
	self.effectType = 0
	self.effectParam = ""
end

function StoryStepVideoMo:init(info)
	self.video = info[1]
	self.delayTimes = info[2]
	self.orderType = info[3]
	self.loop = info[4]
	self.layer = info[5]

	if info[6] then
		self.effectType = info[6]
	end

	if info[7] then
		self.effectTimes = info[7]
	end

	if info[8] then
		self.effectParam = info[8]
	end
end

return StoryStepVideoMo
