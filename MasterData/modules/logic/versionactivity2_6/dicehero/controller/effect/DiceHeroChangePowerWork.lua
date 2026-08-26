-- chunkname: @modules/logic/versionactivity2_6/dicehero/controller/effect/DiceHeroChangePowerWork.lua

module("modules.logic.versionactivity2_6.dicehero.controller.effect.DiceHeroChangePowerWork", package.seeall)

local DiceHeroChangePowerWork = class("DiceHeroChangePowerWork", DiceHeroBaseEffectWork)

function DiceHeroChangePowerWork:onStart(context)
	local targetId = self._effectMo.targetId
	local targetEntity = DiceHeroHelper.instance:getEntity(targetId)

	if not targetEntity then
		logError("找不到实体" .. targetId)

		return
	end

	self._targetEntity = targetEntity
	self._isFromCard = self._effectMo.parent.isByCard
	self._targetPos = self._targetEntity:getPos(2)

	if self._isFromCard and string.nilorempty(self._effectMo.extraData) and self._effectMo.effectNum > 0 then
		local cardItem = DiceHeroHelper.instance:getCard(tonumber(self._effectMo.parent.reasonId))

		self._effectItem = DiceHeroHelper.instance:doEffect(5, cardItem:getPos(), self._targetPos)

		AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_wenming_shot)
		TaskDispatcher.runDelay(self.addPower, self, 0.5)
	else
		self:addPower()
	end
end

function DiceHeroChangePowerWork:addPower()
	self._targetEntity:addPower(self._effectMo.effectNum)
	self:onDone(true)
end

function DiceHeroChangePowerWork:clearWork()
	if self._effectItem then
		DiceHeroHelper.instance:returnEffectItemToPool(self._effectItem)

		self._effectItem = nil
	end

	TaskDispatcher.cancelTask(self.addPower, self)
end

return DiceHeroChangePowerWork
