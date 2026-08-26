-- chunkname: @modules/logic/versionactivity3_1/gaosiniao/work/entry/GaoSiNiaoWork_EnterGameView.lua

module("modules.logic.versionactivity3_1.gaosiniao.work.entry.GaoSiNiaoWork_EnterGameView", package.seeall)

local GaoSiNiaoWork_EnterGameView = class("GaoSiNiaoWork_EnterGameView", GaoSiNiaoEntryFlow_WorkBase)

function GaoSiNiaoWork_EnterGameView.s_create(viewName)
	local work = GaoSiNiaoWork_EnterGameView.New()

	work._viewName = viewName

	return work
end

function GaoSiNiaoWork_EnterGameView:onStart()
	self:clearWork()
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self)
	self:restartBattle()

	local viewName = self._viewName

	if not ViewMgr.instance:isOpen(viewName) then
		ViewMgr.instance:openView(viewName)
	else
		self:onSucc()
	end
end

function GaoSiNiaoWork_EnterGameView:_onOpenViewFinish(viewName)
	if self._viewName == viewName then
		self:onSucc()
	end
end

function GaoSiNiaoWork_EnterGameView:clearWork()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self)
	GaoSiNiaoWork_EnterGameView.super.clearWork(self)
end

return GaoSiNiaoWork_EnterGameView
