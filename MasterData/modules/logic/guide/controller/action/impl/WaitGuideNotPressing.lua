-- chunkname: @modules/logic/guide/controller/action/impl/WaitGuideNotPressing.lua

module("modules.logic.guide.controller.action.impl.WaitGuideNotPressing", package.seeall)

local WaitGuideNotPressing = class("WaitGuideNotPressing", BaseGuideAction)

function WaitGuideNotPressing:onStart(context)
	WaitGuideNotPressing.super.onStart(self, context)

	if GamepadController.instance:isOpen() then
		self:onDone(true)
	elseif self:_notPressing() then
		self:onDone(true)
	else
		TaskDispatcher.runRepeat(self._onFrame, self, 0.01)
	end
end

function WaitGuideNotPressing:clearWork()
	TaskDispatcher.cancelTask(self._onFrame, self)
end

function WaitGuideNotPressing:_onFrame()
	if self:_notPressing() then
		self:onDone(true)
	end
end

function WaitGuideNotPressing:_notPressing()
	local pressing = UnityEngine.Input.touchCount > 0

	return not pressing
end

return WaitGuideNotPressing
