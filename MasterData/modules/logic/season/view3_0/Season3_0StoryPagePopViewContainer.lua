-- chunkname: @modules/logic/season/view3_0/Season3_0StoryPagePopViewContainer.lua

module("modules.logic.season.view3_0.Season3_0StoryPagePopViewContainer", package.seeall)

local Season3_0StoryPagePopViewContainer = class("Season3_0StoryPagePopViewContainer", BaseViewContainer)

function Season3_0StoryPagePopViewContainer:buildViews()
	return {
		Season3_0StoryPagePopView.New()
	}
end

function Season3_0StoryPagePopViewContainer:onContainerClickModalMask()
	self:closeThis()
end

return Season3_0StoryPagePopViewContainer
