-- chunkname: @modules/logic/seasonver/act123/view2_1/Season123_2_1StoryPagePopViewContainer.lua

module("modules.logic.seasonver.act123.view2_1.Season123_2_1StoryPagePopViewContainer", package.seeall)

local Season123_2_1StoryPagePopViewContainer = class("Season123_2_1StoryPagePopViewContainer", BaseViewContainer)

function Season123_2_1StoryPagePopViewContainer:buildViews()
	return {
		Season123_2_1StoryPagePopView.New()
	}
end

function Season123_2_1StoryPagePopViewContainer:onContainerClickModalMask()
	self:closeThis()
end

return Season123_2_1StoryPagePopViewContainer
