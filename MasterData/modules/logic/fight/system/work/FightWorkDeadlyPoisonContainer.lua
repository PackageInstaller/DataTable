-- chunkname: @modules/logic/fight/system/work/FightWorkDeadlyPoisonContainer.lua

module("modules.logic.fight.system.work.FightWorkDeadlyPoisonContainer", package.seeall)

local FightWorkDeadlyPoisonContainer = class("FightWorkDeadlyPoisonContainer", FightStepEffectFlow)

FightWorkDeadlyPoisonContainer.existWrapDict = {}
FightWorkDeadlyPoisonContainer.targetDict = {}

function FightWorkDeadlyPoisonContainer:onStart()
	local effectType = self:getEffectType()
	local effectList = self.fightStepData.actEffect

	self.targetDict = {}

	for _, actEffectData in ipairs(effectList) do
		if not actEffectData:isDone() and effectType == actEffectData.effectType then
			self:addActEffectData(actEffectData)
		end
	end

	tabletool.clear(FightWorkDeadlyPoisonContainer.existWrapDict)

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

							if damageObj[2] and not FightWorkDeadlyPoisonContainer.existWrapDict[entityId] then
								local effectRes, handPoint = self:getEffectRes()
								local wrap = entity.effect:addHangEffect(effectRes, handPoint, nil, 1)

								FightRenderOrderMgr.instance:onAddEffectWrap(entityId, wrap)
								wrap:setLocalPos(0, 0, 0)

								FightWorkDeadlyPoisonContainer.existWrapDict[entityId] = true
							end
						end
					end
				end
			end
		end
	end

	self:onDone(true)
end

function FightWorkDeadlyPoisonContainer:getEffectRes()
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

function FightWorkDeadlyPoisonContainer:addActEffectData(actEffectData)
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
			actEffectData.effectNum,
			showEffect,
			actEffectData.effectNum1 == 1
		}
		seqList[index] = damageObj
	else
		damageObj[1] = damageObj[1] + actEffectData.effectNum

		if actEffectData.effectNum1 == 1 then
			damageObj[3] = true
		end
	end

	actEffectData:setDone()
end

function FightWorkDeadlyPoisonContainer:getEffectType()
	return FightEnum.EffectType.DEADLYPOISONORIGINDAMAGE
end

function FightWorkDeadlyPoisonContainer:getFloatType()
	return FightEnum.FloatType.damage_origin
end

return FightWorkDeadlyPoisonContainer
