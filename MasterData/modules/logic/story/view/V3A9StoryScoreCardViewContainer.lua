-- chunkname: @modules/logic/story/view/V3A9StoryScoreCardViewContainer.lua

module("modules.logic.story.view.V3A9StoryScoreCardViewContainer", package.seeall)

local V3A9StoryScoreCardViewContainer = class("V3A9StoryScoreCardViewContainer", BaseViewContainer)

function V3A9StoryScoreCardViewContainer:buildViews()
	local views = {}

	self.stormView = V3A9StoryScoreCardView.New()

	table.insert(views, self.stormView)

	return views
end

return V3A9StoryScoreCardViewContainer
