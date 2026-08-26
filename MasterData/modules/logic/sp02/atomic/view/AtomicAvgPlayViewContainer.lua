-- chunkname: @modules/logic/sp02/atomic/view/AtomicAvgPlayViewContainer.lua

module("modules.logic.sp02.atomic.view.AtomicAvgPlayViewContainer", package.seeall)

local AtomicAvgPlayViewContainer = class("AtomicAvgPlayViewContainer", BaseViewContainer)

function AtomicAvgPlayViewContainer:buildViews()
	local views = {}

	self.avgView = AtomicAvgPlayView.New()

	table.insert(views, self.avgView)
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))

	return views
end

function AtomicAvgPlayViewContainer:buildTabViews(tabContainerId)
	local view = NavigateButtonsView.New({
		true,
		false,
		false
	})

	view:setOverrideClose(self.overrideCloseFunc, self)

	return {
		view
	}
end

function AtomicAvgPlayViewContainer:overrideCloseFunc()
	self.avgView:onClickClose()
end

return AtomicAvgPlayViewContainer
