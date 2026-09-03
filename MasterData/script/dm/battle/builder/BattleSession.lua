-- chunkname: @/tmp/or_script/lua_compile/dm/battle/builder/BattleSession.lua

function CreateBattleSession(args)
	local SessionMap = {
		arena = ArenaBattleSession,
		tower = TowerBattleSession,
		explore = ExploreBattleSession,
		heroStory = HeroStoryBattleSession,
		maze = StageMazeBattleSession,
		mazeFinal = MazeFinalBossBattleSession,
		petRace = PetRaceBattleSession,
		rtpvp = RTPVPBattleSession,
		spStage = SpStageBattleSession,
		stage = StageBattleSession,
		practice = StagePracticeBattleSession,
		crusade = CrusadeBattleSession,
		actstage = ActstageBattleSession,
		clubboss = ClubBattleSession,
		dream = DreamBattleSession,
		house = HouseBattleSession,
		cooperateboss = CooperateBattleSession,
		orrtpk = RTPVPBattleSession,
		orrtpkrobot = RTPVPRobotBattleSession,
		stageArena = StageArenaBattleSession,
		chessArena = ArenaNewBattleSession,
		mazeTower = MazeTowerBattleSession
	}
	local sessionClass = SessionMap[args.battleType]

	if sessionClass then
		return (sessionClass:new(args))
	end
end

BattleSession = class("BattleSession")

function BattleSession:getBattleConfig()
	assert(false, "override me")
end

function BattleSession:getBattleSimulator()
	assert(false, "override me")
end

function BattleSession:getBattleRecordsProvider()
	assert(false, "override me")
end

function BattleSession:getParticipantPlayers()
	assert(false, "override me")
end

function BattleSession:getAIStrategyForPlayer(battlePlayer)
	assert(false, "override me")
end

function BattleSession:getResultSummary()
	assert(false, "override me")
end

BaseBattleSession = class("BaseBattleSession", BattleSession)

function BaseBattleSession:initialize()
	super.initialize(self)

	self._battleConfig = nil
	self._battleSimulator = nil
	self._recordsProvider = nil
	self._participantPlayers = nil
	self._battleRecorder = nil
	self._battleStatist = nil
	self._autoStrategies = nil
	self._resultSummary = nil
	self._enemyBuff = nil
end

function BaseBattleSession:setRandomSeeds(...)
	local args = {
		...
	}

	if #args == 1 then
		local randomseeds = args[1]

		if type(randomseeds) == "table" then
			self._logicSeed = randomseeds.logicSeed or randomseeds[1]
			self._strategySeedA = randomseeds.strategySeedA or randomseeds[2]
			self._strategySeedB = randomseeds.strategySeedB or randomseeds[3]
		else
			self._logicSeed = randomseeds
		end
	else
		self._logicSeed = args[1]
		self._strategySeedA = args[2]
		self._strategySeedB = args[3]
	end
end

function BaseBattleSession:getBattleConfig()
	return self._battleConfig
end

function BaseBattleSession:getBattlePassiveSkill()
	return {}
end

function BaseBattleSession:_setBattleConfig(battleConfig)
	self._battleConfig = battleConfig
end

function BaseBattleSession:createBattleLogic(battleConfig, battleData)
	local battleLogic = self:createBattleLogicWithConfig(battleConfig)

	if battleData.playerData.rid then
		local player1 = BattlePlayer:new(battleData.playerData.rid):initWithData(battleData.playerData)

		battleLogic:getTeamA():addPlayer(player1)
		battleLogic:registerPlayer(player1)
	else
		for i, playerData in ipairs(battleData.playerData) do
			local playerA = BattlePlayer:new(playerData.rid):initWithData(playerData)

			battleLogic:getTeamA():addPlayer(playerA)
			battleLogic:registerPlayer(playerA)
		end
	end

	if battleData.enemyData.rid then
		local player2 = BattlePlayer:new(battleData.enemyData.rid):initWithData(battleData.enemyData)

		battleLogic:getTeamB():addPlayer(player2)
		battleLogic:registerPlayer(player2)
	else
		for i, enemyData in ipairs(battleData.enemyData) do
			local playerB = BattlePlayer:new(enemyData.rid):initWithData(enemyData)

			battleLogic:getTeamB():addPlayer(playerB)
			battleLogic:registerPlayer(playerB)
		end
	end

	return battleLogic
end

function BaseBattleSession:createBattleLogicWithConfig(config)
	local battlePhaseConfig = config.battlePhaseConfig
	local randomSeed = config.randomSeed

	if not config.maxRound then
		local battleLogic = RegularBattleLogic:new()

		battleLogic:setBattleConfig(battlePhaseConfig)

		local random = Random:new(randomSeed)

		battleLogic:setRandomizer(random)
		battleLogic:setMaxRounds(config.maxRound)

		if config.victoryCfg then
			local judgeRules = self:buildResultJudgeRules(config.victoryCfg)

			battleLogic:setResultJudgeRules(judgeRules)
		end

		if config.groundCellCfg then
			battleLogic:setupGroundCell(config.groundCellCfg)
		end

		local skills = require("skills.all")

		battleLogic:setSkillDefinitions(skills.__all__)

		return battleLogic
	end
end

function BaseBattleSession:getBattleSimulator()
	return self._battleSimulator
end

function BaseBattleSession:getBattleRecordsProvider()
	return self._recordsProvider
end

function BaseBattleSession:getParticipantPlayers()
	return self._participantPlayers
end

function BaseBattleSession:getParticipantPlayerIds()
	return self._participantPlayerIds
end

function BaseBattleSession:getAIStrategyForPlayer(battlePlayer)
	if battlePlayer == nil or self._autoStrategies == nil then
		return nil
	end

	if type(battlePlayer) == "string" then
		return self._autoStrategies[battlePlayer]
	else
		return self._autoStrategies[battlePlayer:getId()]
	end
end

function BaseBattleSession:getResultSummary()
	if self._resultSummary == nil then
		local battleSimulator = self._battleSimulator

		if battleSimulator == nil then
			return nil, "NoSimulator"
		end

		local battleResult = battleSimulator:getBattleResult()

		if battleResult == nil then
			return nil, "NotFinished"
		end

		self._resultSummary = self:generateResultSummary()
	end

	return self._resultSummary
end

function BaseBattleSession:getExitSummary()
	return self:generateResultSummary()
end

function BaseBattleSession:getDetailedResultSummary(err)
	if self._detailedResultSummary == nil then
		local battleSimulator = self._battleSimulator

		if battleSimulator == nil then
			return nil, "NoSimulator"
		end

		local battleResult = battleSimulator:getBattleResult()

		if battleResult == nil then
			return nil, "NotFinished"
		end

		self._detailedResultSummary = self:generateDetailedResultSummary(err)
	end

	return self._detailedResultSummary
end

function BaseBattleSession:buildAll(configures)
	if configures then
		if not configures.forceRebuild then
			local forceRebuild = false

			if self._battleSimulator ~= nil and not forceRebuild then
				return
			end

			local battleSimulator = BattleSimulator:new()
			local battleLogic = self:buildCoreBattleLogic()

			battleSimulator:setBattleLogic(self:wrapBattleLogic(battleLogic))

			local battleRecorder = BattleRecorder:new()

			battleSimulator:setBattleRecorder(battleRecorder)

			self._recordsProvider = battleRecorder

			local battleStatist = self:buildBattleStatist(battleLogic)

			battleSimulator:setBattleStatist(battleStatist)

			local teamA = battleLogic:getTeamA()
			local teamB = battleLogic:getTeamB()
			local playerA = teamA:getPlayerByIndex(1)
			local playerB = teamB:getPlayerByIndex(1)
			local autoStrategies = {}

			if configures then
				if not configures.noAutoStrategies then
					local noAutoStrategies = false

					if not noAutoStrategies then
						local autoStrategyA, priorityA = self:buildAutoStrategy("TeamA", teamA, self._strategySeedA)

						if autoStrategyA then
							self._strategySeedA = self._strategySeedA or autoStrategyA:getRandomSeed()
							autoStrategies[playerA:getId()] = autoStrategyA

							battleSimulator:addAutoStrategy(autoStrategyA, priorityA)
						end

						local autoStrategyB, priorityB = self:buildAutoStrategy("TeamB", teamB, self._strategySeedB)

						if autoStrategyB then
							self._strategySeedB = self._strategySeedB or autoStrategyB:getRandomSeed()
							autoStrategies[playerB:getId()] = autoStrategyB

							battleSimulator:addAutoStrategy(autoStrategyB, priorityB)
						end
					end

					self._battleSimulator = battleSimulator
					self._battleRecorder = battleRecorder
					self._battleStatist = battleStatist
					self._autoStrategies = autoStrategies

					local teamAplayers = {}
					local teamAplayerIds = {}

					for i, playerA in battleLogic:getTeamA():players() do
						teamAplayers[i] = playerA
						teamAplayerIds[i] = playerA:getId()
					end

					local teamBplayers = {}
					local teamBplayerIds = {}

					for i, playerB in battleLogic:getTeamB():players() do
						teamBplayers[i] = playerB
						teamBplayerIds[i] = playerB:getId()
					end

					self._participantPlayers = {
						[kBattleSideA] = teamAplayers,
						[kBattleSideB] = teamBplayers
					}
					self._participantPlayerIds = {
						[kBattleSideA] = teamAplayerIds,
						[kBattleSideB] = teamBplayerIds
					}
				end
			end
		end
	end
end

function BaseBattleSession:getBattleResultAndWinnerIds()
	local battleSimulator = self._battleSimulator
	local battleResult = battleSimulator and battleSimulator:getBattleResult()

	if battleResult == nil then
		return nil
	end

	local result = battleResult

	if result == kBattleSideAWin then
		if not kBattleSideA then
			local winnerSide = kBattleSideB
			local winnerIds = {}

			for _, playerId in ipairs(self:getParticipantPlayerIds()[winnerSide]) do
				winnerIds[#winnerIds + 1] = playerId
			end

			return result, winnerIds
		end
	end
end

function BaseBattleSession:buildCoreBattleLogic()
	assert(false, "override me")
end

function BaseBattleSession:wrapBattleLogic(battleLogic)
	return battleLogic
end

function BaseBattleSession:buildAutoStrategy(playerRole, team, randomSeed)
	local strategy = WeightedStrategy:new(team, Random:new(randomSeed))

	if strategy.setDefaultInitWaitingCD then
		local defaultCD = ConfigReader:getRecordById("ConfigValue", "Fight_DefaultInitWaitingCD") and ConfigReader:getRecordById("ConfigValue", "Fight_DefaultInitWaitingCD").content or 500

		strategy:setDefaultInitWaitingCD(defaultCD)
	end

	return strategy
end

function BaseBattleSession:buildBattleStatist(battleLogic)
	return SimpleBattleStatist:new()
end

function BaseBattleSession:generateResultSummary()
	return {}
end

function BaseBattleSession:generateDetailedResultSummary(err)
	local summary = self:generateResultSummary()

	summary.err = err

	return summary
end

function BaseBattleSession:getPlayersData()
	return self._rawBattleData
end

function BaseBattleSession:genTeamAiInfo()
	local info = {
		{
			players = {},
			ais = {}
		},
		{
			players = {},
			ais = {}
		}
	}

	for _, player in ipairs(self:getParticipantPlayers()[kBattleSideA]) do
		info[1].players[#info[1].players + 1] = player:getId()

		local ai = self:getAIStrategyForPlayer(player)

		if ai then
			info[1].ais[#info[1].ais + 1] = ai
		end
	end

	for _, player in ipairs(self:getParticipantPlayers()[kBattleSideB]) do
		info[2].players[#info[2].players + 1] = player:getId()

		local ai = self:getAIStrategyForPlayer(player)

		if ai then
			info[2].ais[#info[2].ais + 1] = ai
		end
	end

	return info
end

function BaseBattleSession:setupAIController()
	local info = self:genTeamAiInfo()

	if info and self._autoStrategies and next(self._autoStrategies) ~= nil then
		local battleSimulator = self:getBattleSimulator()
		local inputManager = battleSimulator:getInputManager()

		for _, teamInfo in ipairs(info) do
			local ais = teamInfo.ais
			local playerController = LocalPlayerController:new(inputManager)

			playerController:bindPlayers(teamInfo.players)

			if ais then
				for _, ai in ipairs(ais) do
					ai:setController(playerController)
				end
			end
		end
	end
end

local function deepCopy(desc, src)
	local d = desc or {}

	for k, v in pairs(src) do
		d[k] = type(v) == "table" and deepCopy({}, v) or v
	end

	return d
end

local function shuffle(rand, arr, start, ending)
	local m = start or 1
	local n = ending or #arr

	for i = m, n - 1 do
		local k = rand:random(i, n)

		if k ~= i then
			arr[i], arr[k] = arr[k], arr[i]
		end
	end
end

function BaseBattleSession:buildResultJudgeRules(rules)
	if not rules then
		return
	end

	local factory = JudgeRuleFactory
	local ruleMap = {
		TimeOut = factory.timeIsUp,
		KeyUnitsDied = factory.keyUnitsDied,
		SingleSideDeathsReached = factory.singleSideDeathsReached,
		PlayerDeathsReached = factory.playerDeathsReached,
		PlayerRunOutOfEnergy = factory.playerRunOutOfEnergy,
		KeyUnitsEscaped = factory.unitsEscaped,
		KillNum = factory.unitOrSummonDiedReached
	}
	local ret = {}
	local rulesCopy = {}

	deepCopy(rulesCopy, rules)

	for i, rule in ipairs(rulesCopy) do
		local key = rule.type
		local args = rule.factor
		local result

		if rule.winner then
			result = {
				winner = rule.winner
			}
		elseif rule.loser then
			result = {
				loser = rule.loser
			}
		end

		if ruleMap[key] then
			ret[#ret + 1] = ruleMap[key](factory, args, result)
		end
	end

	return ret
end

function BaseBattleSession:_getEneryData(masterId, waveData)
	local prototypeFactory = PrototypeFactory:getInstance()
	local heros

	if waveData then
		heros = {}

		for i = 1, 9 do
			local heroId = waveData[tostring(i)] or waveData[i]

			if heroId then
				local eneryHeroPrototype = prototypeFactory:getEneryHeroPrototype(heroId)
				local hero = deepCopy({}, eneryHeroPrototype:getHeroData())

				BattleDataHelper:fillEnemyCostData(hero)

				heros[tostring(i)] = hero
				hero.transform = hero.transform and hero.transform ~= "" and self:_fillEnemyHeroData(hero.transform) or nil
			end
		end
	end

	local master
	local energy = {
		base = 0,
		capacity = ConfigReader:getRecordById("ConfigValue", "Fight_MaximumMasterEnergy").content
	}

	return {
		heros = heros,
		energy = energy,
		master = (masterId or nil) and self:_fillEnemyMasterData(masterId)
	}
end

function BaseBattleSession:_fillEnemyMasterData(masterId)
	local prototypeFactory = PrototypeFactory:getInstance()
	local eneryMasterPrototype = prototypeFactory:getEneryMasterPrototype(masterId)
	local result = deepCopy({}, eneryMasterPrototype:getMasterData())

	result.transform = result.transform and result.transform ~= "" and self:_fillEnemyMasterData(result.transform) or nil

	return result
end

function BaseBattleSession:_fillEnemyHeroData(heroId)
	if not heroId then
		return
	end

	if type(heroId) ~= "string" then
		return deepCopy({}, heroId)
	end

	local eneryHeroPrototype = PrototypeFactory:getInstance():getEneryHeroPrototype(heroId)
	local data = deepCopy({}, eneryHeroPrototype:getEneryData())

	data.hero.cost = data.cost
	data.hero.transform = data.hero.transform and data.hero.transform ~= "" and self:_fillEnemyHeroData(data.hero.transform) or nil

	return data.hero
end

function BaseBattleSession:_fillEnemyHeroCardData(heroId)
	if not heroId then
		return
	end

	if type(heroId) ~= "string" then
		local data = deepCopy({}, heroId)

		data.hero.cost = data.cost

		BattleDataHelper:fillEnemyCostData(data.hero)

		data.hero.transform = data.hero.transform and data.hero.transform ~= "" and self:_fillEnemyHeroData(data.hero.transform) or nil

		return data
	end

	local eneryHeroPrototype = PrototypeFactory:getInstance():getEneryHeroPrototype(heroId)
	local data = deepCopy({}, eneryHeroPrototype:getEneryData())

	data.hero.cost = data.cost
	data.hero.configId = heroId

	BattleDataHelper:fillEnemyCostData(data.hero)

	data.hero.transform = data.hero.transform and data.hero.transform ~= "" and self:_fillEnemyHeroData(data.hero.transform) or nil

	return data
end

function BaseBattleSession:_buildCardPool(playerData, randomizer, cardRuleId, playerCards, extraCards)
	if cardRuleId then
		::label_41_0::

		local rule = ConfigReader:getRecordById("EnemyCard", cardRuleId)

		if rule and rule.CardCollection then
			local collection = {}

			for i, cardId in ipairs(rule.CardCollection) do
				if cardId == "playerLibrary" then
					if playerCards then
						for _, card in ipairs(playerCards) do
							collection[#collection + 1] = card
						end
					end
				elseif cardId == "extraLibrary" then
					if extraCards then
						for _, card in ipairs(extraCards) do
							collection[#collection + 1] = card
						end
					end
				else
					collection[#collection + 1] = cardId
				end
			end

			local library = {}
			local maxIndex = 0

			for indexStr, dict in pairs(rule.CardLibrary) do
				local index = tonumber(indexStr)

				maxIndex = index < maxIndex and maxIndex or index

				local cards = {}

				library[index] = {
					cards = cards,
					ratio = tonumber(dict[3])
				}

				local dest = tonumber(dict[2]) or #collection

				for i = tonumber(dict[1]), dest do
					cards[#cards + 1] = collection[i]
				end
			end

			local formation = rule.FirstFormation

			if formation then
				local heros = {}

				for i = 1, 9 do
					if i ~= 8 then
						local posInfo = formation[tostring(i)]

						if posInfo then
							if posInfo[1] == "fixed" then
								heros[tostring(i)] = self:_fillEnemyHeroCardData(posInfo[2]).hero
							else
								local sublibrary = library[tonumber(posInfo[2])]

								if sublibrary then
									::label_41_1::

									local var_41_0 = sublibrary.cards

									if sublibrary.cards then
										local count = #sublibrary.cards

										if count and count > 0 then
											local index = randomizer:random(1, count)

											heros[tostring(i)] = self:_fillEnemyHeroCardData(sublibrary.cards[index]).hero
											heros[tostring(i)].ratio = sublibrary.ratio

											table.remove(sublibrary.cards, index)
										end
									end
								end
							end
						end
					end
				end

				if next(heros) ~= nil then
					playerData.heros = heros
				end
			end

			local drawCard = rule.DrawCard

			if drawCard then
				local cards = {}
				local tmpMaxIndex = 0
				local drawRules = {}
				local tmpDict = {}

				for indexStr, info in pairs(drawCard) do
					local index = tonumber(indexStr)

					tmpMaxIndex = index < tmpMaxIndex and tmpMaxIndex or index
					tmpDict[index] = info
				end

				local tmpInfo

				for i = tmpMaxIndex, 1, -1 do
					tmpInfo = tmpDict[i] or tmpInfo
					drawRules[i] = tmpInfo
				end

				for i = 1, tmpMaxIndex do
					local drawRule = drawRules[i]

					if drawRule then
						local sublibrary = library[tonumber(drawRule[2])]

						if sublibrary then
							::label_41_2::

							local var_41_1 = sublibrary.cards

							if sublibrary.cards then
								local count = #sublibrary.cards

								if count and count > 0 then
									local index = randomizer:random(1, count)
									local card = self:_fillEnemyHeroCardData(sublibrary.cards[index])

									card.hero.ratio = sublibrary.ratio
									cards[#cards + 1] = card

									table.remove(sublibrary.cards, index)
								end
							end
						end
					end
				end

				playerData.cards = cards
			end
		elseif playerData.cards then
			for _, card in ipairs(playerData.cards) do
				card.hero.cost = card.cost
			end

			if GameConfigs and GameConfigs.NoAiSetBox == true then
				return
			end

			shuffle(randomizer, playerData.cards)
		end

		if GameConfigs and GameConfigs.NoAiSetBox == true then
			local noOrderCard = {}

			for k, v in pairs(playerCards or playerData.cards) do
				for k_, v_ in pairs(playerData.cards) do
					if v.id == v_.id then
						noOrderCard[#noOrderCard + 1] = v_

						break
					end
				end
			end

			playerData.cards = noOrderCard
		end
	end
end

function BaseBattleSession:_getBlockBattleConfig(configId)
	if configId then
		::label_42_0::

		local result = ConfigReader:getRecordById("BlockBattle", configId)

		if result == nil then
			result = ConfigReader:getRecordById("BlockBattle", ConfigReader:getRecordById("ConfigValue", "Fight_StageEnergy").content)
		end

		return result
	end
end

function BaseBattleSession:_adjustValue(value, config)
	if not config then
		return value or 0
	end

	local v = value

	if config.pattern == "COVER" then
		v = config.value
	elseif config.pattern == "ADD" then
		v = (v or 0) + config.value
	end

	return v or 0
end

function BaseBattleSession:_adjustPlayerData(data, extra)
	if not extra then
		return
	end

	if extra.masterRageBase then
		if data.waves then
			do
				local master = data.waves[1].master

				if master then
					master.anger = self:_adjustValue(master.anger, extra.masterRageBase)
				end
			end

			if extra.heroRageBase then
				if data.waves then
					do
						local heros = data.waves[1].heros

						if heros then
							for idx, hero in pairs(heros) do
								hero.anger = self:_adjustValue(hero.anger, extra.heroRageBase)
							end
						end

						if data.cards then
							for idx, card in ipairs(data.cards) do
								card.hero.anger = self:_adjustValue(card.hero.anger, extra.heroRageBase)
							end
						end
					end

					if extra.masterRageRules then
						if data.waves then
							do
								local master = data.waves[1].master

								if master then
									master.angerRules = extra.masterRageRules
								end
							end

							if extra.heroRageRules then
								if data.waves then
									do
										local heros = data.waves[1].heros

										if heros then
											for idx, hero in pairs(heros) do
												hero.angerRules = extra.heroRageRules
											end
										end

										if data.cards then
											for idx, card in ipairs(data.cards) do
												card.hero.angerRules = extra.heroRageRules
											end
										end
									end

									if extra.extrapasv and extra.extrapasv ~= "" then
										if data.waves then
											for _, waveData in ipairs(data.waves) do
												local master = waveData.master

												if master then
													BattleDataHelper:addExtraPasvSkill(master, {
														level = 1,
														skillId = extra.extrapasv
													})
												end

												local heros = waveData.heros

												if heros then
													for idx, hero in pairs(heros) do
														BattleDataHelper:addExtraPasvSkill(hero, {
															level = 1,
															skillId = extra.extrapasv
														})
													end
												end
											end
										end

										if data.cards then
											for idx, card in ipairs(data.cards) do
												BattleDataHelper:addExtraPasvSkill(card.hero, {
													level = 1,
													skillId = extra.extrapasv
												})
											end
										end
									end

									if extra.masterFBReduction and extra.masterFBReduction ~= "" and data.waves then
										for _, waveData in ipairs(data.waves) do
											local master = waveData.master

											if master then
												BattleDataHelper:addExtraPasvSkill(master, {
													level = 1,
													skillId = extra.masterFBReduction
												})
											end
										end
									end

									if extra.masterpasvs and next(extra.masterpasvs) ~= nil then
										for _, masterpasv in ipairs(extra.masterpasvs) do
											if data.waves then
												for _, waveData in ipairs(data.waves) do
													local master = waveData.master

													if master then
														BattleDataHelper:addExtraPasvSkill(master, {
															level = 1,
															skillId = masterpasv
														}, extra.masterpasvsParam)
													end
												end
											end
										end
									end

									if extra.combatAdjust and extra.combatAdjust ~= "" and data.waves then
										for _, waveData in ipairs(data.waves) do
											local master = waveData.master

											if master then
												BattleDataHelper:addExtraPasvSkill(master, {
													level = 1,
													skillId = extra.combatAdjust
												}, self._enemyBuff)
											end
										end
									end

									if extra.energy then
										data.energy = data.energy or {}
										data.energy.base = self:_adjustValue(data.energy.base, extra.energy.base)
										data.energy.capacity = extra.energy.capacity or data.energy.capacity
										data.energy.scale = extra.energy.scale or data.energy.scale
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

function BaseBattleSession:_genBattlePhaseConfig(stageEnergyCfg, args)
	local battlePhaseConfigs = {
		phases = {},
		battleMode = args.battleMode,
		waitMode = args.waitMode,
		waitTime = args.waitTime
	}
	local durationKeys = {
		"phase1Duration",
		"phase2Duration",
		"phase3Duration"
	}
	local energyKeys = {
		"phase1EnergySpeed",
		"phase2EnergySpeed",
		"phase3EnergySpeed"
	}

	for idx, phaseEnergy in ipairs(stageEnergyCfg) do
		local battlePhaseConfig = {
			phase1EnergySpeed = 0,
			phase3Duration = 0,
			phase1Duration = 0,
			phase2Duration = 0,
			phase3EnergySpeed = 0,
			phase2EnergySpeed = 0
		}

		battlePhaseConfigs.phases[idx] = battlePhaseConfig

		for index, energyInfo in ipairs(phaseEnergy) do
			if durationKeys[index] then
				battlePhaseConfig[durationKeys[index]] = energyInfo.duration
				battlePhaseConfig[energyKeys[index]] = {
					energyInfo.EnergySpeed,
					energyInfo.EnemyEnergySpeed
				}
			end
		end
	end

	return battlePhaseConfigs
end

function BaseBattleSession:_applyBattleConfig(battleData, battleConfig)
	local playerExtra = {
		masterRageBase = battleConfig.MasterRageBase,
		heroRageBase = battleConfig.HeroRageBase,
		masterRageRules = battleConfig.MasterRageRules,
		heroRageRules = battleConfig.HeroRageRules,
		energy = {
			base = battleConfig.EnergyBase,
			capacity = battleConfig.Fight_StageEnergyMax[2],
			scale = battleConfig.EnergyScale
		},
		masterFBReduction = battleConfig.FriendFBReduction,
		masterpasvs = battleConfig.FriendSpecialPassive,
		masterpasvsParam = battleConfig.FriendSpecialPassiveParm,
		combatAdjust = battleConfig.CombatAdjust
	}

	if battleData.playerData.rid then
		self:_adjustPlayerData(battleData.playerData, playerExtra)
	else
		for i, playerData in ipairs(battleData.playerData) do
			self:_adjustPlayerData(playerData, playerExtra)
		end
	end

	local enemyExtra = {
		energy = {
			base = battleConfig.EnemyEnergyBase,
			capacity = battleConfig.Fight_StageEnergyMax[1],
			scale = battleConfig.EnemyEnergyScale
		},
		masterFBReduction = battleConfig.EnemyFBReduction,
		masterpasvs = battleConfig.EnemySpecialPassive,
		masterpasvsParam = battleConfig.EnemySpecialPassiveParm
	}

	if battleData.enemyData.rid then
		self:_adjustPlayerData(battleData.enemyData, enemyExtra)
	else
		for i, enemyData in ipairs(battleData.enemyData) do
			self:_adjustPlayerData(enemyData, enemyExtra)
		end
	end
end

function BaseBattleSession:_genGroundCellCfg(cellCfg)
	local cells = {}

	if cellCfg and type(cellCfg) == "table" then
		for k, v in pairs(cellCfg) do
			table.insert(cells, v)
		end
	end

	return {
		blockCells = cells
	}
end
