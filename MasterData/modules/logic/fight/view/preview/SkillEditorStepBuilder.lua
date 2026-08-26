-- chunkname: @modules/logic/fight/view/preview/SkillEditorStepBuilder.lua

module("modules.logic.fight.view.preview.SkillEditorStepBuilder", package.seeall)

local SkillEditorStepBuilder = class("SkillEditorStepBuilder")
local enableLog = false

function SkillEditorStepBuilder.buildFightStepDataList(skillId, attackerId, targetId)
	local side = FightHelper.getEntity(attackerId):getSide()

	if side == FightEnum.EntitySide.MySide then
		if not FightEnum.EntitySide.EnemySide then
			local oppositeSide = FightEnum.EntitySide.MySide
			local fightStepData = FightStepData.New(FightDef_pb.FightStep())

			fightStepData.editorPlaySkill = true
			fightStepData.actType = 1
			fightStepData.fromId = attackerId
			fightStepData.toId = targetId
			fightStepData.actId = skillId

			local skillCO = lua_skill.configDict[skillId]

			if enableLog then
				SkillEditorStepBuilder._logBehavior(skillCO)
			end

			local randomTargetId

			if skillCO.damageRate > 0 then
				randomTargetId = SkillEditorStepBuilder._buildDamage(skillCO, fightStepData, attackerId, targetId, side, oppositeSide)
			end

			SkillEditorStepBuilder._buildSkillEffectHealOrDmg(skillCO, fightStepData, attackerId, targetId, side, oppositeSide, randomTargetId)
			SkillEditorStepBuilder._buildBehaviorBuffs(skillCO, fightStepData.actEffect, attackerId, targetId, side, oppositeSide, randomTargetId)
			SkillEditorStepBuilder._checkRemoveBuffs(skillCO, fightStepData.actEffect, attackerId, targetId, side, oppositeSide, randomTargetId)
			SkillEditorStepBuilder._buildSummoned(skillCO, fightStepData.actEffect, attackerId, targetId, side, oppositeSide, randomTargetId)
			SkillEditorStepBuilder._buildMagicCircle(skillCO, fightStepData.actEffect, attackerId, targetId, side, oppositeSide, randomTargetId)
			SkillEditorStepBuilder._checkRegainPowerAfterAct(skillCO, fightStepData.actEffect, attackerId, targetId, side, oppositeSide)

			local fightStepDataList = {
				fightStepData
			}
			local addPowerStepData = SkillEditorStepBuilder._checkBuildAddPowerStep(skillCO, fightStepData.actEffect, attackerId, targetId, side, oppositeSide)

			if addPowerStepData then
				table.insert(fightStepDataList, addPowerStepData)
			end

			return fightStepDataList
		end
	end
end

function SkillEditorStepBuilder._logBehavior(skillCO)
	for i = 1, FightEnum.MaxBehavior do
		local behavior = skillCO["behavior" .. i]
		local conditionTarget = skillCO["conditionTarget" .. i]
		local behaviorTarget = skillCO["behaviorTarget" .. i]

		if not string.nilorempty(behavior) then
			local condition = skillCO["condition" .. i]
			local behaviorStr = ""
			local conditionStr = ""

			if not string.nilorempty(behavior) then
				local behaviorId = string.splitToNumber(behavior, "#")[1]
				local behaviorCO = behaviorId and lua_skill_behavior.configDict[behaviorId]

				if behaviorCO then
					if not behaviorCO.type then
						local behaviorType = ""

						behaviorStr = "behavior: " .. behavior .. " " .. behaviorType
					end
				end
			end

			if not string.nilorempty(condition) then
				local conditionId = string.splitToNumber(condition, "#")[1]
				local conditionCO = conditionId and lua_skill_behavior_condition.configDict[conditionId]

				if conditionCO then
					if not conditionCO.type then
						local conditionType = ""

						conditionStr = "condition: " .. condition .. " " .. conditionType
					end
				end
			end

			logError("\n" .. behaviorStr .. "    " .. conditionStr .. "    condTarget_" .. conditionTarget .. "    behaTarget_" .. behaviorTarget)
		end
	end
end

function SkillEditorStepBuilder._buildDamage(skillCO, fightStepData, attackerId, targetId, side, oppositeSide)
	local randomTargetId
	local ET = FightEnum.EffectType

	if FightEnum.LogicTargetClassify.Special[skillCO.logicTarget] then
		logError(skillCO.id .. " 未能正确构建技能步骤，技能对象未实现：" .. skillCO.logicTarget)
	elseif FightEnum.LogicTargetClassify.Single[skillCO.logicTarget] then
		local et, num = SkillEditorStepBuilder._getDmgTypeAndNum(ET.DAMAGE)

		SkillEditorStepBuilder._buildActEffect(fightStepData.actEffect, targetId, et, num, side)
	elseif FightEnum.LogicTargetClassify.SingleAndRandom[skillCO.logicTarget] then
		local isAttack = skillCO.targetLimit == FightEnum.TargetLimit.EnemySide
		local et, num = SkillEditorStepBuilder._getDmgTypeAndNum(ET.DAMAGE)

		SkillEditorStepBuilder._buildActEffect(fightStepData.actEffect, targetId, et, num, side)

		local entityList = FightHelper.getSideEntitys(isAttack and oppositeSide or side)

		for i, entity in ipairs(entityList) do
			if entity.id == targetId then
				table.remove(entityList, i)

				break
			end
		end

		if #entityList > 0 then
			local randomIndex = math.random(#entityList)
			local randomEntity = entityList[randomIndex]

			et, num = SkillEditorStepBuilder._getDmgTypeAndNum(ET.DAMAGE)

			SkillEditorStepBuilder._buildActEffect(fightStepData.actEffect, randomEntity.id, et, num, side)

			randomTargetId = randomEntity.id
		end
	elseif FightEnum.LogicTargetClassify.EnemySideAll[skillCO.logicTarget] then
		local defMOList = FightDataHelper.entityMgr:getNormalList(oppositeSide)

		for _, entityMO in ipairs(defMOList) do
			local et, num = SkillEditorStepBuilder._getDmgTypeAndNum(ET.DAMAGE)

			SkillEditorStepBuilder._buildActEffect(fightStepData.actEffect, entityMO.id, et, num, side)
		end
	elseif FightEnum.LogicTargetClassify.EnemySideindex[skillCO.logicTarget] then
		local index = tonumber(skillCO.logicTarget) - 225
		local defMOList = FightDataHelper.entityMgr:getNormalList(oppositeSide)

		table.sort(defMOList, function(item1, item2)
			return item1.position < item2.position
		end)

		for entityIndex, entityMO in ipairs(defMOList) do
			if entityIndex == index then
				local et, num = SkillEditorStepBuilder._getDmgTypeAndNum(ET.DAMAGE)

				SkillEditorStepBuilder._buildActEffect(fightStepData.actEffect, entityMO.id, et, num, side)
			end
		end
	elseif FightEnum.LogicTargetClassify.MySideAll[skillCO.logicTarget] then
		local atkMOList = FightDataHelper.entityMgr:getNormalList(side)

		for _, entityMO in ipairs(atkMOList) do
			local et, num = SkillEditorStepBuilder._getDmgTypeAndNum(ET.DAMAGE)

			SkillEditorStepBuilder._buildActEffect(fightStepData.actEffect, entityMO.id, et, num, side)
		end
	elseif FightEnum.LogicTargetClassify.Me[skillCO.logicTarget] then
		local et, num = SkillEditorStepBuilder._getDmgTypeAndNum(ET.DAMAGE)

		SkillEditorStepBuilder._buildActEffect(fightStepData.actEffect, attackerId, et, num, side)
	elseif FightEnum.LogicTargetClassify.EnemyMostHp[skillCO.logicTarget] then
		local defMOList = FightDataHelper.entityMgr:getNormalList(oppositeSide)
		local tar_entity_mo
		local max_num = 0

		for _, entityMO in ipairs(defMOList) do
			if max_num < entityMO.currentHp then
				max_num = entityMO.currentHp
				tar_entity_mo = entityMO
			end
		end

		if tar_entity_mo then
			local et, num = SkillEditorStepBuilder._getDmgTypeAndNum(ET.DAMAGE)

			SkillEditorStepBuilder._buildActEffect(fightStepData.actEffect, tar_entity_mo.id, et, num, side)
		end
	elseif FightEnum.LogicTargetClassify.EnemyWith101Buff[skillCO.logicTarget] then
		local defMOList = FightDataHelper.entityMgr:getNormalList(oppositeSide)

		for _, entityMO in ipairs(defMOList) do
			local buffs = entityMO:getBuffList()
			local has101Buff = false

			for _, buffMO in ipairs(buffs) do
				local buffCO = lua_skill_buff.configDict[buffMO.buffId]

				if buffCO and not string.nilorempty(buffCO.features) then
					local featureSp = GameUtil.splitString2(buffCO.features, true)

					for _, oneFeatureSp in ipairs(featureSp) do
						local featureId = oneFeatureSp[1]
						local buffActCO1 = featureId and lua_buff_act.configDict[featureId]
						local feature = buffActCO1 and buffActCO1.type

						if feature == "MonsterLabel" and oneFeatureSp[2] == 101 then
							has101Buff = true

							break
						end
					end
				end

				if has101Buff then
					break
				end
			end

			if has101Buff then
				local et, num = SkillEditorStepBuilder._getDmgTypeAndNum(ET.DAMAGE)

				SkillEditorStepBuilder._buildActEffect(fightStepData.actEffect, entityMO.id, et, num, side)
			end
		end
	elseif FightEnum.LogicTargetClassify.EnemyWith795Feature[skillCO.logicTarget] then
		local defMOList = FightDataHelper.entityMgr:getNormalList(oppositeSide)
		local featureEntityList = {}

		for _, entityMO in ipairs(defMOList) do
			if entityMO:hasBuffFeature(FightEnum.BuffFeature.None) then
				table.insert(featureEntityList, entityMO)
			end
		end

		if #featureEntityList > 0 then
			local index = math.random(1, #featureEntityList)
			local et, num = SkillEditorStepBuilder._getDmgTypeAndNum(ET.DAMAGE)

			SkillEditorStepBuilder._buildActEffect(fightStepData.actEffect, featureEntityList[index].id, et, num, side)
		else
			local index = math.random(1, #defMOList)
			local et, num = SkillEditorStepBuilder._getDmgTypeAndNum(ET.DAMAGE)

			SkillEditorStepBuilder._buildActEffect(fightStepData.actEffect, defMOList[index].id, et, num, side)
		end
	elseif skillCO.logicTarget == "245" then
		local defMOList = FightDataHelper.entityMgr:getNormalList(oppositeSide)

		for _, entityMO in ipairs(defMOList) do
			for k, buffData in pairs(entityMO.buffDic) do
				local buffConfig = lua_skill_buff.configDict[buffData.buffId]

				if buffConfig and buffConfig.typeId == 31320113 then
					local et, num = SkillEditorStepBuilder._getDmgTypeAndNum(ET.DAMAGE)

					SkillEditorStepBuilder._buildActEffect(fightStepData.actEffect, entityMO.id, et, num, side)

					return entityMO.id
				end
			end
		end

		for _, entityMO in ipairs(defMOList) do
			if FightHelper.checkIsBossByMonsterId(entityMO.modelId) then
				local et, num = SkillEditorStepBuilder._getDmgTypeAndNum(ET.DAMAGE)

				SkillEditorStepBuilder._buildActEffect(fightStepData.actEffect, entityMO.id, et, num, side)

				return entityMO.id
			end
		end

		table.sort(defMOList, function(item1, item2)
			return item1.currentHp < item2.currentHp
		end)

		local et, num = SkillEditorStepBuilder._getDmgTypeAndNum(ET.DAMAGE)

		SkillEditorStepBuilder._buildActEffect(fightStepData.actEffect, defMOList[1].id, et, num, side)

		return defMOList[1].id
	elseif string.sub(skillCO.logicTarget, 1, 4) == "247#" then
		local arr = string.split(skillCO.logicTarget, "#")
		local buffTypeId = tonumber(arr[2])
		local defMOList = FightDataHelper.entityMgr:getNormalList(oppositeSide)

		for _, entityMO in ipairs(defMOList) do
			for k, buffData in pairs(entityMO.buffDic) do
				local buffConfig = lua_skill_buff.configDict[buffData.buffId]

				if buffConfig and buffConfig.typeId == buffTypeId then
					local et, num = SkillEditorStepBuilder._getDmgTypeAndNum(ET.DAMAGE)

					SkillEditorStepBuilder._buildActEffect(fightStepData.actEffect, entityMO.id, et, num, side)

					return entityMO.id
				end
			end
		end

		for _, entityMO in ipairs(defMOList) do
			if FightHelper.checkIsBossByMonsterId(entityMO.modelId) then
				local et, num = SkillEditorStepBuilder._getDmgTypeAndNum(ET.DAMAGE)

				SkillEditorStepBuilder._buildActEffect(fightStepData.actEffect, entityMO.id, et, num, side)

				return entityMO.id
			end
		end

		table.sort(defMOList, function(item1, item2)
			return item1.currentHp < item2.currentHp
		end)

		local et, num = SkillEditorStepBuilder._getDmgTypeAndNum(ET.DAMAGE)

		SkillEditorStepBuilder._buildActEffect(fightStepData.actEffect, defMOList[1].id, et, num, side)

		return defMOList[1].id
	end

	return randomTargetId
end

local filterDamgeKey = {
	ConsumeBuffUpSkillDamageRate = true
}

function SkillEditorStepBuilder._buildSkillEffectHealOrDmg(skillCO, fightStepData, attackerId, targetId, side, oppositeSide, randomTargetId)
	local ET_HEAL = FightEnum.EffectType.HEAL
	local ET_DAMAGE = FightEnum.EffectType.DAMAGE
	local ET_ORIGINDAMAGE = FightEnum.EffectType.ORIGINDAMAGE
	local ET_ADDITIONALDAMAGE = FightEnum.EffectType.ADDITIONALDAMAGE

	for i = 1, FightEnum.MaxBehavior do
		local behavior = skillCO["behavior" .. i]
		local condition = skillCO["condition" .. i]
		local conditionTarget = skillCO["conditionTarget" .. i]
		local condSatisfy = SkillEditorStepBuilder._checkBehaviorCondition(condition, conditionTarget, attackerId, targetId)

		if not string.nilorempty(behavior) and condSatisfy then
			local spRes = string.splitToNumber(behavior, "#")
			local behaviorId = spRes[1]
			local behaviorCO = behaviorId and lua_skill_behavior.configDict[behaviorId]

			if behaviorCO then
				local behaviorTarget = skillCO["behaviorTarget" .. i]
				local conditionTarget = skillCO["conditionTarget" .. i]
				local logicTarget = behaviorTarget

				if behaviorTarget == "0" then
					logicTarget = skillCO.logicTarget
				elseif behaviorTarget == "999" then
					logicTarget = conditionTarget ~= "0" and conditionTarget or skillCO.logicTarget
				end

				if string.find(string.lower(behaviorCO.type), "origindamage") then
					SkillEditorStepBuilder._buildOneSkillEffectHealOrDmg(skillCO, i, behaviorId, logicTarget, ET_ORIGINDAMAGE, fightStepData, attackerId, targetId, side, oppositeSide, randomTargetId)
				elseif string.find(string.lower(behaviorCO.type), "additionaldamage") then
					SkillEditorStepBuilder._buildOneSkillEffectHealOrDmg(skillCO, i, behaviorId, logicTarget, ET_ADDITIONALDAMAGE, fightStepData, attackerId, targetId, side, oppositeSide, randomTargetId)
				elseif string.find(string.lower(behaviorCO.type), "heal") then
					SkillEditorStepBuilder._buildOneSkillEffectHealOrDmg(skillCO, i, behaviorId, logicTarget, ET_HEAL, fightStepData, attackerId, targetId, side, oppositeSide, randomTargetId)
				elseif (string.find(string.lower(behaviorCO.type), "damage") or string.find(string.lower(behaviorCO.type), "lostlife")) and not filterDamgeKey[behaviorCO.type] then
					SkillEditorStepBuilder._buildOneSkillEffectHealOrDmg(skillCO, i, behaviorId, logicTarget, ET_DAMAGE, fightStepData, attackerId, targetId, side, oppositeSide, randomTargetId)
				end
			end
		end
	end
end

function SkillEditorStepBuilder._buildOneSkillEffectHealOrDmg(skillCO, behaviorIndex, behaviorId, logicTarget, effectType, fightStepData, attackerId, targetId, side, oppositeSide, randomTargetId)
	local targetIds = SkillEditorStepBuilder._getBehaviorTargetIds(fightStepData.actEffect, skillCO, behaviorIndex, attackerId, targetId, side, oppositeSide, randomTargetId)
	local et, num = SkillEditorStepBuilder._getDmgTypeAndNum(effectType)

	for _, targetId in ipairs(targetIds) do
		SkillEditorStepBuilder._buildActEffect(fightStepData.actEffect, targetId, et, num, side).configEffect = behaviorId
	end
end

SkillEditorStepBuilder.customDamage = nil
SkillEditorStepBuilder.defaultDamage = 1234
SkillEditorStepBuilder.defaultCrit = 2468

function SkillEditorStepBuilder._getDmgTypeAndNum(effectType)
	local t = effectType
	local isCritOn = SkillEditorSideView.isCrit

	if effectType == FightEnum.EffectType.ORIGINDAMAGE then
		t = isCritOn and FightEnum.EffectType.ORIGINCRIT or FightEnum.EffectType.ORIGINDAMAGE
	elseif effectType == FightEnum.EffectType.ADDITIONALDAMAGE then
		t = isCritOn and FightEnum.EffectType.ADDITIONALDAMAGECRIT or FightEnum.EffectType.ADDITIONALDAMAGE
	elseif effectType == FightEnum.EffectType.DAMAGE then
		t = isCritOn and FightEnum.EffectType.CRIT or FightEnum.EffectType.DAMAGE
	elseif effectType == FightEnum.EffectType.HEAL then
		t = isCritOn and FightEnum.EffectType.HEALCRIT or FightEnum.EffectType.HEAL
	end

	return t, SkillEditorStepBuilder.customDamage and SkillEditorStepBuilder.customDamage or isCritOn and SkillEditorStepBuilder.defaultCrit or SkillEditorStepBuilder.defaultDamage
end

local DirectDamageType = {
	[FightEnum.EffectType.MISS] = true,
	[FightEnum.EffectType.DAMAGE] = true,
	[FightEnum.EffectType.CRIT] = true,
	[FightEnum.EffectType.HEAL] = true,
	[FightEnum.EffectType.SHIELD] = true
}

function SkillEditorStepBuilder._buildActEffect(actEffect, targetId, effectType, effectNum, fromSide)
	local actEffectData = FightActEffectData.New()

	actEffectData.targetId = targetId
	actEffectData.effectType = effectType
	actEffectData.effectNum = effectNum
	actEffectData.fromSide = fromSide

	if DirectDamageType[effectType] then
		actEffectData.configEffect = FightEnum.DirectDamageType
	end

	table.insert(actEffect, actEffectData)

	local targetEntityMO = FightDataHelper.entityMgr:getById(targetId)

	if effectType == FightEnum.EffectType.DAMAGE or effectType == FightEnum.EffectType.CRIT or effectType == FightEnum.EffectType.ORIGINDAMAGE or effectType == FightEnum.EffectType.ORIGINCRIT or effectType == FightEnum.EffectType.ADDITIONALDAMAGE or effectType == FightEnum.EffectType.ADDITIONALDAMAGECRIT then
		local hurtInfo = FightHurtInfoData.New(FightDef_pb.FightHurtInfo())

		actEffectData.hurtInfo = hurtInfo
		hurtInfo.damage = effectNum
		hurtInfo.reduceHp = -effectNum

		if targetEntityMO.shieldValue > 0 then
			local absorbHurtParam = {}
			local shieldOffset = Mathf.Clamp(targetEntityMO.shieldValue - effectNum, 0, targetEntityMO.shieldValue)

			absorbHurtParam.reduceShieldBuffMap = "1#" .. shieldOffset
			hurtInfo.reduceHp = effectNum < targetEntityMO.shieldValue and 0 or effectNum - targetEntityMO.shieldValue

			if effectNum >= targetEntityMO.shieldValue then
				local delShieldActEffectData = FightActEffectData.New()

				delShieldActEffectData.targetId = targetId
				delShieldActEffectData.effectType = FightEnum.EffectType.SHIELDDEL
				delShieldActEffectData.effectNum = 0
				delShieldActEffectData.fromSide = fromSide
				delShieldActEffectData.configEffect = 0

				table.insert(actEffect, delShieldActEffectData)

				local buffDic = targetEntityMO:getBuffDic()

				for _, buffMO in pairs(buffDic) do
					local buffCO = lua_skill_buff.configDict[buffMO.buffId]

					if buffCO and not string.nilorempty(buffCO.features) then
						local featureSp = GameUtil.splitString2(buffCO.features, true)

						for _, oneFeatureSp in ipairs(featureSp) do
							local featureId = oneFeatureSp[1]
							local buffActCO1 = featureId and lua_buff_act.configDict[featureId]
							local feature = buffActCO1 and buffActCO1.type

							if feature == "Shield" then
								local delShieldBuffActEffectData = FightActEffectData.New()

								delShieldBuffActEffectData.targetId = buffMO.entityId
								delShieldBuffActEffectData.effectType = FightEnum.EffectType.BUFFDEL
								delShieldBuffActEffectData.effectNum = 0
								delShieldBuffActEffectData.buff = buffMO
								delShieldBuffActEffectData.configEffect = 0

								table.insert(actEffect, delShieldBuffActEffectData)

								break
							end
						end
					end
				end
			end
		end
	end

	return actEffectData
end

local addBuffs = {}

function SkillEditorStepBuilder._buildBehaviorBuffs(skillCO, actEffect, attackerId, targetId, side, oppositeSide, randomTargetId)
	addBuffs = {}

	for i = 1, FightEnum.MaxBehavior do
		local behavior = skillCO["behavior" .. i]
		local condition = skillCO["condition" .. i]
		local conditionTarget = skillCO["conditionTarget" .. i]
		local condSatisfy = SkillEditorStepBuilder._checkBehaviorCondition(condition, conditionTarget, attackerId, targetId)

		if not string.nilorempty(behavior) and condSatisfy then
			local spRes = string.splitToNumber(behavior, "#")

			if spRes[1] == 1 then
				local buffId = spRes[2]

				if not spRes[3] then
					local count = 1
					local targetIds = SkillEditorStepBuilder._getBehaviorTargetIds(actEffect, skillCO, i, attackerId, targetId, side, oppositeSide, randomTargetId)

					SkillEditorStepBuilder._buildOneBehaviorBuffs(skillCO, actEffect, buffId, count, targetIds, attackerId, targetId, side)
				end
			elseif spRes[1] == 20021 or spRes[1] == 20022 or spRes[1] == 20023 then
				local buffCO = lua_skill_buff.configDict[spRes[2]]

				if buffCO then
					local buffIds = string.split(buffCO.features, "#")

					if not spRes[3] then
						local count = 1

						for _ = 1, count do
							local random = math.random(1, #buffIds)
							local buffId = table.remove(buffIds, random)

							buffId = string.splitToNumber(buffId, ",")[1]

							local targetIds = SkillEditorStepBuilder._getBehaviorTargetIds(actEffect, skillCO, i, attackerId, targetId, side, oppositeSide, randomTargetId)

							SkillEditorStepBuilder._buildOneBehaviorBuffs(skillCO, actEffect, buffId, 1, targetIds, attackerId, targetId, side)
						end
					end
				else
					logError("buff config not exist: " .. spRes[2])
				end
			end
		end
	end
end

function SkillEditorStepBuilder._buildOneBehaviorBuffs(skillCO, actEffect, buffId, count, targetIds, attackerId, targetId, side)
	for _, oneTargetId in ipairs(targetIds) do
		for i = 1, count do
			local buffCO = lua_skill_buff.configDict[buffId]
			local existBuffMO = SkillEditorStepBuilder._getExistBuffMO(oneTargetId, buffId)
			local buffProto = FightDef_pb.BuffInfo()

			buffProto.buffId = buffId

			if existBuffMO then
				buffProto.duration = existBuffMO.duration + buffCO.duringTime or buffCO.duringTime
			end

			if existBuffMO then
				buffProto.count = existBuffMO.count + buffCO.effectCount or buffCO.effectCount
			end

			if existBuffMO then
				buffProto.uid = existBuffMO.uid or SkillEditorBuffSelectView.genBuffUid()
			end

			if existBuffMO then
				buffProto.fromUid = existBuffMO.fromUid or attackerId
			end

			local buffMO = FightBuffInfoData.New(buffProto, oneTargetId)
			local actEffectData = FightActEffectData.New()

			actEffectData.targetId = oneTargetId

			if existBuffMO then
				actEffectData.effectType = FightEnum.EffectType.BUFFUPDATE or FightEnum.EffectType.BUFFADD
			end

			actEffectData.effectNum = 1
			actEffectData.fromSide = side
			actEffectData.buff = buffMO

			table.insert(addBuffs, buffMO)
			table.insert(actEffect, actEffectData)
			SkillEditorStepBuilder._buildBuffShield(buffMO, actEffect, attackerId, targetId, side)
		end
	end
end

function SkillEditorStepBuilder._getExistBuffMO(targetId, buffId)
	local entity = FightHelper.getEntity(targetId)

	if not entity then
		return
	end

	local buffCO = lua_skill_buff.configDict[buffId]
	local buffTypeCO = buffCO and lua_skill_bufftype.configDict[buffCO.typeId]
	local includeTypes = buffTypeCO and buffTypeCO.includeTypes
	local includeType = includeTypes and string.splitToNumber(includeTypes, "#")[1]

	if not includeType then
		return
	end

	local entityBuffs = entity:getMO():getBuffList()

	if includeType == 2 or includeType == 10 or includeType == 11 or includeType == 12 then
		for i = #addBuffs, 1, -1 do
			local addBuffMO = addBuffs[i]

			if addBuffMO.entityId == targetId and addBuffMO.buffId == buffId then
				return addBuffMO
			end
		end

		for _, buffMO in ipairs(entityBuffs) do
			if buffMO.buffId == buffId then
				return buffMO
			end
		end
	end
end

function SkillEditorStepBuilder._buildBuffShield(buffMO, actEffect, attackerId, targetId, side)
	local buffCO = lua_skill_buff.configDict[buffMO.buffId]

	if buffCO and not string.nilorempty(buffCO.features) then
		local featureSp = GameUtil.splitString2(buffCO.features, true)

		for _, oneFeatureSp in ipairs(featureSp) do
			local featureId = oneFeatureSp[1]
			local buffActCO1 = featureId and lua_buff_act.configDict[featureId]
			local feature = buffActCO1 and buffActCO1.type

			if feature == "Shield" then
				local percent = (tonumber(oneFeatureSp[4]) or 1000) * 0.001
				local actEffectData = FightActEffectData.New()

				actEffectData.targetId = buffMO.entityId
				actEffectData.effectType = FightEnum.EffectType.SHIELD

				local targetEntity = FightHelper.getEntity(targetId)

				actEffectData.effectNum = targetEntity and math.ceil(percent * targetEntity:getMO().attrMO.hp) or 100
				actEffectData.fromSide = side

				table.insert(actEffect, actEffectData)
			end
		end
	end
end

function SkillEditorStepBuilder._checkRemoveBuffs(skillCO, actEffect, attackerId, targetId, side, oppositeSide, randomTargetId)
	SkillEditorStepBuilder._checkRemoveBuff(skillCO, actEffect, attackerId, targetId, side, oppositeSide, randomTargetId)
	SkillEditorStepBuilder._checkRemove3070Buff1(skillCO, actEffect, attackerId, targetId, side, oppositeSide)
	SkillEditorStepBuilder._checkRemove3070Buff2(skillCO, actEffect, attackerId, targetId, side, oppositeSide)
end

function SkillEditorStepBuilder._checkRemoveBuff(skillCO, actEffect, attackerId, targetId, side, oppositeSide, randomTargetId)
	for i = 1, FightEnum.MaxBehavior do
		local behavior = skillCO["behavior" .. i]
		local condition = skillCO["condition" .. i]
		local conditionTarget = skillCO["conditionTarget" .. i]
		local condSatisfy = SkillEditorStepBuilder._checkBehaviorCondition(condition, conditionTarget, attackerId, targetId)

		if not string.nilorempty(behavior) and condSatisfy then
			local spRes = string.splitToNumber(behavior, "#")
			local behaviorId = spRes[1]
			local effectTargetIds = SkillEditorStepBuilder._getBehaviorTargetIds(actEffect, skillCO, i, attackerId, targetId, side, oppositeSide, randomTargetId)
			local behaviorCO = behaviorId and lua_skill_behavior.configDict[behaviorId]

			if behaviorCO and string.find(behaviorCO.type, "Disperse") == 1 then
				for _, effectTargetId in ipairs(effectTargetIds) do
					local entityMO = FightDataHelper.entityMgr:getById(effectTargetId)

					for _, buffMO in pairs(entityMO:getBuffDic()) do
						local buffCO = lua_skill_buff.configDict[buffMO.buffId]

						if buffCO.isGoodBuff == 1 then
							local actEffectData = FightActEffectData.New()

							actEffectData.targetId = entityMO.id
							actEffectData.effectType = FightEnum.EffectType.BUFFDEL
							actEffectData.buff = buffMO

							table.insert(actEffect, 1, actEffectData)
						end
					end
				end
			end

			if behaviorCO and string.find(behaviorCO.type, "Purify") == 1 then
				for _, effectTargetId in ipairs(effectTargetIds) do
					local entityMO = FightDataHelper.entityMgr:getById(effectTargetId)

					for _, buffMO in pairs(entityMO:getBuffDic()) do
						local buffCO = lua_skill_buff.configDict[buffMO.buffId]

						if buffCO.isGoodBuff == 2 then
							local actEffectData = FightActEffectData.New()

							actEffectData.targetId = entityMO.id
							actEffectData.effectType = FightEnum.EffectType.BUFFDEL
							actEffectData.buff = buffMO

							table.insert(actEffect, 1, actEffectData)
						end
					end
				end
			end
		end
	end
end

function SkillEditorStepBuilder._checkRemove3070Buff1(skillCO, actEffect, attackerId, targetId, side, oppositeSide)
	local entityMO = FightDataHelper.entityMgr:getById(attackerId)

	if entityMO.modelId ~= 3070 or FightCardDataHelper.isBigSkill(skillCO.id) then
		return
	end

	local entityMO = FightDataHelper.entityMgr:getById(attackerId)
	local existBallCount = 0
	local addBallCount = 0
	local allBallBuffMOs = {}
	local existBallBuffMOs = {}

	for _, buffMO in pairs(entityMO:getBuffDic()) do
		local buffCO = lua_skill_buff.configDict[buffMO.buffId]

		if FightEntitySpecialEffect3070_Ball.buffTypeId2EffectPath[buffCO.typeId] then
			existBallCount = existBallCount + 1

			table.insert(allBallBuffMOs, buffMO)
			table.insert(existBallBuffMOs, buffMO)
		end
	end

	for _, actEffectData in ipairs(actEffect) do
		if actEffectData.effectType == FightEnum.EffectType.BUFFADD then
			local buffCO = lua_skill_buff.configDict[actEffectData.buff.buffId]

			if FightEntitySpecialEffect3070_Ball.buffTypeId2EffectPath[buffCO.typeId] then
				addBallCount = addBallCount + 1

				table.insert(allBallBuffMOs, actEffectData.buff)
			end
		end
	end

	if #existBallBuffMOs > 0 then
		local limitNum = 4

		for _, oneBuffMO in ipairs(allBallBuffMOs) do
			local buffConfig = lua_skill_buff.configDict[oneBuffMO.buffId]
			local buffTypeConfig = lua_skill_bufftype.configDict[buffConfig.typeId]
			local limit = string.splitToNumber(buffTypeConfig.includeTypes, "#")[2]

			limitNum = limit < limitNum and limit or limitNum
		end

		local removeCount = existBallCount + addBallCount - limitNum

		removeCount = existBallCount < removeCount and existBallCount or removeCount

		table.sort(existBallBuffMOs, function(buff1, buff2)
			return tonumber(buff1.uid) < tonumber(buff2.uid)
		end)

		for i = 1, removeCount do
			local actEffectData = FightActEffectData.New()

			actEffectData.targetId = attackerId
			actEffectData.effectType = FightEnum.EffectType.BUFFDEL
			actEffectData.buff = existBallBuffMOs[i]

			table.insert(actEffect, 1, actEffectData)
		end
	end
end

function SkillEditorStepBuilder._checkRemove3070Buff2(skillCO, actEffect, attackerId, targetId, side, oppositeSide)
	local entityMO = FightDataHelper.entityMgr:getById(attackerId)

	if entityMO.modelId ~= 3070 or not FightCardDataHelper.isBigSkill(skillCO.id) then
		return
	end

	local firstBallBuffMO

	for _, buffMO in pairs(entityMO:getBuffDic()) do
		local buffCO = lua_skill_buff.configDict[buffMO.buffId]

		if FightEntitySpecialEffect3070_Ball.buffTypeId2EffectPath[buffCO.typeId] then
			local actEffectData = FightActEffectData.New()

			actEffectData.targetId = attackerId
			actEffectData.effectType = FightEnum.EffectType.BUFFDEL
			actEffectData.buff = buffMO

			table.insert(actEffect, 1, actEffectData)
		end
	end
end

function SkillEditorStepBuilder._checkBuildAddPowerStep(skillCO, actEffect, attackerId, targetId, side, oppositeSide)
	local entity = FightHelper.getEntity(attackerId)

	if not entity:getMO():isCharacter() then
		return
	end

	local passiveSkillLevelCOs = SkillConfig.instance:getpassiveskillsCO(entity:getMO().modelId)

	if not passiveSkillLevelCOs then
		return
	end

	for _, passiveSkillLevelCO in ipairs(passiveSkillLevelCOs) do
		local passiveSkillCO = passiveSkillLevelCO and lua_skill.configDict[passiveSkillLevelCO.skillPassive]

		if passiveSkillCO then
			for i = 1, FightEnum.MaxBehavior do
				local condition = passiveSkillCO["condition" .. i]
				local behavior = passiveSkillCO["behavior" .. i]
				local conditionTarget = passiveSkillCO["conditionTarget" .. i]
				local behaviorTarget = passiveSkillCO["behaviorTarget" .. i]

				if not string.nilorempty(condition) and not string.nilorempty(behavior) and conditionTarget == "103" and behaviorTarget == "103" then
					local spRes1 = string.splitToNumber(condition, "#")
					local spRes2 = string.splitToNumber(behavior, "#")
					local conditionId = spRes1[1]
					local behaviorId = spRes2[1]
					local conditionCO = conditionId and lua_skill_behavior_condition.configDict[conditionId]
					local behaviorCO = behaviorId and lua_skill_behavior.configDict[behaviorId]

					if behaviorCO and behaviorCO.type == "ChangePower" then
						if conditionCO and conditionCO.type == "ActiveUseSkill" then
							if not spRes1[2] then
								local skillLv = FightConfig.instance:getSkillLv(skillCO.id)

								if skillLv == spRes1[2] then
									if not spRes2[2] then
										return SkillEditorStepBuilder._buildOneAddPowerStep(passiveSkillCO.id, attackerId, targetId, spRes2[2])
									end
								end
							end
						else
							return SkillEditorStepBuilder._buildOneAddPowerStep(passiveSkillCO.id, attackerId, targetId, 1)
						end
					end
				end
			end
		end
	end
end

function SkillEditorStepBuilder._buildOneAddPowerStep(skillId, attackerId, targetId, addPower)
	local fightStepData = FightStepData.New()

	fightStepData.editorPlaySkill = true
	fightStepData.actType = 1
	fightStepData.fromId = attackerId
	fightStepData.toId = targetId
	fightStepData.actId = skillId
	fightStepData.actEffect = {
		FightActEffectData.New()
	}
	fightStepData.actEffect[1].targetId = attackerId
	fightStepData.actEffect[1].effectType = FightEnum.EffectType.POWERCHANGE
	fightStepData.actEffect[1].effectNum = addPower
	fightStepData.actEffect[1].configEffect = 1
	fightStepData.actEffect[1].buffActId = 0

	return fightStepData
end

function SkillEditorStepBuilder._buildMagicCircle(skillCO, actEffect, attackerId, targetId, side, oppositeSide, randomTargetId)
	for i = 1, FightEnum.MaxBehavior do
		local behavior = skillCO["behavior" .. i]
		local condition = skillCO["condition" .. i]
		local condSatisfy = true

		if not string.nilorempty(condition) then
			local conditionId = string.splitToNumber(condition, "#")[1]
			local conditionCO = conditionId and lua_skill_behavior_condition.configDict[conditionId]

			condSatisfy = conditionCO and conditionCO.type == "None"
		end

		if not string.nilorempty(behavior) and condSatisfy then
			local spRes = string.splitToNumber(behavior, "#")
			local behaviorId = tonumber(spRes[1])
			local behaviorCO = behaviorId and lua_skill_behavior.configDict[behaviorId]

			if behaviorCO then
				if behaviorCO.type == "AddMagicCircle" then
					local magicData = FightModel.instance:getMagicCircleInfo()

					if magicData.magicCircleId then
						local actEffectData = FightActEffectData.New()

						actEffectData.targetId = 0
						actEffectData.effectType = FightEnum.EffectType.MAGICCIRCLEDELETE
						actEffectData.reserveId = magicData.magicCircleId

						table.insert(actEffect, actEffectData)
					end

					local magicCircleConfig = lua_magic_circle.configDict[tonumber(spRes[2])]

					if magicCircleConfig then
						local actEffectData = FightActEffectData.New()

						actEffectData.targetId = 0
						actEffectData.effectType = FightEnum.EffectType.MAGICCIRCLEADD
						actEffectData.magicCircle = {
							magicCircleId = magicCircleConfig.id,
							round = magicCircleConfig.round,
							createUid = attackerId
						}

						table.insert(actEffect, actEffectData)
					end
				elseif behaviorCO.type == "ChangeSummonedLevel" then
					local magicData = FightModel.instance:getMagicCircleInfo()

					if magicData.magicCircleId then
						local actEffectData = FightActEffectData.New()

						actEffectData.targetId = 0
						actEffectData.effectType = FightEnum.EffectType.MAGICCIRCLEDELETE
						actEffectData.reserveId = magicData.magicCircleId

						table.insert(actEffect, actEffectData)
					end
				end
			end
		end
	end
end

function SkillEditorStepBuilder._buildSummoned(skillCO, actEffect, attackerId, targetId, side, oppositeSide, randomTargetId)
	local addSummon = {}
	local oldSummonedLevel = {}

	for i = 1, FightEnum.MaxBehavior do
		local behavior = skillCO["behavior" .. i]
		local condition = skillCO["condition" .. i]
		local condSatisfy = true

		if not string.nilorempty(condition) then
			local conditionId = string.splitToNumber(condition, "#")[1]
			local conditionCO = conditionId and lua_skill_behavior_condition.configDict[conditionId]

			condSatisfy = conditionCO and conditionCO.type == "None"
		end

		if not string.nilorempty(behavior) and condSatisfy then
			local spRes = string.splitToNumber(behavior, "#")
			local behaviorTarget = skillCO["behaviorTarget" .. i]
			local conditionTarget = skillCO["conditionTarget" .. i]
			local targetType = behaviorTarget

			if behaviorTarget == "0" then
				targetType = skillCO.logicTarget
			elseif behaviorTarget == "999" then
				targetType = conditionTarget ~= "0" and conditionTarget or skillCO.logicTarget
			end

			local behaviorId = tonumber(spRes[1])
			local behaviorCO = behaviorId and lua_skill_behavior.configDict[behaviorId]

			if behaviorCO then
				local behaviorTarget = skillCO["behaviorTarget" .. i]
				local conditionTarget = skillCO["conditionTarget" .. i]
				local logicTarget = behaviorTarget

				if behaviorTarget == "0" then
					logicTarget = skillCO.logicTarget
				elseif behaviorTarget == "999" then
					logicTarget = conditionTarget ~= "0" and conditionTarget or skillCO.logicTarget
				end

				if behaviorCO.type == "AddSummoned" then
					local targetIds = SkillEditorStepBuilder._getTargetIds(logicTarget, attackerId, targetId, side, oppositeSide, randomTargetId)

					for _, targetId in ipairs(targetIds) do
						local summonedId = tonumber(spRes[2])
						local summonCount = tonumber(spRes[4]) or 1

						for _ = 1, summonCount do
							local config = FightConfig.instance:getSummonedConfig(summonedId, 1)
							local stanceId = config.stanceId
							local stanceConfig = lua_fight_summoned_stance.configDict[stanceId]
							local maxCount = 0

							for j = 1, 20 do
								local stanceInfo = stanceConfig["pos" .. j]

								maxCount = stanceInfo and #stanceInfo > 0 and maxCount + 1 or maxCount
							end

							local entity = FightHelper.getEntity(targetId)
							local entityMO = entity and entity:getMO()

							if entityMO then
								if not entityMO.summonedInfo.dataDic then
									local dataDic = entityMO:getSummonedInfo():getDataDic()
									local canAddSummoned = maxCount > tabletool.len(dataDic) + tabletool.len(addSummon)

									if canAddSummoned then
										local summonedInfo = {}

										summonedInfo.summonedId = summonedId
										summonedInfo.level = tonumber(spRes[3])
										summonedInfo.uid = SkillEditorBuffSelectView.genBuffUid()
										summonedInfo.fromUid = attackerId

										local actEffectData = FightActEffectData.New()

										actEffectData.targetId = targetId
										actEffectData.effectType = FightEnum.EffectType.SUMMONEDADD
										actEffectData.effectNum = 0
										actEffectData.configEffect = 0
										actEffectData.buffActId = 0
										actEffectData.reserveId = summonedInfo.uid
										actEffectData.reserveStr = ""
										actEffectData.summoned = summonedInfo

										table.insert(actEffect, actEffectData)

										oldSummonedLevel[summonedInfo.uid] = summonedInfo.level
										addSummon[summonedInfo.uid] = summonedInfo

										SkillEditorStepBuilder._buildSummonedDelete(summonedInfo, actEffect, attackerId, targetId, side)
									end
								end
							end
						end
					end
				elseif behaviorCO.type == "ChangeSummonedLevel" then
					local targetIds = SkillEditorStepBuilder._getTargetIds(logicTarget, attackerId, targetId, side, oppositeSide, randomTargetId)

					for _, targetId in ipairs(targetIds) do
						local summonedId = tonumber(spRes[2])
						local entity = FightHelper.getEntity(targetId)
						local entityMO = entity and entity:getMO()

						if entityMO then
							if not entityMO.summonedInfo.dataDic then
								local dataDic = {}
								local allSummon = tabletool.copy(dataDic)

								for uid, one in pairs(addSummon) do
									allSummon[uid] = one
								end

								for _, oldSummonedInfo in pairs(allSummon) do
									if oldSummonedInfo.summonedId == summonedId then
										local summonedInfo = {}

										if not oldSummonedLevel[oldSummonedInfo.uid] then
											local oldLevel = oldSummonedInfo.level

											summonedInfo.summonedId = summonedId
											summonedInfo.level = tonumber(spRes[3])
											summonedInfo.uid = oldSummonedInfo.uid
											summonedInfo.fromUid = attackerId

											local actEffectData = FightActEffectData.New()

											actEffectData.targetId = targetId
											actEffectData.effectType = FightEnum.EffectType.SUMMONEDLEVELUP
											actEffectData.effectNum = summonedInfo.level - oldLevel
											actEffectData.configEffect = 0
											actEffectData.buffActId = 0
											actEffectData.reserveId = summonedInfo.uid
											actEffectData.reserveStr = ""
											actEffectData.summoned = summonedInfo

											table.insert(actEffect, actEffectData)

											oldSummonedLevel[oldSummonedInfo.uid] = summonedInfo.level

											SkillEditorStepBuilder._buildSummonedDelete(summonedInfo, actEffect, attackerId, targetId, side)
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
end

function SkillEditorStepBuilder._buildSummonedDelete(summonedInfo, actEffect, attackerId, targetId, side)
	local summonedCO = FightConfig.instance:getSummonedConfig(summonedInfo.summonedId, summonedInfo.level)

	if summonedCO and summonedInfo.level >= summonedCO.maxLevel then
		local actEffectData = FightActEffectData.New()

		actEffectData.targetId = targetId
		actEffectData.effectType = FightEnum.EffectType.SUMMONEDDELETE
		actEffectData.effectNum = 0
		actEffectData.configEffect = 0
		actEffectData.buffActId = 0
		actEffectData.reserveId = summonedInfo.uid
		actEffectData.reserveStr = ""

		table.insert(actEffect, actEffectData)
	end
end

function SkillEditorStepBuilder._getTargetIds(logicTarget, attackerId, targetId, side, oppositeSide, randomTargetId)
	if FightEnum.LogicTargetClassify.Single[logicTarget] then
		return {
			targetId
		}
	elseif FightEnum.LogicTargetClassify.SingleAndRandom[logicTarget] then
		return {
			targetId,
			randomTargetId
		}
	elseif FightEnum.LogicTargetClassify.MySideAll[logicTarget] then
		local ret = {}
		local atkMOList = FightDataHelper.entityMgr:getNormalList(side)

		for _, entityMO in ipairs(atkMOList) do
			table.insert(ret, entityMO.id)

			return ret
		end
	elseif FightEnum.LogicTargetClassify.Me[logicTarget] then
		return {
			attackerId
		}
	end
end

local Hero_MaKuSi = 3065

function SkillEditorStepBuilder._checkRegainPowerAfterAct(skillCO, actEffect, attackerId, targetId, side, apositeside)
	local realTargetId
	local defenderEntitys = FightHelper.getSideEntitys(apositeside, false)

	for _, defenderEntity in ipairs(defenderEntitys) do
		if defenderEntity:getMO() and defenderEntity:getMO().modelId == Hero_MaKuSi then
			realTargetId = defenderEntity.id

			break
		end
	end

	if not realTargetId then
		return
	end

	local entity = FightHelper.getEntity(attackerId)
	local entityBuffs = entity:getMO():getBuffList()

	for _, buffMO in ipairs(entityBuffs) do
		local buffCO = lua_skill_buff.configDict[buffMO.buffId]
		local features = buffCO and buffCO.features

		if not string.nilorempty(features) then
			local featuresSplit = GameUtil.splitString2(features, true)

			for _, oneFeature in ipairs(featuresSplit) do
				if oneFeature[1] then
					if oneFeature[1] and oneFeature[1].type == "RegainPowerAfterAct" then
						local actEffectData = FightActEffectData.New()

						actEffectData.targetId = realTargetId
						actEffectData.effectType = FightEnum.EffectType.POWERCHANGE
						actEffectData.effectNum = oneFeature[2] or 1
						actEffectData.configEffect = 1
						actEffectData.buffActId = 0

						table.insert(actEffect, actEffectData)
					end
				end
			end
		end
	end
end

function SkillEditorStepBuilder._checkBehaviorCondition(condition, conditionTarget, attackerId, targetId)
	if string.nilorempty(condition) then
		return true
	end

	local condition, count = string.gsub(condition, "[!！]", "")
	local state = SkillEditorStepBuilder.behaviorConditionByStr(condition, conditionTarget, attackerId, targetId)

	if count > 0 then
		return not state
	end

	return state
end

function SkillEditorStepBuilder.behaviorConditionByStr(condition, conditionTarget, attackerId, targetId)
	local conditionSp = string.splitToNumber(condition, "#")
	local conditionId = conditionSp[1]
	local conditionParam = conditionSp[2]
	local conditionCO = conditionId and lua_skill_behavior_condition.configDict[conditionId]

	if not conditionCO or conditionCO.type == "None" then
		return true
	end

	local conditionTargetId = FightEnum.LogicTargetClassify.Me[conditionTarget] and attackerId or targetId
	local conditionEntity = FightHelper.getEntity(conditionTargetId)

	if conditionCO.type == "NoBuffId" and conditionEntity then
		for _, buffMO in pairs(conditionEntity:getMO():getBuffDic()) do
			if buffMO.buffId == conditionParam then
				return false
			end
		end

		return true
	end

	if conditionCO.type == "HasBuffId" and conditionEntity then
		for _, buffMO in pairs(conditionEntity:getMO():getBuffDic()) do
			if buffMO.buffId == conditionParam then
				return true
			end
		end

		return false
	end

	return true
end

function SkillEditorStepBuilder._getBehaviorTargetIds(actEffect, skillCO, behaviorIndex, attackerId, targetId, side, oppositeSide, randomTargetId)
	local logicTarget = skillCO.logicTarget
	local behaviorTarget = skillCO["behaviorTarget" .. behaviorIndex]
	local conditionTarget = skillCO["conditionTarget" .. behaviorIndex]
	local targetType = behaviorTarget

	if behaviorTarget == "0" then
		targetType = logicTarget
	elseif behaviorTarget == "999" then
		targetType = conditionTarget ~= "0" and conditionTarget or logicTarget
	end

	local function insertTarget(ids, id)
		if not tabletool.indexOf(ids, id) then
			table.insert(ids, id)
		end
	end

	local targetIds = {}

	if targetType == FightEnum.CondTargetHpMin then
		local minHpTargetId = attackerId
		local minHpPercent = 1
		local atkMOList = FightDataHelper.entityMgr:getNormalList(side)

		for _, entityMO in ipairs(atkMOList) do
			local hpPercent = entityMO.currentHp / entityMO.attrMO.hp

			if hpPercent < minHpPercent then
				minHpTargetId = entityMO.id
				minHpPercent = hpPercent
			end
		end

		insertTarget(targetIds, minHpTargetId)
	elseif FightEnum.LogicTargetClassify.Special[targetType] then
		insertTarget(targetIds, targetId)
	elseif FightEnum.LogicTargetClassify.Single[targetType] then
		insertTarget(targetIds, targetId)
	elseif FightEnum.LogicTargetClassify.SingleAndRandom[targetType] then
		insertTarget(targetIds, targetId)

		if randomTargetId then
			insertTarget(targetIds, randomTargetId)
		else
			local isAttack = skillCO.targetLimit == FightEnum.TargetLimit.EnemySide
			local entityList = FightHelper.getSideEntitys(isAttack and oppositeSide or side)

			for i, entity in ipairs(entityList) do
				if entity.id == targetId then
					table.remove(entityList, i)

					break
				end
			end

			if #entityList > 0 then
				local randomIndex = math.random(#entityList)
				local randomEntity = entityList[randomIndex]

				randomTargetId = randomEntity.id

				insertTarget(targetIds, randomEntity.id)
			end
		end
	elseif FightEnum.LogicTargetClassify.EnemySideAll[targetType] then
		local defMOList = FightDataHelper.entityMgr:getNormalList(oppositeSide)

		for _, entityMO in ipairs(defMOList) do
			insertTarget(targetIds, entityMO.id)
		end
	elseif FightEnum.LogicTargetClassify.EnemySideindex[targetType] then
		local index = targetType - 225
		local defMOList = FightDataHelper.entityMgr:getNormalList(oppositeSide)

		table.sort(defMOList, function(item1, item2)
			return item1.position < item2.position
		end)

		for entityIndex, entityMO in ipairs(defMOList) do
			if entityIndex == index then
				insertTarget(targetIds, entityMO.id)
			end
		end
	elseif FightEnum.LogicTargetClassify.MySideAll[targetType] then
		local atkMOList = FightDataHelper.entityMgr:getNormalList(side)

		for _, entityMO in ipairs(atkMOList) do
			insertTarget(targetIds, entityMO.id)
		end
	elseif targetType == "109" then
		local atkMOList = FightDataHelper.entityMgr:getNormalList(side)
		local rate = 100
		local entityId = "0"

		for _, entityMO in ipairs(atkMOList) do
			local hpRate = entityMO.currentHp / entityMO.attrMO.hp

			if hpRate <= rate then
				rate = hpRate
				entityId = entityMO.id
			end
		end

		insertTarget(targetIds, entityId)
	elseif FightEnum.LogicTargetClassify.Me[targetType] then
		insertTarget(targetIds, attackerId)
	elseif FightEnum.LogicTargetClassify.SecondaryTarget[targetType] then
		if skillCO.logicTarget == "202" then
			local defMOList = FightDataHelper.entityMgr:getNormalList(oppositeSide)

			for _, entityMO in ipairs(defMOList) do
				if entityMO.id ~= targetId then
					insertTarget(targetIds, entityMO.id)
				end
			end
		end
	elseif FightEnum.LogicTargetClassify.StanceAndBefore[targetType] then
		local attacker = FightDataHelper.entityMgr:getById(attackerId)
		local atkMOList = FightDataHelper.entityMgr:getNormalList(side)

		for _, entityMO in ipairs(atkMOList) do
			if entityMO.position <= attacker.position then
				insertTarget(targetIds, entityMO.id)
			end
		end
	elseif FightEnum.LogicTargetClassify.StanceAndAfter[targetType] then
		local attacker = FightDataHelper.entityMgr:getById(attackerId)
		local atkMOList = FightDataHelper.entityMgr:getNormalList(side)

		for _, entityMO in ipairs(atkMOList) do
			if entityMO.position >= attacker.position then
				insertTarget(targetIds, entityMO.id)
			end
		end
	elseif FightEnum.LogicTargetClassify.Position[targetType] then
		local list = FightHelper.getEnemySideEntitys(attackerId)

		for i, v in ipairs(list) do
			local entityMO = v:getMO()

			if entityMO and entityMO.position == FightEnum.LogicTargetClassify.Position[targetType] then
				insertTarget(targetIds, v.id)
			end
		end
	end

	return targetIds, randomTargetId
end

return SkillEditorStepBuilder
