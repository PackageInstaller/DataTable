-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/controller/action/GuideActionWaitUIViewClose.lua

module("logic.extensions.guide.controller.action.GuideActionWaitUIViewClose", package.seeall)

local GuideActionWaitUIViewClose = class("GuideActionWaitUIViewClose", BaseGuideAction)

function GuideActionWaitUIViewClose:ctor(guideId, stepId, guideStepCO)
	GuideActionWaitUIViewClose.super.ctor(self, guideId, stepId, guideStepCO)

	self._viewId = tonumber(guideStepCO.guideControlParam)
	self._curOpenViewName = false
end

function GuideActionWaitUIViewClose:onEnter(context)
	GlobalDispatcher:addEventListener(EventType.FW_VIEW_CLOSING_EVENT, self._fwViewClosingEvent, self)
	GuideActionWaitUIViewClose.super.onEnter(self, context)
	self:_doWaitView(self._viewId)
	GuideController.instance:openGuideView(self.guideStepCO)
end

function GuideActionWaitUIViewClose:onExit()
	GlobalDispatcher:removeEventListener(EventType.FW_VIEW_CLOSING_EVENT, self._fwViewClosingEvent, self)
	GuideActionWaitUIViewClose.super.onExit(self)
end

function GuideActionWaitUIViewClose:_fwViewClosingEvent(evt, viewName, opType)
	if self._curOpenViewName == viewName then
		self._curOpenViewName = false

		self:onDone(WorkResult.Succeed)
	end
end

function GuideActionWaitUIViewClose:_doWaitView(jumpId)
	local jumpInfo = SystemJumpConfig.instance:getJumpInfo(jumpId)

	if not jumpInfo then
		return
	end

	self._curOpenViewName = jumpInfo.viewName
end

function GuideActionWaitUIViewClose:_onExitByException()
	self:onDone(WorkResult.Succeed)
	GuideController.instance:closeGuide(true)
end

return GuideActionWaitUIViewClose
