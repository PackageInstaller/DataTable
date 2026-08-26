-- chunkname: @modules/logic/story/view/StoryFrontViewContainer.lua

module("modules.logic.story.view.StoryFrontViewContainer", package.seeall)

local StoryFrontViewContainer = class("StoryFrontViewContainer", BaseViewContainer)

function StoryFrontViewContainer:buildViews()
	local views = {}

	table.insert(views, StoryFrontView.New())

	return views
end

function StoryFrontViewContainer:getFrontView()
	return self._views[1]
end

return StoryFrontViewContainer
