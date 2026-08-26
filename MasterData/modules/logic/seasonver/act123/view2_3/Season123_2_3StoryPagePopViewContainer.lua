-- chunkname: @modules/logic/seasonver/act123/view2_3/Season123_2_3StoryPagePopViewContainer.lua

module("modules.logic.seasonver.act123.view2_3.Season123_2_3StoryPagePopViewContainer", package.seeall)

local Season123_2_3StoryPagePopViewContainer = class("Season123_2_3StoryPagePopViewContainer", BaseViewContainer)

function Season123_2_3StoryPagePopViewContainer:buildViews()
	return {
		Season123_2_3StoryPagePopView.New()
	}
end

function Season123_2_3StoryPagePopViewContainer:onContainerClickModalMask()
	self:closeThis()
end

return Season123_2_3StoryPagePopViewContainer
