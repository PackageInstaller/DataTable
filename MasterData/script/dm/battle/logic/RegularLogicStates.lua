-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/RegularLogicStates.lua

local ipairs = _G.ipairs
local pairs = _G.pairs
local max = math.max
local kReadyPromptDuration = 2400
local kDangerWarningDuration = 1700

RegularLogicState_Prepare = class("RegularLogicState_Prepare", BattleState)

function RegularLogicState_Prepare:initialize(name, duration)
	super.initialize(self, name)

	self._duration = duration or 0
end

function RegularLogicState_Prepare:setupContext(battleContext)
	self._battleField = battleContext:getObject("BattleField")
	self._battleRecorder = battleContext:getObject("BattleRecorder")
	self._battleStatist = battleContext:getObject("BattleStatist")
	self._formationSystem = battleContext:getObject("FormationSystem")
	self._eventCenter = battleContext:getObject("EventCenter")
	self._skillSystem = battleContext:getObject("SkillSystem")

	return self
end

function RegularLogicState_Prepare:enter(battleLogic, battleContext)
	super.enter(self, battleLogic, battleContext)
	battleLogic:pauseTiming()
	self:startTimer(1, function()
		self:doPrepare(battleLogic, battleContext)
	end)
end

function RegularLogicState_Prepare:doPrepare(battleLogic, battleContext)
	local allPlayers = battleLogic:getAllPlayers()
	local eventCenter = self._eventCenter
	local duration = 0

	if duration > 0 then
		self:startTimer(duration, function()
			eventCenter:dispatchEvent("WaveEntering")
			self:embattle(battleLogic, allPlayers)
		end)
	else
		eventCenter:dispatchEvent("WaveEntering")
		self:embattle(battleLogic, allPlayers)
	end
end

function RegularLogicState_Prepare:embattle(battleLogic, allPlayers)
	for _, player in ipairs(allPlayers) do
		player:embattle(1, nil, self._formationSystem, self._battleRecorder)
	end

	self._skillSystem:update(0)

	local function readyAndComplete()
		self._eventCenter:dispatchEvent("WaveReady")
		self:startTimer(kReadyPromptDuration, function()
			self:completePreparation(battleLogic)
			self:onMessage(battleLogic, {
				type = "COMPLETED"
			})
		end)
	end

	self:startTimer(self._duration, function()
		self._eventCenter:dispatchEvent("WaveEntered")

		local duration = 0

		if duration > 0 then
			self:startTimer(duration, readyAndComplete)
		else
			readyAndComplete()
		end
	end)
	self:prepareForBattle(battleLogic)
end

function RegularLogicState_Prepare:prepareForBattle(battleLogic)
	if self._battleRecorder then
		local var_14_0 = {
			time = battleLogic:getRemainTime(1),
			bout = battleLogic:getBoutIndex()
		}

		var_14_0.total = battleLogic:getTeamA():countPlayers() + battleLogic:getTeamB():countPlayers() - 1

		self._battleRecorder:recordEvent(kBRMainLine, "Prepare", var_14_0)
		self._battleRecorder:recordEvent(kBRFieldLine, "BlockCell", {
			blockCells = self._battleField:collectBlockCellIndex(kBattleSideA)
		})
	end
end

function RegularLogicState_Prepare:completePreparation(battleLogic)
	self._eventCenter:dispatchEvent("GoFighting")

	if self._battleRecorder then
		self._battleRecorder:recordEvent(kBRMainLine, "GoFighting")
	end

	if self._battleStatist then
		self._battleStatist:sendStatisticEvent("GoFighting", {
			time = startTime
		})
	end
end

RegularLogicState_Waiting = class("RegularLogicState_Waiting", BattleState)

function RegularLogicState_Waiting:initialize(name, waitMode, waitTime)
	super.initialize(self, name)

	self._needWaiting = waitMode == 1 or waitMode == 2
	self._willKeepTiming = waitMode == 2
	self._waitTime = waitTime
end

function RegularLogicState_Waiting:setupContext(battleContext)
	self._battleRecorder = battleContext:getObject("BattleRecorder")
	self._timingSystem = battleContext:getObject("TimingSystem")

	return self
end

function RegularLogicState_Waiting:enter(battleLogic, battleContext, args)
	super.enter(self, battleLogic, battleContext)

	if self._needWaiting then
		if self._willKeepTiming then
			self._timingSystem:setIsTiming(true)
			battleLogic:startPhase()
		else
			self._timingSystem:setIsTiming(false)

			if self._battleRecorder then
				self._battleRecorder:recordEvent(kBRMainLine, "Wait", {})
				self._battleRecorder:recordEvent(kBRMainLine, "NewPhase", {
					time = 0,
					energySpeed = 0,
					phase = 0,
					timelimit = 0,
					duration = battleLogic:getRemainTime(BattlePhases.kPhase1)
				})
			end
		end

		battleLogic:waitProcess()

		if self._waitTime then
			self:startTimer(self._waitTime, function()
				self:onMessage(battleLogic, {
					type = "COMPLETED"
				})
			end)
		end
	else
		self:onMessage(battleLogic, {
			type = "COMPLETED"
		})
	end
end

function RegularLogicState_Waiting:exit(battleLogic, battleContext)
	if self._needWaiting and self._battleRecorder then
		self._battleRecorder:recordEvent(kBRMainLine, "EndWait", {})
	end

	if not self._willKeepTiming then
		battleLogic:startPhase()
	end

	return super.exit(self, battleLogic, battleContext)
end

RegularLogicState_ActionScheduler = class("RegularLogicState_ActionScheduler", BattleState)

function RegularLogicState_ActionScheduler:initialize(name)
	super.initialize(self, name)
end

function RegularLogicState_ActionScheduler:enter(battleLogic, battleContext)
	super.enter(self, battleLogic, battleContext)
	battleLogic:resumeTiming()
	battleLogic:resumeProcess()
end

RegularLogicState_NextWave = class("RegularLogicState_NextWave", BattleState)

function RegularLogicState_NextWave:initialize(name, duration)
	super.initialize(self, name)

	self._duration = duration
end

function RegularLogicState_NextWave:setupContext(battleContext)
	self._battleRecorder = battleContext:getObject("BattleRecorder")
	self._formationSystem = battleContext:getObject("FormationSystem")
	self._actionScheduler = battleContext:getObject("ActionScheduler")
	self._eventCenter = battleContext:getObject("EventCenter")
	self._skillSystem = battleContext:getObject("SkillSystem")
	self._trapSystem = battleContext:getObject("TrapSystem")

	return self
end

function RegularLogicState_NextWave:enter(battleLogic, battleContext, args)
	super.enter(self, battleLogic, battleContext)
	battleLogic:pauseTiming()
	battleLogic:pauseProcess()

	self._args = args
	self._updateAction = true

	if self._debugTimer then
		self._debugTimer:cancel()

		self._debugTimer = nil
	end

	self._debugTimer = self:startTimer(4000, function()
		if self._battleRecorder then
			self._battleRecorder:recordEvent(kBRMainLine, "Error", {
				errorInfo = "checkLast4000",
				state = "NextWave"
			})
		end

		if DEBUG and DEBUG > 0 then
			assert(false, "本次战报可能有问题，如果无法继续，请保存并上传本次战报")
		else
			self._updateAction = false

			self:check(battleLogic, battleContext, self._args)
		end
	end)
end

function RegularLogicState_NextWave:check(battleLogic, battleContext, args)
	if self._debugTimer then
		self._debugTimer:cancel()

		self._debugTimer = nil
	end

	local allPlayers = battleLogic:getAllPlayers()
	local eventCenter = self._eventCenter
	local teamA = battleLogic:getTeamA()
	local teamB = battleLogic:getTeamB()

	self._actionScheduler:reset(battleContext)
	teamA:clearStatus(battleContext)
	teamB:clearStatus(battleContext)

	local nextWaveSta = true

	for _, player in ipairs(allPlayers) do
		if player:isEmbattleNeeded() then
			local nextWave = player:hasNextWave()

			if not nextWave then
				player:fail()

				nextWaveSta = false
			end
		end
	end

	if not nextWaveSta then
		local var_27_0 = {
			type = "NEXT_BOUT"
		}
		local var_27_1 = {}
		local var_27_2 = {}

		if args.result.result == kBattleSideBWaveWiped then
			var_27_2.result = kBattleSideAWin or kBattleSideBWin
		end

		var_27_2.reason = args.result.reason
		var_27_1.result = var_27_2
		var_27_0.args = var_27_1

		self:onMessage(battleLogic, var_27_0)

		return
	end

	if self._battleRecorder then
		self._battleRecorder:recordEvent(kBRMainLine, "EndWave")
	end

	local duration = 2000

	if duration > 0 then
		self:startTimer(duration, function()
			eventCenter:dispatchEvent("WaveEntering")
			self:embattle(battleLogic, allPlayers)
		end)
	else
		eventCenter:dispatchEvent("WaveEntering")
		self:embattle(battleLogic, allPlayers)
	end
end

function RegularLogicState_NextWave:update(battleLogic, battleContext, dt)
	if self._updateAction then
		local actionScheduler = self._actionScheduler

		self._skillSystem:update(dt)

		if not actionScheduler:update(dt, battleContext) then
			if actionScheduler:isFinished() then
				Bdump("wave end 1")

				self._updateAction = false

				self:check(battleLogic, battleContext, self._args)
			else
				Bdump("wave end 2")

				self._updateAction = false

				self:check(battleLogic, battleContext, self._args)
			end
		end
	end

	return super.update(self, battleLogic, battleContext, dt)
end

function RegularLogicState_NextWave:exit(battleLogic, battleContext)
	return super.exit(self, battleLogic, battleContext)
end

function RegularLogicState_NextWave:embattle(battleLogic, allPlayers)
	self._trapSystem:cleanup()

	for _, player in ipairs(allPlayers) do
		if player:isEmbattleNeeded() then
			local nextWave = player:hasNextWave()

			if nextWave then
				player:embattle(nextWave, nil, self._formationSystem, self._battleRecorder)
			end
		end
	end

	local function readyAndComplete()
		self._eventCenter:dispatchEvent("WaveReady")
		self:startTimer(kReadyPromptDuration, function()
			self:onMessage(battleLogic, {
				type = "COMPLETED"
			})

			if self._battleRecorder then
				self._battleRecorder:recordEvent(kBRMainLine, "NewWave", {})
			end
		end)
	end

	self:startTimer(self._duration, function()
		self._eventCenter:dispatchEvent("WaveEntered")

		local duration = 0

		if duration > 0 then
			self:startTimer(duration, readyAndComplete)
		else
			readyAndComplete()
		end
	end)
end

RegularLogicState_NextBout = class("RegularLogicState_NextBout", BattleState)

function RegularLogicState_NextBout:initialize(name, duration1, duration2)
	super.initialize(self, name)

	self._duration1 = duration1
	self._duration2 = duration2
end

function RegularLogicState_NextBout:setupContext(battleContext)
	self._battleRecorder = battleContext:getObject("BattleRecorder")
	self._battleStatist = battleContext:getObject("BattleStatist")
	self._formationSystem = battleContext:getObject("FormationSystem")
	self._timingSystem = battleContext:getObject("TimingSystem")
	self._eventCenter = battleContext:getObject("EventCenter")
	self._battleContext = battleContext

	return self
end

function RegularLogicState_NextBout:enter(battleLogic, battleContext, args)
	super.enter(self, battleLogic, battleContext)
	battleLogic:pauseTiming()
	battleLogic:pauseProcess()

	local boutResult = args.result

	assert(boutResult ~= nil and boutResult.result ~= nil)
	Bdump(boutResult)

	local result = boutResult.result
	local reason = boutResult.reason
	local teamA = battleLogic:getTeamA()
	local teamB = battleLogic:getTeamB()

	if self._battleRecorder then
		local var_37_0 = {}

		var_37_0.phase = battleLogic:getCurrentPhase() and battleLogic:getCurrentPhase().phase
		var_37_0.result = result
		var_37_0.reason = reason

		self._battleRecorder:recordEvent(kBRMainLine, "FinishBout", var_37_0)
	end

	if self._battleStatist then
		local playerA = teamA:getCurPlayer()
		local playerB = teamB:getCurPlayer()

		self._battleStatist:sendStatisticEvent("FinishBout", {
			time = battleLogic:getBoutTime(),
			endTime = self._battleContext:getCurrentTime(),
			result = result,
			roundCount = battleLogic:getRoundNumber(),
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
			},
			reason = reason
		})
	end

	if not teamA:hasNextBout(self._battleContext) then
		battleLogic:finish(kBattleSideBWin)
	end

	if not teamB:hasNextBout(self._battleContext) then
		battleLogic:finish(kBattleSideAWin)
	end

	local battleResult = battleLogic:getBattleResult()

	if battleResult then
		if self._battleRecorder then
			self._battleRecorder:recordEvent(kBRMainLine, "Finish", {
				result = battleResult,
				reason = reason
			})
		end

		if self._battleStatist then
			self._battleStatist:didFinishBattle(battleResult, battleLogic:getTotalTime())
		end

		return
	end

	battleLogic:recordBoutTime()
	battleLogic:getActionScheduler():reset(battleContext)
	teamA:clearStatus(self._battleContext)
	teamB:clearStatus(self._battleContext)
	battleLogic:resetTiming(0)

	if self._battleRecorder then
		self._battleRecorder:recordEvent(kBRMainLine, "NewPhase", {
			timelimit = 0,
			phase = BattlePhases.kPreNextBout,
			duration = battleLogic:getRemainTime(BattlePhases.kPhase1),
			time = self._timingSystem:getCumulativeTime()
		})
	end

	self:startTimer(self._duration1, function()
		teamA:clearStatus(self._battleContext)
		teamB:clearStatus(self._battleContext)
		self:nextBout(battleLogic, battleContext)
	end)
end

function RegularLogicState_NextBout:nextBout(battleLogic, battleContext)
	local trapSystem = battleContext:getObject("TrapSystem")

	trapSystem:cleanup()

	local boutIndex = battleLogic:nextBout()

	if self._battleRecorder then
		local var_39_0 = {
			bout = boutIndex
		}

		var_39_0.total = battleLogic:getTeamA():countPlayers() + battleLogic:getTeamB():countPlayers() - 1

		self._battleRecorder:recordEvent(kBRMainLine, "NextBout", var_39_0)
	end

	local allPlayers = battleLogic:getAllPlayers()
	local eventCenter = self._eventCenter
	local duration = 1000

	if duration > 0 then
		self:startTimer(duration, function()
			eventCenter:dispatchEvent("WaveEntering")
			self:embattle(battleLogic, allPlayers)
		end)
	else
		eventCenter:dispatchEvent("WaveEntering")
		self:embattle(battleLogic, allPlayers)
	end
end

function RegularLogicState_NextBout:exit(battleLogic, battleContext)
	battleLogic:startPhase()

	return super.exit(self, battleLogic, battleContext)
end

function RegularLogicState_NextBout:embattle(battleLogic, allPlayers)
	for _, player in ipairs(allPlayers) do
		if player:isEmbattleNeeded() then
			local nextWave = player:hasNextWave()

			if nextWave then
				player:embattle(nextWave, nil, self._formationSystem, self._battleRecorder)
			end
		end
	end

	local function readyAndComplete()
		self._eventCenter:dispatchEvent("WaveReady")
		self:startTimer(kReadyPromptDuration, function()
			self:onMessage(battleLogic, {
				type = "FINISHED"
			})

			if self._battleRecorder then
				self._battleRecorder:recordEvent(kBRMainLine, "NewBout", {})
			end
		end)
	end

	self:startTimer(self._duration2, function()
		self._eventCenter:dispatchEvent("WaveEntered")

		local duration = 0

		if duration > 0 then
			self:startTimer(duration, readyAndComplete)
		else
			readyAndComplete()
		end
	end)
end

RegularLogicState_BeforeNextBoutState = class("RegularLogicState_BeforeNextBoutState", BattleState)

function RegularLogicState_BeforeNextBoutState:enter(battleLogic, battleContext, args)
	super.enter(self, battleLogic, battleContext)

	self._battleRecorder = battleContext:getObject("BattleRecorder")

	local healthSystem = battleContext:getObject("HealthSystem")

	healthSystem:disableDamage()
	self:startTimer(10000, function()
		if self._battleRecorder then
			self._battleRecorder:recordEvent(kBRMainLine, "Error", {
				errorInfo = "waitLast4000",
				state = "BeforeNextBout"
			})
		end

		if DEBUG and DEBUG > 0 then
			assert(false, "本次战报可能有问题，如果无法继续，请保存并上传本次战报")
		else
			local var_47_0 = {
				type = "NEXT_BOUT"
			}
			local var_47_1 = {}

			var_47_1.result = battleContext:getObject("BattleReferee"):getResult()
			var_47_0.args = var_47_1

			self:onMessage(battleLogic, var_47_0)
		end
	end)
end

function RegularLogicState_BeforeNextBoutState:exit(battleLogic, battleContext)
	local healthSystem = battleContext:getObject("HealthSystem")

	healthSystem:enableDamage()

	return super.exit(self, battleLogic, battleContext)
end

RegularLogicState_Timedout = class("RegularLogicState_Timedout", BattleState)

function RegularLogicState_Timedout:enter(battleLogic, battleContext, args)
	super.enter(self, battleLogic, battleContext)

	local healthSystem = battleContext:getObject("HealthSystem")

	healthSystem:disableDamage()
	battleLogic:battleTimedout()
end

function RegularLogicState_Timedout:exit(battleLogic, battleContext)
	local healthSystem = battleContext:getObject("HealthSystem")

	healthSystem:enableDamage()

	return super.exit(self, battleLogic, battleContext)
end

RegularLogicState_DiligentRound = class("RegularLogicState_DiligentRound", BattleState)

function RegularLogicState_DiligentRound:initialize(name, duration1, duration2)
	super.initialize(self, name)

	self._duration1 = duration1
	self._duration2 = duration2
	self._diligentUnits = {}
end

function RegularLogicState_DiligentRound:setupContext(battleContext)
	self._battleField = battleContext:getObject("BattleField")
	self._actionScheduler = battleContext:getObject("ActionScheduler")
	self._skillSystem = battleContext:getObject("SkillSystem")
	self._battleContext = battleContext

	return self
end

function RegularLogicState_DiligentRound:enter(battleLogic, battleContext, args)
	super.enter(self, battleLogic, battleContext)
	battleLogic:pauseTiming()
	battleLogic:pauseProcess()
	self:_pauseAngerRecovery()

	local units = self._battleField:crossCollectDiligentUnits()

	self._actionScheduler:enterDiligentRoundWithActors(units)

	self._updateAction = true
	self._waiting = true
	self._lessThanLeastTime = true

	local allCrossUnits = self._battleField:crossCollectDiligentUnits()

	if next(allCrossUnits) then
		self:startTimer(args.duration or self._duration1, function()
			self._lessThanLeastTime = false

			self:finish(battleLogic)
		end)
	else
		self:finishImmediate(battleLogic)
	end
end

function RegularLogicState_DiligentRound:update(battleLogic, battleContext, dt)
	if self._updateAction then
		local actionScheduler = self._actionScheduler

		self._skillSystem:update(dt)

		if not actionScheduler:updateDiligentRound(dt, battleContext) then
			if actionScheduler:isDiligentRoundFinished() then
				Bdump("special round end 1", self._savedMessage)

				self._updateAction = false

				self:finish(battleLogic)
			else
				Bdump("special round end 2")

				self._updateAction = false

				self:finish(battleLogic)
			end
		end
	end

	return super.update(self, battleLogic, battleContext, dt)
end

function RegularLogicState_DiligentRound:finishImmediate(battleLogic)
	self._waiting = false

	self:onMessage(battleLogic, {
		type = "COMPLETED"
	})
end

function RegularLogicState_DiligentRound:finish(battleLogic)
	if not self._lessThanLeastTime and not self._updateAction then
		self._waiting = false

		if self._savedMessage then
			self:onMessage(battleLogic, self._savedMessage)
		else
			self:onMessage(battleLogic, {
				type = "COMPLETED"
			})
		end
	end
end

function RegularLogicState_DiligentRound:onMessage(battleLogic, message)
	if message.type == "DILIGENT_ROUND" then
		return
	end

	if self._waiting then
		self._savedMessage = message
	else
		if message.type == "BOUT_END" then
			local var_58_0 = {
				type = "NEXT_BOUT"
			}
			local var_58_1 = {}

			var_58_1.result = self._battleContext:getObject("BattleReferee"):getResult()
			var_58_0.args = var_58_1

			super.onMessage(self, battleLogic, var_58_0)
		else
			super.onMessage(self, battleLogic, message)
		end

		self._savedMessage = nil
	end
end

function RegularLogicState_DiligentRound:exit(battleLogic, battleContext)
	self:_resumeAngerRecovery()

	return super.exit(self, battleLogic, battleContext)
end

function RegularLogicState_DiligentRound:_pauseAngerRecovery()
	self._diligentUnits = self._battleField:crossCollectDiligentUnits()

	for k, unit in pairs(self._diligentUnits) do
		local angerComp = unit:getComponent("Anger")

		angerComp:pauseRecovery()
	end
end

function RegularLogicState_DiligentRound:_resumeAngerRecovery()
	for k, unit in pairs(self._diligentUnits) do
		local angerComp = unit:getComponent("Anger")

		if angerComp then
			angerComp:resumeRecovery()
		end
	end
end
