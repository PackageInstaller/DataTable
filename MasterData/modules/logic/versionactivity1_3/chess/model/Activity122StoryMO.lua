-- chunkname: @modules/logic/versionactivity1_3/chess/model/Activity122StoryMO.lua

module("modules.logic.versionactivity1_3.chess.model.Activity122StoryMO", package.seeall)

local Activity122StoryMO = pureTable("Activity122StoryMO")

function Activity122StoryMO:init(index, storyCfg)
	self.index = index
	self.cfg = storyCfg
	self.storyId = storyCfg.id
end

function Activity122StoryMO:isLocked()
	if StoryModel.instance:isStoryHasPlayed(self.storyId) then
		return false
	end

	return true
end

return Activity122StoryMO
