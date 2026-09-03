-- chunkname: @/tmp/or_script/lua_compile/dm/battle/builder/sessions/ArenaBattleSession.lua

ArenaBattleSession = class("ArenaBattleSession", BaseBattleSession)

function ArenaBattleSession:initialize(serverData)
	super.initialize(self)

	self._playerData = serverData.playerData
	self._enemyData = serverData.enemyData
	self._playerId = self._playerData.rid
	self._enemyId = self._enemyData.rid

	self:setRandomSeeds(serverData.logicSeed, serverData.strategySeedA, serverData.strategySeedB)
end

function ArenaBattleSession:buildBattleData(playerData, enemyData, randomSeed)
	local randomizer = Random:new(randomSeed)
	local playerDrawCard = ConfigReader:getRecordById("ConfigValue", "Fight_PlayerDrawCard").content

	return BattleDataHelper:getIntegralBattleData({
		playerData = playerData,
		enemyData = enemyData
	})
end

function ArenaBattleSession:genBattleConfigAndData(battleData, randomSeed)
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
	end
end

function ArenaBattleSession:buildCoreBattleLogic()
	local battleData = self:buildBattleData(self._playerData, self._enemyData, self._logicSeed)
	local battleConfig = self:genBattleConfigAndData(battleData, self._logicSeed)
	local battleLogic = self:createBattleLogic(battleConfig, battleData)

	self:_setBattleConfig(battleConfig)

	self._rawBattleData = battleData

	return battleLogic
end

function ArenaBattleSession:getBattleResultAndWinnerIds()
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

function ArenaBattleSession:generateDetailedResultSummary(err)
	local battleSimulator = self._battleSimulator

	if self._battleStatist then
		local statData = self._battleStatist:getSummary()
		local playerA = self:getParticipantPlayers()[kBattleSideA][1]
		local playerB = self:getParticipantPlayers()[kBattleSideB][1]
		local result, winners = self:getBattleResultAndWinnerIds()
		local var_6_0 = {
			logicSeed = self._logicSeed,
			strategySeedA = self._strategySeedA,
			strategySeedB = self._strategySeedB,
			result = result,
			winners = winners,
			statist = self._battleStatist
		}

		var_6_0.opData = battleSimulator:getInputManager():dumpInputHistory()
		var_6_0.timelines = self._battleRecorder and self._battleRecorder:dumpRecords()
		var_6_0.playersInfo = {
			challenger = {
				rid = self._playerId,
				playerId = {
					playerA:getId()
				}
			},
			defender = {
				rid = self._enemyId,
				playerId = {
					playerB:getId()
				}
			}
		}
		var_6_0.passiveSkill = self:getBattlePassiveSkill()
		var_6_0.err = err

		return var_6_0
	end
end

function ArenaBattleSession:generateResultSummary()
	local battleSimulator = self._battleSimulator

	if self._battleStatist then
		local statData = self._battleStatist:getSummary()
		local result, winners = self:getBattleResultAndWinnerIds()
		local var_7_0 = {
			logicSeed = self._logicSeed,
			strategySeedA = self._strategySeedA,
			strategySeedB = self._strategySeedB,
			result = result,
			winners = winners,
			statist = self._battleStatist
		}

		var_7_0.opData = battleSimulator:getInputManager():dumpInputHistory()
		var_7_0.timelines = self._battleRecorder and self._battleRecorder:dumpRecords()
		var_7_0.passiveSkill = self:getBattlePassiveSkill()

		return var_7_0
	end
end

function ArenaBattleSession:buildAutoStrategy(playerRole, team, randomSeed)
	local strategy = SequenceStrategy:new(team, Random:new(randomSeed))

	if strategy.setDefaultInitWaitingCD then
		local defaultCD = ConfigReader:getRecordById("ConfigValue", "Fight_DefaultInitWaitingCD") and ConfigReader:getRecordById("ConfigValue", "Fight_DefaultInitWaitingCD").content or 500

		strategy:setDefaultInitWaitingCD(defaultCD)
	end

	return strategy
end

function ArenaBattleSession:getBattleType()
	return "arena"
end

function ArenaBattleSession:getBattlePassiveSkill()
	local battleData = self:getPlayersData()
	local playerShow = BattleDataHelper:getPassiveSkill(battleData.playerData)
	local enemyShow = BattleDataHelper:getPassiveSkill(battleData.enemyData)
	local playerStagePassShow = BattleDataHelper:getStagePassiveSkill(battleData.playerData)
	local enemyStagePassShow = BattleDataHelper:getStagePassiveSkill(battleData.enemyData)

	return {
		playerShow = playerShow,
		enemyShow = enemyShow,
		playerStagePassShow = playerStagePassShow,
		enemyStagePassShow = enemyStagePassShow
	}
end
