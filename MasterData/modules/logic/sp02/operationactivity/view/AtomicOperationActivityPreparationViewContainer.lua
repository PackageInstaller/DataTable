-- chunkname: @modules/logic/sp02/operationactivity/view/AtomicOperationActivityPreparationViewContainer.lua

module("modules.logic.sp02.operationactivity.view.AtomicOperationActivityPreparationViewContainer", package.seeall)

local AtomicOperationActivityPreparationViewContainer = class("AtomicOperationActivityPreparationViewContainer", BaseViewContainer)

function AtomicOperationActivityPreparationViewContainer:buildViews()
	local views = {}

	table.insert(views, AtomicOperationActivityPreparationView.New())
	table.insert(views, TabViewGroup.New(1, "root/#go_topleft"))

	return views
end

function AtomicOperationActivityPreparationViewContainer:buildTabViews(tabContainerId)
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

return AtomicOperationActivityPreparationViewContainer
