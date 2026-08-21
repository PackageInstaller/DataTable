-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/controller/action/GuideActionWaitUICloseBySpecial.lua

module("logic.extensions.guide.controller.action.GuideActionWaitUICloseBySpecial", package.seeall)

local GuideActionWaitUICloseBySpecial = class("GuideActionWaitUICloseBySpecial", BaseGuideAction)

function GuideActionWaitUICloseBySpecial:ctor(guideId, stepId, guideStepCO)
	GuideActionWaitUICloseBySpecial.super.ctor(self, guideId, stepId, guideStepCO)

	self._viewId = tonumber(guideStepCO.guideControlParam)
	self._curOpenViewName = false
end

function GuideActionWaitUICloseBySpecial:onEnter(context)
	GlobalDispatcher:addEventListener(EventType.LOTTERY_RESULT_CLOSE_BY_CLICK, self._onClickViewClose, self)
	GuideActionWaitUICloseBySpecial.super.onEnter(self, context)
	self:_doWaitView(self._viewId)
	GuideController.instance:openGuideView(self.guideStepCO)
end

function GuideActionWaitUICloseBySpecial:onExit()
	GlobalDispatcher:removeEventListener(EventType.LOTTERY_RESULT_CLOSE_BY_CLICK, self._onClickViewClose, self)
	GuideActionWaitUICloseBySpecial.super.onExit(self)
end

function GuideActionWaitUICloseBySpecial:_onClickViewClose(evt, viewName)
	if self._curOpenViewName == viewName then
		self._curOpenViewName = false

		self:onDone(WorkResult.Succeed)
	end
end

function GuideActionWaitUICloseBySpecial:_doWaitView(jumpId)
	local jumpInfo = SystemJumpConfig.instance:getJumpInfo(jumpId)

	if not jumpInfo then
		return
	end

	self._curOpenViewName = jumpInfo.viewName
end

function GuideActionWaitUICloseBySpecial:_onExitByException()
	self:onDone(WorkResult.Succeed)
	GuideController.instance:closeGuide(true)
end

return GuideActionWaitUICloseBySpecial
