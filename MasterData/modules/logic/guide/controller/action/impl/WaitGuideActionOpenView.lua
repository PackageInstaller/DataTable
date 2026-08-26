-- chunkname: @modules/logic/guide/controller/action/impl/WaitGuideActionOpenView.lua

module("modules.logic.guide.controller.action.impl.WaitGuideActionOpenView", package.seeall)

local WaitGuideActionOpenView = class("WaitGuideActionOpenView", BaseGuideAction)

function WaitGuideActionOpenView:onStart(context)
	WaitGuideActionOpenView.super.onStart(self, context)

	local paramList = string.split(self.actionParam, "#")

	self._viewName = paramList[1]

	local timeoutSecond = #paramList >= 2 and tonumber(paramList[2])

	if ViewMgr.instance:isOpen(self._viewName) then
		self:onDone(true)

		return
	end

	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, self._checkOpenView, self)

	if timeoutSecond and timeoutSecond > 0 then
		TaskDispatcher.runDelay(self._delayDone, self, timeoutSecond)
	end
end

function WaitGuideActionOpenView:_delayDone()
	self:clearWork()
	self:onDone(true)
end

function WaitGuideActionOpenView:_checkOpenView(viewName, viewParam)
	if self._viewName == viewName then
		self:clearWork()
		self:onDone(true)
	end
end

function WaitGuideActionOpenView:clearWork()
	TaskDispatcher.cancelTask(self._delayDone, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, self._checkOpenView, self)
end

return WaitGuideActionOpenView
