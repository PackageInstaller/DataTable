-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Common\\FrameBattle\\AttackProcess\\AttackCalc.lua

local BattleConst = require("Common/FrameBattle/BattleConst")
local skillDataBank = require("Common/FrameBattle/BattleObject/SkillDataBank")
local DamageCalc = require("Common/FrameBattle/AttackProcess/DamageCalc")
local BattleStateData = require("Common/FrameBattle/BattleObject/BattleStateData")
local ResProbConfig = require("ClientData/ResProbConfig")
local ResAttackEffect = require("ClientData/ResAttackEffect")
local ResSkillConfig = require("ClientData/ResSkillConfig")
local math = math
local AttackCalc = {}

AttackCalc.FakeProbInfo = {}
AttackCalc.FakeCritInfo = {}

function AttackCalc.onRandomControl(randomGenerator, probId, prabLevel, attacker, target, probSourceType, probSourceKey)
	if ResProbConfig[probId] then
		local values = ResProbConfig[probId].prob_values
		local canEnhance = ResProbConfig[probId].can_enhance
		local fake_crit = ResProbConfig[probId].fake_crit
		local rate = values[prabLevel]

		if rate then
			local oldRate = rate

			if fake_crit and fake_crit > 0 and attacker and probSourceType and probSourceKey then
				rate = AttackCalc.getPropRate(attacker.id, probSourceType, probSourceKey, oldRate)
			end

			if canEnhance and canEnhance > 0 then
				local enhance = 0

				if attacker then
					enhance = attacker.effect_hit
				end

				local resist = 0

				if attacker and target and attacker.attackCamp ~= target.camp then
					resist = target.effect_miss
				end

				if enhance and resist then
					rate = rate * (1 + enhance - resist)
				end
			end

			local shot = false

			if rate >= 10000 or randomGenerator:random() < rate / 10000 then
				shot = true
			end

			if fake_crit and fake_crit > 0 and attacker and probSourceType and probSourceKey then
				AttackCalc.onPropRate(attacker.id, probSourceType, probSourceKey, oldRate, shot)
			end

			return shot
		end
	end

	return false
end

function AttackCalc.getPropRate(attackerId, probSourceType, propKey, rate)
	local attackerInfo = AttackCalc.FakeCritInfo[attackerId]

	if not attackerInfo then
		return rate
	end

	local probInfo = attackerInfo[probSourceType]

	if not probInfo then
		return rate
	end

	local rateInfo = probInfo[propKey]

	if not rateInfo then
		return rate
	end

	if rateInfo.rate ~= rate then
		return rate
	end

	if rateInfo.nowCount == rateInfo.maxCount then
		return rate
	elseif rateInfo.stillRefresh then
		return (rateInfo.nowCount + 1) * rate
	else
		return rateInfo.lastRate
	end
end

function AttackCalc.onPropRate(attackerId, probSourceType, propKey, rate, critHappened)
	if not AttackCalc.FakeCritInfo[attackerId] then
		AttackCalc.FakeCritInfo[attackerId] = {}
	end

	local attackerInfo = AttackCalc.FakeCritInfo[attackerId]

	if not attackerInfo[probSourceType] then
		attackerInfo[probSourceType] = {}
	end

	local probInfo = attackerInfo[probSourceType]

	if not probInfo[propKey] then
		probInfo[propKey] = {}
	end

	local rateInfo = probInfo[propKey]

	if rateInfo.rate ~= rate then
		rateInfo.rate = rate
		rateInfo.nowCount = 0

		local maxCount = 10000 / rate

		if maxCount - math.floor(maxCount) == 0 then
			rateInfo.maxCount = math.floor(maxCount)
		else
			rateInfo.maxCount = math.floor(maxCount) + 1
		end

		rateInfo.stillRefresh = true
	end

	if rateInfo.nowCount == rateInfo.maxCount then
		rateInfo.nowCount = 0
		rateInfo.stillRefresh = true
	end

	rateInfo.nowCount = rateInfo.nowCount + 1

	if rateInfo.stillRefresh and critHappened and rateInfo.nowCount < rateInfo.maxCount then
		rateInfo.stillRefresh = false
		rateInfo.lastRate = (rateInfo.maxCount * rate - 10000) / (rateInfo.maxCount - rateInfo.nowCount)
	end
end

local AreaFuncTable = {}

local function GetAreaSelfEnemy(objectMgr, attacker, pointTargetId)
	return attacker, attacker.attackCamp == BattleConst.CAMP_PLAYER and BattleConst.CAMP_MONSTER or BattleConst.CAMP_PLAYER
end

local function GetAreaSelfFriend(objectMgr, attacker, pointTargetId)
	return attacker, attacker.attackCamp
end

local function GetAreaTargetEnemy(objectMgr, attacker, pointTargetId)
	return objectMgr:getObjectIncludeAll(pointTargetId), attacker.attackCamp == BattleConst.CAMP_PLAYER and BattleConst.CAMP_MONSTER or BattleConst.CAMP_PLAYER
end

local function GetAreaTargetFriend(objectMgr, attacker, pointTargetId)
	if objectMgr:getObjectIncludeAll(pointTargetId) then
		return objectMgr:getObjectIncludeAll(pointTargetId), attacker.attackCamp
	end
end

local function GetAreaTargetHisEnemy(objectMgr, attacker, pointTargetId)
	local target = objectMgr:getObjectIncludeAll(pointTargetId)

	if target then
		return target, target.camp == BattleConst.CAMP_PLAYER and BattleConst.CAMP_MONSTER or BattleConst.CAMP_PLAYER
	end
end

local function GetAreaTargetHisFriend(objectMgr, attacker, pointTargetId)
	local target = objectMgr:getObjectIncludeAll(pointTargetId)

	if target then
		return target, target.camp
	end
end

AreaFuncTable[BattleConst.TARGET_TARGET_AND_ENEMY] = GetAreaTargetEnemy
AreaFuncTable[BattleConst.TARGET_TARGET_AND_FRIEND] = GetAreaTargetFriend
AreaFuncTable[BattleConst.TARGET_SELF_AND_ENEMY] = GetAreaSelfEnemy
AreaFuncTable[BattleConst.TARGET_SELF_AND_FRIEND] = GetAreaSelfFriend
AreaFuncTable[BattleConst.TARGET_FRIEND] = GetAreaTargetHisFriend
AreaFuncTable[BattleConst.TARGET_ENEMY] = GetAreaTargetHisEnemy

local ChooseFuncTable = {}

local function GetChooseOne(area, objectMgr, attacker, sData, target, selectOne, camp)
	local targets = {}

	targets[selectOne.id] = selectOne

	return targets
end

local function GetChooseOneAndBack(area, objectMgr, attacker, sData, target, selectOne, camp)
	local coordX = selectOne.realCoordX
	local coordY = selectOne.realCoordY

	if attacker.realCoordY == selectOne.realCoordY then
		if attacker.realCoordX < selectOne.realCoordX then
			coordX = coordX + 1
		else
			coordX = coordX - 1
		end
	elseif attacker.realCoordX == selectOne.realCoordX + 0.5 then
		coordX = selectOne.realCoordX - 0.5

		if attacker.realCoordY < selectOne.realCoordY then
			coordY = coordY + 1
		else
			coordY = coordY - 1
		end
	elseif attacker.realCoordX == selectOne.realCoordX - 0.5 then
		coordX = selectOne.realCoordX + 0.5

		if attacker.realCoordY < selectOne.realCoordY then
			coordY = coordY + 1
		else
			coordY = coordY - 1
		end
	end

	local targets = {}

	targets[selectOne.id] = selectOne

	local backT = objectMgr:getObjectReal(coordX, coordY)

	if backT and backT.camp == camp then
		targets[backT.id] = backT
	end

	return targets
end

local function GetChooseOneAndLR(area, objectMgr, attacker, sData, target, selectOne, camp)
	local targets = {}

	targets[selectOne.id] = selectOne

	local forwardX = attacker.realCoordX < target.realCoordX and 1 or -1

	if attacker.realCoordY == target.realCoordY then
		local backT1 = objectMgr:getObjectReal(attacker.realCoordX + forwardX * 0.5, attacker.realCoordY + 1)
		local backT2 = objectMgr:getObjectReal(attacker.realCoordX + forwardX * 0.5, attacker.realCoordY - 1)

		if backT1 and backT1.camp == camp then
			targets[backT1.id] = backT1
		end

		if backT2 and backT2.camp == camp then
			targets[backT2.id] = backT2
		end
	else
		local forwardY = attacker.realCoordY < target.realCoordY and 1 or -1
		local backT1 = objectMgr:getObjectReal(attacker.realCoordX + forwardX * 0.5, attacker.realCoordY + forwardY)
		local backT2 = objectMgr:getObjectReal(attacker.realCoordX + forwardX, attacker.realCoordY)

		if backT1 and backT1.camp == camp then
			targets[backT1.id] = backT1
		end

		if backT2 and backT2.camp == camp then
			targets[backT2.id] = backT2
		end
	end

	return targets
end

local function GetChooseOneAndCross(area, objectMgr, attacker, sData, target, selectOne, camp)
	return
end

local function GetChooseOneAndNear(area, objectMgr, attacker, sData, target, selectOne, camp)
	local targets = {}

	objectMgr:getObjectOfNear(targets, selectOne.realCoordX, selectOne.realCoordY, camp, selectOne.bigMonster)

	if selectOne.camp == camp then
		targets[selectOne.id] = selectOne
	end

	return targets
end

local function GetChooseOneAndNearTwo(area, objectMgr, attacker, sData, target, selectOne, camp)
	local targets = {}

	objectMgr:getObjectOfNear(targets, selectOne.realCoordX, selectOne.realCoordY, camp, selectOne.bigMonster, 2)

	if selectOne.camp == camp then
		targets[selectOne.id] = selectOne
	end

	return targets
end

local function GetChooseOneLine(area, objectMgr, attacker, sData, target, selectOne, camp)
	local targets = {}

	objectMgr:getObjectByCoordY(targets, selectOne.realCoordY, camp)

	return targets
end

local function GetChooseOneLineAndNear(area, objectMgr, attacker, sData, target, selectOne, camp)
	local targets = {}

	objectMgr:getObjectByCoordY(targets, selectOne.realCoordY - 1, camp)
	objectMgr:getObjectByCoordY(targets, selectOne.realCoordY, camp)
	objectMgr:getObjectByCoordY(targets, selectOne.realCoordY + 1, camp)

	return targets
end

local function _needGetOutOfPos(attacker, sData, camp)
	if camp == attacker.attackCamp and (not sData.randomTargetNumber or sData.randomTargetNumber == 0) and sData.filterChuyin ~= 1 then
		return true
	end
end

local function GetChooseAll(area, objectMgr, attacker, sData, target, selectOne, camp)
	local targets = {}

	objectMgr:getObjectByCoordX(targets, nil, camp, nil, _needGetOutOfPos(attacker, sData, camp))

	return targets
end

local function GetChooseAllMinHp(area, objectMgr, attacker, sData, target, selectOne, camp)
	local targets = {}

	objectMgr:getObjectByCoordX(targets, nil, camp)

	if sData and sData.excludeTarget and sData.excludeTarget > 0 and selectOne then
		targets[selectOne.id] = nil
	end

	local minId
	local minHp = -1

	for tid, t in pairs(targets) do
		if minHp > t.hp or minHp < 0 then
			if minId then
				targets[minId] = nil
			end

			minId = tid
			minHp = t.hp
		else
			targets[tid] = nil
		end
	end

	return targets
end

local function GetChooseLineFarest(area, objectMgr, attacker, sData, target, selectOne, camp)
	local targets = {}

	objectMgr:getObjectOfFarest(targets, selectOne.realCoordY, camp)

	return targets
end

local function GetChooseAllHero(area, objectMgr, attacker, sData, target, selectOne, camp)
	local targets = {}

	objectMgr:getObjectByCoordX(targets, nil, camp, true, _needGetOutOfPos(attacker, sData, camp))

	return targets
end

local function GetChooseAllMinHpHero(area, objectMgr, attacker, sData, target, selectOne, camp)
	local targets = {}

	objectMgr:getObjectByCoordX(targets, nil, camp, true)

	local minId
	local minHp = -1

	for tid, t in pairs(targets) do
		if minHp > t.hp or minHp < 0 then
			if minId then
				targets[minId] = nil
			end

			minId = tid
			minHp = t.hp
		else
			targets[tid] = nil
		end
	end

	return targets
end

local function GetChooseAllMinHpPercent(area, objectMgr, attacker, sData, target, selectOne, camp)
	local targets = {}

	objectMgr:getObjectByCoordX(targets, nil, camp)

	local minId
	local minHpPercent = 10

	for tid, t in pairs(targets) do
		if minHpPercent > t.hppct then
			if minId then
				targets[minId] = nil
			end

			minId = tid
			minHpPercent = t.hppct
		else
			targets[tid] = nil
		end
	end

	return targets
end

local function GetChooseAllMinHpPercentHero(area, objectMgr, attacker, sData, target, selectOne, camp)
	local targets = {}

	objectMgr:getObjectByCoordX(targets, nil, camp, true)

	local minId
	local minHpPercent = 10

	for tid, t in pairs(targets) do
		if minHpPercent > t.hppct then
			if minId then
				targets[minId] = nil
			end

			minId = tid
			minHpPercent = t.hppct
		else
			targets[tid] = nil
		end
	end

	return targets
end

local function GetChooseBaseMaster(area, objectMgr, attacker, sData, target, selectOne, camp)
	local targets = {}

	if selectOne and selectOne.master then
		targets[selectOne.master] = objectMgr:getObjectIncludeAll(selectOne.master)
	end

	return targets
end

local function GetChooseAllServant(area, objectMgr, attacker, sData, target, selectOne, camp)
	local targets = {}

	if selectOne then
		objectMgr:getServantByCamp(targets, selectOne.attackCamp)
	end

	return targets
end

local function GetChooseMyServant(area, objectMgr, attacker, sData, target, selectOne, camp)
	local targets = {}

	if selectOne then
		objectMgr:getServantByMaster(targets, selectOne)
	end

	return targets
end

local function GetChooseLineFront(area, objectMgr, attacker, sData, target, selectOne, camp)
	local targets = {}

	if selectOne then
		objectMgr:getObjectOfLine(targets, selectOne.realCoordY, camp, true)
	end

	return targets
end

local function GetChooseAllFront(area, objectMgr, attacker, sData, target, selectOne, camp)
	local targets = {}

	if selectOne then
		objectMgr:getObjectOfLine(targets, nil, camp, true)
	end

	return targets
end

local function GetChooseAllBack(area, objectMgr, attacker, sData, target, selectOne, camp)
	local targets = {}

	if selectOne then
		objectMgr:getObjectOfLine(targets, nil, camp, false)
	end

	return targets
end

local function GetChooseOneAndLineBack(area, objectMgr, attacker, sData, target, selectOne, camp)
	local coordX = selectOne.realCoordX
	local addX = 1

	if selectOne.bigMonster then
		addX = 2
	end

	if attacker.realCoordX > selectOne.realCoordX then
		coordX = selectOne.realCoordX - addX
	elseif attacker.realCoordX <= selectOne.realCoordX then
		coordX = selectOne.realCoordX + addX
	end

	local targets = {}

	targets[selectOne.id] = selectOne

	local backT = objectMgr:getObjectReal(coordX, selectOne.realCoordY)

	if backT and backT.camp == camp then
		targets[backT.id] = backT
	end

	return targets
end

local function GetChooseNewTarget(area, objectMgr, attacker, sData, target, selectOne, camp)
	local targets = {}
	local newTarget = attacker:_getNearestEnemy(9999)

	if newTarget then
		targets[newTarget.id] = newTarget
	end

	return targets
end

local function GetChooseDeadHero(area, objectMgr, attacker, sData, target, selectOne, camp)
	local targets = {}

	if selectOne then
		objectMgr:getDeadHero(targets, camp)
	end

	return targets
end

local function GetChooseAllLineFarest(area, objectMgr, attacker, sData, target, selectOne, camp)
	local targets = {}

	if selectOne then
		objectMgr:getObjectOfFarest(targets, nil, camp, true)
	end

	return targets
end

ChooseFuncTable[BattleConst.TARGET_CHOOSE_ONE] = GetChooseOne
ChooseFuncTable[BattleConst.TARGET_CHOOSE_ONE_AND_BACK] = GetChooseOneAndBack
ChooseFuncTable[BattleConst.TARGET_CHOOSE_ONE_AND_LR] = GetChooseOneAndLR
ChooseFuncTable[BattleConst.TARGET_CHOOSE_ONE_AND_NEAR] = GetChooseOneAndNear
ChooseFuncTable[BattleConst.TARGET_CHOOSE_ONE_LINE] = GetChooseOneLine
ChooseFuncTable[BattleConst.TARGET_CHOOSE_ONE_LINE_AND_NEAR] = GetChooseOneLineAndNear
ChooseFuncTable[BattleConst.TARGET_CHOOSE_ALL] = GetChooseAll
ChooseFuncTable[BattleConst.TARGET_CHOOSE_MIN_HP] = GetChooseAllMinHp
ChooseFuncTable[BattleConst.TARGET_CHOOSE_LINE_FAREST] = GetChooseLineFarest
ChooseFuncTable[BattleConst.TARGET_CHOOSE_ALL_HERO] = GetChooseAllHero
ChooseFuncTable[BattleConst.TARGET_CHOOSE_MIN_HP_HERO] = GetChooseAllMinHpHero
ChooseFuncTable[BattleConst.TARGET_CHOOSE_MIN_HP_PERCENT] = GetChooseAllMinHpPercent
ChooseFuncTable[BattleConst.TARGET_CHOOSE_MIN_HP_PERCENT_HERO] = GetChooseAllMinHpPercentHero
ChooseFuncTable[BattleConst.TARGET_CHOOSE_BASE_MASTER] = GetChooseBaseMaster
ChooseFuncTable[BattleConst.TARGET_CHOOSE_ALL_SERVANT] = GetChooseAllServant
ChooseFuncTable[BattleConst.TARGET_CHOOSE_MY_SERVANT] = GetChooseMyServant
ChooseFuncTable[BattleConst.TARGET_CHOOSE_LINE_FRONT] = GetChooseLineFront
ChooseFuncTable[BattleConst.TARGET_CHOOSE_ALL_FRONT] = GetChooseAllFront
ChooseFuncTable[BattleConst.TARGET_CHOOSE_ALL_BACK] = GetChooseAllBack
ChooseFuncTable[BattleConst.TARGET_CHOOSE_ONE_AND_NEAR_TWO] = GetChooseOneAndNearTwo
ChooseFuncTable[BattleConst.TARGET_CHOOSE_ONE_AND_LINE_BACK] = GetChooseOneAndLineBack
ChooseFuncTable[BattleConst.TARGET_CHOOSE_NEW_TARGET] = GetChooseNewTarget
ChooseFuncTable[BattleConst.TARGET_CHOOSE_DEAD_HERO] = GetChooseDeadHero
ChooseFuncTable[BattleConst.TARGET_CHOOSE_ALL_LINE_FAREST] = GetChooseAllLineFarest

local TARGET_RANDOM_BASE_LOWEST = 1
local TARGET_RANDOM_BASE_HIGHEST = 2
local TARGET_RANDOM_MIN_HP_PERCENT = 3
local TARGET_RANDOM_MAX_HP_PERCENT = 4
local TARGET_RANDOM_NO_SUMMON_MONSTER = 5
local TARGET_RANDOM_SUMMON_MONSTER = 6

local function SelectRandomTargets(priorTargets, randomGenerator, randNum)
	local outTargets = {}

	for _, targets in ipairs(priorTargets) do
		local nowNum = 0

		for _, t in pairs(targets) do
			nowNum = nowNum + 1
		end

		if randNum <= nowNum then
			targets = randomGenerator:randomChoice(targets, randNum)

			for tId, t in pairs(targets) do
				outTargets[tId] = t
			end

			break
		else
			for tId, t in pairs(targets) do
				outTargets[tId] = t
			end

			randNum = randNum - nowNum
		end
	end

	return outTargets
end

local function getSkillEventTargets(objectMgr, attacker, pointTargetId, eventData, skillId)
	if eventData.priorUsePreTarget == 1 and attacker.skillRecordTargets[skillId] then
		local preBase = attacker.skillRecordTargets[skillId][2]

		if preBase and preBase:isAlive() then
			return attacker.skillRecordTargets[skillId][1], attacker.skillRecordTargets[skillId][2]
		else
			local target = attacker:_getNearestEnemy(attacker.attackDist)

			if target then
				pointTargetId = target.id
			end
		end
	end

	if eventData.targetChoose == BattleConst.TARGET_CHOOSE_USE_SKILL_RECORDER then
		if attacker.skillRecordTargets[skillId] then
			return attacker.skillRecordTargets[skillId][1], attacker.skillRecordTargets[skillId][2]
		else
			return {}, nil
		end
	end

	local base
	local targets = {}

	if eventData then
		local oneFunc = AreaFuncTable[eventData.targetArea or BattleConst.TARGET_TARGET_AND_ENEMY]
		local one, camp = oneFunc(objectMgr, attacker, pointTargetId)

		if one then
			local targetFunc = ChooseFuncTable[eventData.targetChoose] or ChooseFuncTable[BattleConst.TARGET_CHOOSE_ONE]

			targets = targetFunc(eventData.targetArea, objectMgr, attacker, eventData, attacker.target, one, camp)

			if targets and eventData.excludeTarget and eventData.excludeTarget > 0 and one then
				targets[one.id] = nil
			end

			base = one
		end
	end

	if targets and eventData and eventData.targetFilter and eventData.targetFilter ~= 0 then
		for tid, target in pairs(targets) do
			if eventData.targetFilter == 1 then
				if target.entityType ~= "Friend" then
					targets[tid] = nil
				end
			elseif eventData.targetFilter == 2 and target.entityType ~= "Monster" then
				targets[tid] = nil
			end
		end
	end

	if targets and eventData and eventData.randomTargetNumber and eventData.randomTargetNumber ~= 0 then
		local randomGenerator = objectMgr:getRandomGenerator()

		if randomGenerator then
			local rule = eventData.randomRule

			if rule == TARGET_RANDOM_BASE_LOWEST and base then
				targets = randomGenerator:randomChoiceByRule(targets, eventData.randomTargetNumber, base.id)
			elseif rule == TARGET_RANDOM_BASE_HIGHEST and base then
				targets = randomGenerator:randomChoiceByRule(targets, eventData.randomTargetNumber - 1, base.id)
				targets[base.id] = base
			elseif rule == TARGET_RANDOM_MIN_HP_PERCENT then
				local minId
				local minHpPercent = 10

				for tid, t in pairs(targets) do
					if minHpPercent > t.hppct then
						if minId then
							targets[minId] = nil
						end

						minId = tid
						minHpPercent = t.hppct
					else
						targets[tid] = nil
					end
				end
			elseif rule == TARGET_RANDOM_MAX_HP_PERCENT then
				local maxId
				local maxHpPercent = 0

				for tid, t in pairs(targets) do
					if maxHpPercent < t.hppct then
						if maxId then
							targets[maxId] = nil
						end

						maxId = tid
						maxHpPercent = t.hppct
					else
						targets[tid] = nil
					end
				end
			elseif rule == TARGET_RANDOM_NO_SUMMON_MONSTER or rule == TARGET_RANDOM_SUMMON_MONSTER then
				local priorTargets = {}
				local firstTargets = {}

				if rule == TARGET_RANDOM_NO_SUMMON_MONSTER then
					for tId, t in pairs(targets) do
						if t.isSummonEntity == 0 then
							firstTargets[tId] = t
							targets[tId] = nil
						end
					end
				elseif rule == TARGET_RANDOM_SUMMON_MONSTER then
					for tId, t in pairs(targets) do
						if t.isSummonEntity == 1 then
							firstTargets[tId] = t
							targets[tId] = nil
						end
					end
				end

				targets = SelectRandomTargets({
					firstTargets,
					targets
				}, randomGenerator, eventData.randomTargetNumber)
			else
				targets = randomGenerator:randomChoice(targets, eventData.randomTargetNumber)
			end
		end
	end

	if targets and eventData.eventCondition and eventData.eventCondition ~= "" then
		local conditionArgs = utils.splitString(eventData.eventCondition, ",")

		for targetId, t in pairs(targets) do
			if not utils.onCheckCondition(attacker, conditionArgs, t) then
				targets[targetId] = nil
			end
		end
	end

	if targets then
		local tempTargets = targets

		targets = {}

		for targetId, t in pairs(tempTargets) do
			if objectMgr:getObjectIncludeAll(targetId) then
				table.insert(targets, targetId)
			end
		end

		table.sort(targets)
	end

	if eventData.recordSkillTargets and eventData.recordSkillTargets > 0 then
		attacker.skillRecordTargets[skillId] = {
			targets,
			base
		}

		for _, targetId in ipairs(targets) do
			attacker.preRecordTarget = targetId

			break
		end
	end

	return targets, base
end

local BOX_TYPE_HEAL = 3
local BOX_TYPE_SHIELD = 4
local STATE_TYPE_BUFF = 1

local function judgeWhenImmune(atkEventData, eventLevel)
	if atkEventData.boxId and atkEventData.boxId > 0 and ResAttackEffect[atkEventData.boxId] then
		local boxInfo = ResAttackEffect[atkEventData.boxId][eventLevel]

		if boxInfo and boxInfo.dmg_type and boxInfo.dmg_type ~= BOX_TYPE_HEAL and boxInfo.dmg_type ~= BOX_TYPE_SHIELD then
			return false
		end
	end

	return true
end

local function judgeHit(attacker, target, skillId, atkEventData, cardId, eventLevel)
	local isAlive = target:isAlive()

	if not isAlive then
		return false
	end

	if target.stateGroup:getProp(BattleConst.STATE_DAMAGE_IMMUNE, 0) > 0 and not judgeWhenImmune(atkEventData, eventLevel) then
		if not attacker:isTeammate(target) and atkEventData.boxId and atkEventData.boxId > 0 then
			target:beHited(attacker, 0, BattleConst.DAMAGE_TYPE_HURT_IMMUE, false, nil, atkEventData)
		end

		return false
	end

	if atkEventData.cantBeDodged then
		return true
	end

	if not atkEventData.boxId or not (atkEventData.boxId > 0) then
		return true
	end

	if not ResSkillConfig[cardId] then
		return true
	end

	if ResSkillConfig[cardId][1].skill_type ~= BattleConst.SKILL_CONFIG_CA then
		return true
	end

	if not attacker:isTeammate(target) and target:missEnable() then
		local hitRate = attacker.hit_rate
		local missRate = target.miss
		local realHitRate = hitRate - missRate

		if realHitRate >= 1 then
			return true
		end

		local isHited = false

		if realHitRate > 0 and realHitRate > attacker.randomGenerator:random() then
			isHited = true
		else
			target:beHited(attacker, 0, BattleConst.DAMAGE_TYPE_MISS, false, nil, atkEventData)
		end

		return isHited
	else
		return true
	end
end

local function getAttackPropCache(attacker, target)
	local propCache = {}

	for index, propName in ipairs(DamageCalc.Props) do
		if attacker[propName] then
			propCache[propName] = attacker[propName]
		end
	end

	for propName, funcName in pairs(DamageCalc.SpecialProps) do
		propCache["sp_" .. propName] = attacker[funcName](attacker, target)
	end

	return propCache
end

local function onHitTarget(attacker, target, skillId, eventData, objectMgr, skillPower, propCache, eventLevel, cardId, hitNum, baseId)
	local randomGenerator = objectMgr:getRandomGenerator()

	AttackCalc._onCheckEventState(attacker, target, skillId, eventData, objectMgr, skillPower, cardId, propCache, eventLevel, randomGenerator, baseId)
	AttackCalc._onCheckEventMana(attacker, target, skillId, eventData, objectMgr, skillPower, cardId, propCache, eventLevel, randomGenerator)
	AttackCalc._onCheckEventSummon(attacker, target, skillId, eventData, objectMgr, skillPower, cardId, propCache, eventLevel, randomGenerator)

	return AttackCalc._onCheckEventBox(attacker, target, skillId, eventData, objectMgr, skillPower, cardId, propCache, eventLevel, randomGenerator, hitNum, baseId)
end

local SELECT_MODE_CHOSEN = 2

function AttackCalc._onCheckEventState(attacker, target, skillId, eventData, objectMgr, skillPower, cardId, propCache, eventLevel, randomGenerator, baseId)
	local stun = eventData.stunTime

	if stun and stun > 0 then
		target:beHitedControlled(stun, attacker, "stun")
	end

	if eventData.controlTime and eventData.controlTime > 0 then
		target:beHitedControlled(eventData.controlTime, attacker, eventData.controlAniName)
	end

	local state = eventData.state

	if state then
		local stateCondition = state.stateCondition

		if stateCondition == 1 then
			if not objectMgr:nearIsEmpty(target) then
				return
			end
		elseif stateCondition == 2 and not objectMgr:nearIsEmpty(target, true) then
			return
		end

		local stateProbId = state.stateProbId
		local stateProbOk = true

		if stateProbId and ResProbConfig[stateProbId] then
			stateProbOk = AttackCalc.onRandomControl(randomGenerator, stateProbId, eventLevel, attacker, target, BattleConst.FAKE_PROB_TYPE_STATE, stateProbId)
		end

		if stateProbOk then
			local stateOpt = state.stateOperation or 0

			if stateOpt == 0 then
				local stateId = state.stateId
				local duration = state.duration

				if stateId and stateId > 0 and duration and (duration > 0 or duration == BattleConst.STATE_DURATION_UNLIMIT) then
					local stateLevel = eventLevel

					attacker.passiveGroup:onPassiveTrigger(BattleConst.PASSIVE_TRIGGER_TYPE_ATTACK_RESULT, {
						BattleConst.PASSIVE_TRIGGER_ATTACK_STATE,
						target,
						stateId,
						stateLevel
					})
					target:addBattleState(attacker, stateId, stateLevel, duration, cardId)
					target.passiveGroup:onPassiveTrigger(BattleConst.PASSIVE_TRIGGER_TYPE_BEING_ATTACKED_RESULT, {
						BattleConst.PASSIVE_TRIGGER_ATTACK_STATE,
						attacker,
						stateId,
						stateLevel
					})
				end
			elseif stateOpt == 1 then
				local selectType = state.chooseStateType or 0
				local selectMode = state.chooseStateMode or 0
				local randomCount = state.chooseRandomNum
				local selectIds = state.chooseStateIds

				if selectType and selectMode then
					local dispelNumber = target:delBattleState(selectType, selectMode, randomCount, selectIds)

					if selectMode ~= SELECT_MODE_CHOSEN then
						target:addOutput(BattleConst.MATRIX_EVENT_ENTITY_SOMETHING, {
							BattleConst.ENTITY_SOMETHING_DEL_STATE
						})
					end

					attacker.passiveGroup:onPassiveTrigger(BattleConst.PASSIVE_TRIGGER_TYPE_ATTACK_RESULT, {
						BattleConst.PASSIVE_TRIGGER_ATTACK_DISPEL,
						target,
						selectType,
						dispelNumber
					})
				end
			elseif stateOpt == 2 then
				local selectType = state.chooseStateType or BattleConst.STATE_TYPE_ALL
				local selectMode = state.chooseStateMode or 0
				local randomCount = state.chooseRandomNum
				local selectIds = state.chooseStateIds
				local extendTime = state.duration
				local layerModeState = state.layerState

				if layerModeState and layerModeState > 0 then
					extendTime = (extendTime or 0) * target:getStateLayer(layerModeState, attacker.id)
				end

				if selectType and selectMode and extendTime and extendTime > 0 then
					target:extendBattleState(selectType, selectMode, randomCount, selectIds, extendTime)
				end
			elseif stateOpt == 3 then
				local stateId = state.stateId
				local base = objectMgr:getObjectIncludeAll(baseId)

				if stateId and stateId > 0 and base then
					local stateInfo = base:getStateRemainedTime(stateId, attacker.id)

					if stateInfo then
						local stateLevel = stateInfo[1]

						for index, num in ipairs(stateInfo[2]) do
							if num < BattleConst.STATE_DURATION_UNLIMIT_FRAME then
								local duration = num * target.frameLength / 1000

								target:addBattleState(attacker, stateId, stateLevel, duration, cardId)
							else
								target:addBattleState(attacker, stateId, stateLevel, BattleConst.STATE_DURATION_UNLIMIT, cardId)
							end
						end
					end
				end
			elseif stateOpt == 4 then
				local stateId = state.stateId
				local delLayer = state.delLayer or 1

				if stateId then
					target:delStateLayer(attacker, stateId, delLayer)
				end
			end
		end
	end
end

function AttackCalc._onCheckEventMana(attacker, target, skillId, eventData, objectMgr, skillPower, cardId, propCache, eventLevel, randomGenerator)
	local addManaNumber = eventData.addManaNumber

	if addManaNumber and addManaNumber ~= 0 then
		local addManaProbId = eventData.addManaProbId
		local addManaProbOk = true

		if addManaProbId and ResProbConfig[addManaProbId] then
			addManaProbOk = AttackCalc.onRandomControl(randomGenerator, addManaProbId, eventLevel, attacker, target, BattleConst.FAKE_PROB_TYPE_ADDMANA, 1)
		end

		if addManaProbOk and addManaNumber and addManaNumber ~= 0 then
			target:onAttackChangeMana(addManaNumber, eventData.manaNotShow == 1)
			attacker.passiveGroup:onPassiveTrigger(BattleConst.PASSIVE_TRIGGER_TYPE_ATTACK_RESULT, {
				BattleConst.PASSIVE_TRIGGER_ATTACK_MANA,
				addManaNumber
			})
		end
	end
end

function AttackCalc._onCheckEventSummon(attacker, target, skillId, eventData, objectMgr, skillPower, cardId, propCache, eventLevel, randomGenerator)
	if eventData.summonMonsters and eventData.summonMonsters ~= "" then
		local monsters = {}

		for index, monsterId in ipairs(utils.splitString(eventData.summonMonsters, ",")) do
			if tonumber(monsterId) then
				table.insert(monsters, tonumber(monsterId))
			end
		end

		if next(monsters) then
			objectMgr:onsummonMonsters(attacker, monsters, eventData.summonLineChoose)
		end
	end

	if eventData.weatherFlag and eventData.weatherFlag > 0 then
		objectMgr.weatherManager:enterWeather(eventData.weatherFlag, eventData.weatherTime, attacker)
	end

	if eventData.isChuyin and eventData.isChuyin == 1 then
		attacker:moveOutOfPos()
	end
end

function AttackCalc._onCheckEventBox(attacker, target, skillId, eventData, objectMgr, skillPower, cardId, propCache, eventLevel, randomGenerator, hitNum, baseId)
	if not attacker:isTeammate(target) and target.petId then
		return false
	end

	if eventData.hitedAnim and eventData.hitedAnim ~= "" then
		target:beHitedAnim(eventData.hitedAnim)
	end

	if eventData.hitedOffset and eventData.hitedOffset ~= "" then
		target:beHitedOffset(eventData.hitedOffset)
	end

	if eventData.boxId and ResAttackEffect[eventData.boxId] then
		local hadKillSomeone = false
		local results = DamageCalc.calcDamageResult(propCache, target, eventData.boxId, eventLevel, randomGenerator, skillPower, objectMgr, {
			attacker,
			cardId,
			skillId,
			hitNum,
			baseId
		})

		for index, rInfo in ipairs(results) do
			local damageType = rInfo[1]

			target = rInfo[4]

			local extraInfo = rInfo[5]
			local vamPireInvalie = damageType == BattleConst.DAMAGE_TYPE_VAMPIRE and not attacker:isAlive()
			local healInvalid = damageType == BattleConst.DAMAGE_TYPE_HEAL and not target:isAlive()

			if not vamPireInvalie and not healInvalid then
				local damageAmount = rInfo[2]
				local isCrit = rInfo[3]

				if damageType == BattleConst.DAMAGE_TYPE_VAMPIRE then
					attacker:beHited(attacker, damageAmount, damageType, isCrit)
				elseif damageType == BattleConst.DAMAGE_TYPE_REBOUND then
					attacker:beHited(target, damageAmount, damageType, false)
				else
					if BattleConst.HURT_DICT[damageType] and not eventData.notRecordLastDamage then
						attacker.lastDamage = damageAmount[1]
					end

					if damageType == BattleConst.DAMAGE_TYPE_HEAL and not eventData.notRecordLastDamage then
						attacker.lastHeal = damageAmount
					end

					if target:beHited(attacker, damageAmount, damageType, isCrit, {
						cardId,
						skillId
					}, eventData, eventData.eventType == 1, extraInfo) then
						hadKillSomeone = true
					end
				end
			end
		end

		return hadKillSomeone
	end
end

function AttackCalc.onCalcAttack(objectMgr, attacker, attackArgs, skillPower, delayTime, flySpeed)
	skillPower = skillPower or 10000

	if skillPower < 0 then
		skillPower = 0
	end

	local realTime = true

	if delayTime and delayTime > 0 or flySpeed and flySpeed > 0 then
		realTime = false
	end

	local skillId = attackArgs[1]
	local pointTargetId = attackArgs[2]
	local eventId = attackArgs[3]
	local eventLevel = attackArgs[4]
	local cardId = attackArgs[5]
	local atkEventData = skillDataBank.getAtkEventData(attacker.weaponType, skillId, eventId, eventLevel)

	if not atkEventData then
		return
	end

	local probId = atkEventData.eventProbId
	local targets, base = getSkillEventTargets(objectMgr, attacker, pointTargetId, atkEventData, skillId)

	if not targets then
		return
	end

	local delayArgs
	local hitNum = #targets

	if attacker.recordSkillHitEvent == eventId and attacker.recordSkillHitSkill == skillId then
		attacker:addSkillHitNum(hitNum)
	end

	local baseId = pointTargetId

	if base then
		baseId = base.id
	end

	if realTime then
		local lastTart
		local realHited = false

		for _, tid in ipairs(targets) do
			local target = objectMgr:getObjectIncludeAll(tid)
			local probOk = true

			if probId and ResProbConfig[probId] then
				probOk = AttackCalc.onRandomControl(objectMgr:getRandomGenerator(), probId, eventLevel, attacker, target, BattleConst.FAKE_PROB_TYPE_EVENT, 1)
			end

			if probOk then
				lastTart = target
				realHited = AttackCalc._realHitOne(attacker, target, skillId, atkEventData, objectMgr, skillPower, attacker, eventLevel, cardId, hitNum, baseId)
			end
		end

		if base and (atkEventData.atkCue or atkEventData.baseCue) then
			if realHited then
				attacker:addOutput(BattleConst.MATRIX_EVENT_ENTITY_PLAYATKCUE, {
					base.id,
					atkEventData.atkCue,
					atkEventData.baseCue
				})
			else
				attacker:addOutput(BattleConst.MATRIX_EVENT_ENTITY_PLAYATKCUE, {
					base.id,
					atkEventData.atkCue
				})
			end
		end

		if atkEventData.offsetTime and atkEventData.offsetTime > 0 and lastTart then
			attacker:onOffsetTarget(lastTart, atkEventData.offsetTime)
		end

		if atkEventData.subEventSkill and atkEventData.subEventSkill > 0 and atkEventData.subEventType == 1 then
			AttackCalc.raiseSubEventSkill(objectMgr, attacker, atkEventData, pointTargetId, cardId, eventLevel)
		end
	else
		delayArgs = {}

		for _, tid in ipairs(targets) do
			local target = objectMgr:getObjectIncludeAll(tid)
			local probOk = true

			if probId and ResProbConfig[probId] then
				probOk = AttackCalc.onRandomControl(objectMgr:getRandomGenerator(), probId, eventLevel, attacker, target, BattleConst.FAKE_PROB_TYPE_EVENT, 1)
			end

			if probOk then
				local propCache = getAttackPropCache(attacker, target)
				local flyTime

				if delayTime and delayTime > 0 then
					flyTime = delayTime
				elseif atkEventData.baseToTarget == 1 and base then
					flyTime = (math.abs(base.realCoordX - target.realCoordX) + math.abs(base.realCoordY - target.realCoordY)) * flySpeed
				else
					flyTime = (math.abs(attacker.realCoordX - target.realCoordX) + math.abs(attacker.realCoordY - target.realCoordY)) * flySpeed
				end

				local flyCueId = atkEventData.flyCueId

				if flyCueId > 0 then
					if atkEventData.baseToTarget == 1 and base then
						base:addOutput(BattleConst.MATRIX_EVENT_ENTITY_PLAY_EFFECT, {
							flyCueId,
							tid,
							flyTime
						})
					else
						attacker:addOutput(BattleConst.MATRIX_EVENT_ENTITY_PLAY_EFFECT, {
							flyCueId,
							tid,
							flyTime
						})
					end
				end

				local flyFrame = math.max(1, math.ceil(flyTime * attacker.framePerSec))

				if not delayArgs[flyFrame] then
					delayArgs[flyFrame] = {
						{},
						skillPower,
						base,
						cardId,
						hitNum,
						baseId
					}
				end

				table.insert(delayArgs[flyFrame][1], {
					target,
					propCache
				})
			end
		end
	end

	return delayArgs
end

function AttackCalc.calcDelayAttack(objectMgr, attacker, attackArgs, delayInfo)
	local skillId = attackArgs[1]
	local pointTargetId = attackArgs[2]
	local eventId = attackArgs[3]
	local eventLevel = attackArgs[4]
	local delayTargets = delayInfo[1]
	local skillPower = delayInfo[2]
	local base = delayInfo[3]
	local cardId = delayInfo[4]
	local hitNum = delayInfo[5]
	local baseId = delayInfo[6]
	local atkEventData = skillDataBank.getAtkEventData(attacker.weaponType, skillId, eventId, eventLevel)

	if not atkEventData then
		return
	end

	local realHited = false

	for _, targetInfo in ipairs(delayTargets) do
		local target = targetInfo[1]
		local propCache = targetInfo[2]

		if target.camp ~= attacker.attackCamp or target:isAlive() then
			realHited = AttackCalc._realHitOne(attacker, target, skillId, atkEventData, objectMgr, skillPower, propCache, eventLevel, cardId, hitNum, baseId)
		end
	end

	if base and (atkEventData.atkCue or atkEventData.baseCue) then
		if realHited then
			attacker:addOutput(BattleConst.MATRIX_EVENT_ENTITY_PLAYATKCUE, {
				base.id,
				atkEventData.atkCue,
				atkEventData.baseCue
			})
		else
			attacker:addOutput(BattleConst.MATRIX_EVENT_ENTITY_PLAYATKCUE, {
				base.id,
				atkEventData.atkCue
			})
		end
	end

	if atkEventData.subEventSkill and atkEventData.subEventSkill > 0 and atkEventData.subEventType == 1 then
		AttackCalc.raiseSubEventSkill(objectMgr, attacker, atkEventData, pointTargetId, cardId, eventLevel)
	end
end

function AttackCalc.raiseSubEventSkill(objectMgr, attacker, atkEventData, pointTargetId, cardId, eventLevel)
	if atkEventData.subEventId and atkEventData.subEventId > 0 then
		attacker:triggerSkillEvent(atkEventData.subEventSkill, atkEventData.subEventId, pointTargetId, cardId, eventLevel)
	elseif atkEventData.subRandomEvents and atkEventData.subRandomNum then
		local subRandomEvents = utils.splitString(atkEventData.subRandomEvents, ",")
		local randomGenerator = objectMgr:getRandomGenerator()

		for index = 1, atkEventData.subRandomNum do
			local randomIndex = randomGenerator:random(1, #subRandomEvents)
			local eventId = table.remove(subRandomEvents, randomIndex)

			eventId = tonumber(eventId)

			if eventId then
				attacker:triggerSkillEvent(atkEventData.subEventSkill, eventId, pointTargetId, cardId, eventLevel)
			end
		end
	end
end

function AttackCalc._realHitOne(attacker, target, skillId, atkEventData, objectMgr, skillPower, propCache, eventLevel, cardId, hitNum, baseId)
	local hited = judgeHit(attacker, target, skillId, atkEventData, cardId, eventLevel)

	if hited then
		if atkEventData.boxId == 1100252 and skillPower then
			if skillPower > 15000 then
				skillPower = skillPower - 5000
			elseif skillPower > 13000 then
				skillPower = skillPower - 3000
			elseif skillPower >= 12000 then
				skillPower = skillPower - 1000
			end
		end

		local isDead = onHitTarget(attacker, target, skillId, atkEventData, objectMgr, skillPower, propCache, eventLevel, cardId, hitNum, baseId)

		if atkEventData.hitCue then
			attacker:addOutput(BattleConst.MATRIX_EVENT_ENTITY_PLAYHITCUE, {
				target.id,
				atkEventData.hitCue
			})
		end

		if atkEventData.subEventSkill and atkEventData.subEventSkill > 0 and atkEventData.subEventType ~= 1 and (atkEventData.subEventCondition ~= 1 or isDead) then
			AttackCalc.raiseSubEventSkill(objectMgr, attacker, atkEventData, target.id, cardId, eventLevel)
		end

		return true
	elseif atkEventData.rebornMhp and atkEventData.rebornMhp > 0 and not target:isAlive() then
		objectMgr:onRebornEntity(attacker, target, atkEventData.rebornMhp)
	end

	return false
end

function AttackCalc.getSkillTargets(objectMgr, attacker, pointTargetId, skillId, eventLevel, eventId)
	if eventId == nil then
		return
	end

	local atkEventData = skillDataBank.getAtkEventData(attacker.weaponType, skillId, eventId, eventLevel)

	if not atkEventData then
		return
	end

	local targets, base = getSkillEventTargets(objectMgr, attacker, pointTargetId, atkEventData, skillId)

	return targets, base
end

function AttackCalc.getSkillLockTarget(objectMgr, attacker, skillTarget)
	local targets = {}

	if skillTarget == BattleConst.SKILL_TARGET_SELF then
		return attacker
	elseif skillTarget == BattleConst.SKILL_TARGET_MIN_HP_FRIEND then
		targets = GetChooseAllMinHp(0, objectMgr, attacker, nil, attacker, attacker, attacker.attackCamp)
	elseif skillTarget == BattleConst.SKILL_TARGET_MIN_HP_ENEMY then
		targets = GetChooseAllMinHp(0, objectMgr, attacker, nil, attacker, attacker, attacker.attackCamp == BattleConst.CAMP_PLAYER and BattleConst.CAMP_MONSTER or BattleConst.CAMP_PLAYER)
	elseif skillTarget == BattleConst.SKILL_TARGET_CA_IGNORE_BIG then
		return attacker:_getNearestEnemy(9999, true)
	elseif skillTarget == BattleConst.SKILL_TARGET_CA_LINE_FAREST then
		local target = attacker:_getNearestEnemy(9999, true)

		if target then
			targets = GetChooseLineFarest(0, objectMgr, attacker, nil, target, target, target.camp)
		end
	else
		return attacker:_getNearestEnemy(attacker.attackDist)
	end

	for targetId, target in pairs(targets) do
		return target
	end
end

return AttackCalc
