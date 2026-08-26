-- chunkname: @modules/logic/guide/controller/action/impl/WaitGuideActionUseActPoint.lua

module("modules.logic.guide.controller.action.impl.WaitGuideActionUseActPoint", package.seeall)

local WaitGuideActionUseActPoint = class("WaitGuideActionUseActPoint", BaseGuideAction)

function WaitGuideActionUseActPoint:onStart(context)
	WaitGuideActionUseActPoint.super.onStart(self, context)
	FightController.instance:registerCallback(FightEvent.OnMoveHandCard, self._OnMoveHandCard, self)
	FightController.instance:registerCallback(FightEvent.OnPlayHandCard, self._OnPlayHandCard, self)
end

function WaitGuideActionUseActPoint:_OnPlayHandCard()
	self:onDone(true)
end

function WaitGuideActionUseActPoint:_OnMoveHandCard()
	self:onDone(true)
end

function WaitGuideActionUseActPoint:clearWork()
	FightController.instance:unregisterCallback(FightEvent.OnMoveHandCard, self._OnMoveHandCard, self)
	FightController.instance:unregisterCallback(FightEvent.OnPlayHandCard, self._OnPlayHandCard, self)
end

return WaitGuideActionUseActPoint
