-- chunkname: @modules/logic/versionactivity3_7/wmz/flow/WmzWork_WaitEvent.lua

module("modules.logic.versionactivity3_7.wmz.flow.WmzWork_WaitEvent", package.seeall)

local WmzWork_WaitEvent = class("WmzWork_WaitEvent", WmzWorkBase)

function WmzWork_WaitEvent.s_create(sender, evtName, a1, a2, a3, a4, a5)
	local work = WmzWork_WaitEvent.New()

	work._sender = sender
	work._evtName = evtName
	work._a1 = a1
	work._a2 = a2
	work._a3 = a3
	work._a4 = a4
	work._a5 = a5

	return work
end

function WmzWork_WaitEvent:onStart()
	self:clearWork()

	if not self._sender then
		logWarn("_sender is null")
		self:onSucc()

		return
	end

	if not self._evtName then
		logWarn("_evtName is null")
		self:onSucc()

		return
	end

	self:startBlock(nil, 1)
	self._sender:registerCallback(self._evtName, self._onDispatchedEvt, self)
end

function WmzWork_WaitEvent:_onDispatchedEvt(a1, a2, a3, a4, a5)
	if self._a1 ~= nil then
		if a1 ~= self._a1 then
			return
		end

		if a2 ~= self._a2 then
			return
		end

		if a3 ~= self._a3 then
			return
		end

		if a4 ~= self._a4 then
			return
		end

		if a5 ~= self._a5 then
			return
		end
	end

	self._sender:unregisterCallback(self._evtName, self._onDispatchedEvt, self)
	self:onSucc()
end

function WmzWork_WaitEvent:clearWork()
	if self._sender and self._evtName then
		self._sender:unregisterCallback(self._evtName, self._onDispatchedEvt, self)
	end
end

return WmzWork_WaitEvent
