-- chunkname: @modules/logic/sp02/operationactivity/view/AtomicOperationActivityEnterViewContainer.lua

module("modules.logic.sp02.operationactivity.view.AtomicOperationActivityEnterViewContainer", package.seeall)

local AtomicOperationActivityEnterViewContainer = class("AtomicOperationActivityEnterViewContainer", BaseViewContainer)

function AtomicOperationActivityEnterViewContainer:buildViews()
	local views = {}

	table.insert(views, AtomicOperationActivityEnterView.New())
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))

	return views
end

function AtomicOperationActivityEnterViewContainer:buildTabViews(tabContainerId)
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

return AtomicOperationActivityEnterViewContainer
