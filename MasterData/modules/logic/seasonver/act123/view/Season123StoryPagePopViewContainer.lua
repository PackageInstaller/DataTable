-- chunkname: @modules/logic/seasonver/act123/view/Season123StoryPagePopViewContainer.lua

module("modules.logic.seasonver.act123.view.Season123StoryPagePopViewContainer", package.seeall)

local Season123StoryPagePopViewContainer = class("Season123StoryPagePopViewContainer", BaseViewContainer)

function Season123StoryPagePopViewContainer:buildViews()
	return {
		Season123StoryPagePopView.New()
	}
end

function Season123StoryPagePopViewContainer:onContainerClickModalMask()
	self:closeThis()
end

return Season123StoryPagePopViewContainer
