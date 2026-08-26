-- chunkname: @modules/logic/gm/controller/sequencework/WaitEventWork.lua

module("modules.logic.gm.controller.sequencework.WaitEventWork", package.seeall)

local WaitEventWork = class("WaitEventWork", BaseWork)

function WaitEventWork:ctor(param)
	local temp = string.split(param, ";")
	local controllerName = temp[1]
	local eventModuleName = temp[2]
	local eventName = temp[3]

	self._param = temp[4]
	self._controller = _G[controllerName]

	if not self._controller then
		logError("WaitEventWork controllerName error:" .. tostring(controllerName))

		return
	end

	self._eventModule = _G[eventModuleName]

	if not self._eventModule then
		logError("WaitEventWork eventModuleName error:" .. tostring(eventModuleName))

		return
	end

	self._eventName = self._eventModule[eventName]

	if not self._eventName then
		logError("WaitEventWork eventName error:" .. tostring(eventName))

		return
	end
end

function WaitEventWork:onStart()
	self._controller.instance:registerCallback(self._eventName, self._onReceiveEvent, self)
end

function WaitEventWork:_onReceiveEvent(param)
	local paramType = type(param)

	if paramType == "number" then
		param = tostring(param)
	elseif paramType == "boolean" then
		param = tostring(param)
	end

	if self._param and self._param ~= param then
		return
	end

	self._controller.instance:unregisterCallback(self._eventName, self._onReceiveEvent, self)
	self:onDone(true)
end

function WaitEventWork:clearWork()
	if self._controller then
		self._controller.instance:unregisterCallback(self._eventName, self._onReceiveEvent, self)
	end
end

return WaitEventWork
