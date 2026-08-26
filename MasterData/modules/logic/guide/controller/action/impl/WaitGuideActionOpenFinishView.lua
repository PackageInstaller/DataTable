-- chunkname: @modules/logic/guide/controller/action/impl/WaitGuideActionOpenFinishView.lua

module("modules.logic.guide.controller.action.impl.WaitGuideActionOpenFinishView", package.seeall)

local WaitGuideActionOpenFinishView = class("WaitGuideActionOpenFinishView", BaseGuideAction)

function WaitGuideActionOpenFinishView:onStart(context)
	WaitGuideActionOpenFinishView.super.onStart(self, context)

	local paramList = string.split(self.actionParam, "#")

	self._viewName = paramList[1]

	local timeoutSecond = #paramList >= 2 and tonumber(paramList[2])

	if ViewMgr.instance:isOpenFinish(self._viewName) then
		self:onDone(true)

		return
	else
		ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, self._checkOpenView, self)
	end

	if timeoutSecond and timeoutSecond > 0 then
		TaskDispatcher.runDelay(self._delayDone, self, timeoutSecond)
	end
end

function WaitGuideActionOpenFinishView:_delayDone()
	if self:checkGuideLock() then
		return
	end

	self:onDone(true)
end

function WaitGuideActionOpenFinishView:_checkOpenView(viewName, viewParam)
	if self._viewName == viewName then
		if self:checkGuideLock() then
			return
		end

		ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, self._checkOpenView, self)
		self:onDone(true)
	end
end

function WaitGuideActionOpenFinishView:clearWork()
	TaskDispatcher.cancelTask(self._delayDone, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, self._checkOpenView, self)
end

return WaitGuideActionOpenFinishView
