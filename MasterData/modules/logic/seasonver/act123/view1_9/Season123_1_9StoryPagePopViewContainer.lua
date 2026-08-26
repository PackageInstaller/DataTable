-- chunkname: @modules/logic/seasonver/act123/view1_9/Season123_1_9StoryPagePopViewContainer.lua

module("modules.logic.seasonver.act123.view1_9.Season123_1_9StoryPagePopViewContainer", package.seeall)

local Season123_1_9StoryPagePopViewContainer = class("Season123_1_9StoryPagePopViewContainer", BaseViewContainer)

function Season123_1_9StoryPagePopViewContainer:buildViews()
	return {
		Season123_1_9StoryPagePopView.New()
	}
end

function Season123_1_9StoryPagePopViewContainer:onContainerClickModalMask()
	self:closeThis()
end

return Season123_1_9StoryPagePopViewContainer
