-- chunkname: @modules/logic/versionactivity2_1/activity165/view/Activity165StoryReviewViewContainer.lua

module("modules.logic.versionactivity2_1.activity165.view.Activity165StoryReviewViewContainer", package.seeall)

local Activity165StoryReviewViewContainer = class("Activity165StoryReviewViewContainer", BaseViewContainer)

function Activity165StoryReviewViewContainer:buildViews()
	local views = {}

	table.insert(views, Activity165StoryReviewView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function Activity165StoryReviewViewContainer:buildTabViews(tabContainerId)
	return {
		NavigateButtonsView.New({
			true,
			false,
			false
		})
	}
end

return Activity165StoryReviewViewContainer
