-- chunkname: @modules/logic/fight/entity/comp/skill/FightTLEventDefEffect.lua

module("modules.logic.fight.entity.comp.skill.FightTLEventDefEffect", package.seeall)

local FightTLEventDefEffect = class("FightTLEventDefEffect", FightTimelineTrackItem)
local TypeDefEffect = 8
local TypeHealEffect = 28
local EffectTypes = {
	[TypeDefEffect] = {
		[FightEnum.EffectType.MISS] = true,
		[FightEnum.EffectType.DAMAGE] = true,
		[FightEnum.EffectType.CRIT] = true,
		[FightEnum.EffectType.SHIELD] = true
	},
	[TypeHealEffect] = {
		[FightEnum.EffectType.HEAL] = true,
		[FightEnum.EffectType.HEALCRIT] = true
	}
}

function FightTLEventDefEffect:onTrackStart(fightStepData, duration, paramsArr)
	if self.type == TypeDefEffect and not FightHelper.detectTimelinePlayEffectCondition(fightStepData, paramsArr[8]) then
		return
	end

	self.fightStepData = fightStepData

	local effectName = paramsArr[1]

	if string.nilorempty(effectName) then
		local timeline = FightConfig.instance:getSkinSkillTimeline(nil, fightStepData.actId)

		logError("受击特效名字为空，检查一下技能的timeline：" .. (timeline or "nil"))

		return
	end

	if not string.nilorempty(paramsArr[10]) then
		local attacker = FightHelper.getEntity(self.fightStepData.fromId)
		local entityMO = attacker:getMO()
		local skinId = entityMO and entityMO.skin

		if skinId then
			local skinArr = string.split(paramsArr[10], "|")

			for i, v in ipairs(skinArr) do
				local arr = string.split(v, "#")

				if tonumber(arr[1]) == skinId then
					effectName = arr[2]

					break
				end
			end
		end
	end

	local hangPoint = paramsArr[2]
	local notHangCenter = paramsArr[3]
	local offsetX, offsetY, offsetZ = 0, 0, 0

	if paramsArr[4] then
		local arr = string.split(paramsArr[4], ",")

		offsetX = arr[1] and tonumber(arr[1]) or offsetX
		offsetY = arr[2] and tonumber(arr[2]) or offsetY
		offsetZ = arr[3] and tonumber(arr[3]) or offsetZ
	end

	local renderOrder = tonumber(paramsArr[5]) or -1

	self._act_on_index_entity = paramsArr[6] and tonumber(paramsArr[6])

	local dontSkillEffectIdStr = paramsArr[7]
	local needProcessTypes = EffectTypes[self.type]
	local _monster_scale_effect

	self._monster_scale_dic = nil

	local config = lua_skin_monster_scale.configDict[fightStepData.actId]

	if config then
		local effect_names = string.split(config.effectName, "#")

		for index, name in ipairs(effect_names) do
			if name == effectName then
				_monster_scale_effect = {}

				local arr = string.splitToNumber(config.monsterId, "#")

				for i, v in ipairs(arr) do
					_monster_scale_effect[v] = config.scale
				end

				break
			end
		end
	end

	for _, actEffectData in ipairs((self._act_on_index_entity or nil) and FightHelper.dealDirectActEffectData(self.fightStepData.actEffect, self._act_on_index_entity, EffectTypes[self.type])) do
		if needProcessTypes[actEffectData.effectType] and (self.type == TypeHealEffect or dontSkillEffectIdStr ~= tostring(actEffectData.configEffect)) then
			local oneDefender = FightHelper.getEntity(actEffectData.targetId)

			if oneDefender then
				local can_play_effect = not (self.type == TypeDefEffect and not FightHelper.detectTimelinePlayEffectCondition(fightStepData, paramsArr[8], oneDefender))

				if (actEffectData.effectType == FightEnum.EffectType.SHIELD and not FightHelper.checkShieldHit(actEffectData) or nil) and false and (not self._defenderEffectWrapDict or not self._defenderEffectWrapDict[oneDefender]) then
					if _monster_scale_effect and _monster_scale_effect[oneDefender:getMO().skin] then
						self._monster_scale_dic = {}
						self._monster_scale_dic[oneDefender.id] = _monster_scale_effect[oneDefender:getMO().skin]
					else
						local effectWrap = self:_createHitEffect(oneDefender, effectName, hangPoint, notHangCenter, offsetX, offsetY, offsetZ)

						self:_setRenderOrder(oneDefender.id, effectWrap, renderOrder)

						self._defenderEffectWrapDict = self._defenderEffectWrapDict or {}
						self._defenderEffectWrapDict[oneDefender] = effectWrap
					end
				end
			else
				logNormal("play defender effect fail, entity not exist: " .. actEffectData.targetId)
			end
		end
	end

	if self._monster_scale_dic then
		local combinative = false
		local tar_scale = 1

		for entity_id, scale in pairs(self._monster_scale_dic) do
			local tar_entity = FightHelper.getEntity(entity_id)

			tar_entity:setScale(scale)

			local entity_mo = tar_entity:getMO()

			if entity_mo then
				local skin_config = FightConfig.instance:getSkinCO(entity_mo.skin)

				if skin_config and skin_config.canHide == 1 then
					combinative = tar_entity
					tar_scale = scale

					break
				end
			end
		end

		if combinative then
			FightHelper.refreshCombinativeMonsterScaleAndPos(combinative, tar_scale)

			self._revert_combinative_position = combinative
		end
	end

	if not string.nilorempty(paramsArr[9]) then
		AudioMgr.instance:trigger(tonumber(paramsArr[9]))
	end
end

function FightTLEventDefEffect:onTrackEnd()
	self:_removeEffect()
end

function FightTLEventDefEffect:_createHitEffect(defender, effectName, hangPoint, notHangCenter, offsetX, offsetY, offsetZ)
	local attacker = FightHelper.getEntity(self.fightStepData.fromId)
	local effectWrap

	if not string.nilorempty(hangPoint) then
		effectWrap = defender.effect:addHangEffect(effectName, hangPoint, attacker:getSide())

		effectWrap:setLocalPos(offsetX, offsetY, offsetZ)
	else
		effectWrap = defender.effect:addGlobalEffect(effectName, attacker:getSide())

		local posX, posY, posZ

		if notHangCenter == "0" then
			posX, posY, posZ = FightHelper.getEntityWorldBottomPos(defender)
		elseif notHangCenter == "1" then
			posX, posY, posZ = FightHelper.getEntityWorldCenterPos(defender)
		elseif notHangCenter == "2" then
			posX, posY, posZ = FightHelper.getEntityWorldTopPos(defender)
		elseif notHangCenter == "3" then
			posX, posY, posZ = FightHelper.getProcessEntitySpinePos(defender)
		else
			local hangPointGO = not string.nilorempty(notHangCenter) and defender:getHangPoint(notHangCenter)

			if hangPointGO then
				local hangPointPosition = hangPointGO.transform.position

				posZ = hangPointPosition.z
				posY = hangPointPosition.y
				posX = hangPointPosition.x
			else
				posX, posY, posZ = FightHelper.getEntityWorldCenterPos(defender)
			end
		end

		if defender:isMySide() then
			if not -offsetX then
				local offsetX2 = offsetX

				effectWrap:setWorldPos(posX + offsetX2, posY + offsetY, posZ + offsetZ)
			end
		end
	end

	return effectWrap
end

function FightTLEventDefEffect:_setRenderOrder(entityId, effectWrap, renderOrder)
	if renderOrder == -1 then
		FightRenderOrderMgr.instance:onAddEffectWrap(entityId, effectWrap)
	else
		FightRenderOrderMgr.instance:setEffectOrder(effectWrap, renderOrder)
	end
end

function FightTLEventDefEffect:onDestructor()
	self:_removeEffect()
end

function FightTLEventDefEffect:_removeEffect()
	if self._defenderEffectWrapDict then
		for defender, effectWrap in pairs(self._defenderEffectWrapDict) do
			FightRenderOrderMgr.instance:onRemoveEffectWrap(defender.id, effectWrap)
			defender.effect:removeEffect(effectWrap)
		end

		self._defenderEffectWrapDict = nil
	end

	if self._monster_scale_dic then
		for entity_id, v in pairs(self._monster_scale_dic) do
			local tar_entity = FightHelper.getEntity(entity_id)

			if tar_entity then
				tar_entity:setScale(1)
			end
		end

		if self._revert_combinative_position then
			FightHelper.refreshCombinativeMonsterScaleAndPos(self._revert_combinative_position, 1)
		end
	end

	self._revert_combinative_position = nil
	self._monster_scale_dic = nil
end

return FightTLEventDefEffect
