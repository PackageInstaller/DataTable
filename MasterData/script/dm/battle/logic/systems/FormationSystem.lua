-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/systems/FormationSystem.lua

FormationSystem = class("FormationSystem", BattleSubSystem)

FormationSystem:has("_entityManager", {
	is = "rw"
})
FormationSystem:has("_randomizer", {
	is = "rw"
})
FormationSystem:has("_cemetery", {
	is = "rw"
})

function FormationSystem:initialize()
	super.initialize(self)

	self._cellsForPlayers = {}
	self._excludingUnits = {}
end

function FormationSystem:startup(battleContext)
	super.startup(self, battleContext)

	self._battleField = battleContext:getObject("BattleField")
	self._entityManager = battleContext:getObject("EntityManager")
	self._randomizer = battleContext:getObject("Randomizer")
	self._actionScheduler = battleContext:getObject("ActionScheduler")
	self._cemetery = BattleCemetery:new()
	self._angerSystem = battleContext:getObject("AngerSystem")
	self._TrapSystem = battleContext:getObject("TrapSystem")

	return self
end

function FormationSystem:_getCellsForPlayer(player)
	local cellsForPlayer = self._cellsForPlayers[player]

	if cellsForPlayer == nil then
		cellsForPlayer = self._battleField:collectCells({}, player:getSide(), false)
		self._cellsForPlayers[player] = cellsForPlayer
	end

	return cellsForPlayer
end

function FormationSystem:_collectEmptyCellsForPlayer(player)
	local cellsForPlayer = self:_getCellsForPlayer(player)
	local emptyCells, count = {}, 0

	for i = 1, #cellsForPlayer do
		local cell = cellsForPlayer[i]

		if cell and cell:getResident() == nil and cell:isNormalStatus() then
			count = count + 1
			emptyCells[i] = cell
		end
	end

	emptyCells.count = count

	return emptyCells
end

function FormationSystem:_settleUnit(player, unit, cellId, animation, isUserCmd, fromAction, rightNowSit)
	local battleField = self._battleField
	local unitType = unit:getUnitType()

	unit:setOwner(player)
	battleField:settleUnit(cellId, unit)
	unit:getFSM():changeState(UnitSimpleState:new("NewBorn", 50))

	local processRecorder = self._processRecorder

	if processRecorder ~= nil then
		local unitInfo = unit:dumpInformation()

		unitInfo.anim = animation
		unitInfo.owner = player:getId()

		processRecorder:newObjectTimeline(unitInfo.id, "BattleUnit")
		processRecorder:recordObjectEvent(unitInfo.id, fromAction, unitInfo)
	end

	if self._eventCenter then
		self._eventCenter:dispatchEvent("UnitSpawned", {
			how = "single",
			from = fromAction,
			player = player,
			unit = unit
		})
	end

	local enterAction = BattleEnterAction:new(isUserCmd):withActor(unit)

	if rightNowSit then
		self._actionScheduler:addEmergentActionAtFirst(enterAction)
	else
		self._actionScheduler:addEmergentAction(enterAction)
	end

	if self._eventCenter then
		self._eventCenter:dispatchEvent("UnitPreEnter", {
			unit = unit
		})
	end

	if self._eventCenter and unit and unit:getSide() == kBattleSideA and unit:getUnitType() == BattleUnitType.kHero then
		self._eventCenter:dispatchEvent("GuideUnitSpawned")
	end

	return unit
end

function FormationSystem:CanBeSitBy(cellId, seatRules)
	local battleField = self._battleField
	local cell = battleField:getCellById(cellId)
	local oldRes = cell:getResident()

	if oldRes then
		local canBeSit = false
		local killOrKick

		for rule, killorkick in pairs(seatRules) do
			if rule == "SUMMONED" then
				canBeSit = oldRes:isSummoned()
			else
				local flagComp = oldRes:getComponent("Flag")

				canBeSit = flagComp:hasFlag(rule)
			end

			if canBeSit then
				killOrKick = killorkick

				break
			end
		end

		if canBeSit then
			oldRes:setLifeStage(ULS_Kicked)
			cell:setOldResident(oldRes)
			cell:setOldResidentDieRule(killOrKick)

			return true
		end
	end

	return false, "InvalidTargetPosition"
end

function FormationSystem:SpawnUnit(player, unitData, cellNo, animation, isUserCmd, isMasterOrCost, seatRules, rightNowSit)
	local cellId = makeCellId(player:getSide(), cellNo)
	local battleField = self._battleField

	if not battleField:isEmptyCell(cellId) then
		if seatRules and not next(seatRules) then
			return false, "InvalidTargetPosition"
		else
			local canBeSit, reason = self:CanBeSitBy(cellId, seatRules)

			if not canBeSit then
				return canBeSit, reason
			end
		end
	end

	local entityManager = self._entityManager
	local unit

	if isMasterOrCost == true then
		unit = unitData.isBattleField and entityManager:createBattleFieldUnit(unitData) or entityManager:createMasterUnit(unitData)
	else
		local cost = isMasterOrCost
		local energyInfo

		if cost and cost > 0 then
			energyInfo = player:consumeEnergy(cost)

			if energyInfo == nil then
				return false, "EnergyNotEnough"
			end
		end

		if energyInfo then
			self._processRecorder:recordObjectEvent(player:getId(), "SyncE", energyInfo)
		end

		unit = entityManager:createHeroUnit(unitData)
	end

	return self:_settleUnit(player, unit, cellId, animation, isUserCmd, "SpawnUnit", rightNowSit)
end

local function extend(values, constants)
	for name, value in _G.pairs(constants) do
		_G.rawset(values, name, value)
	end
end

function FormationSystem:SpawnByTransform(player, unit, location, isMarkedSummon)
	local transformData = unit:getTransformData()

	if not transformData then
		return
	end

	local cellId = self._battleField:findEmptyCellId(player:getSide(), location)

	if not cellId then
		return false, "InvalidSpawnPosition"
	end

	local unit = unit
	local targetId
	local prefix = unit:getId() .. "_r"
	local entityManager = self._entityManager
	local index = 0

	repeat
		targetId = prefix .. index
		index = index + 1
	until entityManager:fetchEntity(prefix .. index) == nil

	local newUnit = entityManager:copyHeroUnit(unit, targetId, 1)

	newUnit:transformWithData(transformData)
	newUnit:setIsSummoned(isMarkedSummon)

	;({
		dur = 1000
	}).name = anim or "init"

	self:_settleUnit(player, newUnit, cellId, nil, false, "SpawnUnit")
end

function FormationSystem:summon(actor, source, summonId, summonFactor, location)
	assert(type(summonId) == "string", "summonId is not string")

	local player = actor:getOwner()
	local cellId = self._battleField:findEmptyCellId(player:getSide(), location)

	if not cellId then
		return false, "InvalidSummonPosition"
	end

	local summonInfo = actor:getOwner():getSummonInfo(summonId)

	if not summonInfo then
		return false, "NoSummonInfo"
	end

	if actor:getSurfaceIndex() and actor:getSurfaceIndex() > 0 and summonInfo.extraSurFace and summonInfo.extraSurFace[actor:getSurfaceIndex()] then
		summonInfo.modelId = summonInfo.extraSurFace[actor:getSurfaceIndex()]
	end

	extend(summonFactor, summonInfo)

	local targetId = player:calcSummonIdentify(summonId)
	local entityManager = self._entityManager
	local unit = entityManager:summonHeroUnit(source, targetId, summonFactor)
	local animation

	unit:setSummoner(actor)

	local result = self:_settleUnit(player, unit, cellId, animation, false, "CallUnit")

	if self._eventCenter then
		self._eventCenter:dispatchEvent("UnitSummoned", {
			unit = unit,
			actor = actor
		})
	end

	return result
end

function FormationSystem:summonMaster(actor, source, summonId, summonFactor, workId)
	assert(type(summonId) == "string", "summonId is not string")

	local player = actor:getOwner()
	local summonInfo = actor:getOwner():getSummonInfo(summonId)

	if not summonInfo then
		return false, "NoSummonInfo"
	end

	summonInfo.skills.unique = nil

	extend(summonFactor, summonInfo)

	local targetId = player:calcSummonIdentify(summonId)
	local entityManager = self._entityManager
	local unit = entityManager:summonHeroUnit(source, targetId, summonFactor)
	local animation

	player:setMasterUnit(unit)

	local sourceAngerComp = source:getComponent("Anger")
	local unitAngerComp = unit:getComponent("Anger")

	unitAngerComp:setAngerRules(sourceAngerComp:getAngerRules())

	local skillComp = source:getComponent("Skill")
	local targetSkill = unit:getComponent("Skill")
	local passives = targetSkill:getSkill(kBattlePassiveSkill)

	passives = passives or {}

	for k, v in pairs(skillComp:getSkill(kBattlePassiveSkill)) do
		passives[#passives + 1] = v:clone()
	end

	unit:setCardInfo({
		enterPauseTime = 1500
	})
	unit:getComponent("Skill"):setupSkillList(kBattlePassiveSkill, passives)
	source:setPresentMaster(false)

	if self._battleField:eraseUnit(source) then
		if self._processRecorder then
			self._processRecorder:recordObjectEvent(source:getId(), "ClearAllSwitchAction")
			self._processRecorder:recordObjectEvent(source:getId(), "Die")
		end

		if eventCenter then
			eventCenter:dispatchEvent("UnitDied", source, source:getOwner())
		end
	end

	unit:setUnitType(BattleUnitType.kMaster)
	unit:setPresentMaster(true)

	local playerSide = player:getSide()
	local result = self:_settleUnit(player, unit, playerSide == kBattleSideA and 8 or -8, animation, false, "CallMasterUnit")

	source:getFSM():changeState(nil)
	source:setLifeStage(ULS_Kicked)

	local buffSystem = self._battleContext:getObject("BuffSystem")
	local skillSystem = self._battleContext:getObject("SkillSystem")

	buffSystem:cloneBuffsOnTarget(unit, source, nil, workId)
	skillSystem:clearTriggersForActor(source)
	skillSystem:cancelSkillsForActor(source)
	buffSystem:cleanupBuffsOnTarget(source)

	if self._eventCenter then
		self._eventCenter:dispatchEvent("UnitSummoned", {
			unit = unit,
			actor = actor
		})
	end

	local battleStatist = self._battleContext:getObject("BattleStatist")

	if battleStatist then
		battleStatist:sendStatisticEvent("UnitHurt", {
			hpDetails = {
				[source:getId()] = 0
			}
		})
	end

	return result
end

function FormationSystem:summonEnemy(actor, source, summonId, summonFactor, location)
	assert(type(summonId) == "string", "summonId is not string")

	local battlelogic = self._battleContext:getObject("BattleLogic")
	local player = battlelogic:getRivalPlayer(actor:getOwner())
	local cellId = self._battleField:findEmptyCellId(player:getSide(), location)

	if not cellId then
		return false, "InvalidSummonPosition"
	end

	local summonInfo = actor:getOwner():getSummonInfo(summonId)

	if not summonInfo then
		return false, "NoSummonInfo"
	end

	extend(summonFactor, summonInfo)

	local targetId = player:calcSummonIdentify(summonId)
	local entityManager = self._entityManager
	local unit = entityManager:summonHeroUnit(source, targetId, summonFactor)
	local animation

	unit:setSummoner(actor)

	local result = self:_settleUnit(player, unit, cellId, animation, false, "CallUnit")

	if self._eventCenter then
		self._eventCenter:dispatchEvent("UnitSummoned", {
			unit = unit,
			actor = actor
		})
	end

	return result
end

function FormationSystem:spawnAssist(actor, assistId, player, cellId)
	local assistInfo = actor:getOwner():getAssistInfo(assistId)

	if not assistInfo then
		return
	end

	local targetCellId = self._battleField:findEmptyCellId(player:getSide(), {
		cellId
	})

	if not targetCellId then
		targetCellId = makeCellId(player:getSide(), cellId)

		local unit2Kick = self._battleField:getCellById(targetCellId):getResident()

		self:_kickUnit(unit2Kick)
	end

	actor:getOwner():removeAssistInfo(assistId)

	assistInfo.id = player:calcAssistIdentify(assistId)

	local entityManager = self._entityManager
	local unit = entityManager:createHeroUnit(assistInfo)

	return self:_settleUnit(player, unit, targetCellId, animation, true, "SpawnUnit")
end

function FormationSystem:_randomElemInArray(array)
	if array == nil or #array == 0 then
		return nil
	end

	local heroArray = {}

	for i = 1, #array do
		local elem = array[i]

		if elem:getUnitType() == BattleUnitType.kHero then
			heroArray[#heroArray + 1] = elem
		end
	end

	if heroArray == nil or #heroArray == 0 then
		return nil
	end

	return heroArray[self._randomizer:random(1, #heroArray)]
end

function FormationSystem:revive(actor, hpRatio, anger, location)
	local player = actor:getOwner()
	local cellId = self._battleField:findEmptyCellId(player:getSide(), location)

	if not cellId then
		return false, "InvalidRevivePosition"
	end

	local bodies = self._cemetery:getUnitsBySide(player:getSide())
	local unit = self:_randomElemInArray(bodies)

	if not unit then
		return false, "NoValidBody"
	end

	if not unit:canBeUnearth() then
		return false, "ForbidenRevive"
	end

	local targetId
	local prefix = unit:getId() .. "_r"
	local entityManager = self._entityManager
	local index = 0

	repeat
		targetId = prefix .. index
		index = index + 1
	until entityManager:fetchEntity(prefix .. index) == nil

	local newUnit = entityManager:copyHeroUnit(unit, targetId, 1)

	newUnit:setModelId(unit:getModelId())

	local animation
	local angerComp = newUnit:getComponent("Anger")

	angerComp:setAnger(anger)

	local healthComp = newUnit:getComponent("Health")

	healthComp:setHp(healthComp:getMaxHp() * hpRatio)
	newUnit:setBeRevive(true)

	local newUnit, detail = self:_settleUnit(player, newUnit, cellId, animation, false, "Revive")

	if unit then
		self._cemetery:untomb(unit)
	end

	return newUnit, detail
end

function FormationSystem:reviveByUnit(actor, unit, hpRatio, anger, location, owner)
	local player = owner or actor:getOwner()
	local cellId = self._battleField:findEmptyCellId(player:getSide(), location)

	if not cellId then
		return false, "InvalidRevivePosition"
	end

	if not unit:canBeUnearth() then
		return false, "ForbidenRevive"
	end

	local unit = unit
	local targetId
	local prefix = unit:getId() .. "_r"
	local entityManager = self._entityManager
	local index = 0

	repeat
		targetId = prefix .. index
		index = index + 1
	until entityManager:fetchEntity(prefix .. index) == nil

	local newUnit = entityManager:copyHeroUnit(unit, targetId, 1)

	newUnit:setModelId(unit:getModelId())

	local animation
	local angerComp = newUnit:getComponent("Anger")

	angerComp:setAnger(anger)

	local healthComp = newUnit:getComponent("Health")

	healthComp:setHp(healthComp:getMaxHp() * hpRatio)
	newUnit:setBeRevive(true)

	local newUnit, detail = self:_settleUnit(player, newUnit, cellId, animation, false, "Revive")

	if unit then
		self._cemetery:untomb(unit)
	end

	return newUnit, detail
end

function FormationSystem:reviveByUnitSigleTon(actor, unit, hpRatio, anger, location, owner)
	local player = owner or actor:getOwner()
	local cellId = self._battleField:findEmptyCellId(player:getSide(), location)

	if not cellId then
		return false, "InvalidRevivePosition"
	end

	if not unit:canBeUnearth() then
		return false, "ForbidenRevive"
	end

	local unit = unit
	local targetId
	local prefix = unit:getId() .. "_r"
	local entityManager = self._entityManager
	local index = 0

	repeat
		targetId = prefix .. index
		index = index + 1
	until entityManager:fetchEntity(prefix .. index) == nil

	local newUnit = entityManager:copyHeroUnit(unit, targetId, 1)

	newUnit:setModelId(unit:getModelId())

	local animation
	local angerComp = newUnit:getComponent("Anger")

	angerComp:setAnger(anger)

	local healthComp = newUnit:getComponent("Health")

	healthComp:setHp(healthComp:getMaxHp() * hpRatio)
	newUnit:setBeRevive(true)
	newUnit:setIsSummoned(unit:isSummoned())
	newUnit:setSummoner(unit:getSummoner())

	local newUnit, detail = self:_settleUnit(player, newUnit, cellId, animation, false, "Revive")

	if unit then
		self._cemetery:untomb(unit)
	end

	return newUnit, detail
end

function FormationSystem:reviveRandom(actor, hpRatio, anger, location)
	local player = actor:getOwner()
	local cellId = self._battleField:findEmptyCellId(player:getSide(), location)

	if not cellId then
		return false, "InvalidRevivePosition"
	end

	local bodies1 = self._cemetery:getUnitsBySide(player:getSide())
	local bodies2 = self._cemetery:getUnitsBySide(opposeBattleSide(player:getSide()))
	local bodies = {}

	for k, v in ipairs(bodies1) do
		bodies[k] = v
	end

	for k, v in ipairs(bodies2) do
		bodies[#bodies + 1] = v
	end

	local unit = self:_randomElemInArray(bodies)

	if not unit then
		return false, "NoValidBody"
	end

	if not unit:canBeUnearth() then
		return false, "ForbidenRevive"
	end

	local targetId
	local prefix = (player:getSide() == kBattleSideA and "f_" or "e_") .. unit:getId() .. "_r"
	local entityManager = self._entityManager
	local index = 0

	repeat
		targetId = prefix .. index
		index = index + 1
	until entityManager:fetchEntity(prefix .. index) == nil

	local newUnit = entityManager:copyHeroUnit(unit, targetId, 1)

	newUnit:setModelId(unit:getModelId())

	local animation
	local angerComp = newUnit:getComponent("Anger")

	angerComp:setAnger(anger)

	local healthComp = newUnit:getComponent("Health")

	healthComp:setHp(healthComp:getMaxHp() * hpRatio)
	newUnit:setBeRevive(true)

	local newUnit, detail = self:_settleUnit(player, newUnit, cellId, animation, false, "Revive")

	if unit then
		self._cemetery:untomb(unit)
	end

	if self._eventCenter then
		self._eventCenter:dispatchEvent("UnitRevive", {
			unit = unit
		})
	end

	return newUnit, detail
end

function FormationSystem:rebornUnit(unit, ratio, anger, location)
	local hpRatio = ratio or 1
	local player = unit:getOwner()
	local pos = unit:getPosition()
	local id = BFCell_pos2id(1, pos.x, pos.y)
	local l_ocation = {
		id
	}

	location = location and l_ocation

	local cellId = self._battleField:findEmptyCellId(player:getSide(), l_ocation)

	if not cellId then
		return false, "InvalidRebornPosition"
	end

	local healthComp = unit:getComponent("Health")

	healthComp:setHp(healthComp:getMaxHp() * hpRatio)

	if anger then
		local AngerComp = unit:getComponent("Anger")

		AngerComp:setAnger(anger)
	end

	local battleField = self._battleField
	local unitType = unit:getUnitType()

	unit:setOwner(player)
	battleField:settleUnit(cellId, unit)

	local processRecorder = self._processRecorder

	if processRecorder ~= nil then
		local unitInfo = unit:dumpInformation()

		unitInfo.anim = nil
		unitInfo.owner = player:getId()

		processRecorder:recordObjectEvent(unitInfo.id, "RebornUnit", unitInfo)
	end

	unit:setLifeStage(ULS_Reviving)
	self._cemetery:untomb(unit)

	if self._eventCenter then
		self._eventCenter:dispatchEvent("UnitReborn", {
			unit = unit
		})
	end
end

function FormationSystem:changeUnitPreSettled(unit)
	local processRecorder = self._processRecorder

	if processRecorder ~= nil then
		processRecorder:recordObjectEvent(unit:getId(), "Settled")
	end
end

function FormationSystem:changeUnitSettled(unit)
	if unit:isInStages(ULS_Newborn) then
		unit:setLifeStage(ULS_Normal)

		local skillSystem = self._battleContext:getObject("SkillSystem")

		skillSystem:buildSkillsForActor(unit)
		unit:getFSM():changeState(UnitSimpleState:new("Preparing", 600))

		local processRecorder = self._processRecorder

		if processRecorder ~= nil then
			processRecorder:recordObjectEvent(unit:getId(), "Settled")
		end

		if self._eventCenter then
			self._eventCenter:dispatchEvent("UnitSettled", {
				unit = unit
			})
		end

		self._TrapSystem:triggerTrap(unit)
	end
end

function FormationSystem:clearOldResident(actor)
	local oldResident = actor:getCell():getOldResident()

	if oldResident then
		local dieRules = actor:getCell():getOldResidentDieRule()

		for k, v in pairs(dieRules) do
			if v == "kick" then
				local buffSystem = self._battleContext:getObject("BuffSystem")
				local _, cnt = buffSystem:selectBuffsOnTarget(oldResident, MakeFilter(function(buff)
					return buff:isMatched("UnKick")
				end))
				local skillSystem = self._battleContext:getObject("SkillSystem")

				skillSystem:activateSpecificTrigger(oldResident, "UNIT_KICK_BY_OTHERSET", {
					dierule = "kick",
					newunit = actor,
					UnKickTag = cnt
				})
				skillSystem:activateGlobalTrigger("UNIT_KICK_BY_OTHERSET", {
					dierule = "kick",
					unit = oldResident,
					newunit = actor,
					UnKickTag = cnt
				})
				self:_kickUnit(oldResident)

				if self._eventCenter then
					self._eventCenter:dispatchEvent("UnitsWillLeave", {
						oldResident
					}, self:_groupUnitsByPlayer({
						oldResident
					}))
					self._eventCenter:dispatchEvent("UnitsLeft", {
						oldResident
					}, self:_groupUnitsByPlayer({
						oldResident
					}), false, true)
				end

				return
			end
		end

		for k, v in pairs(dieRules) do
			if v == "die" then
				oldResident:setLifeStage(ULS_Dying)
				self:removeDyingUnits({
					oldResident
				})

				return
			end
		end
	end
end

function FormationSystem:removeDyingUnits(dyingUnits)
	local dead = 0

	if dyingUnits then
		if not #dyingUnits then
			local count = 0

			if count > 0 then
				for i = 1, count do
					local theDying = dyingUnits[i]

					if self:performDeathSkill(theDying) then
						dead = dead + 1
					elseif self:buryUnit(theDying) then
						dead = dead + 1
					end
				end
			end

			return dead
		end
	end
end

local kExcludeDying = "dying"
local kExcludeExpelled = "expelled"
local kExcludeFlee = "flee"
local kExcludeReviving = "reviving"
local kExcludeExpelledJoinreferee = "expelled_joinreferee"
local kExcludeFleedJoinreferee = "fleed_joinreferee"

function FormationSystem:_excludeUnit(unit, reason, workId, force)
	local excludingUnits = self._excludingUnits
	local status = excludingUnits[unit]

	if status ~= nil then
		if force then
			excludingUnits[unit] = {
				reason = reason,
				workId = workId
			}

			return unit
		end

		return nil, status
	end

	excludingUnits[unit] = {
		reason = reason,
		workId = workId
	}
	excludingUnits[#excludingUnits + 1] = unit

	return unit
end

function FormationSystem:excludeDyingUnit(unit, workId)
	return self:_excludeUnit(unit, kExcludeDying, workId)
end

function FormationSystem:expelUnit(unit, workId, force, joinReferee)
	if joinReferee then
		return self:_excludeUnit(unit, kExcludeExpelledJoinreferee, workId, force)
	else
		return self:_excludeUnit(unit, kExcludeExpelled, workId, force)
	end
end

function FormationSystem:fleeUnit(unit, workId, force, joinReferee)
	if joinReferee then
		return self:_excludeUnit(unit, kExcludeFleedJoinreferee, workId, force)
	else
		return self:_excludeUnit(unit, kExcludeFlee, workId, force)
	end
end

function FormationSystem:reviveUnit(unit, force)
	return self:_excludeUnit(unit, kExcludeReviving)
end

function FormationSystem:wontDieUnit(unit)
	local excludingUnits = self._excludingUnits
	local status = excludingUnits[unit]

	if status == nil or status.reason ~= kExcludeDying then
		return
	end

	excludingUnits[unit] = nil

	for i = 1, #excludingUnits do
		if excludingUnits[i] == unit then
			table.remove(excludingUnits, i)

			return
		end
	end
end

function FormationSystem:processExcludingUnits(workId)
	local excludingUnits = self._excludingUnits
	local total = #excludingUnits

	if total == 0 then
		return
	end

	local ii = 1
	local deadUnits, cntDead = nil, 0
	local expelledUnits, cntExpelled = nil, 0
	local expelledRefereeUnits, cntRefereeExpelled = nil, 0
	local fleeUnits, cntFlee = nil, 0
	local fleeRefereeUnits, cntFleedExpelled = nil, 0

	for i = 1, total do
		local unit = excludingUnits[i]
		local status = excludingUnits[unit]

		excludingUnits[i] = nil

		if unit:getReferenceCount() <= 0 then
			if workId ~= nil and status.workId ~= nil and status.workId ~= workId then
				ii = ii + 1
				excludingUnits[ii] = unit

				if workId ~= nil and status.workId ~= nil and status.workId == workId then
					status.workId = nil
				end
			else
				local reason = status.reason

				excludingUnits[unit] = nil

				if reason == kExcludeDying then
					if deadUnits == nil then
						deadUnits = {}
					end

					cntDead = cntDead + 1
					deadUnits[cntDead] = unit
				elseif reason == kExcludeExpelled then
					if expelledUnits == nil then
						expelledUnits = {}
					end

					cntExpelled = cntExpelled + 1
					expelledUnits[cntExpelled] = unit
				elseif reason == kExcludeExpelledJoinreferee then
					if expelledRefereeUnits == nil then
						expelledRefereeUnits = {}
					end

					cntRefereeExpelled = cntRefereeExpelled + 1
					expelledRefereeUnits[cntRefereeExpelled] = unit
				elseif reason == kExcludeExpelledJoinreferee then
					if fleeRefereeUnits == nil then
						fleeRefereeUnits = {}
					end

					cntFleedExpelled = cntFleedExpelled + 1
					fleeRefereeUnits[cntFleedExpelled] = unit
				elseif reason == kExcludeFlee then
					if fleeUnits == nil then
						fleeUnits = {}
					end

					cntFlee = cntFlee + 1
					fleeUnits[cntFlee] = unit
				elseif reason == kExcludeReviving then
					-- block empty
				end
			end
		end
	end

	if expelledUnits then
		self:removeExpelledUnits(expelledUnits)
	end

	if expelledRefereeUnits then
		self:removeExpelledUnits(expelledRefereeUnits, nil, true)
	end

	if fleeUnits then
		self:removeExpelledUnits(fleeUnits, true)
	end

	if fleeRefereeUnits then
		self:removeExpelledUnits(fleeRefereeUnits, true, true)
	end

	if deadUnits then
		self:removeDyingUnits(deadUnits)
	end
end

function FormationSystem:removeExpelledUnits(units, fleeSta, joinReferee)
	if units == nil or #units == 0 then
		return nil
	end

	local groupedByPlayer = self:_groupUnitsByPlayer(units)
	local eventCenter = self._eventCenter

	if eventCenter then
		eventCenter:dispatchEvent("UnitsWillLeave", units, groupedByPlayer)
	end

	for _, unit in ipairs(units) do
		self:_kickUnit(unit)
	end

	if eventCenter then
		eventCenter:dispatchEvent("UnitsLeft", units, groupedByPlayer, fleeSta, joinReferee)
	end

	return groupedByPlayer
end

function FormationSystem:_groupUnitsByPlayer(units)
	local unitGroups = {}
	local groupsArray = unitGroups

	for _, unit in ipairs(units) do
		local player = unit:getOwner()
		local group = unitGroups[player]

		if group == nil then
			group = {
				player = player,
				units = {}
			}
			unitGroups[player] = group
			groupsArray[#groupsArray + 1] = group
		end

		group.units[#group.units + 1] = unit
	end

	return groupsArray
end

function FormationSystem:performDeathSkill(entity)
	entity:setLifeStage(ULS_Dying)

	local skillComp = entity:getComponent("Skill")
	local deathSkill = skillComp and skillComp:getSkill(kBattleDeathSkill)

	if deathSkill == nil then
		return false
	end

	local deathAction = BattleDeathSkillAction:new():withActor(entity)

	self._actionScheduler:addEmergentAction(deathAction)

	return true
end

function FormationSystem:buryUnit(unit)
	if not unit:isInStages(ULS_Dying, ULS_Dead) then
		return
	end

	unit:setLifeStage(ULS_Dead)

	local eventCenter = self._eventCenter

	if eventCenter then
		eventCenter:dispatchEvent("UnitWillDie", unit, unit:getOwner())
	end

	unit:getFSM():changeState(nil)

	if self._battleField:eraseUnit(unit) then
		if not unit._isSummoned and unit:canRevive() then
			self._cemetery:bury(unit)
		end

		if self._processRecorder then
			self._processRecorder:recordObjectEvent(unit:getId(), "Die")
		end

		if eventCenter then
			eventCenter:dispatchEvent("UnitDied", unit, unit:getOwner())
		end

		return true
	end

	return nil
end

function FormationSystem:_kickUnit(unit)
	unit:setLifeStage(ULS_Kicked)

	if self._battleField:eraseUnit(unit) and self._processRecorder then
		self._processRecorder:recordObjectEvent(unit:getId(), "Kick")
	end
end

function FormationSystem:transform(unit, hpRatio)
	local transformData = unit:getTransformData()

	if not transformData then
		return
	end

	local player = unit:getOwner()
	local eventCenter = self._eventCenter

	if eventCenter then
		eventCenter:dispatchEvent("UnitWillTransform", unit, player)
	end

	unit:setLifeStage(ULS_Normal)
	unit:transformWithData(transformData)

	local healthComp = unit:getComponent("Health")

	healthComp:setHp(healthComp:getHp() * hpRatio)
	unit:getFSM():changeState(UnitSimpleState:new("Preparing", 600))

	if self._processRecorder ~= nil then
		local unitInfo = unit:dumpInformation()

		unitInfo.anim = animation
		unitInfo.owner = player:getId()

		self._processRecorder:recordObjectEvent(unit:getId(), "Transform", unitInfo)
	end

	if eventCenter then
		eventCenter:dispatchEvent("UnitTransformed", unit, player)
	end
end

function FormationSystem:transportExt(unit, cellNo, duration, timeScale)
	local cellId = makeCellId(unit:getOwner():getSide(), cellNo)
	local battleField = self._battleField
	local posComp = unit:getComponent("Position")

	if posComp then
		::label_39_0::

		local var_39_0 = posComp:getCell()

		if var_39_0 then
			var_39_0 = posComp:getCell():getId()

			local oldCellId = var_39_0
			local targetUnit
			local orgCellId = unit:getCell():getId()

			if not battleField:isEmptyCell(cellId) then
				local targetCell = battleField:getCellById(cellId)

				targetUnit = targetCell:getResident()
			end

			if unit and unit:hasFlag("CANNOT_MOVE") then
				return
			end

			if targetUnit and targetUnit:hasFlag("CANNOT_MOVE") then
				return
			end

			battleField:exchangeUnits(oldCellId, cellId)

			local processRecorder = self._processRecorder

			if processRecorder ~= nil then
				processRecorder:recordObjectEvent(unit:getId(), "TransportExt", {
					cell = cellId,
					duration = duration,
					timeScale = timeScale
				})

				if targetUnit then
					processRecorder:recordObjectEvent(targetUnit:getId(), "TransportExt", {
						ignoreSwitch = true,
						cell = orgCellId,
						duration = duration,
						timeScale = timeScale
					})
				end
			end

			if self._eventCenter then
				self._eventCenter:dispatchEvent("UnitTransported", {
					player = player,
					unit = unit,
					cellId = cellId,
					oldCellId = oldCellId
				})
			end

			return oldCellId
		end
	end
end

function FormationSystem:transport(unit, cellNo)
	local cellId = makeCellId(unit:getOwner():getSide(), cellNo)
	local battleField = self._battleField

	if not battleField:isEmptyCell(cellId) then
		return false, "InvalidTargetPosition"
	end

	local posComp = unit:getComponent("Position")

	if posComp then
		::label_40_0::

		local var_40_0 = posComp:getCell()

		if var_40_0 then
			var_40_0 = posComp:getCell():getId()

			local oldCellId = var_40_0

			battleField:exchangeUnits(oldCellId, cellId)

			local processRecorder = self._processRecorder

			if processRecorder ~= nil then
				processRecorder:recordObjectEvent(unit:getId(), "Transport", {
					cell = cellId
				})
			end

			if self._eventCenter then
				self._eventCenter:dispatchEvent("UnitTransported", {
					player = player,
					unit = unit,
					cellId = cellId,
					oldCellId = oldCellId
				})
			end

			return oldCellId
		end
	end
end

function FormationSystem:recordDying()
	self._hasDying = true
end

function FormationSystem:checkDying()
	self._hasDying = nil

	return self._hasDying
end

function FormationSystem:forbidenRevive(unit)
	unit:forbidenRevive()
	self._cemetery:untomb(unit)
end

local function isMad(actor)
	local flagComp = actor:getComponent("Flag")

	return flagComp:hasStatus(kBEMad)
end

local function getProvoke(actor)
	local flagComp = actor:getComponent("Flag")

	if flagComp:hasStatus(kBEProvoked) then
		return actor:getProvokeTarget()
	end
end

function FormationSystem:findPrimaryTarget(actor)
	local battleField = self._battleField
	local actorCellId = actor:getComponent("Position"):getCell():getId()
	local primTrgt
	local provoker = getProvoke(actor)

	if provoker then
		local cell = provoker:getComponent("Position"):getCell()

		if cell and cell:getResident() == provoker then
			primTrgt = provoker
		end
	end

	if primTrgt == nil then
		primTrgt = isMad(actor) and battleField:searchPrimaryTargetRandom(actorCellId, self._battleContext) or battleField:searchPrimaryTarget(actorCellId)
	end

	return primTrgt
end

function FormationSystem:findFoe(actor)
	local foeId = actor:getFoe()

	if not foeId then
		return
	end

	local targetSide = opposeBattleSide(actor:getSide())
	local units = self._battleField:collectUnits({}, targetSide)

	for _, unit in ipairs(units) do
		if unit:getId() == foeId then
			return unit
		end
	end

	return nil
end

function FormationSystem:getPassiveCountOnHero(unit, skillId)
	local count = 0
	local skillComp = unit:getComponent("Skill")

	for k, v in pairs(skillComp:getSkills() or {}) do
		if table.getn(v) > 0 then
			for k_, v_ in pairs(v) do
				if v_:getId() == skillId then
					count = count + 1
				end
			end
		elseif v.getId and v:getId() == skillId then
			count = count + 1
		end
	end

	return count
end

function FormationSystem:updateOnRoundEnded()
	local buffSystem = self._battleContext:getObject("BuffSystem")
	local units = self._battleField:crossCollectUnits()

	for i = 1, #units do
		buffSystem:updateOnRoundEnded(units[i])
	end
end

function FormationSystem:updateOnNewSecond(elapsed)
	local buffSystem = self._battleContext:getObject("BuffSystem")
	local units = self._battleField:crossCollectUnits()

	for i = 1, #units do
		buffSystem:updateOnNewSecond(units[i], elapsed)
		self._angerSystem:applyAngerRuleOnTarget(nil, units[i], AngerRules.kPerSecond)
	end
end

function FormationSystem:update(dt, battleContext)
	local units = self._battleField:getAllUnits()

	for i = 1, #units do
		units[i]:update(dt, battleContext)

		local posComp = units[i]:getComponent("Position")

		if posComp then
			local cell = posComp:getCell()

			if cell:getOldResident() then
				cell:getOldResident():update(dt, battleContext)
			end
		end
	end
end

function FormationSystem:reset()
	self._cemetery:reset()
end
