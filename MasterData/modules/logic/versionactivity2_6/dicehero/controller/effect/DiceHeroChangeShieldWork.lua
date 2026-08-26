-- chunkname: @modules/logic/versionactivity2_6/dicehero/controller/effect/DiceHeroChangeShieldWork.lua

module("modules.logic.versionactivity2_6.dicehero.controller.effect.DiceHeroChangeShieldWork", package.seeall)

local DiceHeroChangeShieldWork = class("DiceHeroChangeShieldWork", DiceHeroBaseEffectWork)

function DiceHeroChangeShieldWork:onStart(context)
	local targetId = self._effectMo.targetId
	local targetEntity = DiceHeroHelper.instance:getEntity(targetId)

	if not targetEntity then
		logError("找不到实体" .. targetId)
		self:onDone(true)

		return
	end

	self._targetEntity = targetEntity
	self._isFromCard = self._effectMo.parent.isByCard
	self._targetPos = self._targetEntity:getPos(1)

	if self._isFromCard and string.nilorempty(self._effectMo.extraData) and self._effectMo.effectNum > 0 then
		local cardItem = DiceHeroHelper.instance:getCard(tonumber(self._effectMo.parent.reasonId))

		self._effectItem = DiceHeroHelper.instance:doEffect(6, cardItem:getPos(), self._targetPos)

		AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_wenming_shot)
		TaskDispatcher.runDelay(self.showEffectNum, self, 0.5)
	else
		self:showEffectNum()
	end
end

function DiceHeroChangeShieldWork:showEffectNum()
	self._targetEntity:addShield(self._effectMo.effectNum)

	if self._effectMo.effectNum > 0 then
		AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_wenming_defense)
		self._targetEntity:showEffect(3)

		if self._effectItem then
			self._effectItem:initData(4, self._targetPos, nil, string.format("%+d", self._effectMo.effectNum))
		else
			self._effectItem = DiceHeroHelper.instance:doEffect(4, self._targetPos, nil, string.format("%+d", self._effectMo.effectNum))
		end

		TaskDispatcher.runDelay(self._delayDone, self, 1)
	else
		self:onDone(true)
	end
end

function DiceHeroChangeShieldWork:_delayDone()
	self:onDone(true)
end

function DiceHeroChangeShieldWork:clearWork()
	self._targetEntity = nil

	if self._effectItem then
		DiceHeroHelper.instance:returnEffectItemToPool(self._effectItem)

		self._effectItem = nil
	end

	TaskDispatcher.cancelTask(self._delayDone, self)
	TaskDispatcher.cancelTask(self.showEffectNum, self)
end

return DiceHeroChangeShieldWork
