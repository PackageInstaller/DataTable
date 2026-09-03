-- chunkname: @/tmp/or_script/lua_compile/dm/battle/builder/sessions/PetRaceBattleSession.lua

PetRaceBattleSession = class("PetRaceBattleSession", BaseBattleSession)

function PetRaceBattleSession:initialize(serverData)
	super.initialize(self)

	self._playerData = serverData.playerData
	self._enemyData = serverData.enemyData
	self._maxTime = serverData.maxTime
	self._playerId = self._playerData[1].rid
	self._enemyId = self._enemyData[1].rid

	self:setRandomSeeds(serverData.logicSeed)
end

function PetRaceBattleSession:buildBattleData(playerData, enemyData, randomSeed)
	local playerId = playerData[1].rid
	local enemyId = enemyData[1].rid
	local battleData = {
		playerData = {},
		enemyData = {}
	}

	for i, _playerData in ipairs(playerData) do
		_playerData.rid = playerId .. "p" .. i
		battleData.playerData[i] = BattleDataHelper:getIntegralPlayerData(_playerData)
	end

	for i, _enemyData in ipairs(enemyData) do
		_enemyData.rid = enemyId .. "p" .. i
		battleData.enemyData[i] = BattleDataHelper:getIntegralPlayerData(_enemyData, true)
	end

	return battleData
end

function PetRaceBattleSession:genBattleConfigAndData(battleData, randomSeed, maxTime)
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
		waitTime = battleConfig and battleConfig.WaitModeLimit,
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

function PetRaceBattleSession:buildCoreBattleLogic()
	local battleData = self:buildBattleData(self._playerData, self._enemyData, self._logicSeed)
	local battleConfig = self:genBattleConfigAndData(battleData, self._logicSeed, self._maxTime)
	local battleLogic = self:createBattleLogic(battleConfig, battleData)

	self:_setBattleConfig(battleConfig)

	return battleLogic
end

function PetRaceBattleSession:buildAutoStrategy(playerRole, team, randomSeed)
	return nil
end

function PetRaceBattleSession:genTeamAiInfo()
	return nil
end

function PetRaceBattleSession:getBattleResultAndWinnerIds()
	local battleSimulator = self._battleSimulator
	local battleResult = battleSimulator and battleSimulator:getBattleResult()
	local result = battleResult or -1

	if result == 1 then
		if not self._playerId then
			local winner = self._enemyId

			return result, {
				winner
			}
		end
	end
end

function PetRaceBattleSession:generateDetailedResultSummary(err)
	local battleSimulator = self._battleSimulator

	if self._battleStatist then
		local statData = self._battleStatist:getSummary()
		local playerIds = self:getParticipantPlayerIds()
		local players = self:getParticipantPlayers()
		local result, winners = self:getBattleResultAndWinnerIds()

		local function getRemainHpInfo(players)
			local totalMax, totalRemain = 0, 0

			for _, player in ipairs(players) do
				local max, remain = player:getRemainHpInfo()

				totalMax = totalMax + max
				totalRemain = totalRemain + remain
			end

			return {
				total = totalMax,
				remain = totalRemain
			}
		end

		local var_8_0 = {
			logicSeed = self._logicSeed,
			result = result,
			winners = winners,
			statist = self._battleStatist
		}

		var_8_0.opData = battleSimulator:getInputManager():dumpInputHistory()
		var_8_0.timelines = self._battleRecorder and self._battleRecorder:dumpRecords()
		var_8_0.playersInfo = {
			challenger = {
				rid = self._playerId,
				playerId = playerIds[kBattleSideA]
			},
			defender = {
				rid = self._enemyId,
				playerId = playerIds[kBattleSideB]
			}
		}
		var_8_0.hpInfo = {
			challenger = getRemainHpInfo(players[kBattleSideA]),
			defender = getRemainHpInfo(players[kBattleSideB])
		}
		var_8_0.err = err

		return var_8_0
	end
end

function HeroStoryBattleSession:getBattlePassiveSkill()
	local playerStagePassShow = BattleDataHelper:getStagePassiveSkill(battleData.playerData)
	local enemyStagePassShow = BattleDataHelper:getStagePassiveSkill(battleData.enemyData)

	return {
		playerStagePassShow = playerStagePassShow,
		enemyStagePassShow = enemyStagePassShow
	}
end

function PetRaceBattleSession:getBattleType()
	return "petRace"
end
