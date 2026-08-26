-- chunkname: @modules/logic/battlepass/flow/BpOpenAndWaitCloseWork.lua

module("modules.logic.battlepass.flow.BpOpenAndWaitCloseWork", package.seeall)

local BpOpenAndWaitCloseWork = class("BpOpenAndWaitCloseWork", BaseWork)

function BpOpenAndWaitCloseWork:ctor(viewName)
	self._viewName = viewName
end

function BpOpenAndWaitCloseWork:onStart()
	UIBlockMgr.instance:endBlock("BpChargeFlow")
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	ViewMgr.instance:openView(self._viewName)
end

function BpOpenAndWaitCloseWork:_onCloseViewFinish(viewName)
	if viewName == self._viewName then
		UIBlockMgr.instance:startBlock("BpChargeFlow")
		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
		self:onDone(true)
	end
end

function BpOpenAndWaitCloseWork:clearWork()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

return BpOpenAndWaitCloseWork
