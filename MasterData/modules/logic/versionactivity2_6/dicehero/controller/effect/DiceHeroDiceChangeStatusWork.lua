-- chunkname: @modules/logic/versionactivity2_6/dicehero/controller/effect/DiceHeroDiceChangeStatusWork.lua

module("modules.logic.versionactivity2_6.dicehero.controller.effect.DiceHeroDiceChangeStatusWork", package.seeall)

local DiceHeroDiceChangeStatusWork = class("DiceHeroDiceChangeStatusWork", DiceHeroBaseEffectWork)

function DiceHeroDiceChangeStatusWork:onStart(context)
	local diceItem = DiceHeroHelper.instance:getDice(self._effectMo.targetId)

	if not diceItem or not diceItem.diceMo then
		logError("骰子uid不存在" .. self._effectMo.targetId)

		return self:onDone(true)
	end

	diceItem.diceMo.status = self._effectMo.effectNum

	diceItem:refreshLock()
	self:onDone(true)
end

return DiceHeroDiceChangeStatusWork
