-- chunkname: @modules/logic/autochess/main/flow/AutoChessDamageWork.lua

module("modules.logic.autochess.main.flow.AutoChessDamageWork", package.seeall)

local AutoChessDamageWork = class("AutoChessDamageWork", BaseWork)

function AutoChessDamageWork:ctor(effect, skillEffectId)
	self.effect = effect
	self.skillEffectId = skillEffectId
	self.entityMgr = AutoChessEntityMgr.instance
	self.attackEntity = self.entityMgr:tryGetEntity(self.effect.fromId)
end

function AutoChessDamageWork:onStart()
	local time = 0
	local damageType = tonumber(self.effect.effectNum)

	if damageType == AutoChessEnum.DamageType.Ranged then
		local effectId = AutoChessEnum.Tag2EffectId.Ranged
		local targetEntity = self.entityMgr:getEntity(self.effect.targetIds[1])

		if self.attackEntity and targetEntity then
			time = self.attackEntity:ranged(targetEntity.transform.position, effectId)
		end

		TaskDispatcher.runDelay(self.playBeingAttack, self, time)
	elseif damageType == AutoChessEnum.DamageType.Skill then
		if self.skillEffectId == 30015 then
			local entityA = self.entityMgr:tryGetEntity(self.effect.fromId)

			if entityA then
				for _, targetId in ipairs(self.effect.targetIds) do
					local entityB = self.entityMgr:tryGetEntity(targetId)

					if entityB then
						time = entityA:playEffect(self.skillEffectId, {
							flyPos = entityB.transform.position
						})
					end
				end
			end

			TaskDispatcher.runDelay(self.playBeingAttack, self, time)
		else
			self:playBeingAttack()
		end
	else
		if self.attackEntity then
			time = self.attackEntity:attack()
		end

		TaskDispatcher.runDelay(self.playBeingAttack, self, time - 0.3)
	end
end

function AutoChessDamageWork:playBeingAttack()
	local damageType = tonumber(self.effect.effectNum)

	if damageType == AutoChessEnum.DamageType.MeleeAoe then
		for k, targetId in ipairs(self.effect.targetIds) do
			local entity = self.entityMgr:getEntity(targetId)

			if entity then
				local effectId = k == 1 and 20001 or 20003

				entity:playEffect(effectId)
			end
		end
	else
		local effectId = self.skillEffectId == 30015 and 30016 or 20001

		for _, targetId in ipairs(self.effect.targetIds) do
			local entity = self.entityMgr:getEntity(targetId)

			if entity then
				entity:playEffect(effectId)
			end
		end
	end

	TaskDispatcher.runDelay(self.finishWork, self, 0.5)
end

function AutoChessDamageWork:onResume()
	self:finishWork()
end

function AutoChessDamageWork:clearWork()
	if self.hasClear then
		return
	end

	self.hasClear = true

	TaskDispatcher.cancelTask(self.playBeingAttack, self)
	TaskDispatcher.cancelTask(self.finishWork, self)

	self.effect = nil
end

function AutoChessDamageWork:finishWork()
	self:onDone(true)
end

function AutoChessDamageWork:onReset()
	return
end

return AutoChessDamageWork
