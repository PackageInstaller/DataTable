-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/ArcadeSkillFactory.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.ArcadeSkillFactory", package.seeall)

local ArcadeSkillFactory = class("ArcadeSkillFactory")

ArcadeSkillFactory.CondBaseClzMap = {
	ifAttackType = ArcadeSkillCondAttackType,
	inSpecifyRoom = ArcadeSkillCondSpecifyRoom,
	attributeJudgment = ArcadeSkillCondAttributeJudgment,
	scopeJudgment = ArcadeSkillCondScopeJudgment,
	beAttackBy = ArcadeSkillCondBeAttackBy,
	ifInjured = ArcadeSkillCondIfInjured,
	weaponNotFully = ArcadeSkillCondWeaponNotFully,
	inSpecifyFloor = ArcadeSkillCondInSpecifyFloor,
	notInSpecifyFloor = ArcadeSkillCondNotInSpecifyFloor,
	ifTargetNum = ArcadeSkillCondIfTargetNum,
	perRound = ArcadeSkillCondPerRound,
	perAttack = ArcadeSkillCondPerAttack,
	monsterKills = ArcadeSkillCondMonsterKills,
	numberJudgment = ArcadeSkillCondNumberJudgment,
	hitTargetHaveBuff = ArcadeSkillCondHitTargetHaveBuff
}
ArcadeSkillFactory.HitBaseClzMap = {
	attributeChange1 = ArcadeSkillHitAttrChange,
	attributeChange2 = ArcadeSkillHitAttrChange,
	dropSomething = ArcadeSkillHitDropSomething,
	attackTargetChange = ArcadeSkillHitAttackTargetChange,
	skillAttack = ArcadeSkillHitSkillAttack,
	passiveSkillAdd = ArcadeSkillHitPassiveSkillAdd,
	passiveSkillRemove = ArcadeSkillHitPassiveSkillRemove,
	durabilityFix = ArcadeSkillHitDurabilityFix,
	energyAdd = ArcadeSkillHitEnergyAdd,
	lostWeapon = ArcadeSkillHitLostWeapon,
	refreshProducts = ArcadeSkillHitRefreshProducts,
	[ArcadeGameEnum.SkillHitName.Summon] = ArcadeSkillHitSummon,
	randomSummon = ArcadeSkillHitRandomSummon,
	addBuff = ArcadeSkillHitAddBuff,
	removeBuff = ArcadeSkillHitRemoveBuff,
	normalmove = ArcadeSkillHitNormalMove,
	flashmove = ArcadeSkillHitFlashMove,
	randomUseSkill = ArcadeSkillHitRandomUseSkill,
	ghost = ArcadeSkillHitGhost,
	collision = ArcadeSkillHitCollision,
	alertAttack = ArcadeSkillHitAlertAttack,
	killSelf = ArcadeSkillHitKillSelf,
	dieandsummon = ArcadeSkillHitDieandSummon,
	dirShield = ArcadeSkillHitDirShield,
	flop = ArcadeSkillHitFlop,
	massifAdd = ArcadeSkillHitMassifAdd,
	throwingBomb = ArcadeSkillHitThrowingBomb,
	unaffectedFloor = ArcadeSkillHitUnaffectedFloor,
	dropPortal = ArcadeSkillHitDropPortal,
	weaponUsedTimesFix = ArcadeSkillHitWeaponUsedTimesFix,
	removeCollection = ArcadeSkillHitRemoveCollection,
	changeAttackAttr = ArcadeSkillHitChangeAttackAttr,
	removeAttackAttr = ArcadeSkillHitRemoveAttackAttr,
	removeFloor = ArcadeSkillHitRemoveFloor,
	dropBomb = ArcadeSkillHitDropBomb,
	directRemoveSelf = ArcadeSkillHitDirectRemoveSelf,
	changePrefab = ArcadeSkillHitChangePrefab
}
ArcadeSkillFactory.TargetBaseClzMap = {
	character = ArcadeSkillTargetCharacter,
	lineColor = ArcadeSkillTargetLinkColor,
	color = ArcadeSkillTargetSameColor,
	rect = ArcadeSkillTargetRect,
	cross = ArcadeSkillTargetCross,
	line = ArcadeSkillTargetLine,
	random = ArcadeSkillTargetRandom,
	scope = ArcadeSkillTargetScope,
	attacker = ArcadeSkillTargetAttacker,
	owner = ArcadeSkillTargetOwner,
	shapeSize = AracdeSkillTargetShapeSize,
	floor = AracdeSkillTargetFloorGrid,
	outline = ArcadeSkillTargetOutline,
	triangle = ArcadeSkillTargetTriangle,
	specBuff = ArcadeSkillTargetSpecBuff
}

function ArcadeSkillFactory:createSkillById(skillId)
	local skillCfg = ArcadeConfig.instance:getPassiveSkillCfg(skillId, true)

	if not skillCfg then
		return
	end

	local skillObj = ArcadeSkillNormal.New(skillId)
	local sEffList = ArcadeGameEnum.TriggerCfgKeys.Effect
	local condList = ArcadeGameEnum.TriggerCfgKeys.Condition
	local pointList = ArcadeGameEnum.TriggerCfgKeys.TriggerPoint
	local limitList = ArcadeGameEnum.TriggerCfgKeys.Limit
	local effectIdList = ArcadeGameEnum.TriggerCfgKeys.EffectId
	local atkEffectIdList = ArcadeGameEnum.TriggerCfgKeys.AtkEffectId

	self._createSkillCfg = skillCfg

	for idx, effKey in ipairs(sEffList) do
		self._createIndex = idx

		local effectStr = skillCfg[effKey]
		local condStr = skillCfg[condList[idx]]
		local triggerPoint = skillCfg[pointList[idx]]
		local limit = skillCfg[limitList[idx]]
		local effectId = skillCfg[effectIdList[idx]]
		local atkEffectId = skillCfg[atkEffectIdList[idx]]

		if ArcadeGameEnum.PrintLog and not string.nilorempty(effectStr) then
			logNormal(string.format("ArcadeSkillFactory:createSkillById => skillId:%s -> %s,effect:%s,point:%s,cond:%s", skillCfg.id, idx, effectStr, triggerPoint, condStr))
		end

		local triggerBase = self:createSkillTriggerById(effectStr, triggerPoint, condStr)

		if triggerBase then
			skillObj:addTriggerBase(triggerBase)
			triggerBase:setSkillBase(skillObj)

			local hitBase = triggerBase:getHitBase()

			hitBase.limit = limit
			hitBase.effectId = effectId
			hitBase.atkEffectId = atkEffectId
		end
	end

	self._createSkillCfg = nil
	self._createIndex = nil

	return skillObj
end

function ArcadeSkillFactory:createSkillTriggerById(effectStr, triggerPoint, condStr)
	if string.nilorempty(effectStr) then
		return
	end

	local condBaseList = self:createSkillCondList(condStr)
	local hitBase = self:createSkillHit(effectStr)

	return ArcadeSkillTriggerNormal.New(condBaseList, hitBase, triggerPoint)
end

function ArcadeSkillFactory:createSkillCondList(condStr)
	local result = {}
	local strList = string.split(condStr, "|")

	if strList then
		for _, str in ipairs(strList) do
			local condBase = self:_newSkillClz(str, ArcadeSkillFactory.CondBaseClzMap, ArcadeSkillCondNormal, true, self._createIndex and ArcadeGameEnum.TriggerCfgKeys.Condition[self._createIndex])

			table.insert(result, condBase)
		end
	end

	return result
end

function ArcadeSkillFactory:createSkillHit(effStr)
	return self:_newSkillClz(effStr, ArcadeSkillFactory.HitBaseClzMap, ArcadeSkillHitNormal, true, self._createIndex and ArcadeGameEnum.TriggerCfgKeys.Effect[self._createIndex])
end

function ArcadeSkillFactory:_newSkillClz(str, clzMap, defineClz, isLogError, key)
	if not string.nilorempty(str) then
		local clz
		local params = string.split(str, "#")

		if params then
			clz = clzMap[params[1]]
		end

		if clz then
			return clz.New(params)
		end

		if isLogError == true then
			if self._createSkillCfg then
				logError(string.format("字段名配置错误，找不到对应的脚本。skillId:[%s] %s==> %s", self._createSkillCfg.id, key, str))
			else
				logError(string.format("字段名配置错误，找不到对应的脚本。==> %s", str))
			end
		end
	end

	return defineClz.New()
end

function ArcadeSkillFactory:createSkillTargetById(id)
	local targetCfg = ArcadeConfig.instance:getSkillTargetCfg(id, true)
	local clz = ArcadeSkillFactory.TargetBaseClzMap[targetCfg and targetCfg.clztype]
	local instClz = clz and clz.New() or ArcadeSkillTargetNormal.New()

	instClz:setTargetConfig(targetCfg)

	return instClz
end

ArcadeSkillFactory.instance = ArcadeSkillFactory.New()

return ArcadeSkillFactory
