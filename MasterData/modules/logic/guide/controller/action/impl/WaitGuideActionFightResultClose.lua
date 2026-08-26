-- chunkname: @modules/logic/guide/controller/action/impl/WaitGuideActionFightResultClose.lua

module("modules.logic.guide.controller.action.impl.WaitGuideActionFightResultClose", package.seeall)

local WaitGuideActionFightResultClose = class("WaitGuideActionFightResultClose", BaseGuideAction)

function WaitGuideActionFightResultClose:onStart(context)
	WaitGuideActionFightResultClose.super.onStart(self, context)
	FightController.instance:registerCallback(FightEvent.OnResultViewClose, self._onResultViewClose, self)
end

function WaitGuideActionFightResultClose:_onResultViewClose()
	FightController.instance:unregisterCallback(FightEvent.OnResultViewClose, self._onResultViewClose, self)
	self:onDone(true)
end

function WaitGuideActionFightResultClose:clearWork()
	FightController.instance:unregisterCallback(FightEvent.OnResultViewClose, self._onResultViewClose, self)
end

return WaitGuideActionFightResultClose
