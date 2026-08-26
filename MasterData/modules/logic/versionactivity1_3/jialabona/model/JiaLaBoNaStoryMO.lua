-- chunkname: @modules/logic/versionactivity1_3/jialabona/model/JiaLaBoNaStoryMO.lua

module("modules.logic.versionactivity1_3.jialabona.model.JiaLaBoNaStoryMO", package.seeall)

local JiaLaBoNaStoryMO = pureTable("JiaLaBoNaStoryMO")

function JiaLaBoNaStoryMO:init(index, storyCfg)
	self.id = storyCfg.id or index
	self.index = index
	self.storyId = storyCfg.id
	self.config = storyCfg
end

function JiaLaBoNaStoryMO:isLocked()
	if StoryModel.instance:isStoryHasPlayed(self.storyId) then
		return false
	end

	return true
end

return JiaLaBoNaStoryMO
