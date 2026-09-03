-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/RegularBattleLogic.lua

require("dm.battle.logic.BattleReferee")
require("dm.battle.logic.BattleActionScheduler")

BattlePhases = {
	kPhase1 = 1,
	kPhase3 = 3,
	kTimeup = 4,
	kPhase2 = 2,
	kNextbout = 6,
	kPreNextBout = 5,
	kWaitCommand = 0,
	kNextboutReady = 7,
	kPrepare = -1
}

local REGULAR_BATTLE_DEFAULTS = {
	phase3Duration = 30000,
	phase1Duration = 60000,
	preNextBoutDuration = 3000,
	phase1EnergySpeed = 1,
	phase2Duration = 30000,
	phase2EnergySpeed = 2,
	phase3EnergySpeed = 2,
	prepareDuration = 2400
}

RegularBattleLogic = class("RegularBattleLogic", BattleLogic)

RegularBattleLogic:has("_maxRounds", {
	is = "rw"
})
RegularBattleLogic:has("_skillDefinitions", {
	is = "rw"
})
RegularBattleLogic:has("_actionScheduler", {
	is = "r"
})
RegularBattleLogic:has("_boutIndex", {
	is = "r"
})

function RegularBattleLogic:initialize()
	super.initialize(self)

	self._actionScheduler = BattleActionScheduler:new()
end

function RegularBattleLogic:setBattleConfig(battleConfig)
	self._battleConfig = battleConfig

	if battleConfig.battleMode then
		self:setBattleMode(battleConfig.battleMode)
	end

	self:loadNextBoutConfig()
end

function RegularBattleLogic:loadNextBoutConfig()
	local defaults = REGULAR_BATTLE_DEFAULTS

	self._boutIndex = (self._boutIndex or 0) + 1

	local battleConfig = self._battleConfig

	if battleConfig then
		::label_3_0::

		local var_3_1 = battleConfig.phases

		if battleConfig.phases then
			var_3_1 = battleConfig.phases[self._boutIndex]

			if not battleConfig.phases[self._boutIndex] then
				local phaseConfig = battleConfig.phases[1]
				local var_3_2 = {}
				local var_3_3 = {
					index = 1
				}

				if phaseConfig then
					var_3_3.duration = phaseConfig.phase1Duration or defaults.phase1Duration
				end

				if phaseConfig then
					var_3_3.energySpeed = phaseConfig.phase1EnergySpeed or defaults.phase1EnergySpeed
				end

				var_3_3.phase = BattlePhases.kPhase1
				var_3_3.nextPhase = BattlePhases.kPhase2
				var_3_3.onEnter = self.onEnterPhase
				var_3_2[BattlePhases.kPhase1] = var_3_3

				local var_3_4 = {
					index = 2
				}

				if phaseConfig then
					var_3_4.duration = phaseConfig.phase2Duration or defaults.phase2Duration
				end

				if phaseConfig then
					var_3_4.energySpeed = phaseConfig.phase2EnergySpeed or defaults.phase2EnergySpeed
				end

				var_3_4.phase = BattlePhases.kPhase2
				var_3_4.nextPhase = BattlePhases.kPhase3
				var_3_4.onEnter = self.onEnterPhase
				var_3_2[BattlePhases.kPhase2] = var_3_4

				local var_3_5 = {
					index = 3
				}

				if phaseConfig then
					var_3_5.duration = phaseConfig.phase3Duration or defaults.phase3Duration
				end

				if phaseConfig then
					var_3_5.energySpeed = phaseConfig.phase3EnergySpeed or defaults.phase3EnergySpeed
				end

				var_3_5.phase = BattlePhases.kPhase3
				var_3_5.onEnter = self.onEnterPhase
				var_3_2[BattlePhases.kPhase3] = var_3_5
				self._phases = var_3_2
			end
		end
	end
end

function RegularBattleLogic:setupStateTransitions(battleContext)
	local startState = RegularLogicState_Prepare:new("prepare", 0)
	local waitingState = RegularLogicState_Waiting:new("waiting", self._battleConfig.waitMode, self._battleConfig.waitTime)
	local actionSchedulerState = RegularLogicState_ActionScheduler:new("actionScheduler")
	local nextWaveState = RegularLogicState_NextWave:new("nextWave", 200)
	local beforeNextBoutState = RegularLogicState_BeforeNextBoutState:new("beforeNextBout")
	local nextBoutState = RegularLogicState_NextBout:new("nextBout", 500, 200)
	local timedOutState = RegularLogicState_Timedout:new("timedOut")
	local diligentState = RegularLogicState_DiligentRound:new("diligentRound", 2000)

	startState:setupContext(battleContext):addTransition("COMPLETED", waitingState):enableOperation("heroCard"):enableOperation("emojiUsed"):enableOperation("doskill"):enableOperation("cancelskill"):enableOperation("checkMasterSkillState")
	waitingState:setupContext(battleContext):addTransition("COMPLETED", actionSchedulerState):addTransition("TIMEDOUT", timedOutState):enableOperation("heroCard"):enableOperation("emojiUsed"):enableOperation("doskill"):enableOperation("cancelskill"):enableOperation("checkMasterSkillState")
	actionSchedulerState:setupContext(battleContext):addTransition("NEXT_WAVE", nextWaveState):addTransition("BOUT_END", beforeNextBoutState):addTransition("NEXT_BOUT", nextBoutState):addTransition("TIMEDOUT", timedOutState):addTransition("DILIGENT_ROUND", diligentState):enableOperation("heroCard"):enableOperation("emojiUsed"):enableOperation("skillCard"):enableOperation("doskill"):enableOperation("cancelskill"):enableOperation("refreshSkillCard"):enableOperation("checkMasterSkillState")
	beforeNextBoutState:setupContext(battleContext):addTransition("NEXT_BOUT", nextBoutState):addTransition("TIMEDOUT", timedOutState)
	nextWaveState:setupContext(battleContext):addTransition("COMPLETED", actionSchedulerState):addTransition("NEXT_BOUT", nextBoutState)
	nextBoutState:setupContext(battleContext):addTransition("FINISHED", actionSchedulerState)
	timedOutState:setupContext(battleContext):addTransition("NEXT_BOUT", nextBoutState)
	diligentState:setupContext(battleContext):addTransition("COMPLETED", actionSchedulerState):addTransition("NEXT_WAVE", nextWaveState):addTransition("NEXT_BOUT", nextBoutState)

	return startState
end

function RegularBattleLogic:isReadyForInput()
	return true
end

function RegularBattleLogic:isReadyForAI()
	if self._currentPhase and self._currentPhase.index and self._currentPhase.index > 0 then
		return true
	end

	return false
end

function RegularBattleLogic:isWaiting()
	return self._logicUpdateFunc == self.waitCommand
end

function RegularBattleLogic:getRemainTime(phaseIndex)
	local duration = 0

	for i = phaseIndex, BattlePhases.kPhase3 do
		local phase = self._phases[i]

		duration = duration + phase.duration
	end

	return duration
end

function RegularBattleLogic:setDurationForPhase(phase, duration)
	local phaseCfg = self._phases[phase]

	if phaseCfg == nil then
		return
	end

	phaseCfg.duration = duration
end

function RegularBattleLogic:setupWithContext(battleContext)
	super.setupWithContext(self, battleContext)
	battleContext:setObject("ActionScheduler", self._actionScheduler)

	return true
end

function RegularBattleLogic:startSubModules(battleContext)
	super.startSubModules(self, battleContext)
	self:setupInputHandlers(battleContext)
	self._actionScheduler:reset(battleContext)

	local teamA, teamB = self:getTeamA(), self:getTeamB()

	teamA:start(battleContext)
	teamB:start(battleContext)

	return true
end

function RegularBattleLogic:setupExtraSkillEnvironment(skillSystem)
	return
end

function RegularBattleLogic:adjustEnergyBaseSpeed(energySpeed)
	local teamA = self:getTeamA()

	teamA:adjustEnergyBaseSpeed((type(energySpeed) == "table" or nil) and (energySpeed[1] or energySpeed))

	local teamB = self:getTeamB()

	teamB:adjustEnergyBaseSpeed((type(energySpeed) == "table" or nil) and (energySpeed[2] or energySpeed))
end

function RegularBattleLogic:setupGroundCell(cfg)
	if cfg.blockCells then
		for k, cellId in pairs(cfg.blockCells) do
			self._battleField:blockCell(cellId)
		end
	end
end

function RegularBattleLogic:startPhase()
	self._currentPhase = self._phases[BattlePhases.kPhase1]

	if self._currentPhase.onEnter ~= nil then
		self._currentPhase.onEnter(self, self._currentPhase)
	end
end

function RegularBattleLogic:getCurrentPhase()
	return self._currentPhase
end

function RegularBattleLogic:onEnterPhase(phase)
	self:adjustEnergyBaseSpeed(phase.energySpeed)

	if self._battleRecorder then
		self._battleRecorder:recordEvent(kBRMainLine, "NewPhase", {
			phase = phase.index,
			bout = self._boutIndex,
			duration = self:getRemainTime(phase.index),
			timelimit = phase.duration,
			time = self._timingSystem:getCumulativeTime(),
			energySpeed = phase.energySpeed
		})

		if phase.index == 1 then
			self._battleRecorder:recordEvent(kBRMainLine, "Round", {
				num = self:getRoundNumber(),
				max = self:getMaxRounds()
			})
		end
	end
end

function RegularBattleLogic:battleTimedout()
	self._battleReferee:battleTimedup()
	self._actionScheduler:setFinished()
end

function RegularBattleLogic:getPhaseTime(phaseIndex)
	local phase = self._phases[phaseIndex]

	return (phase or nil) and (phase.duration or 0)
end

function RegularBattleLogic:getBoutTime()
	local phases = {
		BattlePhases.kPhase1,
		BattlePhases.kPhase2,
		BattlePhases.kPhase3
	}
	local result = 0

	for _, phaseIndex in ipairs(phases) do
		local phase = self._phases[phaseIndex]

		if phase and phase == self._currentPhase then
			result = result + self._timingSystem:getCumulativeTime()

			break
		end

		result = result + ((phase or nil) and (phase.duration or 0))
	end

	return result
end

function RegularBattleLogic:getTotalTime()
	if self._boutTimes then
		local result = self:getBoutTime()

		for _, time in ipairs(self._boutTimes) do
			result = result + time
		end

		return result
	else
		return self:getBoutTime()
	end
end

function RegularBattleLogic:setupInputHandlers()
	self:setupInputHandler("heroCard", self.handle_HeroCard, true)
	self:setupInputHandler("skillCard", self.handle_SkillCard, true)
	self:setupInputHandler("doskill", self.handle_DoSkill, true)
	self:setupInputHandler("cancelskill", self.handle_CancelSkill, true)
	self:setupInputHandler("refreshSkillCard", self.handle_RefreshSkillCard, true)
	self:setupInputHandler("checkMasterSkillState", self.handle_CheckMasterSkillState, true)
	self:setupInputHandler("leave", self.handle_Leave)
	self:setupInputHandler("Leave", self.handle_Leave)
	self:setupInputHandler("emojiUsed", self.handle_EmojiUsed, true)
end

function RegularBattleLogic:handle_EmojiUsed(player, op, args)
	if self._battleRecorder and player:getMasterUnit() then
		self._battleRecorder:recordEvent(player:getMasterUnit():getId(), "Emoji", args)
	end
end

function RegularBattleLogic:handle_CheckMasterSkillState(player, op, args)
	if self._battleRecorder and player:getMasterUnit() then
		local master = player:getMasterUnit()
		local flagComp = master:getComponent("Flag")
		local isForbid = not not (flagComp and flagComp:hasAnyStatus({
			kBEDazed,
			kBEMuted,
			kBENumbed,
			kBEFrozen
		}))

		if isForbid ~= master._forbidonSkillSt then
			self._battleRecorder:recordEvent(kBRMainLine, "ForbidSkill", isForbid)

			master._forbidonSkillSt = isForbid
		end
	end
end

function RegularBattleLogic:handle_HeroCard(player, op, args)
	if self._battleReferee:getResult() then
		return false, "finish"
	end

	local idx, cardid = args.idx, args.card
	local card, reason = player:takeCardAtIndex(idx, cardid)

	if card == nil then
		return false, reason
	end

	if card:isLocked() then
		return false, "cardIsLocked"
	end

	local ok, detail = card:usedByPlayer(player, self._battleContext, args.cellNo)

	if not ok then
		return false, detail
	end

	if idx <= 4 then
		local newCard, nextCard = player:fillCardAtIndex(idx)

		if self._battleRecorder ~= nil then
			local var_25_0 = player:getId()
			local var_25_1 = "Card"
			local var_25_2 = {
				type = "hero",
				idx = idx
			}

			var_25_2.card = newCard and newCard:dumpInformation() or 0
			var_25_2.next = nextCard and nextCard:dumpInformation() or 0

			self._battleRecorder:recordEvent(var_25_0, var_25_1, var_25_2)
		end
	end

	if self._battleStatist ~= nil then
		self._battleStatist:sendStatisticEvent("UseHeroCard", {
			player = player,
			card = card
		})
	end

	self._commanded = true

	self._skillSystem:activateGlobalTrigger("HERO_CARD_CHANGEED", {
		player = player,
		idx = idx,
		oldcard = card,
		newcard = newCard
	})

	return true
end

function RegularBattleLogic:handle_SkillCard(player, op, args)
	if self._battleReferee:getResult() then
		return false, "finish"
	end

	local idx, cardid = args.idx, args.card
	local card, reason = player:takeCardAtIndex(idx, cardid)

	if card == nil then
		return false, reason
	end

	if card:isLocked() then
		return false, "cardIsLocked"
	end

	local ok, detail = card:usedByPlayer(player, self._battleContext, nil, args)

	if not ok then
		return false, detail
	end

	if idx <= 4 then
		local newCard, nextCard = player:fillCardAtIndex(idx)

		if self._battleRecorder ~= nil then
			local var_26_0 = player:getId()
			local var_26_1 = "Card"
			local var_26_2 = {
				type = "skill",
				idx = idx
			}

			var_26_2.card = newCard and newCard:dumpInformation() or 0
			var_26_2.next = nextCard and nextCard:dumpInformation() or 0

			self._battleRecorder:recordEvent(var_26_0, var_26_1, var_26_2)
		end
	end

	if self._battleStatist ~= nil then
		self._battleStatist:sendStatisticEvent("UseSkillCard", {
			player = player,
			card = card
		})
	end

	self._commanded = true

	return true
end

function RegularBattleLogic:handle_RefreshSkillCard(player, op, args)
	if self._battleReferee:getResult() then
		return false, "finish"
	end

	if not player:checkCanFillSkillCards() then
		return false, "wrongCardState"
	end

	if not cost then
		local cost = player:getRefreshCost()
		local energyInfo

		if cost and cost > 0 then
			energyInfo = player:consumeEnergy(cost)

			if energyInfo == nil then
				return false, "EnergyNotEnough"
			end
		end

		if energyInfo and self._battleRecorder ~= nil then
			self._battleRecorder:recordEvent(player:getId(), "SyncE", energyInfo)
		end

		local randomizer = self._battleContext:getObject("Randomizer")

		player:refreshSkillCard(randomizer)

		if self._battleStatist ~= nil then
			self._battleStatist:sendStatisticEvent("RefreshSkillCard", {
				player = player
			})
		end

		self._commanded = true

		return true
	end
end

function RegularBattleLogic:handle_DoSkill(player, op, args)
	if self._battleReferee:getResult() then
		return false, "finish"
	end

	local master = player:getMasterUnit()

	if not master then
		return false, "noMaster"
	end

	local skillType = args.type

	if skillType == nil then
		return false, "skillNotSpecified"
	end

	if not isReadyForUniqueSkill(master) then
		return false, "checkFailed"
	end

	local ok, detail = self._actionScheduler:exertUniqueSkill(master, skillType)

	if not ok then
		return false, detail
	end

	self._commanded = true

	return true, detail
end

function RegularBattleLogic:handle_CancelSkill(player, op, args)
	if self._battleReferee:getResult() then
		return false, "finish"
	end

	local master = player:getMasterUnit()

	if not master then
		return false, "noMaster"
	end

	local skillType = args.type

	if skillType == nil then
		return false, "skillNotSpecified"
	end

	local skill = master:getComponent("Skill")

	if skill and skill:getUniqueSkillRoutine() then
		skill:getUniqueSkillRoutine():cancel(self._battleContext)
	else
		return false, "noskill in process"
	end

	self._commanded = true

	return true
end

function RegularBattleLogic:handle_Leave(player, op, args)
	print("handle_Leave", 1)

	if self._battleResult ~= nil then
		return false, "alreadyFinished"
	end

	print("handle_Leave", 2)

	local result

	if player == self._teamA:getCurPlayer() then
		result = kBattleSideALose
	elseif player == self._teamB:getCurPlayer() then
		result = kBattleSideBLose
	else
		return false, "unknownPlayer"
	end

	self:finish(result)

	if self._battleRecorder then
		self._battleRecorder:recordEvent(kBRMainLine, "Finish", {
			reason = "PLAYER_LEFT",
			result = result
		})
	end

	if self._battleStatist ~= nil then
		local playerA = self:getTeamA():getCurPlayer()
		local playerB = self:getTeamB():getCurPlayer()

		self._battleStatist:sendStatisticEvent("FinishBout", {
			reason = "userLeave",
			time = self:getBoutTime(),
			endTime = self._battleContext:getCurrentTime(),
			result = result,
			roundCount = self:getRoundNumber(),
			hpRatio = {
				[playerA:getId()] = playerA:getHpRatio(),
				[playerB:getId()] = playerB:getHpRatio()
			},
			remainAnger = {
				[playerA:getId()] = playerA:getRemainAnger(),
				[playerB:getId()] = playerB:getRemainAnger()
			},
			hpDetails = {
				[playerA:getId()] = playerA:getHpDetails(self._battleContext),
				[playerB:getId()] = playerB:getHpDetails(self._battleContext)
			}
		})
	end

	return true
end

function RegularBattleLogic:on_GainAnger(_, args)
	local anger = args.anger
	local entity = args.unit

	if self._battleMode ~= 1 and (args.check or anger.eft > 0) and isReadyForUniqueSkill(entity) and self._actionScheduler:exertUniqueSkill(entity, kBattleUniqueSkill) then
		-- block empty
	end

	super.on_GainAnger(self, _, args)

	return anger
end

function RegularBattleLogic:resetTiming(...)
	self._timingSystem:resetCumulativeTime(0)
end

function RegularBattleLogic:pauseTiming(...)
	self._timingSystem:setIsTiming(false, ...)
end

function RegularBattleLogic:resumeTiming(...)
	self._timingSystem:setIsTiming(true, ...)
end

function RegularBattleLogic:pauseProcess()
	self._logicUpdateFunc = nil
end

function RegularBattleLogic:resumeProcess()
	self._logicUpdateFunc = self.updateBattle
end

function RegularBattleLogic:waitProcess()
	self._logicUpdateFunc = self.waitCommand
end

function RegularBattleLogic:getAllPlayers()
	return {
		self._teamA:getCurPlayer(),
		self._teamB:getCurPlayer()
	}
end

function RegularBattleLogic:step(dt)
	self._timingSystem:accumulateTime(dt)

	if self._logicUpdateFunc then
		self:_logicUpdateFunc(dt)
	end

	local result = super.step(self, dt)

	return self._battleResult
end

function RegularBattleLogic:waitCommand(dt)
	if self._timingSystem:isTiming() then
		local battleContext = self._battleContext

		self:getTeamA():update(dt, battleContext)
		self:getTeamB():update(dt, battleContext)
		self._formationSystem:update(dt, battleContext)
		self._skillSystem:update(dt)
	end

	if self._commanded then
		self._timingSystem:setIsTiming(true)
		self:pauseProcess()
		self:dispatchMessage({
			type = "COMPLETED"
		})
	end

	local result = self._battleReferee:getResult()

	if result then
		self:dispatchMessage({
			type = "NEXT_BOUT",
			args = {
				result = result
			}
		})
	end
end

function RegularBattleLogic:updateBattle(dt)
	local battleContext = self._battleContext

	self:getTeamA():update(dt, battleContext)
	self:getTeamB():update(dt, battleContext)
	self._formationSystem:update(dt, battleContext)
	self._skillSystem:update(dt)

	if self._timingSystem:checkLocking(dt) then
		return
	end

	local actionScheduler = self._actionScheduler

	if not actionScheduler:update(dt, battleContext) then
		if actionScheduler:isFinished() then
			if not self:isFinished() then
				local result = self._battleReferee:getResult()

				if result then
					self:dispatchMessage({
						type = "NEXT_BOUT",
						args = {
							result = result
						}
					})
				end
			end
		elseif self:enterNewRound() and self._battleRecorder then
			self._battleRecorder:recordEvent(kBRMainLine, "Round", {
				num = self:getRoundNumber()
			})
		end
	end
end

function RegularBattleLogic:recordBoutTime()
	self._boutTimes = self._boutTimes or {}
	self._boutTimes[#self._boutTimes + 1] = self:getBoutTime()
end

function RegularBattleLogic:nextBout()
	self:loadNextBoutConfig()
	self._teamA:nextBout(self._battleContext)
	self._teamB:nextBout(self._battleContext)
	self:resetBattle()

	return self._boutIndex
end

function RegularBattleLogic:resetBattle()
	self._actionScheduler:reset(self._battleContext)
	self._battleReferee:startNewBattle(self, self._battleContext)
	self._formationSystem:reset()
	self._skillSystem:reset()
end

function RegularBattleLogic:on_NewTime(_, args)
	super.on_NewTime(self, _, args)

	local elapsed = args.now
	local currentPhase = self._currentPhase

	if currentPhase ~= nil then
		local duration = currentPhase.duration

		if elapsed ~= nil and duration >= 0 and duration <= elapsed then
			local newPhase = self._phases[currentPhase.nextPhase]

			elapsed = elapsed - duration

			while newPhase and newPhase.duration == 0 do
				newPhase = self._phases[newPhase.nextPhase]
			end

			if newPhase ~= nil then
				self._currentPhase = newPhase

				self._timingSystem:resetCumulativeTime(elapsed)

				if self._currentPhase.onEnter ~= nil then
					self._currentPhase.onEnter(self, self._currentPhase)
				end
			else
				self:dispatchMessage({
					type = "TIMEDOUT"
				})
			end
		end
	end
end
