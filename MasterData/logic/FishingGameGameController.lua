-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fishinggame/controller/FishingGameGameController.lua

module("logic.extensions.fishinggame.controller.FishingGameGameController", package.seeall)

local FishingGameGameController = class("FishingGameGameController", BaseController)
local SceneMinX = -640
local SceneMaxX = 640
local SceneMinY = -360
local SceneMaxY = 360
local WaterY = 23
local PowerGridStartY = -330
local AttackStartDistanceX = 30
local AttackCheckY = 270
local AttackHitFreezeTime = 1

function FishingGameGameController:onInit()
	self:onReset()
end

function FishingGameGameController:onReset()
	self._comTemplateMap = {}
	self._unitPoolMap = {}
	self._unitPoolComMap = {}
	self._curUnitMap = {}
	self._curUnitMapsByType = {}
	self._unitNum = 0
	self._powerGridEffectTimer = 0
end

function FishingGameGameController:initGame()
	self:destroyGame()

	self._comTemplateMap = self._comTemplateMap or {}
end

function FishingGameGameController:destroyGame()
	self:resetGameUnits()
	self:clearObjectPool()

	if self._boatCon then
		self._boatCon:destroy()

		self._boatCon = nil
	end

	self._boatUnit = nil
end

function FishingGameGameController:setUnitComTemplate(unitTag, copyInstance)
	if not copyInstance then
		printError("FishingGameGameController:setUnitComTemplate copyInstance is nil, unitTag:", unitTag)

		return
	end

	self._comTemplateMap = self._comTemplateMap or {}
	self._comTemplateMap[unitTag] = copyInstance

	goutil.setActive(copyInstance, false)
end

function FishingGameGameController:setPlayerRoot(playerRoot)
	self._playerRoot = playerRoot
end

function FishingGameGameController:setActivityId(activityId)
	self._activityId = checknumber(activityId)

	local actCfg = FishingGameConfig.instance:getActivityCfg(self._activityId) or {}

	self:setGamePlanId(actCfg.gamePlanId)
end

function FishingGameGameController:setGamePlanId(gamePlanId)
	self._gamePlanId = checknumber(gamePlanId)
end

function FishingGameGameController:resetGame()
	self:resetGameUnits()

	self._gameCfg = FishingGameConfig.instance:getGameCfg(self._gamePlanId) or {}
	self._fishPlanId = checknumber(self._gameCfg.fishPlanId)
	self._unitNum = 0
	self._score = 0
	self._blood = checknumber(self._gameCfg.blood)
	self._leftTime = checknumber(self._gameCfg.time)
	self._isGameOver = false
	self._isGameStarted = false
	self._hasSendEnd = false
	self._caughtUnit = nil
	self._curUnitMapsByType = {}
	self._curUnitMap = {}
	self._freezeTimer = 0
	self._powerGridEffectTimer = 0
	self._powerGridTimer = checknumber(self._gameCfg.electricGridInterval)
	self._attackFishTimer = 0

	self:_buildFishWeightMap()
	self:_createBoat()
	self:_createInitialFishes()
	self:_createGrass()
	self:_createTreasureBoxes()
end

function FishingGameGameController:startGame()
	if self._isGameOver then
		return
	end

	self._isGameStarted = true

	if self._boatUnit then
		self._boatUnit:startCast()
	end
end

function FishingGameGameController:isGameStarted()
	return self._isGameStarted
end

function FishingGameGameController:isGameOver()
	return self._isGameOver
end

function FishingGameGameController:getScore()
	return checknumber(self._score)
end

function FishingGameGameController:getBlood()
	return checknumber(self._blood)
end

function FishingGameGameController:getLeftTime()
	return math.max(0, math.ceil(checknumber(self._leftTime)))
end

function FishingGameGameController:markEndSent()
	self._hasSendEnd = true
end

function FishingGameGameController:hasSendEnd()
	return self._hasSendEnd
end

function FishingGameGameController:setBoatDirect(direct)
	if self._boatUnit then
		self._boatUnit:setBoatDirect(direct)
	end
end

function FishingGameGameController:getCurDeltaTime()
	return UnityEngine.Time.deltaTime
end

function FishingGameGameController:updateGame()
	if self._isGameOver or not self._isGameStarted then
		return
	end

	local deltaTime = self:getCurDeltaTime()

	self:_updateFreeze(deltaTime)
	self:_updatePowerGridEffect(deltaTime)
	self:_updateGameTimer(deltaTime)

	if self._boatUnit then
		self._boatUnit:update(deltaTime)

		if self._boatCon then
			self._boatCon:updateUI(deltaTime)
		end
	end

	self:_updateUnits(deltaTime)
	self:_updateSpawn(deltaTime)
	self:_checkHookCollision()
	self:_updateCaughtUnit()
	self:_checkThrowingUnits()
	self:_recycleOutSceneUnits()
	self:_refillFishes()
	self:_updateSibling()
end

function FishingGameGameController:resetGameUnits()
	if self._curUnitMap then
		local unitList = {}

		for _, unit in pairs(self._curUnitMap) do
			table.insert(unitList, unit)
		end

		for _, unit in ipairs(unitList) do
			self:destroyUnit(unit)
		end

		table.clear(self._curUnitMap)
	end

	if self._curUnitMapsByType then
		for unitType, map in pairs(self._curUnitMapsByType) do
			table.clear(map)

			self._curUnitMapsByType[unitType] = nil
		end

		table.clear(self._curUnitMapsByType)
	end

	self._caughtUnit = nil
end

function FishingGameGameController:clearObjectPool()
	if self._unitPoolMap then
		for unitType, pool in pairs(self._unitPoolMap) do
			pool:clear()

			self._unitPoolMap[unitType] = nil
		end
	end

	if self._unitPoolComMap then
		for unitType, pool in pairs(self._unitPoolComMap) do
			pool:clear()

			self._unitPoolComMap[unitType] = nil
		end
	end

	self._unitPoolMap = {}
	self._unitPoolComMap = {}
end

function FishingGameGameController:createUnit(unitType)
	self._unitNum = checknumber(self._unitNum) + 1
	self._unitPoolMap = self._unitPoolMap or {}
	self._unitPoolMap[unitType] = self._unitPoolMap[unitType] or self:_createUnitPool(unitType)
	self._curUnitMapsByType[unitType] = self._curUnitMapsByType[unitType] or {}

	local unit = self._unitPoolMap[unitType]:fetchObject()

	unit:setUnitId(self._unitNum)

	self._curUnitMap[self._unitNum] = unit
	self._curUnitMapsByType[unitType][self._unitNum] = unit

	return unit
end

function FishingGameGameController:destroyUnit(unit)
	if not unit then
		return
	end

	local unitType = unit:getType()
	local unitId = unit:getUnitId()

	self._curUnitMap[unitId] = nil

	if self._curUnitMapsByType[unitType] then
		self._curUnitMapsByType[unitType][unitId] = nil
	end

	local unitCom = unit:getCom()

	if unitCom and self._unitPoolComMap[unitType] then
		unit:clearCom()
		self._unitPoolComMap[unitType]:returnObject(unitCom)
	end

	if self._unitPoolMap[unitType] then
		self._unitPoolMap[unitType]:returnObject(unit)
	end
end

function FishingGameGameController:_createUnitPool(unitType)
	local function createFunc()
		local unitClass = self:_getUnitClass(unitType)

		return unitClass.New()
	end

	local function disposeFunc(obj)
		obj:reset()
	end

	local function resetFunc(obj)
		obj:reset()
	end

	return ObjectPool.New(20, createFunc, disposeFunc, resetFunc)
end

function FishingGameGameController:createUnitCom(unitType)
	self._unitPoolComMap[unitType] = self._unitPoolComMap[unitType] or self:_createConPool(unitType)

	return self._unitPoolComMap[unitType]:fetchObject()
end

function FishingGameGameController:_createConPool(unitType)
	local template = self._comTemplateMap[unitType]

	local function createFunc()
		if not template then
			printError("FishingGameGameController:_createConPool template is nil, unitType:", unitType)

			return nil
		end

		local go = goutil.cloneAndSetParent(template, template.transform.parent)
		local conClass = self:_getUnitConClass(unitType)

		return conClass.New(go)
	end

	local function disposeFunc(obj)
		obj:destroy()
	end

	local function resetFunc(obj)
		obj:reset()
	end

	return ObjectPool.New(20, createFunc, disposeFunc, resetFunc)
end

function FishingGameGameController:_createBoat()
	local playerInstance = self._comTemplateMap[FishingGameEnum.UnitType.Player]

	if not playerInstance then
		printError("FishingGameGameController:_createBoat no player template")

		return
	end

	if self._boatCon then
		self._boatCon:destroy()

		self._boatCon = nil
	end

	if self._playerRoot then
		if not self._playerRoot.transform then
			local playerParent = playerInstance.transform.parent
			local playerGo = goutil.cloneAndSetParent(playerInstance, playerParent, "player")

			self._boatUnit = FishingGameBoat.New(self._gameCfg)
			self._boatCon = FishingGameBoatCon.New(playerGo)

			self._boatUnit:setCom(self._boatCon)
			goutil.setActive(playerGo, true)
		end
	end
end

function FishingGameGameController:_buildFishWeightMap()
	self._fishCfgs = FishingGameConfig.instance:getFishCfgs(self._fishPlanId) or {}
	self._fishWeightMap = {}

	for _, cfg in pairs(self._fishCfgs) do
		if checknumber(cfg.weight) > 0 then
			self._fishWeightMap[cfg.fishId] = cfg.weight
		end
	end
end

function FishingGameGameController:_createInitialFishes()
	for i = 1, checknumber(self._gameCfg.fishNum) do
		self:_createRandomFish(true)
	end
end

function FishingGameGameController:_createRandomFish(isInScene)
	local fishId = MathUtil.randomWithWeightHashtable(self._fishWeightMap)
	local fishCfg = FishingGameConfig.instance:getFishCfg(self._fishPlanId, fishId)

	if not fishCfg then
		return
	end

	local unitType = checknumber(fishCfg.type)
	local pos = isInScene and self:_getRandomFishInScenePos(fishCfg) or self:_getRandomFishEdgePos(fishCfg)
	local unit = self:_createHookableUnit(unitType, fishCfg, pos.x, pos.y)

	if unit then
		if pos.x < 0 then
			unit:setFishHorizontalDirect(FishingGameEnum.FishDirect.Right)
		else
			unit:setFishHorizontalDirect(FishingGameEnum.FishDirect.Left)
		end
	end
end

function FishingGameGameController:_createGrass()
	local grassCfg = self:_getCfgByType(FishingGameEnum.FishType.Grass)

	if not grassCfg then
		return
	end

	for i = 1, checknumber(self._gameCfg.grassNum) do
		local pos = self:_getRandomPosByRanges(self._gameCfg.grassPosX, self._gameCfg.grassPosY)
		local unit = self:_createHookableUnit(FishingGameEnum.FishType.Grass, grassCfg, pos.x, pos.y)

		if unit then
			unit:setOriginPosition(pos.x, pos.y)
		end
	end
end

function FishingGameGameController:_createTreasureBoxes()
	local treasureCfg = self:_getCfgByType(FishingGameEnum.FishType.TreasureBox)

	if treasureCfg then
		local pos = self:_getRandomPosByRanges(self._gameCfg.unLimitTreasureBoxX, self._gameCfg.treasureBoxYRange)

		self:_createHookableUnit(FishingGameEnum.FishType.TreasureBox, treasureCfg, pos.x, pos.y)
	end

	local limitTreasureCfg = self:_getCfgByType(FishingGameEnum.FishType.LimitTreasureBox)

	if not limitTreasureCfg then
		return
	end

	if not self._gameCfg.limitTreasureBoxNum then
		local numRange = {
			1,
			1
		}
		local treasureNum = self:_randomInRange(numRange)

		for i = 1, treasureNum do
			local pos = self:_getRandomPosByRanges(self._gameCfg.limitTreasureBoxX, self._gameCfg.treasureBoxYRange)
			local unit = self:_createHookableUnit(FishingGameEnum.FishType.LimitTreasureBox, limitTreasureCfg, pos.x, pos.y)

			if unit then
				if not self._gameCfg.limitTreasureOpenTime then
					local openRange = {
						0,
						0
					}
					local openTimer = self:_randomInRange(openRange)

					unit:setLimitTreasureTimer(openTimer, checknumber(self._gameCfg.limitTreasureCountDownTime))
				end
			end
		end
	end
end

function FishingGameGameController:_createPowerGrid()
	local powerGridCfg = self:_getCfgByType(FishingGameEnum.FishType.PowerGrid)

	if not powerGridCfg then
		return
	end

	if not self._gameCfg.electricGridXRange then
		local xRange = {
			SceneMinX,
			SceneMaxX
		}
		local posX = self:_randomInRange(xRange)

		self:_createHookableUnit(FishingGameEnum.FishType.PowerGrid, powerGridCfg, posX, PowerGridStartY)
	end
end

function FishingGameGameController:_createHookableUnit(unitType, cfg, posX, posY)
	local unit = self:createUnit(unitType)

	unit:setFishCfg(self._fishPlanId, cfg, unitType)
	unit:setPosition(posX, posY)

	local unitCom = self:createUnitCom(unitType)

	unit:setCom(unitCom)

	return unit
end

function FishingGameGameController:_updateFreeze(deltaTime)
	if self._freezeTimer > 0 then
		self._freezeTimer = math.max(0, self._freezeTimer - deltaTime)
	end

	if self._boatUnit then
		self._boatUnit:setFrozen(self._freezeTimer > 0)
	end
end

function FishingGameGameController:_updatePowerGridEffect(deltaTime)
	if self._powerGridEffectTimer > 0 then
		self._powerGridEffectTimer = math.max(0, self._powerGridEffectTimer - deltaTime)
	end
end

function FishingGameGameController:_updateGameTimer(deltaTime)
	self._leftTime = self._leftTime - deltaTime

	if self._leftTime <= 0 then
		self._leftTime = 0
		self._isGameOver = true
	end
end

function FishingGameGameController:_updateUnits(deltaTime)
	local destroyList = {}

	for _, unit in pairs(self._curUnitMap) do
		unit:update(deltaTime)

		if unit:isLimitTreasureExpired() then
			table.insert(destroyList, unit)
		end
	end

	for _, unit in ipairs(destroyList) do
		self:destroyUnit(unit)
	end
end

function FishingGameGameController:_updateSpawn(deltaTime)
	self._powerGridTimer = self._powerGridTimer - deltaTime

	if self._powerGridTimer <= 0 then
		self._powerGridTimer = checknumber(self._gameCfg.electricGridInterval)

		self:_createPowerGrid()
	end

	self._attackFishTimer = math.max(0, checknumber(self._attackFishTimer) - deltaTime)

	if self._attackFishTimer <= 0 and self:_startAttackFishes() then
		self._attackFishTimer = checknumber(self._gameCfg.atkFishInterval)
	end
end

function FishingGameGameController:_checkHookCollision()
	if not self._boatUnit or not self._boatUnit:isDropping() or self._caughtUnit then
		return
	end

	local hookRect = self._boatUnit:getHookRect()
	local target
	local priority = -1

	for _, unit in pairs(self._curUnitMap) do
		if unit:isCanHook() and self:_isRectOverlap(hookRect, unit.rect) then
			local curPriority = self:_getHookPriority(unit)

			if priority < curPriority then
				priority = curPriority
				target = unit
			end
		end
	end

	if target then
		self._caughtUnit = target

		target:startHooked()
		self._boatUnit:forceRetract()

		local freezeTimer = target:getHookFreezeTimer()

		if freezeTimer > 0 then
			self._freezeTimer = math.max(self._freezeTimer, freezeTimer)
		end

		if target:shouldInterruptAttackOnHook() then
			self:_interruptAttackFishes()
		end
	end
end

function FishingGameGameController:_updateCaughtUnit()
	if not self._caughtUnit or not self._boatUnit then
		if self._boatUnit and self._boatUnit:isAtHome() then
			self._boatUnit:startCast()
		end

		return
	end

	local hookX, hookY = self._boatUnit:getHookPosition()
	local boatRect = self._boatUnit:getBoatRect()
	local boatX = self:_getRectCenter(boatRect)

	self._caughtUnit:updateHookedPosition(hookX, hookY, self._boatUnit.angle, boatX)

	if hookY >= WaterY then
		local caughtUnit = self._caughtUnit

		self._caughtUnit = nil

		self:_handleUnitReachWater(caughtUnit)
	elseif self._boatUnit:isAtHome() then
		local caughtUnit = self._caughtUnit

		self._caughtUnit = nil

		self:_handleUnitReachWater(caughtUnit)
	end
end

function FishingGameGameController:_handleUnitReachWater(unit)
	if not unit then
		return
	end

	local stunTimer = unit:getReachWaterStunTimer()

	if stunTimer > 0 then
		self._powerGridEffectTimer = math.max(checknumber(self._powerGridEffectTimer), stunTimer)

		self:_stunAllFish(stunTimer)
		self:destroyUnit(unit)
	elseif unit:shouldDestroyOnReachWater() then
		self:destroyUnit(unit)
	else
		unit:startThrow((self._boatUnit or nil) and (self._boatUnit.position.x or 0), AttackCheckY)
	end
end

function FishingGameGameController:_checkThrowingUnits()
	if not self._boatUnit then
		return
	end

	local boatRect = self._boatUnit:getBoatRect()
	local peopleRect = self._boatUnit:getPeopleRect()
	local destroyList = {}
	local caughtList = {}
	local missList = {}
	local attackMissList = {}

	for _, unit in pairs(self._curUnitMap) do
		if unit:getCurState() == FishingGameEnum.UnitState.Throwing then
			if self:_canCatchThrowingUnit(unit, boatRect) then
				self:_addScore(unit.score)
				self:_showScoreTips(unit.score)
				table.insert(caughtList, unit)
			elseif self:_isThrowingUnitBackToWater(unit) then
				table.insert(missList, unit)
			end
		elseif unit:getCurState() == FishingGameEnum.UnitState.Attack then
			if self:_canCheckAttackHit(unit) then
				local peopleX, peopleY = self:_getRectCenter(peopleRect)

				unit:updateAttackTargetPosition(peopleX, peopleY)
			end

			if self:_canCheckAttackHit(unit) and self:_isRectOverlap(unit.rect, peopleRect) then
				self:_damageBlood(1, AttackHitFreezeTime)

				self._freezeTimer = math.max(checknumber(self._freezeTimer), AttackHitFreezeTime)

				local hitX, hitY = self:_getAttackHitStayPosition(peopleRect)

				unit:startAttackHit(hitX, hitY)
			elseif unit:isAttackBackToOrigin() then
				table.insert(attackMissList, unit)
			end
		elseif unit:getCurState() == FishingGameEnum.UnitState.AttackHit and unit:isAttackHitFinished() then
			table.insert(destroyList, unit)
		end
	end

	for _, unit in ipairs(caughtList) do
		self:_resolveCaughtUnit(unit)
	end

	for _, unit in ipairs(missList) do
		self:_resolveMissUnit(unit)
	end

	for _, unit in ipairs(attackMissList) do
		unit:resetAfterAttackMiss()
	end

	for _, unit in ipairs(destroyList) do
		self:destroyUnit(unit)
	end
end

function FishingGameGameController:_resolveCaughtUnit(unit)
	if not unit then
		return
	end

	if unit:shouldResetToOriginAfterThrow() then
		unit:resetToOrigin()
	else
		self:destroyUnit(unit)
	end
end

function FishingGameGameController:_resolveMissUnit(unit)
	if not unit then
		return
	end

	if unit:isMovingFish() then
		unit:resetAfterThrowMiss()
	elseif unit:shouldResetToOriginAfterThrow() then
		unit:resetToOrigin()
	else
		self:destroyUnit(unit)
	end
end

function FishingGameGameController:_isThrowingUnitBackToWater(unit)
	if not unit then
		return false
	end

	if unit:isMovingFish() then
		return unit.position.y <= unit:getHookBeforeY()
	end

	return unit.position.y < SceneMinY
end

function FishingGameGameController:_canCatchThrowingUnit(unit, boatRect)
	if not unit or not boatRect then
		return false
	end

	return unit:isThrowFalling() and unit.position.y >= boatRect.y and self:_isRectOverlap(unit.rect, boatRect)
end

function FishingGameGameController:_recycleOutSceneUnits()
	local destroyList = {}

	for _, unit in pairs(self._curUnitMap) do
		if unit:isActive() and unit:getCurState() == FishingGameEnum.UnitState.Idle and unit:isIdleOutOfScene(SceneMinX, SceneMaxX, SceneMaxY, WaterY) then
			table.insert(destroyList, unit)
		end
	end

	for _, unit in ipairs(destroyList) do
		self:destroyUnit(unit)
	end
end

function FishingGameGameController:_refillFishes()
	if self:_isPowerGridEffecting() then
		return
	end

	local curFishNum = 0

	for _, unit in pairs(self._curUnitMap) do
		if unit:isActive() and unit:isMovingFish() then
			curFishNum = curFishNum + 1
		end
	end

	local needNum = checknumber(self._gameCfg.fishNum) - curFishNum

	for i = 1, needNum do
		self:_createRandomFish(false)
	end
end

function FishingGameGameController:_startAttackFishes()
	local attackMap = self._curUnitMapsByType[FishingGameEnum.FishType.AttackFish]

	if not attackMap or not self._boatUnit or self:_isPowerGridCaught() then
		return false
	end

	local startedNum = 0
	local maxNum = checknumber(self._gameCfg.atkFishAttackNum)

	if maxNum <= 0 then
		return false
	end

	for _, unit in pairs(attackMap) do
		if maxNum <= startedNum then
			return true
		end

		if unit:isActive() and unit:getCurState() == FishingGameEnum.UnitState.Idle and not unit:isStunned() and self:_canStartAttackFish(unit) then
			local targetX = self:_getAttackFishTargetX()

			unit:startAttack(targetX, AttackCheckY)

			startedNum = startedNum + 1
		end
	end

	return startedNum > 0
end

function FishingGameGameController:_canStartAttackFish(unit)
	if not unit or not self._boatUnit then
		return false
	end

	local targetX = self:_getAttackFishTargetX()
	local minX = targetX - AttackStartDistanceX
	local maxX = targetX + AttackStartDistanceX

	return minX <= unit.position.x and maxX >= unit.position.x
end

function FishingGameGameController:_getAttackFishTargetX()
	if not self._boatUnit then
		return 0
	end

	local peopleRect = self._boatUnit:getPeopleRect()

	return (self:_getRectCenter(peopleRect))
end

function FishingGameGameController:_canCheckAttackHit(unit)
	return unit and unit:hasReachedAttackPeak()
end

function FishingGameGameController:_getRectCenter(rect)
	if not rect then
		return 0, 0
	end

	return checknumber(rect.x) + checknumber(rect.w) * 0.5, checknumber(rect.y) + checknumber(rect.h) * 0.5
end

function FishingGameGameController:_getAttackHitStayPosition(peopleRect)
	if self._boatCon then
		local headX, headY = self._boatCon:getHeadPosition()

		if headX and headY then
			return headX, headY
		end
	end

	return self:_getRectCenter(peopleRect)
end

function FishingGameGameController:_isPowerGridCaught()
	return self._caughtUnit and self._caughtUnit:shouldInterruptAttackOnHook()
end

function FishingGameGameController:_isPowerGridEffecting()
	return self:_isPowerGridCaught() or checknumber(self._powerGridEffectTimer) > 0
end

function FishingGameGameController:_interruptAttackFishes()
	local attackMap = self._curUnitMapsByType[FishingGameEnum.FishType.AttackFish]

	if not attackMap then
		return
	end

	for _, unit in pairs(attackMap) do
		unit:interruptAttack()
	end
end

function FishingGameGameController:_stunAllFish(timer)
	for _, unit in pairs(self._curUnitMap) do
		if unit:isMovingFish() then
			unit:interruptAttack()
			unit:setStunTimer(timer)
		end
	end
end

function FishingGameGameController:_addScore(score)
	self._score = math.max(0, checknumber(self._score) + checknumber(score))
end

function FishingGameGameController:_showScoreTips(score)
	local showScore = checknumber(score)

	if showScore <= 0 or not self._boatCon then
		return
	end

	local posX, posY = self._boatCon:getHeadPosition()

	if posX and posY then
		GlobalDispatcher:dispatch(GlobalNotify.FishingGameShowScoreTips, showScore, posX, posY)
	end
end

function FishingGameGameController:_damageBlood(value, colorDuration)
	local damageValue = checknumber(value)

	self._blood = math.max(0, checknumber(self._blood) - damageValue)

	if damageValue > 0 and self._boatCon then
		self._boatCon:playDamageColor(colorDuration)
	end

	if self._blood <= 0 then
		self._isGameOver = true
	end
end

function FishingGameGameController:_updateSibling()
	local list = {}

	for _, unit in pairs(self._curUnitMap) do
		if unit:isActive() then
			table.insert(list, unit)
		end
	end

	ArraySort.sortOn(list, function(unit)
		return self:_getHookPriority(unit)
	end, ArraySort.ASCENDING)

	for index, unit in ipairs(list) do
		local unitCom = unit:getCom()

		if unitCom and unitCom:getContainer() then
			unitCom:getContainer().transform:SetSiblingIndex(index - 1)
		end
	end
end

function FishingGameGameController:_getHookPriority(unit)
	return unit and unit:getHookPriority() or 0
end

function FishingGameGameController:_getCfgByType(unitType)
	for _, cfg in pairs(self._fishCfgs or {}) do
		if checknumber(cfg.type) == unitType then
			return cfg
		end
	end
end

function FishingGameGameController:_getUnitClass(unitType)
	local fishType = FishingGameEnum.FishType
	local classMap = {
		[fishType.Fish] = FishingGameFish,
		[fishType.AttackFish] = FishingGameAttackFish,
		[fishType.Grass] = FishingGameGrass,
		[fishType.TreasureBox] = FishingGameTreasureBox,
		[fishType.LimitTreasureBox] = FishingGameLimitTreasureBox,
		[fishType.PowerGrid] = FishingGamePowerGrid,
		[fishType.ElectricEel] = FishingGameElectricEel
	}

	return classMap[unitType] or FishingGameFish
end

function FishingGameGameController:_getUnitConClass(unitType)
	local fishType = FishingGameEnum.FishType
	local classMap = {
		[fishType.Fish] = FishingGameFishCon,
		[fishType.AttackFish] = FishingGameAttackFishCon,
		[fishType.Grass] = FishingGameGrassCon,
		[fishType.TreasureBox] = FishingGameTreasureBoxCon,
		[fishType.LimitTreasureBox] = FishingGameLimitTreasureBoxCon,
		[fishType.PowerGrid] = FishingGamePowerGridCon,
		[fishType.ElectricEel] = FishingGameElectricEelCon
	}

	return classMap[unitType] or FishingGameFishCon
end

function FishingGameGameController:_getRandomFishInScenePos(fishCfg)
	if not fishCfg.showYRange then
		return {
			x = math.random(SceneMinX + 80, SceneMaxX - 80),
			y = self:_randomInRange(fishCfg.showYRange)
		}
	end
end

function FishingGameGameController:_getRandomFishEdgePos(fishCfg)
	if not fishCfg.showYRange then
		local isLeft = math.random(1, 2) == 1
		local var_77_0 = {}

		if isLeft then
			var_77_0.x = SceneMinX - 80 or SceneMaxX + 80
		end

		var_77_0.y = self:_randomInRange(fishCfg.showYRange)

		return var_77_0
	end
end

function FishingGameGameController:_getRandomPosByRanges(rangeX, rangeY)
	rangeX = rangeX or {
		SceneMinX,
		SceneMaxX
	}
	rangeY = rangeY or {
		SceneMinY,
		WaterY
	}

	return {
		x = self:_randomInRange(rangeX),
		y = self:_randomInRange(rangeY)
	}
end

function FishingGameGameController:_randomInRange(range)
	local minValue = math.min(checknumber(range[1]), checknumber(range[2]))
	local maxValue = math.max(checknumber(range[1]), checknumber(range[2]))

	return math.random(minValue, maxValue)
end

function FishingGameGameController:_isRectOverlap(rectA, rectB)
	if not rectA or not rectB then
		return false
	end

	return rectA.x < rectB.x + rectB.w and rectA.x + rectA.w > rectB.x and rectA.y < rectB.y + rectB.h and rectA.y + rectA.h > rectB.y
end

FishingGameGameController.instance = FishingGameGameController.New()

return FishingGameGameController
