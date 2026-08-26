-- chunkname: @modules/logic/story/model/StoryStepAudioMo.lua

module("modules.logic.story.model.StoryStepAudioMo", package.seeall)

local StoryStepAudioMo = pureTable("StoryStepAudioMo")

function StoryStepAudioMo:ctor()
	self.audio = 0
	self.audioState = 0
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
	self.volume = 1
	self.transTimes = {
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0
	}
	self.count = 1
end

function StoryStepAudioMo:init(info)
	self.audio = info[1]
	self.audioState = info[2]
	self.delayTimes = info[3]
	self.orderType = info[4]
	self.volume = info[5]
	self.transTimes = info[6]
	self.count = info[7]
end

return StoryStepAudioMo
