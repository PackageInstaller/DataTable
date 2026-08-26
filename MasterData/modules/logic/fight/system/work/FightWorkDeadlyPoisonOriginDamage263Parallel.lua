-- chunkname: @modules/logic/fight/system/work/FightWorkDeadlyPoisonOriginDamage263Parallel.lua

module("modules.logic.fight.system.work.FightWorkDeadlyPoisonOriginDamage263Parallel", package.seeall)

local FightWorkDeadlyPoisonOriginDamage263Parallel = class("FightWorkDeadlyPoisonOriginDamage263Parallel", FightStepEffectFlow)

FightWorkDeadlyPoisonOriginDamage263Parallel.existWrapDict = {}
FightWorkDeadlyPoisonOriginDamage263Parallel.targetDict = {}

function FightWorkDeadlyPoisonOriginDamage263Parallel:onStart()
	local hurtEffect = self:getHurtEffect()
	local effectList = self.fightStepData.actEffect

	self.targetDict = {}

	for _, actEffectData in ipairs(effectList) do
		if not actEffectData:isDone() and actEffectData.effectType == FightEnum.EffectType.FIGHTHURTDETAIL and actEffectData.hurtInfo.hurtEffect == hurtEffect then
			self:addActEffectData(actEffectData)
		end
	end

	tabletool.clear(FightWorkDeadlyPoisonOriginDamage263Parallel.existWrapDict)

	for entityId, seqList in pairs(self.targetDict) do
		local entity = FightHelper.getEntity(entityId)

		if entity then
			local isMySide = entity:isMySide()

			for _, damageObj in pairs(seqList) do
				local damage = damageObj[1]

				if damage > 0 then
					if isMySide then
						if not -damage then
							local floatNum = damage

							FightFloatMgr.instance:float(entityId, self:getFloatType(), floatNum, nil, damageObj[3])

							if entity.nameUI then
								entity.nameUI:addHp(-damage)
							end

							FightController.instance:dispatchEvent(FightEvent.OnHpChange, entity, -damage)

							if damageObj[2] and not FightWorkDeadlyPoisonOriginDamage263Parallel.existWrapDict[entityId] then
								local effectRes, handPoint = self:getEffectRes()
								local wrap = entity.effect:addHangEffect(effectRes, handPoint, nil, 1)

								FightRenderOrderMgr.instance:onAddEffectWrap(entityId, wrap)
								wrap:setLocalPos(0, 0, 0)

								FightWorkDeadlyPoisonOriginDamage263Parallel.existWrapDict[entityId] = true
							end
						end
					end
				end
			end
		end
	end

	self:onDone(true)
end

function FightWorkDeadlyPoisonOriginDamage263Parallel:getEffectRes()
	local fromId = self.fightStepData.fromId

	if fromId then
		::label_2_0::

		local entityMo = FightDataHelper.entityMgr:getById(fromId)
		local skin = entityMo and entityMo.skin
		local co = skin and lua_fight_sp_effect_ddg.configDict[skin]
		local effectRes = "v2a3_ddg/ddg_innate_02"
		local hangPoint = ModuleEnum.SpineHangPointRoot

		if co then
			effectRes = co.posionEffect
			hangPoint = co.posionHang
		end

		return effectRes, hangPoint
	end
end

function FightWorkDeadlyPoisonOriginDamage263Parallel:addActEffectData(actEffectData)
	local entityId = actEffectData.targetId
	local seqList = self.targetDict[entityId]

	if not seqList then
		seqList = {}
		self.targetDict[entityId] = seqList
	end

	local index = tonumber(actEffectData.reserveId)
	local showEffect = not string.nilorempty(actEffectData.reserveStr)
	local damageObj = seqList[index]

	if not damageObj then
		damageObj = {
			actEffectData.hurtInfo.damage,
			showEffect,
			actEffectData.hurtInfo.assassinate
		}
		seqList[index] = damageObj
	else
		damageObj[1] = damageObj[1] + actEffectData.hurtInfo.damage

		if actEffectData.hurtInfo.assassinate then
			damageObj[3] = true
		end
	end

	actEffectData:setDone()
end

function FightWorkDeadlyPoisonOriginDamage263Parallel:getHurtEffect()
	return FightEnum.EffectType.DEADLYPOISONORIGINDAMAGE
end

function FightWorkDeadlyPoisonOriginDamage263Parallel:getFloatType()
	return FightEnum.FloatType.damage_origin
end

return FightWorkDeadlyPoisonOriginDamage263Parallel
