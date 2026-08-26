-- chunkname: @modules/logic/guide/controller/action/impl/WaitGuideActionCardEndPause.lua

module("modules.logic.guide.controller.action.impl.WaitGuideActionCardEndPause", package.seeall)

local WaitGuideActionCardEndPause = class("WaitGuideActionCardEndPause", BaseGuideAction)

function WaitGuideActionCardEndPause:onStart(context)
	WaitGuideActionCardEndPause.super.onStart(self, context)
	FightController.instance:registerCallback(FightEvent.OnGuideCardEndPause, self._onGuideCardEndPause, self)
end

function WaitGuideActionCardEndPause:_onGuideCardEndPause(guideParam)
	guideParam.OnGuideCardEndPause = true

	FightController.instance:unregisterCallback(FightEvent.OnGuideCardEndPause, self._onGuideCardEndPause, self)
	self:onDone(true)
end

function WaitGuideActionCardEndPause:clearWork()
	FightController.instance:unregisterCallback(FightEvent.OnGuideCardEndPause, self._onGuideCardEndPause, self)
end

return WaitGuideActionCardEndPause
