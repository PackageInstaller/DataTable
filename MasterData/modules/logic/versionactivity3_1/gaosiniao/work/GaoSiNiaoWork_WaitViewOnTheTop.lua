-- chunkname: @modules/logic/versionactivity3_1/gaosiniao/work/GaoSiNiaoWork_WaitViewOnTheTop.lua

module("modules.logic.versionactivity3_1.gaosiniao.work.GaoSiNiaoWork_WaitViewOnTheTop", package.seeall)

local GaoSiNiaoWork_WaitViewOnTheTop = class("GaoSiNiaoWork_WaitViewOnTheTop", GaoSiNiaoWorkBase)

function GaoSiNiaoWork_WaitViewOnTheTop.s_create(viewName, optIgnoreViewList)
	local work = GaoSiNiaoWork_WaitViewOnTheTop.New()

	work._viewName = viewName
	work._ignoreViewList = optIgnoreViewList

	return work
end

function GaoSiNiaoWork_WaitViewOnTheTop:_checkViewOnTheTop()
	return ViewHelper.instance:checkViewOnTheTop(self._viewName, self._ignoreViewList)
end

function GaoSiNiaoWork_WaitViewOnTheTop:onStart()
	self:clearWork()

	local viewName = self._viewName

	if string.nilorempty(viewName) then
		logWarn("viewName is invalid")
		self:onSucc()

		return
	end

	if not ViewMgr.instance:isOpen(viewName) then
		logWarn("viewName is not open: " .. tostring(viewName))
		self:onSucc()

		return
	end

	if self:_checkViewOnTheTop() then
		self:onSucc()
	else
		ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	end
end

function GaoSiNiaoWork_WaitViewOnTheTop:_onCloseViewFinish()
	if self:_checkViewOnTheTop() then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
		self:onSucc()
	end
end

function GaoSiNiaoWork_WaitViewOnTheTop:clearWork()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	GaoSiNiaoWork_WaitViewOnTheTop.super.clearWork(self)
end

return GaoSiNiaoWork_WaitViewOnTheTop
