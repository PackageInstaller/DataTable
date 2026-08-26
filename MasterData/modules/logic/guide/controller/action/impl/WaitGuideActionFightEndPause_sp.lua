-- chunkname: @modules/logic/guide/controller/action/impl/WaitGuideActionFightEndPause_sp.lua

module("modules.logic.guide.controller.action.impl.WaitGuideActionFightEndPause_sp", package.seeall)

local WaitGuideActionFightEndPause_sp = class("WaitGuideActionFightEndPause_sp", BaseGuideAction)

function WaitGuideActionFightEndPause_sp:onStart(context)
	WaitGuideActionFightEndPause_sp.super.onStart(self, context)
	FightController.instance:registerCallback(FightEvent.OnGuideFightEndPause_sp, self._onGuideFightEndPause, self)
end

function WaitGuideActionFightEndPause_sp:_onGuideFightEndPause(guideParam)
	guideParam.OnGuideFightEndPause_sp = true

	FightController.instance:unregisterCallback(FightEvent.OnGuideFightEndPause_sp, self._onGuideFightEndPause, self)
	self:onDone(true)
end

function WaitGuideActionFightEndPause_sp:clearWork()
	FightController.instance:unregisterCallback(FightEvent.OnGuideFightEndPause_sp, self._onGuideFightEndPause, self)
end

return WaitGuideActionFightEndPause_sp
