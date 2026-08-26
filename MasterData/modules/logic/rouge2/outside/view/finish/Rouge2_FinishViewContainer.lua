-- chunkname: @modules/logic/rouge2/outside/view/finish/Rouge2_FinishViewContainer.lua

module("modules.logic.rouge2.outside.view.finish.Rouge2_FinishViewContainer", package.seeall)

local Rouge2_FinishViewContainer = class("Rouge2_FinishViewContainer", BaseViewContainer)

function Rouge2_FinishViewContainer:buildViews()
	local views = {}

	table.insert(views, Rouge2_FinishView.New())

	return views
end

function Rouge2_FinishViewContainer:playCloseTransition()
	TaskDispatcher.runDelay(self.onCloseAnimDone, self, 0.5)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self.onOpenView, self)
end

function Rouge2_FinishViewContainer:onCloseAnimDone()
	Rouge2_OutsideController.instance:dispatchEvent(Rouge2_OutsideEvent.onFinishViewDone)
end

function Rouge2_FinishViewContainer:onOpenView(viewName)
	if viewName == ViewName.Rouge2_ResultView then
		self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self.onOpenView, self)
		self:onPlayCloseTransitionFinish()
	end
end

return Rouge2_FinishViewContainer
