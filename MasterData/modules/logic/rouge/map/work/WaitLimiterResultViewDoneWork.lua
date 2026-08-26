-- chunkname: @modules/logic/rouge/map/work/WaitLimiterResultViewDoneWork.lua

module("modules.logic.rouge.map.work.WaitLimiterResultViewDoneWork", package.seeall)

local WaitLimiterResultViewDoneWork = class("WaitLimiterResultViewDoneWork", BaseWork)

function WaitLimiterResultViewDoneWork:onStart()
	local hasLimiterResult = self:_checkIsNeedOpenRougeLimiterResultView()

	if not hasLimiterResult then
		self:onDone(true)

		return
	end

	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, self.onCloseViewDone, self)
	RougeDLCController101.instance:openRougeLimiterResultView()
end

function WaitLimiterResultViewDoneWork:_checkIsNeedOpenRougeLimiterResultView()
	local rougeResult = RougeModel.instance:getRougeResult()
	local limiterResultMo = rougeResult and rougeResult:getLimiterResultMo()

	return limiterResultMo ~= nil
end

function WaitLimiterResultViewDoneWork:clearWork()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, self.onCloseViewDone, self)
end

function WaitLimiterResultViewDoneWork:onCloseViewDone(viewName)
	if viewName == ViewName.RougeLimiterResultView then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, self.onCloseView, self)
		self:onDone(true)
	end
end

return WaitLimiterResultViewDoneWork
