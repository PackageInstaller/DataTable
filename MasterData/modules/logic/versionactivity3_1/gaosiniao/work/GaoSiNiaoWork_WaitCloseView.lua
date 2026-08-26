-- chunkname: @modules/logic/versionactivity3_1/gaosiniao/work/GaoSiNiaoWork_WaitCloseView.lua

module("modules.logic.versionactivity3_1.gaosiniao.work.GaoSiNiaoWork_WaitCloseView", package.seeall)

local GaoSiNiaoWork_WaitCloseView = class("GaoSiNiaoWork_WaitCloseView", GaoSiNiaoWorkBase)

function GaoSiNiaoWork_WaitCloseView.s_create(viewName)
	local work = GaoSiNiaoWork_WaitCloseView.New()

	work._viewName = viewName

	return work
end

function GaoSiNiaoWork_WaitCloseView:onStart()
	self:clearWork()

	local viewName = self._viewName

	if ViewMgr.instance:isOpen(viewName) then
		ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	else
		self:onSucc()
	end
end

function GaoSiNiaoWork_WaitCloseView:_onCloseViewFinish(viewName)
	if self._viewName == viewName then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
		self:onSucc()
	end
end

function GaoSiNiaoWork_WaitCloseView:clearWork()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	GaoSiNiaoWork_WaitCloseView.super.clearWork(self)
end

return GaoSiNiaoWork_WaitCloseView
