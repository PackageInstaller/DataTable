-- chunkname: @modules/logic/guide/controller/action/impl/WaitGuideActionClickMask.lua

module("modules.logic.guide.controller.action.impl.WaitGuideActionClickMask", package.seeall)

local WaitGuideActionClickMask = class("WaitGuideActionClickMask", BaseGuideAction)

function WaitGuideActionClickMask:ctor(guideId, stepId, actionParam)
	WaitGuideActionClickMask.super.ctor(self, guideId, stepId, actionParam)

	local paramList = string.split(actionParam, "#")

	self._beforeClickWaitSecond = #paramList >= 1 and tonumber(paramList[1]) or 0
	self._afterClickWaitSecond = #paramList >= 2 and tonumber(paramList[2]) or 0

	local stepCO = GuideConfig.instance:getStepCO(guideId, stepId)

	self._isForceGuide = stepCO.notForce == 0
	self._alpha = nil

	if #paramList >= 3 then
		self._alpha = tonumber(paramList[3])
	end

	self._goPath = GuideModel.instance:getStepGOPath(guideId, stepId)
end

function WaitGuideActionClickMask:onStart(context)
	WaitGuideActionClickMask.super.onStart(self, context)

	if self._beforeClickWaitSecond > 0 then
		GuideViewMgr.instance:disableHoleClick()
		TaskDispatcher.runDelay(self._onDelayStart, self, self._beforeClickWaitSecond)
	else
		self:_onDelayStart()
	end
end

function WaitGuideActionClickMask:clearWork()
	GuideViewMgr.instance:setHoleClickCallback(nil, nil)
	TaskDispatcher.cancelTask(self._onDelayStart, self)
	TaskDispatcher.cancelTask(self._onDelayDone, self)
end

function WaitGuideActionClickMask:_onClickTarget(isInside)
	if isInside or not self._isForceGuide then
		GuideViewMgr.instance:disableHoleClick()
		GuideViewMgr.instance:setHoleClickCallback(nil, nil)

		self._isInside = isInside

		TaskDispatcher.runDelay(self._onDelayDone, self, self._afterClickWaitSecond + 0.01)
	end
end

function WaitGuideActionClickMask:_onDelayStart()
	if not self._alpha then
		local alpha

		if self._isForceGuide == false then
			alpha = 0
		end

		if alpha then
			GuideViewMgr.instance:setMaskAlpha(alpha)
		end

		GuideViewMgr.instance:enableHoleClick()
		GuideViewMgr.instance:setHoleClickCallback(self._onClickTarget, self)
	end
end

function WaitGuideActionClickMask:_onDelayDone()
	if self._isInside then
		self:onDone(true)
	elseif not self._isForceGuide then
		GuideController.instance:oneKeyFinishGuide(self.guideId, false)
	end
end

return WaitGuideActionClickMask
