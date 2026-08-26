-- chunkname: @modules/logic/explore/controller/BaseExploreSequence.lua

module("modules.logic.explore.controller.BaseExploreSequence", package.seeall)

local BaseExploreSequence = class("BaseExploreSequence")

function BaseExploreSequence:ctor()
	self._sequence = nil
end

function BaseExploreSequence:buildFlow()
	if self._sequence then
		self._sequence:destroy()
	end

	self._sequence = FlowSequence.New()
end

function BaseExploreSequence:addWork(work)
	self._sequence:addWork(work)
end

function BaseExploreSequence:start(callback, callbackObj)
	self._callback = callback
	self._callbackObj = callbackObj

	self._sequence:registerDoneListener(self.doCallback, self)
	self._sequence:start({})
end

function BaseExploreSequence:dispose()
	if self._sequence then
		self._sequence:unregisterDoneListener(self.doCallback, self)
		self._sequence:destroy()
	end

	self._sequence = nil
	self._context = nil
	self._callback = nil
	self._callbackObj = nil
end

function BaseExploreSequence:doCallback()
	self._sequence:unregisterDoneListener(self.doCallback, self)

	if self._callback then
		if self._callbackObj then
			self._callback(self._callbackObj, self._sequence.isSuccess)
		else
			self._callback(self._sequence.isSuccess)
		end
	end
end

return BaseExploreSequence
