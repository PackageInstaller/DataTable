-- chunkname: @modules/logic/versionactivity2_1/activity165/view/Activity165StoryEditViewContainer.lua

module("modules.logic.versionactivity2_1.activity165.view.Activity165StoryEditViewContainer", package.seeall)

local Activity165StoryEditViewContainer = class("Activity165StoryEditViewContainer", BaseViewContainer)

function Activity165StoryEditViewContainer:buildViews()
	self.editView = Activity165StoryEditView.New()

	local views = {}

	table.insert(views, TabViewGroup.New(1, "#go_topleft"))
	table.insert(views, self.editView)

	return views
end

function Activity165StoryEditViewContainer:buildTabViews(tabContainerId)
	return {
		NavigateButtonsView.New({
			true,
			true,
			false
		})
	}
end

function Activity165StoryEditViewContainer:playCloseTransition()
	self:startViewCloseBlock()
	self.editView:playCloseAnim(self.onPlayCloseTransitionFinish, self)
end

return Activity165StoryEditViewContainer
