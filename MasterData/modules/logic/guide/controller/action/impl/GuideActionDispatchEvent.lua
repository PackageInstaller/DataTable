-- chunkname: @modules/logic/guide/controller/action/impl/GuideActionDispatchEvent.lua

module("modules.logic.guide.controller.action.impl.GuideActionDispatchEvent", package.seeall)

local GuideActionDispatchEvent = class("GuideActionDispatchEvent", BaseGuideAction)

function GuideActionDispatchEvent:onStart(context)
	GuideActionDispatchEvent.super.onStart(self, context)

	local temp = string.split(self.actionParam, "#")
	local controllerName = temp[1]
	local eventModuleName = temp[2]
	local eventName = temp[3]
	local param = temp[4]

	self._controller = getModuleDef(controllerName)

	if not self._controller then
		logError("GuideActionDispatchEvent controllerName error:" .. tostring(controllerName))
		self:onDone(true)

		return
	end

	self._eventModule = getModuleDef(eventModuleName)

	if not self._eventModule then
		logError("GuideActionDispatchEvent eventModuleName error:" .. tostring(eventModuleName))
		self:onDone(true)

		return
	end

	self._eventName = self._eventModule[eventName]

	if not self._eventName then
		logError("GuideActionDispatchEvent eventName error:" .. tostring(eventName))
		self:onDone(true)

		return
	end

	logNormal(string.format("%s dispatch %s %s param:%s", controllerName, eventModuleName, self._eventName or "nil", param or "nil"))
	self._controller.instance:dispatchEvent(self._eventName, param)
	self:onDone(true)
end

return GuideActionDispatchEvent
