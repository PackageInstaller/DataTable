-- chunkname: @modules/logic/story/view/heropreview/StoryHeroPreviewContainer.lua

module("modules.logic.story.view.heropreview.StoryHeroPreviewContainer", package.seeall)

local StoryHeroPreviewContainer = class("StoryHeroPreviewContainer", BaseViewContainer)

function StoryHeroPreviewContainer:buildViews()
	local views = {}

	table.insert(views, StoryHeroPreview.New())

	return views
end

return StoryHeroPreviewContainer
