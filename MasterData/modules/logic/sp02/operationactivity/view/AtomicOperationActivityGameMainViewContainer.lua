-- chunkname: @modules/logic/sp02/operationactivity/view/AtomicOperationActivityGameMainViewContainer.lua

module("modules.logic.sp02.operationactivity.view.AtomicOperationActivityGameMainViewContainer", package.seeall)

local AtomicOperationActivityGameMainViewContainer = class("AtomicOperationActivityGameMainViewContainer", BaseViewContainer)

function AtomicOperationActivityGameMainViewContainer:buildViews()
	local views = {}

	table.insert(views, AtomicOperationActivityGameMainView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function AtomicOperationActivityGameMainViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			true,
			true
		}, nil, nil, nil, self.onClickHelp, self)

		self.navigateView:setOverrideHelp(self.onClickHelp, self)

		return {
			self.navigateView
		}
	end
end

function AtomicOperationActivityGameMainViewContainer:onClickHelp()
	ViewMgr.instance:openView(ViewName.AtomicOperationActivityGameTipView)
end

return AtomicOperationActivityGameMainViewContainer
