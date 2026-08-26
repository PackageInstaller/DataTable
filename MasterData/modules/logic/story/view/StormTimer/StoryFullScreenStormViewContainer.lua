-- chunkname: @modules/logic/story/view/StormTimer/StoryFullScreenStormViewContainer.lua

module("modules.logic.story.view.StormTimer.StoryFullScreenStormViewContainer", package.seeall)

local StoryFullScreenStormViewContainer = class("StoryFullScreenStormViewContainer", BaseViewContainer)

function StoryFullScreenStormViewContainer:buildViews()
	local views = {}

	self.stormView = StoryFullScreenStormView.New()

	table.insert(views, self.stormView)

	return views
end

function StoryFullScreenStormViewContainer:playCloseTransition(paramTable)
	self.stormView:playCloseAnim()
	StoryFullScreenStormViewContainer.super.playCloseTransition(self, paramTable)
end

return StoryFullScreenStormViewContainer
