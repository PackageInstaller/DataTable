-- chunkname: @modules/logic/story/model/StoryBgZoneMo.lua

module("modules.logic.story.model.StoryBgZoneMo", package.seeall)

local StoryBgZoneMo = pureTable("StoryBgZoneMo")

function StoryBgZoneMo:ctor()
	self.path = ""
	self.sourcePath = ""
	self.offsetX = 0
	self.offsetY = 0
end

function StoryBgZoneMo:init(info)
	self.path = info[1]
	self.sourcePath = info[2]
	self.offsetX = info[3]
	self.offsetY = info[4]
end

return StoryBgZoneMo
