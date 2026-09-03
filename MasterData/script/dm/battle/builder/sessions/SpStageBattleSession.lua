-- chunkname: @/tmp/or_script/lua_compile/dm/battle/builder/sessions/SpStageBattleSession.lua

SpStageBattleSession = class("SpStageBattleSession", StageBattleSession)

function SpStageBattleSession:buildBattleData(pointId, playerData, randomSeed)
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

function SpStageBattleSession:genBattleConfigAndData(battleData, pointId, randomSeed)
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

function SpStageBattleSession:getBattleType()
	return "spStage"
end

function SpStageBattleSession:getBattlePassiveSkill()
	local pointConfig = ConfigReader:getRecordById("BlockSpPoint", self._pointId)

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
