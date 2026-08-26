-- chunkname: @modules/logic/story/view/StoryBackgroundViewContainer.lua

module("modules.logic.story.view.StoryBackgroundViewContainer", package.seeall)

local StoryBackgroundViewContainer = class("StoryBackgroundViewContainer", BaseViewContainer)

function StoryBackgroundViewContainer:buildViews()
	local views = {}

	table.insert(views, StoryBackgroundView.New())

	return views
end

return StoryBackgroundViewContainer
