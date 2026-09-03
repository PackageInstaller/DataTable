-- chunkname: @/tmp/or_script/lua_compile/dm/battle/builder/sessions/StageBattleSession.lua

StageBattleSession = class("StageBattleSession", BaseBattleSession)

function StageBattleSession:initialize(serverData)
	super.initialize(self)

	self._pointId = serverData.pointId
	self._playerData = serverData.playerData
	self._playerId = self._playerData.rid
	self._enemyId = self._pointId
	self._enemyBuff = serverData.enemyBuff

	self:setRandomSeeds(serverData.logicSeed, serverData.strategySeedA, serverData.strategySeedB)
end

function StageBattleSession:buildBattleData(pointId, playerData, randomSeed)
	local pointConfig = ConfigReader:getRecordById("BlockPoint", pointId)
	local enemyData = self:_getEneryData(pointConfig.EnemyMaster)
	local randomizer = Random:new(randomSeed)
	local playerCards = playerData.cards

	self:_buildCardPool(enemyData, randomizer, pointConfig.EnemyCard, playerCards)

	if pointConfig.PlayerCard ~= "" then
		if not pointConfig.PlayerCard then
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
	end
end

function StageBattleSession:genBattleConfigAndData(battleData, pointId, randomSeed)
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

function StageBattleSession:buildCoreBattleLogic()
	local battleData = self:buildBattleData(self._pointId, self._playerData, self._logicSeed)
	local battleConfig = self:genBattleConfigAndData(battleData, self._pointId, self._logicSeed)
	local battleLogic = self:createBattleLogic(battleConfig, battleData)

	self:_setBattleConfig(battleConfig)

	self._rawBattleData = battleData

	return battleLogic
end

function StageBattleSession:generateResultSummary()
	local battleSimulator = self._battleSimulator

	if self._battleStatist then
		local statData = self._battleStatist:getSummary()
		local result, winners = self:getBattleResultAndWinnerIds()
		local var_5_0 = {
			logicSeed = self._logicSeed,
			strategySeedA = self._strategySeedA,
			strategySeedB = self._strategySeedB,
			result = result,
			winners = winners,
			statist = self._battleStatist
		}

		var_5_0.opData = battleSimulator:getInputManager():dumpInputHistory()

		return var_5_0
	end
end

function StageBattleSession:generateDetailedResultSummary(err)
	local battleSimulator = self._battleSimulator

	if self._battleStatist then
		local statData = self._battleStatist:getSummary()
		local playerIds = self:getParticipantPlayerIds()
		local result, winners = self:getBattleResultAndWinnerIds()

		if self._battleRecorder then
			local battleRecords = self._battleRecorder:dumpRecords()
			local var_6_1 = {
				logicSeed = self._logicSeed,
				strategySeedA = self._strategySeedA,
				strategySeedB = self._strategySeedB,
				result = result,
				winners = winners,
				statist = self._battleStatist
			}

			var_6_1.opData = battleSimulator:getInputManager():dumpInputHistory()
			var_6_1.timelines = self._battleRecorder and self._battleRecorder:dumpRecords()
			var_6_1.playersInfo = {
				challenger = {
					rid = self._playerId,
					playerId = playerIds[kBattleSideA]
				},
				defender = {
					rid = self._enemyId,
					playerId = playerIds[kBattleSideB]
				}
			}
			var_6_1.err = err

			return var_6_1
		end
	end
end

function StageBattleSession:getBattleType()
	return "stage"
end

function StageBattleSession:getBattlePassiveSkill()
	local pointConfig = ConfigReader:getRecordById("BlockPoint", self._pointId)

	if not pointConfig.SpecialSkillShow then
		local battleData = self:getPlayersData()
		local playerShow = BattleDataHelper:getPassiveSkill(battleData.playerData)
		local enemyShow = {}

		for k, v in pairs(pointConfig.SpecialSkillShow) do
			enemyShow[#enemyShow + 1] = {
				lv = 1,
				id = v
			}
		end

		local playerStagePassShow = BattleDataHelper:getStagePassiveSkill(battleData.playerData)

		return {
			playerShow = playerShow,
			enemyShow = enemyShow,
			playerStagePassShow = playerStagePassShow,
			enemyStagePassShow = enemyStagePassShow
		}
	end
end
