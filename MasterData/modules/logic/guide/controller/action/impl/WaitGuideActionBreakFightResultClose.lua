-- chunkname: @modules/logic/guide/controller/action/impl/WaitGuideActionBreakFightResultClose.lua

module("modules.logic.guide.controller.action.impl.WaitGuideActionBreakFightResultClose", package.seeall)

local WaitGuideActionBreakFightResultClose = class("WaitGuideActionBreakFightResultClose", BaseGuideAction)

function WaitGuideActionBreakFightResultClose:onStart(context)
	WaitGuideActionBreakFightResultClose.super.onStart(self, context)
	FightController.instance:registerCallback(FightEvent.OnBreakResultViewClose, self._onBreakResultViewClose, self)
end

function WaitGuideActionBreakFightResultClose:_onBreakResultViewClose(param)
	param.isBreak = true

	FightController.instance:unregisterCallback(FightEvent.OnBreakResultViewClose, self._onBreakResultViewClose, self)
	self:onDone(true)
end

function WaitGuideActionBreakFightResultClose:clearWork()
	FightController.instance:unregisterCallback(FightEvent.OnBreakResultViewClose, self._onBreakResultViewClose, self)
end

return WaitGuideActionBreakFightResultClose
