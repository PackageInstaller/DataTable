-- chunkname: @modules/logic/seasonver/act123/view1_8/Season123_1_8StoryPagePopViewContainer.lua

module("modules.logic.seasonver.act123.view1_8.Season123_1_8StoryPagePopViewContainer", package.seeall)

local Season123_1_8StoryPagePopViewContainer = class("Season123_1_8StoryPagePopViewContainer", BaseViewContainer)

function Season123_1_8StoryPagePopViewContainer:buildViews()
	return {
		Season123_1_8StoryPagePopView.New()
	}
end

function Season123_1_8StoryPagePopViewContainer:onContainerClickModalMask()
	self:closeThis()
end

return Season123_1_8StoryPagePopViewContainer
