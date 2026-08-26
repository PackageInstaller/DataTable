-- chunkname: @modules/logic/story/view/StoryPrologueSkipViewContainer.lua

module("modules.logic.story.view.StoryPrologueSkipViewContainer", package.seeall)

local StoryPrologueSkipViewContainer = class("StoryPrologueSkipViewContainer", BaseViewContainer)

function StoryPrologueSkipViewContainer:buildViews()
	local views = {}

	table.insert(views, StoryPrologueSkipView.New())

	return views
end

return StoryPrologueSkipViewContainer
