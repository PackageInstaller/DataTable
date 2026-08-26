-- chunkname: @modules/common/others/openmultiview/OpenViewWork.lua

module("modules.common.others.openmultiview.OpenViewWork", package.seeall)

local OpenViewWork = class("OpenViewWork", BaseWork)

function OpenViewWork:ctor(openViewParam)
	self._openFunction = openViewParam.openFunction
	self._openFunctionObj = openViewParam.openFunctionObj
	self._waitOpenViewName = openViewParam.waitOpenViewName
end

function OpenViewWork:onStart(context)
	if not self._openFunction then
		self:onDone(true)

		return
	end

	if not self._waitOpenViewName then
		self._openFunction(self._openFunctionObj)
		self:onDone(true)

		return
	end

	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, self._onOpenFinish, self)
	ViewMgr.instance:registerCallback(ViewEvent.ReOpenWhileOpen, self._onOpenFinish, self)
	TaskDispatcher.runDelay(self._overtime, self, 5)
	self._openFunction(self._openFunctionObj)
end

function OpenViewWork:_overtime()
	TaskDispatcher.cancelTask(self._overtime, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, self._onOpenFinish, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.ReOpenWhileOpen, self._onOpenFinish, self)
	self:onDone(true)
end

function OpenViewWork:_onOpenFinish(viewName)
	if viewName == self._waitOpenViewName then
		TaskDispatcher.cancelTask(self._overtime, self)
		ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, self._onOpenFinish, self)
		ViewMgr.instance:unregisterCallback(ViewEvent.ReOpenWhileOpen, self._onOpenFinish, self)
		self:onDone(true)
	end
end

function OpenViewWork:clearWork()
	TaskDispatcher.cancelTask(self._overtime, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, self._onOpenFinish, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.ReOpenWhileOpen, self._onOpenFinish, self)
end

return OpenViewWork
