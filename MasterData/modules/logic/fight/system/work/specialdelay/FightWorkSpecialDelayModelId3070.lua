-- chunkname: @modules/logic/fight/system/work/specialdelay/FightWorkSpecialDelayModelId3070.lua

module("modules.logic.fight.system.work.specialdelay.FightWorkSpecialDelayModelId3070", package.seeall)

local FightWorkSpecialDelayModelId3070 = class("FightWorkSpecialDelayModelId3070", UserDataDispose)

function FightWorkSpecialDelayModelId3070:ctor(parentClass, fightStepData)
	self:__onInit()

	self._parentClass = parentClass
	self.fightStepData = fightStepData

	self:onStart()
end

local delayTime = 0.4
local delayTime1 = 0.45

function FightWorkSpecialDelayModelId3070:onStart()
	if self.fightStepData.actType == FightEnum.ActType.SKILL then
		local entity = FightHelper.getEntity(self.fightStepData.fromId)
		local entityMO = entity and entity:getMO()

		if entityMO then
			local counter = 0
			local maxNum

			for i, v in ipairs(self.fightStepData.actEffect) do
				if v.effectType == FightEnum.EffectType.BUFFADD and v.buff then
					local buffConfig = lua_skill_buff.configDict[v.buff.buffId]

					if buffConfig and FightEntitySpecialEffect3070_Ball.buffTypeId2EffectPath[buffConfig.typeId] then
						counter = counter + 1

						local buffTypeConfig = lua_skill_bufftype.configDict[buffConfig.typeId]

						maxNum = maxNum or tonumber(string.split(buffTypeConfig.includeTypes, "#")[2])
					end
				end
			end

			if counter > 0 then
				local num = math.min(counter, maxNum)

				TaskDispatcher.runDelay(self._delay, self, delayTime1 + delayTime * num / FightModel.instance:getSpeed())

				return
			end
		end
	end

	self:_delay()
end

function FightWorkSpecialDelayModelId3070:_delay()
	self._parentClass:_delayDone()
end

function FightWorkSpecialDelayModelId3070:releaseSelf()
	TaskDispatcher.cancelTask(self._delay, self)
	self:__onDispose()
end

return FightWorkSpecialDelayModelId3070
