-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/BattleLogic.lua

local floor = math.floor

kBRMainLine = "$MAIN"
kBRFieldLine = "$BFIELD"
BattleLogic = class("BattleLogic", FSMBattleLogic)

BattleLogic:has("_battleConfig", {
	is = "rw"
})
BattleLogic:has("_battleReferee", {
	is = "r"
})
BattleLogic:has("_randomizer", {
	is = "rw"
})
BattleLogic:has("_battleField", {
	is = "r"
})
BattleLogic:has("_battleMode", {
	is = "rw"
})

function BattleLogic:initialize()
	super.initialize(self)

	self._battlePlayersRegistry = {}
	self._battleConfig = {}
	self._battleField = BattleField:new()
	self._teamA = BattlePlayerSerialTeam:new(kBattleSideA)
	self._teamB = BattlePlayerSerialTeam:new(kBattleSideB)
	self._entityManager = BattleEntityManager:new()
	self._battleReferee = BattleReferee:new(BasicJudgeRule:create())
	self._battleMode = 2
	self._eventCenter = BattleEventDispatcher:new()
	self._buffSystem = BuffSystem:new()
	self._healthSystem = HealthSystem:new()
	self._angerSystem = AngerSystem:new()
	self._cardSystem = CardSystem:new()
	self._trapSystem = TrapSystem:new()
	self._skillSystem = BattleSkillSystem:new()
	self._formationSystem = FormationSystem:new()
	self._timingSystem = TimingSystem:new()
end

function BattleLogic:setupWithContext(battleContext)
	battleContext:setObject("EventCenter", self._eventCenter)

	self._roundNumber = 0
	self._battleResult = nil
	self._battleContext = battleContext
	self._battleRecorder = battleContext:getObject("BattleRecorder")
	self._battleStatist = battleContext:getObject("BattleStatist")

	self:setupRandomizer(battleContext)
	battleContext:setObject("BattleConfig", self._battleConfig)
	battleContext:setObject("BattleField", self._battleField)
	battleContext:setObject("EntityManager", self._entityManager)
	battleContext:setObject("TeamA", self._teamA)
	battleContext:setObject("TeamB", self._teamB)
	battleContext:setObject("BattleReferee", self._battleReferee)

	local battleRecorder = self._battleRecorder

	if battleRecorder ~= nil then
		self._entityManager:setBattleRecorder(battleRecorder)

		local processRecorder = CommonProcessRecorder:new(battleRecorder)

		processRecorder:reset()
		battleContext:setObject("ProcessRecorder", processRecorder)
	end

	local formationSystem = self._formationSystem

	battleContext:setObject("FormationSystem", formationSystem)

	local timingSystem = self._timingSystem

	battleContext:setObject("TimingSystem", timingSystem)

	local buffSystem = self._buffSystem

	battleContext:setObject("BuffSystem", buffSystem)

	local healthSystem = self._healthSystem

	battleContext:setObject("HealthSystem", healthSystem)

	local angerSystem = self._angerSystem

	battleContext:setObject("AngerSystem", angerSystem)

	local cardSystem = self._cardSystem

	battleContext:setObject("CardSystem", cardSystem)

	local trapSystem = self._trapSystem

	battleContext:setObject("TrapSystem", trapSystem)

	local skillSystem = self._skillSystem

	battleContext:setObject("SkillSystem", skillSystem)
	skillSystem:setFrameInterval(battleContext:getFrameInterval())
	skillSystem:installBuiltinEnvironment()
	skillSystem:installGlobalEnvironment(_G.SkillDevKit)
	skillSystem:installGlobalEnvironment({
		random = function(n, m)
			return self._randomizer:random(n, m)
		end,
		BattleFrameTime = function(_)
			return battleContext:getCurrentTime()
		end,
		BattleTime = function(_)
			return self:getTotalTime()
		end,
		config = self._battleConfig,
		["$BattleContext"] = battleContext,
		["$EventCenter"] = self._eventCenter,
		["$BattleField"] = self._battleField,
		["$HealthSystem"] = self._healthSystem,
		["$AngerSystem"] = self._angerSystem,
		["$BuffSystem"] = self._buffSystem,
		["$FormationSystem"] = self._formationSystem,
		["$TimingSystem"] = self._timingSystem,
		["$CardSystem"] = self._cardSystem,
		["$TrapSystem"] = self._trapSystem,
		["$Statist"] = self._battleStatist
	})

	if self._skillDefinitions then
		skillSystem:installGlobalEnvironment(self._skillDefinitions, true)
	end

	self:setupExtraSkillEnvironment(skillSystem)
	battleContext:setObject("SkillGlobalScope", skillSystem:getGlobalEnvironment())
	self:setupEventListeners(self._eventCenter)

	return true
end

function BattleLogic:startSubModules(battleContext)
	if self._battleRecorder ~= nil then
		self._battleRecorder:newTimeline(kBRMainLine, "BattleMainLine")
		self._battleRecorder:newTimeline(kBRFieldLine, "BattleField")
	end

	if self._battleReferee then
		self._battleReferee:startNewBattle(self, battleContext)
	end

	self._timingSystem:setIsTiming(true, true)
	self._timingSystem:resetCumulativeTime(0)
	self._formationSystem:startup(battleContext)
	self._timingSystem:startup(battleContext)
	self._buffSystem:startup(battleContext)
	self._healthSystem:setBuffSystem(self._buffSystem)
	self._healthSystem:startup(battleContext)
	self._angerSystem:startup(battleContext)
	self._cardSystem:startup(battleContext)
	self._trapSystem:startup(battleContext)
	self._skillSystem:startup(battleContext)

	return true
end

function BattleLogic:setResultJudgeRules(judgeRules)
	self._battleReferee:setJudgeRules(judgeRules)
end

function BattleLogic:setupEventListeners(eventCenter)
	eventCenter:addListener("UnitPreEnter", bind1(self.on_UnitPreEnter, self), 0)
	eventCenter:addListener("UnitRevive", bind1(self.on_UnitRevive, self), 0)
	eventCenter:addListener("UnitReborn", bind1(self.on_UnitReborn, self), 0)
	eventCenter:addListener("UnitSpawned", bind1(self.on_UnitSpawned, self), 0)
	eventCenter:addListener("UnitSettled", bind1(self.on_UnitSettled, self), 0)
	eventCenter:addListener("UnitSummoned", bind1(self.on_UnitSummoned, self), 0)
	eventCenter:addListener("UnitWillDie", bind1(self.on_UnitWillDie, self), 0)
	eventCenter:addListener("UnitDied", bind1(self.on_UnitDied, self), 0)
	eventCenter:addListener("UnitsWillLeave", bind1(self.on_UnitsWillLeave, self), 0)
	eventCenter:addListener("UnitsLeft", bind1(self.on_UnitsLeft, self), 0)
	eventCenter:addListener("EntityHurt", bind1(self.on_EntityHurt, self), 0)
	eventCenter:addListener("EntityCure", bind1(self.on_EntityCure, self), 0)
	eventCenter:addListener("GainAnger", bind1(self.on_GainAnger, self), 0)
	eventCenter:addListener("DropItems", function(_, ...)
		self:collectDropItems(...)
	end, 0)
	eventCenter:addListener("UnitWillTransform", bind1(self.on_UnitWillTransform, self), 0)
	eventCenter:addListener("UnitTransformed", bind1(self.on_UnitTransformed, self), 0)
	eventCenter:addListener("UnitTransported", bind1(self.on_UnitTransported, self), 0)
	eventCenter:addListener("NewTime", bind1(self.on_NewTime, self), 0)
end

function BattleLogic:determineTeamPriority()
	local prior, posterior
	local teamA, teamB = self._teamA, self._teamB
	local initiative1 = teamA:getInitiativeValue()
	local initiative2 = teamB:getInitiativeValue()

	if initiative2 < initiative1 then
		posterior = teamB
		prior = teamA
	elseif initiative1 < initiative2 then
		posterior = teamA
		prior = teamB
	elseif self._lastBenefited ~= teamA then
		self._lastBenefited = teamA
		posterior = teamB
		prior = teamA
	else
		self._lastBenefited = teamB
		posterior = teamA
		prior = teamB
	end

	self._prior, self._posterior = prior, posterior

	return prior, posterior
end

function BattleLogic:getPriorTeam()
	return self._prior
end

function BattleLogic:getPosteriorTeam()
	return self._posterior
end

function BattleLogic:getPlayer(side)
	if side == kBattleSideA then
		return self._teamA:getCurPlayer()
	elseif side == kBattleSideB then
		return self._teamB:getCurPlayer()
	end

	return nil
end

function BattleLogic:getRivalPlayer(player)
	if player:getSide() == kBattleSideA then
		return self:getPlayer(kBattleSideB)
	elseif player:getSide() == kBattleSideB then
		return self:getPlayer(kBattleSideA)
	end

	return nil
end

function BattleLogic:getRoundNumber()
	return self._roundNumber
end

function BattleLogic:enterNewRound()
	if self._battleReferee ~= nil and self._battleResult == nil then
		local result = self._battleReferee:checkPlayerEnergy()

		result = result or self._battleReferee:battleRoundOver(self._roundNumber)

		if result then
			return false
		end
	end

	if self._roundNumber > 0 then
		self._formationSystem:updateOnRoundEnded()
		self._trapSystem:updateOnRoundEnded()
	end

	self._skillSystem:activateGlobalTrigger("NEW_ROUND", {})
	self._formationSystem:processExcludingUnits()

	local priorTeam, posteriorTeam = self:determineTeamPriority()
	local units = self._battleField:crossCollectBySpeed()

	self._actionScheduler:enterNewRoundWithActors(units)

	self._roundNumber = self._roundNumber + 1

	local battleContext = self._battleContext

	battleContext:writeVar("round", self._roundNumber)
	battleContext:setObject("prior", priorTeam)
	battleContext:setObject("posterior", posteriorTeam)

	if self._eventCenter then
		self._eventCenter:dispatchEvent("EnterNewRound", {
			round = self._roundNumber,
			units = units
		})
	end

	return true
end

function BattleLogic:on_UnitPreEnter(_, args)
	local unit = args.unit

	self._skillSystem:buildSkillsForActorPreEnter(unit)
	self._skillSystem:activateSpecificTrigger(unit, "PRE_ENTER")
	self._skillSystem:activateGlobalTrigger("UNIT_PRE_ENTER", {
		unit = unit
	})
end

function BattleLogic:on_UnitReborn(_, args)
	local unit = args.unit

	self._skillSystem:activateSpecificTrigger(unit, "REBORN")
	self._skillSystem:activateGlobalTrigger("UNIT_REBORN", {
		unit = unit
	})
end

function BattleLogic:on_UnitRevive(_, args)
	local unit = args.unit

	self._skillSystem:activateSpecificTrigger(unit, "REVIVE")
	self._skillSystem:activateGlobalTrigger("UNIT_REVIVE", {
		unit = unit
	})
end

function BattleLogic:on_UnitSpawned(_, args)
	local how, player, unit = args.how, args.player, args.unit
	local unitType = unit:getUnitType()
	local battleStatist = self._battleStatist

	if battleStatist ~= nil then
		battleStatist:sendStatisticEvent("UnitSpawned", {
			player = player,
			unit = unit,
			type = unitType == BattleUnitType.kMaster and "master" or unitType == BattleUnitType.kBattleField and "battlefield" or "hero",
			round = self:getRoundNumber(),
			startTime = self._battleContext:getCurrentTime()
		})
	end
end

function BattleLogic:on_UnitSettled(_, args)
	local unit = args.unit

	if unit:getUnitType() == BattleUnitType.kBattleField then
		return
	end

	self._skillSystem:activateSpecificTrigger(unit, "ENTER", {
		isRevive = unit:isBeRevive()
	})
	self._skillSystem:activateGlobalTrigger("UNIT_ENTER", {
		unit = unit,
		isRevive = unit:isBeRevive()
	})
end

function BattleLogic:on_UnitSummoned(_, args)
	local unit, actor = args.unit, args.actor

	self._skillSystem:activateGlobalTrigger("UNIT_SUMMON", {
		unit = actor,
		summond = unit
	})

	local battleStatist = self._battleStatist

	if battleStatist ~= nil then
		battleStatist:sendStatisticEvent("UnitSummoned", {
			unit = unit,
			actor = actor
		})
	end
end

function BattleLogic:on_UnitTransported(_, args)
	local battleStatist = self._battleStatist

	if battleStatist ~= nil then
		battleStatist:sendStatisticEvent("UnitTransported", {
			player = args.player,
			unit = args.unit,
			cellId = args.cellId
		})
	end

	local newCell = self._battleField:getCellById(args.cellId)
	local oldCell = self._battleField:getCellById(args.oldCellId)

	self._skillSystem:activateGlobalTrigger("UNIT_TRANSPORT", {
		unit = args.unit,
		oldCell = oldCell,
		newCell = newCell
	})
	self._skillSystem:activateSpecificTrigger(args.unit, "TRANSPORT", {
		unit = args.unit,
		oldCell = oldCell,
		newCell = newCell
	})
end

function BattleLogic:on_UnitWillDie(_, unit, player)
	local buffSystem = self._buffSystem

	buffSystem:cleanupBuffsOnTarget(unit)
end

function BattleLogic:on_UnitDied(_, unit, player)
	local battleStatist = self._battleStatist

	if battleStatist ~= nil then
		battleStatist:sendStatisticEvent("UnitDied", {
			player = player,
			unit = unit,
			round = self:getRoundNumber(),
			endTime = self._battleContext:getCurrentTime()
		})
	end

	self._skillSystem:activateSpecificTrigger(unit, "DIE")
	self._skillSystem:activateGlobalTrigger("UNIT_DIE", {
		unit = unit
	})
	self._skillSystem:clearTriggersForActor(unit)

	if self._battleReferee ~= nil and self._battleResult == nil then
		self._battleReferee:battleUnitDied(unit)
	end
end

function BattleLogic:on_UnitsWillLeave(_, units, unitGroups)
	local skillSystem = self._skillSystem
	local buffSystem = self._buffSystem

	for _, unit in ipairs(units) do
		skillSystem:activateGlobalTrigger("UNIT_KICK", {
			unit = unit
		})
		skillSystem:cancelSkillsForActor(unit)
		skillSystem:clearTriggersForActor(unit)
		buffSystem:cleanupBuffsOnTarget(unit)
	end
end

function BattleLogic:on_UnitsLeft(_, units, unitGroups, fleeSta, joinReferee)
	local battleStatist = self._battleStatist

	if battleStatist ~= nil then
		for i, unit in ipairs(units) do
			battleStatist:sendStatisticEvent("UnitLeft", {
				player = unit:getOwner(),
				unit = unit,
				round = self:getRoundNumber()
			})
		end
	end

	if self._battleReferee ~= nil and self._battleResult == nil then
		self._battleReferee:battleUnitsExcluded(units)

		if fleeSta then
			self._battleReferee:battleUnitsEscaped(units)
		end

		if joinReferee then
			for k, v in pairs(units) do
				self._battleReferee:battleUnitDied(v)
			end
		end
	end
end

function BattleLogic:on_GainAnger(_, args)
	local anger = args.anger
	local entity = args.unit

	if anger.eft > 0 and entity:getUnitType() == BattleUnitType.kMaster and isReadyForUniqueSkill(entity) and self._eventCenter then
		self._eventCenter:dispatchEvent("MasterFullAnger", {
			side = entity:getSide()
		})
	end

	return anger
end

function BattleLogic:on_EntityHurt(_, args)
	local actor, target, hurt, workId, how = args.actor, args.target, args.hurt, args.workId, args.how
	local prevHpRatio, curHpRatio = args.prevHpRatio, args.curHpRatio

	if hurt.deadly and target ~= nil then
		target:setLifeStage(ULS_Dying)
		self._skillSystem:activateSpecificTrigger(target, "DYING")
		self._skillSystem:activateGlobalTrigger("UNIT_DYING", {
			unit = target
		})
	end

	local targetHpComp = target:getComponent("Health")

	if hurt.eft ~= nil and hurt.eft > 0 then
		local hurtRatio = targetHpComp:ratioOfMaxHp(hurt.eft)
		local result = self._angerSystem:applyAngerRuleOnTarget(workId, target, AngerRules.kFromDamage, hurtRatio)

		if floor(prevHpRatio * 100) ~= floor(curHpRatio * 100) or curHpRatio <= 0 then
			self._skillSystem:activateGlobalTrigger("UNIT_HPCHANGE", {
				unit = target,
				prevHpPercent = floor(prevHpRatio * 100),
				curHpPercent = floor(curHpRatio * 100),
				how = how,
				actor = actor,
				hurt = hurt
			})

			if actor and hurt and hurt.deadly then
				self._skillSystem:activateGlobalTrigger("UNIT_BEKILLED", {
					unit = target,
					prevHpPercent = floor(prevHpRatio * 100),
					curHpPercent = floor(curHpRatio * 100),
					how = how,
					actor = actor,
					hurt = hurt
				})
			end
		end
	end

	local battleStatist = self._battleStatist

	if targetHpComp and battleStatist ~= nil then
		battleStatist:sendStatisticEvent("UnitHurt", {
			hpDetails = {
				[target:getId()] = targetHpComp:getHp()
			}
		})
	end
end

function BattleLogic:on_EntityCure(_, args)
	local actor, target, cure, workId, how = args.actor, args.target, args.cure, args.workId, args.how
	local prevHpRatio, curHpRatio = args.prevHpRatio, args.curHpRatio
	local battleStatist = self._battleStatist

	if cure.eft ~= nil and cure.eft > 0 then
		if actor and battleStatist ~= nil then
			battleStatist:sendStatisticEvent("DoCure", {
				player = actor:getOwner(),
				unit = actor,
				target = target,
				detail = cure
			})
		end

		if floor(prevHpRatio * 100) ~= floor(curHpRatio * 100) then
			self._skillSystem:activateGlobalTrigger("UNIT_HPCHANGE", {
				unit = target,
				prevHpPercent = floor(prevHpRatio * 100),
				curHpPercent = floor(curHpRatio * 100),
				actor = actor,
				how = how,
				hurt = cure
			})
		end
	end
end

function BattleLogic:collectDropItems(source, items)
	local battleStatist = self._battleStatist

	if battleStatist ~= nil then
		local side = source:getSide()
		local player = self:getPlayer(opposeBattleSide(side))

		battleStatist:sendStatisticEvent("GetSpoils", {
			player = player,
			source = source,
			items = items
		})
	end
end

function BattleLogic:on_UnitWillTransform(_, unit, player)
	local buffSystem = self._buffSystem

	buffSystem:cleanupBuffsOnTarget(unit)
	self._skillSystem:clearTriggersForActor(unit)
	self._skillSystem:activateGlobalTrigger("UNIT_KICK", {
		type = "transform",
		unit = unit
	})
end

function BattleLogic:on_UnitTransformed(_, unit, player)
	local battleStatist = self._battleStatist

	if battleStatist ~= nil then
		battleStatist:sendStatisticEvent("UnitTransformed", {
			player = player,
			unit = unit
		})
	end

	local buffSystem = self._buffSystem

	buffSystem:triggerEnterBuffs(unit)
	self._skillSystem:buildSkillsForActor(unit)
	self._skillSystem:activateSpecificTrigger(unit, "ENTER", {
		isRevive = unit:isBeRevive()
	})
	self._skillSystem:activateGlobalTrigger("UNIT_ENTER", {
		type = "transform",
		unit = unit,
		isRevive = unit:isBeRevive()
	})
end

function BattleLogic:on_NewTime(_, args)
	local elapsed = math.floor(args.now)

	self._skillSystem:activateTimingTrigger(args.delta)

	if math.floor(args.prev / 1000) < math.floor(args.now / 1000) then
		self._formationSystem:updateOnNewSecond(math.floor(args.now / 1000))
	end

	self._cardSystem:updateOnNewSecond(args)
end
