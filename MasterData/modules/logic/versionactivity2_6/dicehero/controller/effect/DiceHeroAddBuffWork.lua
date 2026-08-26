-- chunkname: @modules/logic/versionactivity2_6/dicehero/controller/effect/DiceHeroAddBuffWork.lua

module("modules.logic.versionactivity2_6.dicehero.controller.effect.DiceHeroAddBuffWork", package.seeall)

local DiceHeroAddBuffWork = class("DiceHeroAddBuffWork", DiceHeroBaseEffectWork)

function DiceHeroAddBuffWork:onStart(context)
	local targetId = self._effectMo.targetId
	local targetEntity = DiceHeroHelper.instance:getEntity(targetId)
	local delay = 0

	if not targetEntity then
		logError("找不到实体" .. targetId)
	else
		targetEntity:addOrUpdateBuff(self._effectMo.buff)

		if self._effectMo.buff.co.visible == 1 then
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

function DiceHeroAddBuffWork:_delayDone()
	self:onDone(true)
end

function DiceHeroAddBuffWork:clearWork()
	TaskDispatcher.cancelTask(self._delayDone, self)
end

return DiceHeroAddBuffWork
