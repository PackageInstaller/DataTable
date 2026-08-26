-- chunkname: @modules/logic/sp02/operationactivity/view/game/AtomicOperationActivityGameViewContainer.lua

module("modules.logic.sp02.operationactivity.view.game.AtomicOperationActivityGameViewContainer", package.seeall)

local AtomicOperationActivityGameViewContainer = class("AtomicOperationActivityGameViewContainer", BaseViewContainer)

function AtomicOperationActivityGameViewContainer:buildViews()
	local views = {}
	local mainView = AtomicOperationActivityGameView.New()

	self.mainView = mainView

	table.insert(views, mainView)
	table.insert(views, TabViewGroup.New(1, "root/#go_topleft"))

	return views
end

function AtomicOperationActivityGameViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		self.navigateView:setOverrideClose(self.overrideClose, self)

		return {
			self.navigateView
		}
	end
end

function AtomicOperationActivityGameViewContainer:overrideClose()
	self.mainView:onClickClose()
end

return AtomicOperationActivityGameViewContainer
