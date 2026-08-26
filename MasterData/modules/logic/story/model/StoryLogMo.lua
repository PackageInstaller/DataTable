-- chunkname: @modules/logic/story/model/StoryLogMo.lua

module("modules.logic.story.model.StoryLogMo", package.seeall)

local StoryLogMo = pureTable("StoryLogMo")

function StoryLogMo:ctor()
	self.info = {}
end

function StoryLogMo:init(info)
	self.info = info
end

return StoryLogMo
