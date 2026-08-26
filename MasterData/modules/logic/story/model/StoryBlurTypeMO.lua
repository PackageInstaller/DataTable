-- chunkname: @modules/logic/story/model/StoryBlurTypeMO.lua

module("modules.logic.story.model.StoryBlurTypeMO", package.seeall)

local StoryBlurTypeMO = pureTable("StoryBlurTypeMO")

function StoryBlurTypeMO:ctor()
	self.type = 0
	self.name = ""
	self.startname = ""
	self.animLength = 0
	self.isRadial = false
	self.extraParam = ""
end

function StoryBlurTypeMO:init(info)
	self.type = info[1]
	self.name = info[2]
	self.startname = info[3]
	self.animLength = info[4]
	self.isRadial = info[5]
	self.extraParam = info[6]
end

return StoryBlurTypeMO
