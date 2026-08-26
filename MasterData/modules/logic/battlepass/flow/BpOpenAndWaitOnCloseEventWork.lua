-- chunkname: @modules/logic/battlepass/flow/BpOpenAndWaitOnCloseEventWork.lua

module("modules.logic.battlepass.flow.BpOpenAndWaitOnCloseEventWork", package.seeall)

local BpOpenAndWaitOnCloseEventWork = class("BpOpenAndWaitOnCloseEventWork", BaseWork)

function BpOpenAndWaitOnCloseEventWork:ctor(viewName, param)
	self._viewName = viewName
	self._param = param
end

function BpOpenAndWaitOnCloseEventWork:onStart()
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, self._onCloseViewFinish, self)
	ViewMgr.instance:openView(self._viewName, self._param)
end

function BpOpenAndWaitOnCloseEventWork:_onCloseViewFinish(viewName)
	if viewName == self._viewName then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, self._onCloseViewFinish, self)
		self:onDone(true)
	end
end

function BpOpenAndWaitOnCloseEventWork:clearWork()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, self._onCloseViewFinish, self)
end

return BpOpenAndWaitOnCloseEventWork
