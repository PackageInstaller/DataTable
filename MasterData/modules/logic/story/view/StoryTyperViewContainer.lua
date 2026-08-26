-- chunkname: @modules/logic/story/view/StoryTyperViewContainer.lua

module("modules.logic.story.view.StoryTyperViewContainer", package.seeall)

local StoryTyperViewContainer = class("StoryTyperViewContainer", BaseViewContainer)

function StoryTyperViewContainer:buildViews()
	local views = {}

	table.insert(views, StoryTyperView.New())

	return views
end

return StoryTyperViewContainer
