-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/util/BattleBuffUtil.lua

module("logic.battle.util.BattleBuffUtil", package.seeall)

local BattleBuffUtil = {}

function BattleBuffUtil.addBuff(unit, buffId, buffCode, buffRound, buffLayer)
	unit.buff:addBuff(buffId, buffCode, buffRound, buffLayer)

	local buffCO = BuffConfig.instance:getBuffCO(buffCode)

	if BuffCOUtil.isGood(buffCO) then
		unit.bubble:showCenterBubble(BattleEnum.BubbleType.BUFF_ADD_HINT, buffCode, BattleConst.DelayOne)
		unit.effectPlayer:playUniqueEffect(BattleConst.ADD_BUFF)
		CriwareAudioFacade.instance:playSEById(CriwareAudioEnum.ui_general_buffeffect)
	else
		unit.bubble:showCenterBubble(BattleEnum.BubbleType.BUFF_ADD_HINT, buffCode, BattleConst.DelayOne)
		unit.effectPlayer:playUniqueEffect(BattleConst.ADD_DEBUFF)
		CriwareAudioFacade.instance:playSEById(CriwareAudioEnum.ui_general_debuffeffect)
	end

	local hasAddEffect = BattleBuffUtil._processBuffAddEffect(unit, buffCO)

	BattleBuffUtil._processBuffEffects(unit, buffCO)

	return hasAddEffect
end

function BattleBuffUtil.initUnitBuffEffect(unit)
	local buffMOList = unit.buff:getAllBuff()

	for _, buffMO in ipairs(buffMOList) do
		local buffCO = buffMO:getBuffCO()

		BattleBuffUtil._processBuffEffects(unit, buffCO)
	end
end

function BattleBuffUtil._processBuffAddEffect(unit, buffCO)
	return BattleBuffUtil._processBuffAddEffect_DizzyOrSleep(unit, buffCO)
end

function BattleBuffUtil._processBuffEffects(unit, buffCO)
	local ret = false

	BattleBuffUtil._processBuffEffects_Common(unit, buffCO)
	BattleBuffUtil._processBuffAddEffect_State(unit, buffCO)
	BattleBuffUtil._processBuffEffects_Linkes(unit, buffCO)
end

function BattleBuffUtil._processBuffEffects_Common(unit, buffCO)
	local effectCode = buffCO.effectCode

	if effectCode > 0 then
		unit.effectPlayer:playLoopEffect(effectCode)
	end
end

function BattleBuffUtil._processBuffEffects_Linkes(unit, buffCO)
	if not BuffCOUtil.isLink(buffCO) then
		return
	end

	local unitMgr = BattleMgr.instance:getUnitMgr()
	local units = unitMgr:getUnitsByCampId(unit.property:getCampId())
	local entityIds = BattleTableUtil.getTempList()
	local targetBuffCode = buffCO.id

	for _, unit in pairs(units) do
		if unit.buff:constainsBuffCode(targetBuffCode) then
			table.insert(entityIds, unit.property:getEntityId())
		end
	end

	local entityCount = #entityIds

	if entityCount > 1 then
		local effectPlayer = BattleMgr.instance:getEffectPlayer()
		local effectCode = buffCO.linkEffectCode

		for fromIndex = 1, entityCount do
			for toIndex = fromIndex + 1, entityCount do
				effectPlayer:addLinkLine(effectCode, entityIds[fromIndex], entityIds[toIndex])
			end
		end
	end

	BattleTableUtil.releaseTempList(entityIds)

	return entityCount > 0
end

function BattleBuffUtil._processBuffAddEffect_State(unit, buffCO)
	local hasStateEffect = false

	if not unit.property:isImmuneBuff(buffCO.id) and BuffCOUtil.isDizzyOrSleep(buffCO) then
		hasStateEffect = true

		unit.property:activeState(BattleEnum.State.DIZZY_OR_SLEEP)
	end

	if hasStateEffect then
		unit.stateEffect:refreshStateEffect()
	end
end

function BattleBuffUtil._processBuffAddEffect_DizzyOrSleep(unit, buffCO)
	if not unit.property:isImmuneBuff(buffCO.id) and BuffCOUtil.isDizzyOrSleep(buffCO) and not unit.property:isStateActive(BattleEnum.State.DIZZY_OR_SLEEP) then
		unit.meshModelMover:playMappedAnimation(UnitAnimState.Hit, false, true)
		BattleUnitUtil.play3dAudio(unit, unit.property:getHitAudio())
		unit.property:activeState(BattleEnum.State.DIZZY_OR_SLEEP)

		return true
	end

	return false
end

return BattleBuffUtil
