-- chunkname: @/tmp/or_script/lua_compile/dm/battle/builder/sessions/ExploreBattleSession.lua

ExploreBattleSession = class("ExploreBattleSession", StageBattleSession)

function ExploreBattleSession:initialize(serverData)
	super.initialize(self, serverData)

	self._enemyData = serverData.enemyData
	self._enemyId = self._enemyData.rid
end

function ExploreBattleSession:buildBattleData(pointId, playerData, enemyData, randomSeed)
	local pointConfig = ConfigReader:getRecordById("MapBattlePoint", pointId)
	local randomizer = Random:new(randomSeed)
	local playerCards = playerData.cards

	self:_buildCardPool(enemyData, randomizer, pointConfig.EnemyCard, playerCards)

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

function ExploreBattleSession:genBattleConfigAndData(battleData, pointId, randomSeed)
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

function ExploreBattleSession:buildCoreBattleLogic()
	local battleData = self:buildBattleData(self._pointId, self._playerData, self._enemyData, self._logicSeed)
	local battleConfig = self:genBattleConfigAndData(battleData, self._pointId, self._logicSeed)
	local battleLogic = self:createBattleLogic(battleConfig, battleData)

	self:_setBattleConfig(battleConfig)

	self._rawBattleData = battleData

	return battleLogic
end

function ExploreBattleSession:getBattleResultAndWinnerIds()
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

function ExploreBattleSession:generateDetailedResultSummary(err)
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
		var_6_0.err = err

		return var_6_0
	end
end

function ExploreBattleSession:getBattleType()
	return "explore"
end

function ExploreBattleSession:getBattlePassiveSkill()
	local pointConfig = ConfigReader:getRecordById("MapBattlePoint", self._pointId)

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
		local enemyStagePassShow = BattleDataHelper:getStagePassiveSkill(battleData.enemyData)

		return {
			playerShow = playerShow,
			enemyShow = enemyShow,
			playerStagePassShow = playerStagePassShow,
			enemyStagePassShow = enemyStagePassShow
		}
	end
end
