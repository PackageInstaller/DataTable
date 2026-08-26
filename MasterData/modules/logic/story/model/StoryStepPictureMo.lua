-- chunkname: @modules/logic/story/model/StoryStepPictureMo.lua

module("modules.logic.story.model.StoryStepPictureMo", package.seeall)

local StoryStepPictureMo = pureTable("StoryStepPictureMo")

function StoryStepPictureMo:ctor()
	self.picType = 0
	self.cirRadius = 0
	self.picColor = "#ffffffff"
	self.picture = ""
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
	self.effType = 0
	self.effDegree = 0
	self.effDelayTimes = {
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0
	}
	self.effTimes = {
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0
	}
	self.effRate = 1
end

function StoryStepPictureMo:init(info)
	self.picType = info[1]
	self.cirRadius = info[2]
	self.picColor = info[3]
	self.picture = info[4]
	self.delayTimes = info[5]
	self.orderType = info[6]
	self.inType = info[7]
	self.inTimes = info[8]
	self.outType = info[9]
	self.outTimes = info[10]
	self.pos = {
		info[11],
		info[12]
	}
	self.layer = info[13]
	self.effType = info[14]
	self.effDegree = info[15]
	self.effDelayTimes = info[16]
	self.effTimes = info[17]
	self.effRate = info[18]
end

return StoryStepPictureMo
