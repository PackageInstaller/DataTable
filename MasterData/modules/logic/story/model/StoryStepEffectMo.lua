-- chunkname: @modules/logic/story/model/StoryStepEffectMo.lua

module("modules.logic.story.model.StoryStepEffectMo", package.seeall)

local StoryStepEffectMo = pureTable("StoryStepEffectMo")

function StoryStepEffectMo:ctor()
	self.effect = ""
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
	self.inType = 0
	self.inTimes = {
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0
	}
	self.outType = 0
	self.outTimes = {
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0
	}
	self.pos = {}
	self.layer = 9
end

function StoryStepEffectMo:init(info)
	self.effect = info[1]
	self.delayTimes = info[2]
	self.orderType = info[3]
	self.inType = info[4]
	self.inTimes = info[5]
	self.outType = info[6]
	self.outTimes = info[7]
	self.pos = {
		info[8],
		info[9]
	}
	self.layer = info[10]
end

return StoryStepEffectMo
