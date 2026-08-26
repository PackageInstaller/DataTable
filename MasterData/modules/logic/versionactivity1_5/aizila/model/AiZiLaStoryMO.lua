-- chunkname: @modules/logic/versionactivity1_5/aizila/model/AiZiLaStoryMO.lua

module("modules.logic.versionactivity1_5.aizila.model.AiZiLaStoryMO", package.seeall)

local AiZiLaStoryMO = pureTable("AiZiLaStoryMO")

function AiZiLaStoryMO:init(index, storyCfg)
	self.id = storyCfg.id or index
	self.index = index
	self.storyId = storyCfg.id
	self.config = storyCfg
end

function AiZiLaStoryMO:isLocked()
	if StoryModel.instance:isStoryHasPlayed(self.storyId) then
		return false
	end

	return true
end

return AiZiLaStoryMO
