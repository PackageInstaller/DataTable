-- chunkname: @modules/logic/story/view/StoryViewContainer.lua

module("modules.logic.story.view.StoryViewContainer", package.seeall)

local StoryViewContainer = class("StoryViewContainer", BaseViewContainer)

function StoryViewContainer:buildViews()
	local views = {}

	table.insert(views, StoryView.New())

	return views
end

return StoryViewContainer
