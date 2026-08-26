-- chunkname: @modules/logic/story/model/StoryStepBGMo.lua

module("modules.logic.story.model.StoryStepBGMo", package.seeall)

local StoryStepBGMo = pureTable("StoryStepBGMo")

function StoryStepBGMo:ctor()
	self.bgType = 0
	self.bgImg = ""
	self.transType = 0
	self.darkTimes = {
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0
	}
	self.waitTimes = {
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0
	}
	self.fadeTimes = {
		0.5,
		0.5,
		0.5,
		0.5,
		0.5,
		0.5,
		0.5,
		0.5
	}
	self.offset = {}
	self.angle = 0
	self.scale = 1
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
	self.materialId = 0
end

function StoryStepBGMo:init(info)
	self.bgType = info[1]

	if info[2] ~= "" then
		if self.bgType == StoryEnum.BgType.Video then
			self.bgImg = info[2]
		elseif string.find(info[2], "/") then
			if not info[2] then
				local path = "bg/" .. info[2]

				self.bgImg = StoryBgZoneModel.instance:getRightBgZonePath(path)
			end
		end
	end

	self.transType = info[3]
	self.darkTimes = info[4]
	self.waitTimes = info[5]
	self.fadeTimes = info[6]
	self.offset = {
		info[7],
		info[8]
	}
	self.angle = info[9]
	self.scale = info[10]
	self.transTimes = info[11]
	self.effType = info[12]
	self.effDegree = info[13]
	self.effDelayTimes = info[14]
	self.effTimes = info[15]
	self.effRate = info[16]
	self.materialId = info[17]
end

return StoryStepBGMo
