-- chunkname: @modules/logic/rouge/map/view/finish/RougeFinishViewContainer.lua

module("modules.logic.rouge.map.view.finish.RougeFinishViewContainer", package.seeall)

local RougeFinishViewContainer = class("RougeFinishViewContainer", BaseViewContainer)

function RougeFinishViewContainer:buildViews()
	local views = {}

	table.insert(views, RougeFinishView.New())

	return views
end

function RougeFinishViewContainer:playCloseTransition()
	TaskDispatcher.runDelay(self.onCloseAnimDone, self, 0.5)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self.onOpenView, self)
end

function RougeFinishViewContainer:onCloseAnimDone()
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onFinishViewDone)
end

function RougeFinishViewContainer:onOpenView(viewName)
	if viewName == ViewName.RougeResultView then
		self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self.onOpenView, self)
		self:onPlayCloseTransitionFinish()
	end
end

return RougeFinishViewContainer
