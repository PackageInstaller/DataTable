-- chunkname: @modules/logic/guide/controller/action/impl/WaitGuideActionAnyEvent.lua

module("modules.logic.guide.controller.action.impl.WaitGuideActionAnyEvent", package.seeall)

local WaitGuideActionAnyEvent = class("WaitGuideActionAnyEvent", BaseGuideAction)

function WaitGuideActionAnyEvent:onStart(context)
	WaitGuideActionAnyEvent.super.onStart(self, context)

	local temp = string.split(self.actionParam, "#")
	local controllerName = temp[1]
	local eventModuleName = temp[2]
	local eventName = temp[3]

	self._param = temp[4]
	self._controller = _G[controllerName]

	if not self._controller then
		logError("WaitGuideActionAnyEvent controllerName error:" .. tostring(controllerName))

		return
	end

	self._eventModule = _G[eventModuleName]

	if not self._eventModule then
		logError("WaitGuideActionAnyEvent eventModuleName error:" .. tostring(eventModuleName))

		return
	end

	self._eventName = self._eventModule[eventName]

	if not self._eventName then
		logError("WaitGuideActionAnyEvent eventName error:" .. tostring(eventName))

		return
	end

	self._controller.instance:registerCallback(self._eventName, self._onReceiveEvent, self)
end

function WaitGuideActionAnyEvent:_onReceiveEvent(param)
	if self:checkGuideLock() then
		return
	end

	local paramType = type(param)
	local isValid = false

	if paramType == "number" then
		param = tostring(param)
	elseif paramType == "boolean" then
		param = tostring(param)
	elseif paramType == "function" then
		isValid = param(self._param)
	end

	if not isValid and self._param and self._param ~= param then
		return
	end

	self._controller.instance:unregisterCallback(self._eventName, self._onReceiveEvent, self)
	self:onDone(true)
end

function WaitGuideActionAnyEvent:clearWork()
	if self._controller then
		self._controller.instance:unregisterCallback(self._eventName, self._onReceiveEvent, self)
	end
end

return WaitGuideActionAnyEvent
