-- chunkname: @modules/logic/sp01/act205/view/card/Act205CardSelectViewContainer.lua

module("modules.logic.sp01.act205.view.card.Act205CardSelectViewContainer", package.seeall)

local Act205CardSelectViewContainer = class("Act205CardSelectViewContainer", BaseViewContainer)

function Act205CardSelectViewContainer:buildViews()
	local views = {}

	table.insert(views, Act205CardSelectView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function Act205CardSelectViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			self.navigateView
		}
	end
end

return Act205CardSelectViewContainer
