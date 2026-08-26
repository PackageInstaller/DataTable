-- chunkname: @modules/logic/guide/controller/action/impl/WaitGuideActionClickAnywhere.lua

module("modules.logic.guide.controller.action.impl.WaitGuideActionClickAnywhere", package.seeall)

local WaitGuideActionClickAnywhere = class("WaitGuideActionClickAnywhere", BaseGuideAction)

function WaitGuideActionClickAnywhere:ctor(guideId, stepId, actionParam)
	WaitGuideActionClickAnywhere.super.ctor(self, guideId, stepId, actionParam)
end

function WaitGuideActionClickAnywhere:onStart(context)
	WaitGuideActionClickAnywhere.super.onStart(self, context)
	GuideViewMgr.instance:setHoleClickCallback(self._onClickTarget, self)
	GuideViewMgr.instance:enableSpaceBtn(true)
end

function WaitGuideActionClickAnywhere:clearWork()
	GuideViewMgr.instance:setHoleClickCallback(nil, nil)
	GuideViewMgr.instance:enableSpaceBtn(false)
	TaskDispatcher.cancelTask(self._delayCheckPressingState, self)
end

function WaitGuideActionClickAnywhere:_onClickTarget(isInside)
	self:onDone(true)
end

return WaitGuideActionClickAnywhere
