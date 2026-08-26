-- chunkname: @modules/logic/story/view/StoryHeroViewContainer.lua

module("modules.logic.story.view.StoryHeroViewContainer", package.seeall)

local StoryHeroViewContainer = class("StoryHeroViewContainer", BaseViewContainer)

function StoryHeroViewContainer:buildViews()
	local views = {}

	table.insert(views, StoryHeroView.New())

	return views
end

return StoryHeroViewContainer
