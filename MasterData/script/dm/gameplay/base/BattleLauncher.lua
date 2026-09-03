-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/base/BattleLauncher.lua

BattleErrorCode = {
	kTimeout = 1
}
BattleLauncher = BattleLauncher or {}

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

function BattleLauncher:buildResultJudgeRules(rules)
	if not rules then
		return
	end

	local factory = JudgeRuleFactory
	local ruleMap = {
		TimeOut = factory.timeIsUp,
		KeyUnitsDied = factory.keyUnitsDied,
		SingleSideDeathsReached = factory.singleSideDeathsReached,
		PlayerDeathsReached = factory.playerDeathsReached,
		PlayerRunOutOfEnergy = factory.playerRunOutOfEnergy
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

function BattleLauncher:_getEneryData(masterId, waveData)
	local prototypeFactory = PrototypeFactory:getInstance()
	local heros

	if waveData then
		heros = {}

		for i = 1, 9 do
			local heroId = waveData[tostring(i)] or waveData[i]

			if heroId then
				local eneryHeroPrototype = prototypeFactory:getEneryHeroPrototype(heroId)
				local hero = deepCopy({}, eneryHeroPrototype:getHeroData())

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

function BattleLauncher:createSimulatorWithConfig(config, battleData)
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

		local battleRecorder = BattleRecorder:new()
		local battleStatist = SimpleBattleStatist:new()
		local battleSimulator = BattleSimulator:new()

		battleSimulator:setBattleRecorder(battleRecorder)
		battleSimulator:setBattleStatist(battleStatist)
		battleSimulator:setBattleLogic(battleLogic)

		local skills = require("skills.all")

		battleLogic:setSkillDefinitions(skills.__all__)

		return battleSimulator
	end
end

function BattleLauncher:_fillEnemyMasterData(masterId)
	local prototypeFactory = PrototypeFactory:getInstance()
	local eneryMasterPrototype = prototypeFactory:getEneryMasterPrototype(masterId)
	local result = deepCopy({}, eneryMasterPrototype:getMasterData())

	result.transform = result.transform and result.transform ~= "" and self:_fillEnemyMasterData(result.transform) or nil

	return result
end

function BattleLauncher:_fillEnemyHeroData(heroId)
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

function BattleLauncher:_fillEnemyHeroCardData(heroId)
	if not heroId then
		return
	end

	if type(heroId) ~= "string" then
		local data = deepCopy({}, heroId)

		data.hero.cost = data.cost
		data.hero.transform = data.hero.transform and data.hero.transform ~= "" and self:_fillEnemyHeroData(data.hero.transform) or nil

		return data
	end

	local eneryHeroPrototype = PrototypeFactory:getInstance():getEneryHeroPrototype(heroId)
	local data = deepCopy({}, eneryHeroPrototype:getEneryData())

	data.hero.cost = data.cost
	data.hero.transform = data.hero.transform and data.hero.transform ~= "" and self:_fillEnemyHeroData(data.hero.transform) or nil

	return data
end

function BattleLauncher:_buildCardPool(playerData, randomizer, cardRuleId, playerCards, extraCards)
	if cardRuleId then
		::label_9_0::

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
									::label_9_1::

									local var_9_0 = sublibrary.cards

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
							::label_9_2::

							local var_9_1 = sublibrary.cards

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

			shuffle(randomizer, playerData.cards)
		end
	end
end

function BattleLauncher:_getBlockBattleConfig(configId)
	if configId then
		::label_10_0::

		local result = ConfigReader:getRecordById("BlockBattle", configId)

		if result == nil then
			result = ConfigReader:getRecordById("BlockBattle", ConfigReader:getRecordById("ConfigValue", "Fight_StageEnergy").content)
		end

		return result
	end
end

function BattleLauncher:_adjustValue(value, config)
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

function BattleLauncher:_adjustPlayerData(data, extra)
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

									if extra.masterpasv and extra.masterpasv ~= "" and data.waves then
										for _, waveData in ipairs(data.waves) do
											local master = waveData.master

											if master then
												BattleDataHelper:addExtraPasvSkill(master, {
													level = 1,
													skillId = extra.masterpasv
												})
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

function BattleLauncher:_genBattlePhaseConfig(stageEnergyCfg, args)
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

function BattleLauncher:_applyBattleConfig(battleData, battleConfig)
	local playerExtra = {
		masterRageBase = battleConfig.MasterRageBase,
		heroRageBase = battleConfig.HeroRageBase,
		masterRageRules = battleConfig.MasterRageRules,
		heroRageRules = battleConfig.HeroRageRules,
		energy = {
			base = battleConfig.EnergyBase,
			capacity = battleConfig.Fight_StageEnergyMax[1],
			scale = battleConfig.EnergyScale
		},
		masterpasv = battleConfig.FriendFBReduction
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
			capacity = battleConfig.Fight_StageEnergyMax[2],
			scale = battleConfig.EnemyEnergyScale
		},
		masterpasv = battleConfig.EnemyFBReduction
	}

	if battleData.enemyData.rid then
		self:_adjustPlayerData(battleData.enemyData, enemyExtra)
	else
		for i, enemyData in ipairs(battleData.enemyData) do
			self:_adjustPlayerData(enemyData, enemyExtra)
		end
	end
end

StageBattleLauncher = StageBattleLauncher or setmetatable({}, {
	__index = BattleLauncher
})

function StageBattleLauncher:genBattleConfigAndData(battleData, pointId, randomSeed)
	if battleData == nil then
		return
	end

	local pointConfig = ConfigReader:getRecordById("BlockPoint", pointId)
	local battleConfig = self:_getBlockBattleConfig(pointConfig.BlockBattleConfig)
	local maxRound = ConfigReader:getRecordById("ConfigValue", "Fight_MaximumRound").content

	if battleConfig then
		if not battleConfig.StageEnergy then
			local stageEnergy = self:_getBlockBattleConfig(ConfigReader:getRecordById("ConfigValue", "Fight_StageEnergy").content).StageEnergy
			local battlePhaseConfig = self:_genBattlePhaseConfig(stageEnergy, {
				waitMode = battleConfig and battleConfig.WaitMode,
				battleMode = battleConfig and battleConfig.BattleMode
			})

			self:_applyBattleConfig(battleData, battleConfig)

			local victoryConditions = pointConfig.VictoryConditions

			return {
				battlePhaseConfig = battlePhaseConfig,
				randomSeed = randomSeed,
				maxRound = maxRound,
				victoryCfg = victoryConditions
			}
		end
	end
end

function StageBattleLauncher:buildBattleData(pointId, playerData, randomSeed)
	local pointConfig = ConfigReader:getRecordById("BlockPoint", pointId)
	local enemyData = self:_getEneryData(pointConfig.EnemyMaster)
	local randomizer = Random:new(randomSeed)
	local playerCards = playerData.cards

	self:_buildCardPool(enemyData, randomizer, pointConfig.EnemyCard, playerCards)

	local playerDrawCard = ConfigReader:getRecordById("ConfigValue", "Fight_PlayerDrawCard").content

	self:_buildCardPool(playerData, randomizer, playerDrawCard, playerCards)

	enemyData.rid = pointId
	enemyData.headImg = pointConfig.BossHeadPic
	enemyData.initiative = pointConfig.Speed

	if pointConfig.Assist then
		enemyData.assist = {}

		for i, heroId in ipairs(pointConfig.Assist) do
			enemyData.assist[i] = self:_fillEnemyHeroCardData(heroId).hero
		end
	end

	return BattleDataHelper:getIntegralBattleData({
		playerData = playerData,
		enemyData = enemyData
	})
end

HeroStoryBattleLauncher = HeroStoryBattleLauncher or setmetatable({}, {
	__index = BattleLauncher
})

function HeroStoryBattleLauncher:genBattleConfigAndData(battleData, pointId, randomSeed)
	if battleData == nil then
		return
	end

	local pointConfig = ConfigReader:getRecordById("HeroStoryPoint", pointId)
	local battleConfig = self:_getBlockBattleConfig(pointConfig.BlockBattleConfig)
	local maxRound = ConfigReader:getRecordById("ConfigValue", "Fight_MaximumRound").content

	if battleConfig then
		if not battleConfig.StageEnergy then
			local stageEnergy = self:_getBlockBattleConfig(ConfigReader:getRecordById("ConfigValue", "Fight_StageEnergy").content).StageEnergy
			local battlePhaseConfig = self:_genBattlePhaseConfig(stageEnergy, {
				waitMode = battleConfig and battleConfig.WaitMode,
				battleMode = battleConfig and battleConfig.BattleMode
			})

			self:_applyBattleConfig(battleData, battleConfig)

			local victoryConditions = pointConfig.VictoryConditions

			return {
				battlePhaseConfig = battlePhaseConfig,
				randomSeed = randomSeed,
				maxRound = maxRound,
				victoryCfg = victoryConditions
			}
		end
	end
end

function HeroStoryBattleLauncher:buildBattleData(pointId, playerData, randomSeed)
	local pointConfig = ConfigReader:getRecordById("HeroStoryPoint", pointId)
	local enemyData = self:_getEneryData(pointConfig.EnemyMaster)
	local randomizer = Random:new(randomSeed)
	local playerCards = playerData.cards

	self:_buildCardPool(enemyData, randomizer, pointConfig.EnemyCard, playerCards)

	local playerDrawCard = ConfigReader:getRecordById("ConfigValue", "Fight_PlayerDrawCard").content

	self:_buildCardPool(playerData, randomizer, playerDrawCard, playerCards)

	enemyData.rid = pointId
	enemyData.headImg = pointConfig.BossHeadPic
	enemyData.initiative = pointConfig.Speed

	return BattleDataHelper:getIntegralBattleData({
		playerData = playerData,
		enemyData = enemyData
	})
end

ArenaBattleLauncher = ArenaBattleLauncher or setmetatable({}, {
	__index = BattleLauncher
})

function ArenaBattleLauncher:genBattleConfigAndData(battleData, randomSeed)
	if battleData == nil then
		return
	end

	local maxRound = ConfigReader:getRecordById("ConfigValue", "Fight_MaximumRound").content
	local battleConfig = self:_getBlockBattleConfig(ConfigReader:getRecordById("ConfigValue", "Fight_Arena").content)

	if battleConfig then
		if not battleConfig.StageEnergy then
			local stageEnergy = self:_getBlockBattleConfig(ConfigReader:getRecordById("ConfigValue", "Fight_StageEnergy").content).StageEnergy
			local battlePhaseConfig = self:_genBattlePhaseConfig(stageEnergy, {
				waitMode = battleConfig and battleConfig.WaitMode,
				battleMode = battleConfig and battleConfig.BattleMode
			})

			self:_applyBattleConfig(battleData, battleConfig)

			return {
				battlePhaseConfig = battlePhaseConfig,
				randomSeed = randomSeed,
				maxRound = maxRound,
				victoryCfg = victoryConditions
			}
		end
	end
end

function ArenaBattleLauncher:buildBattleData(playerData, enemyData, randomSeed)
	local randomizer = Random:new(randomSeed)
	local playerDrawCard = ConfigReader:getRecordById("ConfigValue", "Fight_PlayerDrawCard").content

	return BattleDataHelper:getIntegralBattleData({
		playerData = playerData,
		enemyData = enemyData
	})
end

PetraceBattleLauncher = PetraceBattleLauncher or setmetatable({}, {
	__index = BattleLauncher
})

function PetraceBattleLauncher:genBattleConfigAndData(battleData, randomSeed, maxTime)
	if battleData == nil then
		return
	end

	local maxRound = ConfigReader:getRecordById("ConfigValue", "Fight_MaximumRound").content
	local battleConfig = self:_getBlockBattleConfig(ConfigReader:getRecordById("ConfigValue", "Fight_KOF").content)
	local Fight_Time = maxTime * 1000
	local stageEnergy = {
		{
			{
				EnemyEnergySpeed = 0,
				EnergySpeed = 0,
				duration = Fight_Time
			}
		}
	}
	local battlePhaseConfig = self:_genBattlePhaseConfig(stageEnergy, {
		waitMode = battleConfig and battleConfig.WaitMode,
		battleMode = battleConfig and battleConfig.BattleMode
	})

	self:_applyBattleConfig(battleData, battleConfig)

	return {
		battlePhaseConfig = battlePhaseConfig,
		randomSeed = randomSeed,
		maxRound = maxRound,
		victoryCfg = victoryConditions
	}
end

function PetraceBattleLauncher:buildBattleData(serverData)
	local playerId = serverData.playerData[1].rid
	local enemyId = serverData.enemyData[1].rid
	local battleData = {
		playerData = {},
		enemyData = {}
	}

	for i, playerData in ipairs(serverData.playerData) do
		playerData.rid = playerId .. "p" .. i
		battleData.playerData[i] = BattleDataHelper:getIntegralPlayerData(playerData)
	end

	for i, enemyData in ipairs(serverData.enemyData) do
		enemyData.rid = enemyId .. "p" .. i
		battleData.enemyData[i] = BattleDataHelper:getIntegralPlayerData(enemyData, true)
	end

	return battleData
end

SpStageBattleLauncher = SpStageBattleLauncher or setmetatable({}, {
	__index = BattleLauncher
})

function SpStageBattleLauncher:genBattleConfigAndData(battleData, pointId, randomSeed)
	if battleData == nil then
		return
	end

	local pointConfig = ConfigReader:getRecordById("BlockSpPoint", pointId)
	local battleConfig = self:_getBlockBattleConfig(pointConfig.BlockBattleConfig)
	local maxRound = ConfigReader:getRecordById("ConfigValue", "Fight_MaximumRound").content

	if battleConfig then
		if not battleConfig.StageEnergy then
			local stageEnergy = self:_getBlockBattleConfig(ConfigReader:getRecordById("ConfigValue", "Fight_StageEnergy").content).StageEnergy
			local battlePhaseConfig = self:_genBattlePhaseConfig(stageEnergy, {
				waitMode = battleConfig and battleConfig.WaitMode,
				battleMode = battleConfig and battleConfig.BattleMode
			})

			self:_applyBattleConfig(battleData, battleConfig)

			local victoryConditions = pointConfig.VictoryConditions

			return {
				battlePhaseConfig = battlePhaseConfig,
				randomSeed = randomSeed,
				maxRound = maxRound,
				victoryCfg = victoryConditions
			}
		end
	end
end

function SpStageBattleLauncher:buildBattleData(pointId, playerData, randomSeed)
	local randomizer = Random:new(randomSeed)
	local playerCards = playerData.cards
	local playerDrawCard = ConfigReader:getRecordById("ConfigValue", "Fight_PlayerDrawCard").content

	self:_buildCardPool(playerData, randomizer, playerDrawCard, playerCards)

	local battleData = {
		playerData = BattleDataHelper:getIntegralPlayerData(playerData)
	}
	local pointConfig = ConfigReader:getRecordById("BlockSpPoint", pointId)
	local enemyWaves = pointConfig.EnemyWaves

	if enemyWaves and type(enemyWaves) == "table" then
		battleData.enemyData = {}

		for playerIdx, enemyWaveData in ipairs(enemyWaves) do
			local enemyData = {
				rid = pointId .. "p" .. playerIdx,
				waveData = {}
			}

			for index, waveData in ipairs(enemyWaveData) do
				local data = self:_getEneryData(waveData.master, waveData)

				enemyData.energy = data.energy
				enemyData.waveData[index] = {
					master = data.master,
					heros = data.heros
				}
			end

			battleData.enemyData[playerIdx] = BattleDataHelper:getIntegralPlayerData(enemyData, true)
		end
	else
		local enemyData = self:_getEneryData(pointConfig.EnemyMaster)

		self:_buildCardPool(enemyData, randomizer, pointConfig.EnemyCard, playerCards)

		enemyData.rid = pointId
		enemyData.headImg = pointConfig.BossHeadPic
		enemyData.initiative = pointConfig.Speed
		battleData.enemyData = BattleDataHelper:getIntegralPlayerData(enemyData, true)
	end

	return battleData
end

StagePracticeBattleLauncher = StagePracticeBattleLauncher or setmetatable({}, {
	__index = BattleLauncher
})

function StagePracticeBattleLauncher:genBattleConfigAndData(battleData, pointId, randomSeed)
	if battleData == nil then
		return
	end

	local pointConfig = ConfigReader:getRecordById("StagePracticePoint", pointId)
	local battleConfig = self:_getBlockBattleConfig(pointConfig.BlockBattleConfig)
	local maxRound = ConfigReader:getRecordById("ConfigValue", "Fight_MaximumRound").content

	if battleConfig then
		if not battleConfig.StageEnergy then
			local stageEnergy = self:_getBlockBattleConfig(ConfigReader:getRecordById("ConfigValue", "Fight_StageEnergy").content).StageEnergy
			local battlePhaseConfig = self:_genBattlePhaseConfig(stageEnergy, {
				waitMode = battleConfig and battleConfig.WaitMode,
				battleMode = battleConfig and battleConfig.BattleMode
			})

			if pointConfig.Stop == 1 then
				battlePhaseConfig.waitCommand = true
			end

			self:_applyBattleConfig(battleData, battleConfig)

			local victoryConditions = pointConfig.VictoryConditions

			return {
				battlePhaseConfig = battlePhaseConfig,
				randomSeed = randomSeed,
				maxRound = maxRound,
				victoryCfg = victoryConditions
			}
		end
	end
end

function StagePracticeBattleLauncher:buildBattleData(pointId, playerData, randomSeed)
	local pointConfig = ConfigReader:getRecordById("StagePracticePoint", pointId)
	local enemyData = self:_getEneryData(pointConfig.EnemyMaster)
	local randomizer = Random:new(randomSeed)
	local playerCards = playerData.cards

	self:_buildCardPool(enemyData, randomizer, pointConfig.EnemyHero, playerCards)

	local playerDrawCard = pointConfig.SelfCard

	self:_buildCardPool(playerData, randomizer, playerDrawCard, playerCards)

	enemyData.rid = pointId
	enemyData.headImg = pointConfig.BossHeadPic
	enemyData.initiative = pointConfig.Speed

	return BattleDataHelper:getIntegralBattleData({
		playerData = playerData,
		enemyData = enemyData
	})
end

ExploreBattleLauncher = ExploreBattleLauncher or setmetatable({}, {
	__index = BattleLauncher
})

function ExploreBattleLauncher:genBattleConfigAndData(battleData, pointId, randomSeed)
	if battleData == nil then
		return
	end

	local pointConfig = ConfigReader:getRecordById("MapBattlePoint", pointId)
	local battleConfig = self:_getBlockBattleConfig(pointConfig.BlockBattleConfig)
	local maxRound = ConfigReader:getRecordById("ConfigValue", "Fight_MaximumRound").content

	if battleConfig then
		if not battleConfig.StageEnergy then
			local stageEnergy = self:_getBlockBattleConfig(ConfigReader:getRecordById("ConfigValue", "Fight_StageEnergy").content).StageEnergy
			local battlePhaseConfig = self:_genBattlePhaseConfig(stageEnergy, {
				waitMode = battleConfig and battleConfig.WaitMode,
				battleMode = battleConfig and battleConfig.BattleMode
			})

			self:_applyBattleConfig(battleData, battleConfig)

			local victoryConditions = pointConfig.VictoryConditions

			return {
				battlePhaseConfig = battlePhaseConfig,
				randomSeed = randomSeed,
				maxRound = maxRound,
				victoryCfg = victoryConditions
			}
		end
	end
end

function ExploreBattleLauncher:selectEnemyByLevel(enemyHerolist, playerlevel, collection)
	for _, dict in ipairs(enemyHerolist) do
		for level, heroCards in pairs(dict) do
			if playerlevel <= tonumber(level) then
				collection = collection or {}

				for _, card in ipairs(heroCards) do
					collection[#collection + 1] = card
				end

				return collection
			end
		end
	end
end

function ExploreBattleLauncher:buildBattleData(pointId, playerData, enemyData, randomSeed)
	local pointConfig = ConfigReader:getRecordById("MapBattlePoint", pointId)
	local randomizer = Random:new(randomSeed)
	local playerCards = playerData.cards

	if pointConfig.PlayerCard ~= "" then
		if not pointConfig.PlayerCard then
			local playerDrawCard = ConfigReader:getRecordById("ConfigValue", "Fight_PlayerDrawCard").content

			self:_buildCardPool(playerData, randomizer, playerDrawCard, playerCards)

			if playerData.extraCards then
				local count = #playerData.extraCards

				for idx, card in ipairs(playerData.cards) do
					playerData.extraCards[count + idx] = card
				end

				playerData.cards = playerData.extraCards
				playerData.extraCards = nil
			end

			return BattleDataHelper:getIntegralBattleData({
				playerData = playerData,
				enemyData = enemyData
			})
		end
	end
end

StageMazeBattleLauncher = StageMazeBattleLauncher or setmetatable({}, {
	__index = BattleLauncher
})

function StageMazeBattleLauncher:genBattleConfigAndData(battleData, pointId, randomSeed)
	if battleData == nil then
		return
	end

	local maxRound = ConfigReader:getRecordById("ConfigValue", "Fight_MaximumRound").content
	local pointConfig = ConfigReader:getRecordById("PansLabFightPoint", pointId)
	local battleConfig = self:_getBlockBattleConfig(pointConfig.BlockBattleConfig)

	if battleConfig then
		if not battleConfig.StageEnergy then
			local stageEnergy = self:_getBlockBattleConfig(ConfigReader:getRecordById("ConfigValue", "Fight_StageEnergy").content).StageEnergy
			local battlePhaseConfig = self:_genBattlePhaseConfig(stageEnergy, {
				waitMode = battleConfig and battleConfig.WaitMode,
				battleMode = battleConfig and battleConfig.BattleMode
			})

			self:_applyBattleConfig(battleData, battleConfig)

			local victoryConditions = pointConfig.VictoryConditions

			return {
				battlePhaseConfig = battlePhaseConfig,
				randomSeed = randomSeed,
				maxRound = maxRound,
				victoryCfg = victoryConditions
			}
		end
	end
end

function StageMazeBattleLauncher:buildBattleData(playerData, enemyData, randomSeed)
	local randomizer = Random:new(randomSeed)
	local playerDrawCard = ConfigReader:getRecordById("ConfigValue", "Fight_PlayerDrawCard").content

	self:_buildCardPool(playerData, randomizer, playerDrawCard, playerData.cards)

	return BattleDataHelper:getIntegralBattleData({
		playerData = playerData,
		enemyData = enemyData
	})
end

MazeFinalBossBattleLauncher = MazeFinalBossBattleLauncher or setmetatable({}, {
	__index = BattleLauncher
})

function MazeFinalBossBattleLauncher:genBattleConfigAndData(battleData, pointId, randomSeed)
	if battleData == nil then
		return
	end

	local pointConfig = ConfigReader:getRecordById("PansLabFightPoint", pointId)
	local battleConfig = self:_getBlockBattleConfig(pointConfig.BlockBattleConfig)
	local maxRound = ConfigReader:getRecordById("ConfigValue", "Fight_MaximumRound").content

	if battleConfig then
		if not battleConfig.StageEnergy then
			local stageEnergy = self:_getBlockBattleConfig(ConfigReader:getRecordById("ConfigValue", "Fight_StageEnergy").content).StageEnergy
			local battlePhaseConfig = self:_genBattlePhaseConfig(stageEnergy, {
				waitMode = battleConfig and battleConfig.WaitMode,
				battleMode = battleConfig and battleConfig.BattleMode
			})

			if battleConfig then
				self:_applyBattleConfig(battleData, battleConfig)
			end

			local victoryConditions = pointConfig.VictoryConditions

			return {
				battlePhaseConfig = battlePhaseConfig,
				randomSeed = randomSeed,
				maxRound = maxRound,
				victoryCfg = victoryConditions
			}
		end
	end
end

function MazeFinalBossBattleLauncher:buildBattleData(playerData, enemyData, randomSeed)
	local randomizer = Random:new(randomSeed)
	local playerDrawCard = ConfigReader:getRecordById("ConfigValue", "Fight_PlayerDrawCard").content

	self:_buildCardPool(playerData, randomizer, playerDrawCard, playerData.cards)

	return BattleDataHelper:getIntegralBattleData({
		playerData = playerData,
		enemyData = enemyData
	})
end
