-- chunkname: @modules/logic/versionactivity2_6/xugouji/controller/gamestep/XugoujiGameStepCardEffectStatue.lua

module("modules.logic.versionactivity2_6.xugouji.controller.gamestep.XugoujiGameStepCardEffectStatue", package.seeall)

local XugoujiGameStepCardEffectStatue = class("XugoujiGameStepCardEffectStatue", XugoujiGameStepBase)

function XugoujiGameStepCardEffectStatue:start()
	local cardUid = self._stepData.uid
	local effectStatus = self._stepData.status
	local isAddEffect = self._stepData.isAdd

	Activity188Model.instance:updateCardEffectStatus(cardUid, isAddEffect, effectStatus)
	TaskDispatcher.runDelay(self._doCardEffect, self, 0.35)
end

function XugoujiGameStepCardEffectStatue:_doCardEffect()
	local cardUid = self._stepData.uid
	local cardInfo = Activity188Model.instance:getCardInfo(cardUid)

	if not cardInfo then
		self.finish()
	end

	XugoujiController.instance:dispatchEvent(XugoujiEvent.CardEffectStatusUpdated, cardUid)
	self:_onCardEffectActionDone()
end

function XugoujiGameStepCardEffectStatue:_onCardEffectActionDone()
	TaskDispatcher.runDelay(self.finish, self, 0.5)
end

function XugoujiGameStepCardEffectStatue:finish()
	XugoujiGameStepCardEffectStatue.super.finish(self)
end

function XugoujiGameStepCardEffectStatue:dispose()
	TaskDispatcher.cancelTask(self._doCardEffect, self)
	TaskDispatcher.cancelTask(self.finish, self)
	XugoujiGameStepBase.dispose(self)
end

return XugoujiGameStepCardEffectStatue
