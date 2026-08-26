-- chunkname: @modules/logic/seasonver/act123/view2_0/Season123_2_0StoryPagePopViewContainer.lua

module("modules.logic.seasonver.act123.view2_0.Season123_2_0StoryPagePopViewContainer", package.seeall)

local Season123_2_0StoryPagePopViewContainer = class("Season123_2_0StoryPagePopViewContainer", BaseViewContainer)

function Season123_2_0StoryPagePopViewContainer:buildViews()
	return {
		Season123_2_0StoryPagePopView.New()
	}
end

function Season123_2_0StoryPagePopViewContainer:onContainerClickModalMask()
	self:closeThis()
end

return Season123_2_0StoryPagePopViewContainer
