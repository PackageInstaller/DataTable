-- chunkname: @modules/logic/versionactivity2_5/challenge/view/badge/Act183BadgeViewContainer.lua

module("modules.logic.versionactivity2_5.challenge.view.badge.Act183BadgeViewContainer", package.seeall)

local Act183BadgeViewContainer = class("Act183BadgeViewContainer", BaseViewContainer)

function Act183BadgeViewContainer:buildViews()
	local views = {}

	table.insert(views, TabViewGroup.New(1, "root/#go_topleft"))
	table.insert(views, Act183BadgeView.New())

	return views
end

function Act183BadgeViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			self.navigateView
		}
	end
end

return Act183BadgeViewContainer
