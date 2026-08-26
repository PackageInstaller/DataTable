-- chunkname: @modules/logic/sp01/act205/view/ocean/Act205OceanSelectViewContainer.lua

module("modules.logic.sp01.act205.view.ocean.Act205OceanSelectViewContainer", package.seeall)

local Act205OceanSelectViewContainer = class("Act205OceanSelectViewContainer", BaseViewContainer)

function Act205OceanSelectViewContainer:buildViews()
	local views = {}

	table.insert(views, Act205OceanSelectView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function Act205OceanSelectViewContainer:buildTabViews(tabContainerId)
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

function Act205OceanSelectViewContainer:setOverrideCloseClick(overrideCloseFunc, overrideCloseObj)
	self.navigateView:setOverrideClose(overrideCloseFunc, overrideCloseObj)
end

return Act205OceanSelectViewContainer
