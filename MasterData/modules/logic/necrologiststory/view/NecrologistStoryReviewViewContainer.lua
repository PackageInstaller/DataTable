-- chunkname: @modules/logic/necrologiststory/view/NecrologistStoryReviewViewContainer.lua

module("modules.logic.necrologiststory.view.NecrologistStoryReviewViewContainer", package.seeall)

local NecrologistStoryReviewViewContainer = class("NecrologistStoryReviewViewContainer", BaseViewContainer)

function NecrologistStoryReviewViewContainer:buildViews()
	local views = {}

	self.reviewView = NecrologistStoryReviewView.New()

	table.insert(views, self.reviewView)
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function NecrologistStoryReviewViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		local navView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			navView
		}
	end
end

function NecrologistStoryReviewViewContainer:getBranchItem()
	return self.reviewView:getBranchItem()
end

return NecrologistStoryReviewViewContainer
