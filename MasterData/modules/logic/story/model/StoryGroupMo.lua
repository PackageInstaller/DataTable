-- chunkname: @modules/logic/story/model/StoryGroupMo.lua

module("modules.logic.story.model.StoryGroupMo", package.seeall)

local StoryGroupMo = pureTable("StoryGroupMo")

function StoryGroupMo:ctor()
	self.id = 0
	self.branchId = 0
	self.branchName = ""
end

function StoryGroupMo:init(info)
	self.id = info[1]
	self.branchId = info[2]
	self.branchName = info[3]
end

return StoryGroupMo
