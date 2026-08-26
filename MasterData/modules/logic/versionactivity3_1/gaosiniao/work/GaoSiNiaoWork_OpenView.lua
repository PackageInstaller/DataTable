-- chunkname: @modules/logic/versionactivity3_1/gaosiniao/work/GaoSiNiaoWork_OpenView.lua

module("modules.logic.versionactivity3_1.gaosiniao.work.GaoSiNiaoWork_OpenView", package.seeall)

local GaoSiNiaoWork_OpenView = class("GaoSiNiaoWork_OpenView", GaoSiNiaoWorkBase)

function GaoSiNiaoWork_OpenView.s_create(viewName)
	local work = GaoSiNiaoWork_OpenView.New()

	work._viewName = viewName

	return work
end

function GaoSiNiaoWork_OpenView:onStart()
	self:clearWork()

	local viewName = self._viewName

	if not ViewMgr.instance:isOpen(viewName) then
		ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self)
		ViewMgr.instance:openView(viewName)
	else
		self:onSucc()
	end
end

function GaoSiNiaoWork_OpenView:_onOpenViewFinish(viewName)
	if self._viewName == viewName then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self)
		self:onSucc()
	end
end

function GaoSiNiaoWork_OpenView:clearWork()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self)
	GaoSiNiaoWork_OpenView.super.clearWork(self)
end

return GaoSiNiaoWork_OpenView
