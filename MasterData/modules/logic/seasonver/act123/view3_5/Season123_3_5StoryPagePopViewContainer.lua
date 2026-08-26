-- chunkname: @modules/logic/seasonver/act123/view3_5/Season123_3_5StoryPagePopViewContainer.lua

module("modules.logic.seasonver.act123.view3_5.Season123_3_5StoryPagePopViewContainer", package.seeall)

local Season123_3_5StoryPagePopViewContainer = class("Season123_3_5StoryPagePopViewContainer", BaseViewContainer)

function Season123_3_5StoryPagePopViewContainer:buildViews()
	return {
		Season123_3_5StoryPagePopView.New()
	}
end

function Season123_3_5StoryPagePopViewContainer:onContainerClickModalMask()
	self:closeThis()
end

return Season123_3_5StoryPagePopViewContainer
