-- chunkname: @modules/logic/handbook/model/HandbookStoryMO.lua

module("modules.logic.handbook.model.HandbookStoryMO", package.seeall)

local HandbookStoryMO = pureTable("HandbookStoryMO")

function HandbookStoryMO:init(storyGroupId, index)
	self.storyGroupId = storyGroupId
	self.index = index
end

return HandbookStoryMO
