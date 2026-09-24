-- chunkname: @modules/logic/autochess/main/flow/work/AutoChessPlayAttackWork.lua

module("modules.logic.autochess.main.flow.work.AutoChessPlayAttackWork", package.seeall)

local AutoChessPlayAttackWork = class("AutoChessPlayAttackWork", AutoChessBaseWork)

function AutoChessPlayAttackWork:onStart()
	local attackEntity = self.entityMgr:tryGetEntity(self.effect.fromId)
	local time = 0
	local damageType = tonumber(self.effect.effectNum)

	if damageType == AutoChessEnum.DamageType.Ranged then
		local effectId = AutoChessEnum.Tag2EffectId.Ranged
		local targetEntity = self.entityMgr:getEntity(self.effect.targetIds[1])

		if attackEntity and targetEntity then
			time = attackEntity:ranged(targetEntity.transform.position, effectId)
		end

		self:delayCall(self.playBeingAttack, time)
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

			self:delayCall(self.playBeingAttack, time)
		else
			self:playBeingAttack()
		end
	else
		if attackEntity then
			time = attackEntity:attack()
		end

		self:delayCall(self.playBeingAttack, time - 0.3)
	end
end

function AutoChessPlayAttackWork:playBeingAttack()
	self:delDelayFunc(self.playBeingAttack)

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

	self:delayCall(self.finishWork, 0.5)
end

return AutoChessPlayAttackWork
