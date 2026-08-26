-- chunkname: @modules/logic/versionactivity2_6/dicehero/controller/effect/DiceHeroUpdateBuffWork.lua

module("modules.logic.versionactivity2_6.dicehero.controller.effect.DiceHeroUpdateBuffWork", package.seeall)

local DiceHeroUpdateBuffWork = class("DiceHeroUpdateBuffWork", DiceHeroBaseEffectWork)

function DiceHeroUpdateBuffWork:onStart(context)
	local targetId = self._effectMo.targetId
	local targetEntity = DiceHeroHelper.instance:getEntity(targetId)
	local delay = 0

	if not targetEntity then
		logError("找不到实体" .. targetId)
	else
		local heroMo = targetEntity:getHeroMo()
		local isAddLayer = self._effectMo.buff.co.visible == 1 and heroMo:isAddLayer(self._effectMo.buff)

		targetEntity:addOrUpdateBuff(self._effectMo.buff)

		if isAddLayer then
			if self._effectMo.buff.co.tag == 1 then
				AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_wenming_buff)
				targetEntity:showEffect(1)
			else
				AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_wenming_debuff)
				targetEntity:showEffect(2)
			end

			delay = 0.5
		end
	end

	if delay > 0 then
		TaskDispatcher.runDelay(self._delayDone, self, delay)
	else
		self:onDone(true)
	end
end

function DiceHeroUpdateBuffWork:_delayDone()
	self:onDone(true)
end

function DiceHeroUpdateBuffWork:clearWork()
	TaskDispatcher.cancelTask(self._delayDone, self)
end

return DiceHeroUpdateBuffWork
