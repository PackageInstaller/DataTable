-- chunkname: @modules/logic/sp01/act205/view/Act205GameStartViewContainer.lua

module("modules.logic.sp01.act205.view.Act205GameStartViewContainer", package.seeall)

local Act205GameStartViewContainer = class("Act205GameStartViewContainer", BaseViewContainer)

function Act205GameStartViewContainer:buildViews()
	local views = {}

	table.insert(views, Act205GameStartView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function Act205GameStartViewContainer:buildTabViews(tabContainerId)
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

return Act205GameStartViewContainer
