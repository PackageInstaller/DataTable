-- chunkname: @modules/logic/versionactivity3_1/gaosiniao/work/GaoSiNiaoWork_CloseView.lua

module("modules.logic.versionactivity3_1.gaosiniao.work.GaoSiNiaoWork_CloseView", package.seeall)

local GaoSiNiaoWork_CloseView = class("GaoSiNiaoWork_CloseView", GaoSiNiaoWorkBase)

function GaoSiNiaoWork_CloseView.s_create(viewName)
	local work = GaoSiNiaoWork_CloseView.New()

	work._viewName = viewName

	return work
end

function GaoSiNiaoWork_CloseView:onStart()
	self:clearWork()

	local viewName = self._viewName

	if ViewMgr.instance:isOpen(viewName) then
		ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
		ViewMgr.instance:closeView(viewName)
	else
		self:onSucc()
	end
end

function GaoSiNiaoWork_CloseView:_onCloseViewFinish(viewName)
	if self._viewName == viewName then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
		self:onSucc()
	end
end

function GaoSiNiaoWork_CloseView:clearWork()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	GaoSiNiaoWork_CloseView.super.clearWork(self)
end

return GaoSiNiaoWork_CloseView
