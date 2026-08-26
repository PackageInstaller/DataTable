-- chunkname: @modules/logic/versionactivity2_1/activity165/view/Activity165StoryEnterViewContainer.lua

module("modules.logic.versionactivity2_1.activity165.view.Activity165StoryEnterViewContainer", package.seeall)

local Activity165StoryEnterViewContainer = class("Activity165StoryEnterViewContainer", BaseViewContainer)

function Activity165StoryEnterViewContainer:buildViews()
	local views = {}

	table.insert(views, Activity165StoryEnterView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function Activity165StoryEnterViewContainer:buildTabViews(tabContainerId)
	return {
		NavigateButtonsView.New({
			true,
			true,
			false
		})
	}
end

return Activity165StoryEnterViewContainer
