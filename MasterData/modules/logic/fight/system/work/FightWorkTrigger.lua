-- chunkname: @modules/logic/fight/system/work/FightWorkTrigger.lua

module("modules.logic.fight.system.work.FightWorkTrigger", package.seeall)

local FightWorkTrigger = class("FightWorkTrigger", FightEffectBase)

function FightWorkTrigger:onStart()
	local effectNum = self.actEffectData.effectNum

	if self.actEffectData.configEffect == -1 and effectNum == 4150002 then
		local delay = false

		if self.fightStepData.actEffect then
			local sign = false

			for i, v in ipairs(self.fightStepData.actEffect) do
				if v == self.actEffectData then
					sign = i
					delay = true
				end
			end

			for i = sign + 1, #self.fightStepData.actEffect do
				local actEffectData = self.fightStepData.actEffect[i]

				if actEffectData.effectType == FightEnum.EffectType.TRIGGER and actEffectData.configEffect == -1 and actEffectData.effectNum == 4150002 then
					delay = false
				end
			end
		end

		if delay then
			self:cancelFightWorkSafeTimer()
			self:com_registTimer(self._yuranDelayDone, 0.3)
		else
			self:onDone(true)
		end

		return
	end

	local config = lua_trigger_action.configDict[effectNum]

	if config then
		local triggerClass = _G["FightWorkTrigger" .. config.actionType]

		if triggerClass then
			self:cancelFightWorkSafeTimer()

			self._work = triggerClass.New(self.fightStepData, self.actEffectData)

			self._work:registerDoneListener(self._onWorkDone, self)
			self._work:onStart(self.context)
		else
			self:onDone(true)
		end
	else
		logError("触发器行为表找不到id:" .. effectNum)
		self:onDone(true)
	end
end

function FightWorkTrigger:_yuranDelayDone()
	self:onDone(true)
end

function FightWorkTrigger:_onWorkDone()
	self:onDone(true)
end

function FightWorkTrigger:clearWork()
	if self._work then
		self._work:unregisterDoneListener(self._onWorkDone, self)
		self._work:onStop()

		self._work = nil
	end
end

return FightWorkTrigger
