-- chunkname: @modules/logic/fight/controller/FightASFDHelper.lua

module("modules.logic.fight.controller.FightASFDHelper", package.seeall)

local FightASFDHelper = _M

function FightASFDHelper.getMissileTargetId(fightStepData)
	if not fightStepData then
		return
	end

	if fightStepData.actEffect then
		for _, actEffectData in ipairs(fightStepData.actEffect) do
			if FightASFDHelper.isDamageEffect(actEffectData.effectType) then
				return actEffectData.targetId
			end
		end
	end

	return fightStepData.toId
end

FightASFDHelper.DamageEffectTypeDict = {
	[FightEnum.EffectType.MISS] = true,
	[FightEnum.EffectType.DAMAGE] = true,
	[FightEnum.EffectType.CRIT] = true,
	[FightEnum.EffectType.SHIELD] = true,
	[FightEnum.EffectType.SHIELDDEL] = true,
	[FightEnum.EffectType.ADDITIONALDAMAGE] = true,
	[FightEnum.EffectType.ADDITIONALDAMAGECRIT] = true,
	[FightEnum.EffectType.ORIGINDAMAGE] = true,
	[FightEnum.EffectType.ORIGINCRIT] = true
}

function FightASFDHelper.isDamageEffect(effectType)
	return effectType and FightASFDHelper.DamageEffectTypeDict[effectType]
end

function FightASFDHelper.getASFDType(fightStepData)
	return FightEnum.ASFDType.Normal
end

function FightASFDHelper.mathReplyRule(entityId, co, context)
	local rule = co.replaceRule

	if string.nilorempty(rule) then
		return true
	end

	return FightASFDHelper.checkRule(rule, entityId, context)
end

function FightASFDHelper.checkRule(rule, entityId, context)
	if string.nilorempty(rule) then
		return true
	end

	local ruleList = FightStrUtil.instance:getSplitString2Cache(rule, true)

	for _, ruleArr in ipairs(ruleList) do
		local ruleId = ruleArr[1]

		if ruleId == FightEnum.ASFDReplyRule.HasSkin then
			if not FightASFDHelper.checkHasSkinRule(ruleArr, entityId) then
				return false
			end
		elseif ruleId == FightEnum.ASFDReplyRule.HasBuffActId then
			if not FightASFDHelper.checkHasBuffActIdRule(ruleArr, entityId) then
				return false
			end
		elseif ruleId == FightEnum.ASFDReplyRule.IndexMoreThan then
			if context then
				if not context.emitterAttackNum then
					local curIndex = 1

					return curIndex >= ruleArr[2]
				end
			end
		end
	end

	return true
end

function FightASFDHelper.checkHasSkinRule(ruleArr, entityId)
	for i = 2, #ruleArr do
		if FightHelper.hasSkinId(ruleArr[i]) then
			return true
		end
	end

	return false
end

function FightASFDHelper.checkHasBuffActIdRule(ruleArr, entityId)
	if entityId then
		::label_7_0::

		local entityMo = FightDataHelper.entityMgr:getById(entityId)

		return entityMo and entityMo:hasBuffActId(ruleArr[2])
	end
end

function FightASFDHelper.sortASFDCo(co1, co2)
	return co1.priority > co2.priority
end

FightASFDHelper.tempCoList = {}

function FightASFDHelper.getASFDCo(entityId, unit, default, context)
	local list = FightASFDConfig.instance:getUnitList(unit)

	if not list then
		return default
	end

	tabletool.clear(FightASFDHelper.tempCoList)

	for _, co in ipairs(list) do
		if FightASFDHelper.mathReplyRule(entityId, co, context) then
			table.insert(FightASFDHelper.tempCoList, co)
		end
	end

	if #FightASFDHelper.tempCoList < 1 then
		return default
	end

	table.sort(FightASFDHelper.tempCoList, FightASFDHelper.sortASFDCo)

	return FightASFDHelper.tempCoList[1]
end

function FightASFDHelper.getBornCo(entityId)
	return FightASFDHelper.getASFDCo(entityId, FightEnum.ASFDUnit.Born, FightASFDConfig.instance.defaultBornCo)
end

function FightASFDHelper.getEmitterCo(entityId)
	return FightASFDHelper.getASFDCo(entityId, FightEnum.ASFDUnit.Emitter, FightASFDConfig.instance.defaultEmitterCo)
end

function FightASFDHelper.getMissileCo(entityId, context)
	return FightASFDHelper.getASFDCo(entityId, FightEnum.ASFDUnit.Missile, FightASFDConfig.instance.defaultMissileCo, context)
end

function FightASFDHelper.getExplosionCo(entityId, context)
	return FightASFDHelper.getASFDCo(entityId, FightEnum.ASFDUnit.Explosion, FightASFDConfig.instance.defaultExplosionCo, context)
end

function FightASFDHelper.getEmitterPos(side, sceneEmitterId)
	local fightParam = FightModel.instance:getFightParam()
	local waveId = FightModel.instance:getCurWaveId() or 1
	local sceneId = fightParam and fightParam:getScene(waveId) or 1
	local sceneCo = lua_fight_asfd_emitter_position.configDict[sceneId]

	sceneCo = sceneCo or lua_fight_asfd_emitter_position.configDict[1]

	local co = sceneEmitterId and sceneCo[sceneEmitterId]

	co = co or sceneCo[1]

	if side == FightEnum.EntitySide.MySide then
		if not co.mySidePos then
			local pos = co.enemySidePos

			return pos[1], pos[2], pos[3]
		end
	end
end

function FightASFDHelper.getStartPos(side, sceneEmitterId)
	local x, y, z = FightASFDHelper.getEmitterPos(side, sceneEmitterId)
	local randomX, randomY = GameUtil.getRandomPosInCircle(x, y, FightASFDConfig.instance.randomRadius)
	local offset = FightASFDConfig.instance.emitterCenterOffset

	randomX = side == FightEnum.EntitySide.MySide and randomX - offset.x or randomX + offset.x
	randomY = randomY + offset.y

	return Vector3(randomX, randomY, z)
end

function FightASFDHelper.getEndPos(toEntityId, hangPoint)
	hangPoint = hangPoint or FightASFDConfig.instance.hitHangPoint

	local toEntity = FightHelper.getEntity(toEntityId)
	local goHangPoint = toEntity:getHangPoint(FightASFDConfig.instance.hitHangPoint)

	if not goHangPoint then
		return Vector3(0, 0, 0)
	end

	return goHangPoint.transform.position
end

function FightASFDHelper.getRandomValue()
	return math.random(0, 1000) / 1000
end

local RandDomAreaY = {
	Down = 2,
	Up = 1
}

function FightASFDHelper.changeRandomArea()
	if FightASFDHelper.randomAreaY == RandDomAreaY.Up then
		FightASFDHelper.randomAreaY = RandDomAreaY.Down or RandDomAreaY.Up
	end
end

FightASFDHelper.forbidSampleYRate = 0.1

function FightASFDHelper.getRandomPos(startPos, endPos, co)
	local pos = Vector3()
	local t = FightASFDHelper.getRandomValue()
	local startX, endX = FightASFDHelper.getFormatPos(startPos.x, endPos.x, FightASFDConfig.instance.sampleXRate)

	pos.x = LuaTween.linear(t, startX, endX - startX, 1)
	t = FightASFDHelper.getRandomValue()
	pos.z = LuaTween.linear(t, startPos.z, endPos.z - startPos.z, 1)
	t = FightASFDHelper.getRandomValue()

	local height = math.abs(endPos.y - startPos.y)
	local minHeight = co.sampleMinHeight
	local startPosY, endPosY = startPos.y, endPos.y

	if minHeight > 0 and height < minHeight then
		local offset = (minHeight - height) / 2

		if endPosY < startPosY then
			startPosY = startPosY + offset
			endPosY = endPosY - offset
		else
			startPosY = startPosY - offset
			endPosY = endPosY + offset
		end
	end

	local forbidStartPosY, forbidEndPosY = FightASFDHelper.getFormatPos(startPosY, endPosY, FightASFDHelper.forbidSampleYRate)

	if FightASFDHelper.randomAreaY == RandDomAreaY.Up then
		endPosY = forbidStartPosY
	else
		startPosY = forbidEndPosY
	end

	pos.y = LuaTween.linear(t, startPosY, endPosY - startPosY, 1)

	return pos
end

function FightASFDHelper.getFormatPos(startPos, endPos, rate)
	rate = math.min(1, math.max(0, rate))

	local halfRate = rate / 2
	local startRate = 0.5 - halfRate
	local endRate = 0.5 + halfRate
	local len = endPos - startPos
	local newStartPos = LuaTween.linear(startRate, startPos, len, 1)
	local newEndPos = LuaTween.linear(endRate, startPos, len, 1)

	return newStartPos, newEndPos
end

function FightASFDHelper.getASFDBornRemoveRes(bornCo)
	return bornCo.res .. "_end"
end

function FightASFDHelper.getASFDEmitterRemoveRes(emitterCo)
	return emitterCo.res .. "_end"
end

function FightASFDHelper.getASFDExplosionScale(fightStepData, explosionCo, toEntityId)
	local scale = explosionCo.scale

	if scale == 0 then
		scale = 1
	end

	if FightASFDHelper._checkTriggerMustCrit(fightStepData, toEntityId) and FightASFDHelper._checkHasHeroId() then
		return FightASFDConfig.instance.maDiErDaCritScale * scale
	end

	return scale
end

FightASFDHelper.TempEntityMoList = {}

function FightASFDHelper._checkHasHeroId()
	local MDEDHeroId = 3041
	local entityList = FightASFDHelper.TempEntityMoList

	tabletool.clear(entityList)

	entityList = FightDataHelper.entityMgr:getMyNormalList(entityList)

	for _, entityMo in ipairs(entityList) do
		if entityMo:isCharacter() and entityMo.modelId == MDEDHeroId then
			return true
		end
	end

	return false
end

function FightASFDHelper._checkTriggerMustCrit(fightStepData, toEntityId)
	if not fightStepData then
		return false
	end

	local actEffectDataList = fightStepData.actEffect

	if not actEffectDataList then
		return false
	end

	for _, actEffectData in ipairs(actEffectDataList) do
		if actEffectData.effectType == FightEnum.EffectType.MUSTCRIT and actEffectData.reserveId == toEntityId then
			return true
		end
	end

	return false
end

function FightASFDHelper.getStepContext(stepData, curASFDIndex)
	if stepData then
		for _, effectMo in ipairs(stepData.actEffect) do
			if effectMo.effectType == FightEnum.EffectType.EMITTERFIGHTNOTIFY then
				local context

				if not string.nilorempty(effectMo.reserveStr) then
					context = cjson.decode(effectMo.reserveStr)
				end

				context.emitterAttackNum = context.emitterAttackNum or curASFDIndex
				context.emitterAttackMaxNum = context.emitterAttackMaxNum or curASFDIndex

				return context
			end
		end
	end
end

function FightASFDHelper.isALFPullOutStep(stepData, curASFDIndex)
	local context = FightASFDHelper.getStepContext(stepData, curASFDIndex)

	if not context then
		return false
	end

	if not context.emitterAttackNum or not context.emitterAttackMaxNum then
		return false
	end

	if context.emitterAttackNum < context.emitterAttackMaxNum then
		return false
	end

	local entityId = stepData.fromId

	if entityId then
		::label_27_0::

		local entityMo = FightDataHelper.entityMgr:getById(entityId)

		return entityMo and entityMo:hasBuffActId(924)
	end
end

FightASFDHelper.tempVector2_A = Vector2(-1, 0)
FightASFDHelper.tempVector2_B = Vector2()

function FightASFDHelper.getZRotation(startPosX, startPosY, endPosX, endPosY)
	FightASFDHelper.tempVector2_B:Set(endPosX - startPosX, endPosY - startPosY)

	local sign = Mathf.Sign(FightASFDHelper.tempVector2_A.x * FightASFDHelper.tempVector2_B.y - FightASFDHelper.tempVector2_A.y * FightASFDHelper.tempVector2_B.x)

	return Vector2.Angle(FightASFDHelper.tempVector2_A, FightASFDHelper.tempVector2_B) * sign
end

function FightASFDHelper.getLastRoundRecordCardEnergyByEntityMo(entityMo)
	if not entityMo then
		return
	end

	local buffDict = entityMo:getBuffDic()

	if not buffDict then
		return
	end

	local curRound = FightModel.instance:getCurRoundId() - 1

	for _, buffMo in pairs(buffDict) do
		for _, actInfo in ipairs(buffMo.actInfo) do
			if actInfo.actId == FightEnum.BuffActId.NoUseCardEnergyRecordByRound then
				local str = actInfo.strParam
				local list = FightStrUtil.instance:getSplitString2Cache(str, true, "|", "#")

				for _, info in ipairs(list) do
					if info[1] == curRound then
						return info[2]
					end
				end
			end
		end
	end
end

function FightASFDHelper.getLastRoundRecordCardEnergy()
	local entityList = FightASFDHelper.TempEntityMoList

	tabletool.clear(entityList)

	entityList = FightDataHelper.entityMgr:getMyNormalList(entityList)

	for _, entityMo in ipairs(entityList) do
		local energy = FightASFDHelper.getLastRoundRecordCardEnergyByEntityMo(entityMo)

		if energy then
			return energy
		end
	end

	return 0
end

return FightASFDHelper
