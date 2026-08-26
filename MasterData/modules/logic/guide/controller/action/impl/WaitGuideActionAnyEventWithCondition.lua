-- chunkname: @modules/logic/guide/controller/action/impl/WaitGuideActionAnyEventWithCondition.lua

module("modules.logic.guide.controller.action.impl.WaitGuideActionAnyEventWithCondition", package.seeall)

local WaitGuideActionAnyEventWithCondition = class("WaitGuideActionAnyEventWithCondition", BaseGuideAction)

function WaitGuideActionAnyEventWithCondition:onStart(context)
	WaitGuideActionAnyEventWithCondition.super.onStart(self, context)

	local temp = string.split(self.actionParam, "#")
	local checkFunc = temp[1]

	if self:commonCheck(checkFunc) then
		self:onDone(true)

		return
	end

	local controllerName = temp[2]
	local eventModuleName = temp[3]
	local eventName = temp[4]

	self._param = temp[5]
	self._controller = _G[controllerName]

	if not self._controller then
		logError("WaitGuideActionAnyEventWithCondition controllerName error:" .. tostring(controllerName))

		return
	end

	self._eventModule = _G[eventModuleName]

	if not self._eventModule then
		logError("WaitGuideActionAnyEventWithCondition eventModuleName error:" .. tostring(eventModuleName))

		return
	end

	self._eventName = self._eventModule[eventName]

	if not self._eventName then
		logError("WaitGuideActionAnyEventWithCondition eventName error:" .. tostring(eventName))

		return
	end

	self._controller.instance:registerCallback(self._eventName, self._onReceiveEvent, self)
end

function WaitGuideActionAnyEventWithCondition:commonCheck(param)
	if not param then
		return false
	end

	local arr = string.split(param, "_")
	local cls = _G[arr[1]]

	if not cls then
		return false
	end

	local func = cls[arr[2]]

	if not func then
		return false
	end

	if cls.instance then
		return func(cls.instance, unpack(arr, 3))
	else
		return func(unpack(arr, 3))
	end
end

function WaitGuideActionAnyEventWithCondition:_onReceiveEvent(param)
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

function WaitGuideActionAnyEventWithCondition:clearWork()
	if self._controller then
		self._controller.instance:unregisterCallback(self._eventName, self._onReceiveEvent, self)
	end
end

return WaitGuideActionAnyEventWithCondition
