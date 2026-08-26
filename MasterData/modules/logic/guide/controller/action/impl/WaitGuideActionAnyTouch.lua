-- chunkname: @modules/logic/guide/controller/action/impl/WaitGuideActionAnyTouch.lua

module("modules.logic.guide.controller.action.impl.WaitGuideActionAnyTouch", package.seeall)

local WaitGuideActionAnyTouch = class("WaitGuideActionAnyTouch", BaseGuideAction)

function WaitGuideActionAnyTouch:ctor(guideId, stepId, actionParam)
	WaitGuideActionAnyTouch.super.ctor(self, guideId, stepId, actionParam)
end

function WaitGuideActionAnyTouch:onStart(context)
	WaitGuideActionAnyTouch.super.onStart(self, context)
	GameStateMgr.instance:registerCallback(GameStateEvent.OnTouchScreen, self._onTouchScreen, self)
end

function WaitGuideActionAnyTouch:clearWork()
	GameStateMgr.instance:unregisterCallback(GameStateEvent.OnTouchScreen, self._onTouchScreen, self)
end

function WaitGuideActionAnyTouch:_onTouchScreen()
	GameStateMgr.instance:unregisterCallback(GameStateEvent.OnTouchScreen, self._onTouchScreen, self)
	TaskDispatcher.runDelay(function()
		self:onDone(true)
	end, nil, 0.1)
end

return WaitGuideActionAnyTouch
