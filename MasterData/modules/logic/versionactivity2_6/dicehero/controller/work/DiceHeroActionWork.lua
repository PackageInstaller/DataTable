-- chunkname: @modules/logic/versionactivity2_6/dicehero/controller/work/DiceHeroActionWork.lua

module("modules.logic.versionactivity2_6.dicehero.controller.work.DiceHeroActionWork", package.seeall)

local DiceHeroActionWork = class("DiceHeroActionWork", BaseWork)

function DiceHeroActionWork:ctor(stepMo)
	DiceHeroActionWork.super.ctor(self, stepMo)

	self._stepMo = stepMo
end

function DiceHeroActionWork:onStart(context)
	if self._stepMo.actionType == 1 and self._stepMo.isByCard then
		local cardItem = DiceHeroHelper.instance:getCard(tonumber(self._stepMo.reasonId))

		cardItem:doHitAnim()
	else
		local item = DiceHeroHelper.instance:getEntity(self._stepMo.fromId)

		if item then
			item:playHitAnim()
		end
	end

	AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_wenming_cardrelease)
	TaskDispatcher.runDelay(self._delayDone, self, 1)
end

function DiceHeroActionWork:_delayDone()
	self:onDone(true)
end

function DiceHeroActionWork:clearWork()
	TaskDispatcher.cancelTask(self._delayDone, self)
end

return DiceHeroActionWork
