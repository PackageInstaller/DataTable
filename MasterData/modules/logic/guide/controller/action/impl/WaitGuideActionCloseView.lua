-- chunkname: @modules/logic/guide/controller/action/impl/WaitGuideActionCloseView.lua

module("modules.logic.guide.controller.action.impl.WaitGuideActionCloseView", package.seeall)

local WaitGuideActionCloseView = class("WaitGuideActionCloseView", BaseGuideAction)

function WaitGuideActionCloseView:onStart(context)
	WaitGuideActionCloseView.super.onStart(self, context)

	self._viewName = self.actionParam

	if ViewMgr.instance:isOpen(self._viewName) then
		ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	else
		self:onDone(true)
	end
end

function WaitGuideActionCloseView:_onCloseViewFinish(viewName, viewParam)
	if self._viewName == viewName then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
		self:onDone(true)
	end
end

function WaitGuideActionCloseView:clearWork()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

return WaitGuideActionCloseView
