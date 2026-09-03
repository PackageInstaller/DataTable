-- chunkname: @/tmp/or_script/lua_compile/dm/battle/builder/sessions/MazeTowerBattleSession.lua

MazeTowerBattleSession = class("MazeTowerBattleSession", BaseBattleSession)

function MazeTowerBattleSession:initialize(serverData)
	super.initialize(self)

	self._blockMapId = serverData.blockMapId
	self._blockPointId = serverData.blockPointId
	self._playerData = serverData.playerData
	self._enemyData = serverData.enemyData
	self._playerId = self._playerData.rid
	self._enemyId = self._enemyData.rid
	self._enemyBuff = serverData.enemyBuff

	self:setRandomSeeds(serverData.logicSeed, serverData.strategySeedA, serverData.strategySeedB)
end

function MazeTowerBattleSession:buildBattleData(playerData, enemyData, randomSeed)
	local randomizer = Random:new(randomSeed)
	local playerDrawCard = ConfigReader:getRecordById("ConfigValue", "Fight_PlayerDrawCard").content
	local pointConfig = ConfigReader:getRecordById("MazeBlockBattle", self._blockPointId)

	return BattleDataHelper:getIntegralBattleData({
		playerData = playerData,
		enemyData = enemyData
	})
end

function MazeTowerBattleSession:genBattleConfigAndData(battleData, randomSeed)
	if battleData == nil then
		return
	end

	local pointConfig = ConfigReader:getRecordById("MazeBlockBattle", self._blockPointId)
	local maxRound = ConfigReader:getRecordById("ConfigValue", "Fight_MaximumRound").content
	local battleConfig = self:_getBlockBattleConfig(pointConfig.BlockBattleConfig)

	if battleConfig then
		if not battleConfig.StageEnergy then
			local stageEnergy = self:_getBlockBattleConfig(ConfigReader:getRecordById("ConfigValue", "Fight_StageEnergy").content).StageEnergy
			local battlePhaseConfig = self:_genBattlePhaseConfig(stageEnergy, {
				waitMode = battleConfig and battleConfig.WaitMode,
				waitTime = battleConfig and battleConfig.WaitModeLimit,
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

function MazeTowerBattleSession:buildCoreBattleLogic()
	local battleData = self:buildBattleData(self._playerData, self._enemyData, self._logicSeed)
	local battleConfig = self:genBattleConfigAndData(battleData, self._logicSeed)
	local battleLogic = self:createBattleLogic(battleConfig, battleData)

	self:_setBattleConfig(battleConfig)

	self._rawBattleData = battleData

	return battleLogic
end

function MazeTowerBattleSession:_adjustPlayerData(data, extra)
	super._adjustPlayerData(self, data, extra)

	if data.waves then
		if data.waves then
			for idx, hero in pairs(data.waves) do
				local enemyCfg = ConfigReader:getRecordById("EnemyHero", hero.configId)

				if enemyCfg and enemyCfg.RageRules then
					hero.angerRules = enemyCfg.RageRules
				end
			end
		end
	end
end

function MazeTowerBattleSession:getBattleResultAndWinnerIds()
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

function MazeTowerBattleSession:generateDetailedResultSummary(err)
	local battleSimulator = self._battleSimulator

	if self._battleStatist then
		local statData = self._battleStatist:getSummary()
		local playerA = self:getParticipantPlayers()[kBattleSideA][1]
		local playerB = self:getParticipantPlayers()[kBattleSideB][1]
		local result, winners = self:getBattleResultAndWinnerIds()
		local var_7_0 = {
			logicSeed = self._logicSeed,
			strategySeedA = self._strategySeedA,
			strategySeedB = self._strategySeedB,
			result = result,
			winners = winners,
			statist = self._battleStatist,
			pointId = self._blockPointId,
			mapId = self._blockMapId
		}

		var_7_0.opData = battleSimulator:getInputManager():dumpInputHistory()
		var_7_0.timelines = self._battleRecorder and self._battleRecorder:dumpRecords()
		var_7_0.playersInfo = {
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
		var_7_0.passiveSkill = self:getBattlePassiveSkill()
		var_7_0.err = err

		return var_7_0
	end
end

function MazeTowerBattleSession:generateResultSummary()
	local battleSimulator = self._battleSimulator

	if self._battleStatist then
		local statData = self._battleStatist:getSummary()
		local result, winners = self:getBattleResultAndWinnerIds()
		local var_8_0 = {
			logicSeed = self._logicSeed,
			strategySeedA = self._strategySeedA,
			strategySeedB = self._strategySeedB,
			result = result,
			winners = winners,
			pointId = self._blockPointId,
			statist = self._battleStatist
		}

		var_8_0.opData = battleSimulator:getInputManager():dumpInputHistory()
		var_8_0.timelines = self._battleRecorder and self._battleRecorder:dumpRecords()
		var_8_0.passiveSkill = self:getBattlePassiveSkill()

		return var_8_0
	end
end

function MazeTowerBattleSession:getBattleType()
	return "mazeTower"
end

function MazeTowerBattleSession:getBattlePassiveSkill()
	local battleData = self:getPlayersData()
	local playerShow = BattleDataHelper:getTowerPassiveSkill(battleData.playerData)
	local pointConfig = ConfigReader:getRecordById("MazeBlockBattle", self._blockPointId)

	if not pointConfig.SpecialSkillShow then
		local enemyShow = {}

		for k, v in pairs(pointConfig.SpecialSkillShow) do
			enemyShow[#enemyShow + 1] = {
				lv = 1,
				id = v
			}
		end

		local playerStagePassShow = BattleDataHelper:getStagePassiveSkill(battleData.playerData)
		local enemyStagePassShow = BattleDataHelper:getStagePassiveSkill(battleData.enemyData)

		return {
			playerShow = playerShow,
			enemyShow = enemyShow,
			playerStagePassShow = playerStagePassShow,
			enemyStagePassShow = enemyStagePassShow
		}
	end
end
