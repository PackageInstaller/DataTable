-- chunkname: @modules/logic/story/view/StoryBranchViewContainer.lua

module("modules.logic.story.view.StoryBranchViewContainer", package.seeall)

local StoryBranchViewContainer = class("StoryBranchViewContainer", BaseViewContainer)

function StoryBranchViewContainer:buildViews()
	local views = {}

	table.insert(views, StoryBranchView.New())

	return views
end

return StoryBranchViewContainer
