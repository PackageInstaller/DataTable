-- chunkname: @modules/logic/versionactivity2_6/dicehero/controller/effect/DiceHeroDamageWork.lua

module("modules.logic.versionactivity2_6.dicehero.controller.effect.DiceHeroDamageWork", package.seeall)

local DiceHeroDamageWork = class("DiceHeroDamageWork", DiceHeroBaseEffectWork)

function DiceHeroDamageWork:onStart(context)
	local gameData = DiceHeroFightModel.instance:getGameData()

	self._isFromCard = self._effectMo.parent.isByCard
	self._isByHero = gameData.allyHero.uid == self._effectMo.fromId

	local fromItem = DiceHeroHelper.instance:getEntity(self._effectMo.fromId)
	local targetItem = DiceHeroHelper.instance:getEntity(self._effectMo.targetId)

	self._targetPos = targetItem:getPos()
	self._targetItem = targetItem

	if self._isByHero and self._isFromCard and string.nilorempty(self._effectMo.extraData) then
		local cardItem = DiceHeroHelper.instance:getCard(tonumber(self._effectMo.parent.reasonId))

		self._effectItem = DiceHeroHelper.instance:doEffect(2, cardItem:getPos(), self._targetPos)
	else
		self._effectItem = DiceHeroHelper.instance:doEffect(self._isByHero and 2 or 3, fromItem:getPos(), self._targetPos)
	end

	AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_wenming_shot)
	TaskDispatcher.runDelay(self._delayShowDamage, self, 0.5)
end

function DiceHeroDamageWork:_delayShowDamage()
	DiceHeroController.instance:dispatchEvent(DiceHeroEvent.OnDamage, self._isByHero)
	AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_wenming_shotimp)
	self._targetItem:showEffect(4)
	TaskDispatcher.runDelay(self._delayShowNum, self, 0.5)
	TaskDispatcher.runDelay(self._delayFinish, self, 1)
end

function DiceHeroDamageWork:_delayShowNum()
	self._effectItem:initData(1, self._targetPos, nil, self._effectMo.effectNum)
end

function DiceHeroDamageWork:_delayFinish()
	self:onDone(true)
end

function DiceHeroDamageWork:clearWork()
	if self._effectItem then
		DiceHeroHelper.instance:returnEffectItemToPool(self._effectItem)

		self._effectItem = nil
	end

	TaskDispatcher.cancelTask(self._delayShowDamage, self)
	TaskDispatcher.cancelTask(self._delayShowNum, self)
	TaskDispatcher.cancelTask(self._delayFinish, self)
end

return DiceHeroDamageWork
