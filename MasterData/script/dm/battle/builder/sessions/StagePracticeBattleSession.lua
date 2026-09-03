-- chunkname: @/tmp/or_script/lua_compile/dm/battle/builder/sessions/StagePracticeBattleSession.lua

StagePracticeBattleSession = class("StagePracticeBattleSession", StageBattleSession)

function StagePracticeBattleSession:buildBattleData(pointId, playerData, randomSeed)
	local pointConfig = ConfigReader:getRecordById("StagePracticePoint", pointId)

	pointConfig = pointConfig or ConfigReader:getRecordById("BlockPracticePoint", pointId)

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

function StagePracticeBattleSession:genBattleConfigAndData(battleData, pointId, randomSeed)
	if battleData == nil then
		return
	end

	local pointConfig = ConfigReader:getRecordById("StagePracticePoint", pointId)

	pointConfig = pointConfig or ConfigReader:getRecordById("BlockPracticePoint", pointId)

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

function StagePracticeBattleSession:getBattleType()
	return "practice"
end

function StagePracticeBattleSession:getBattlePassiveSkill()
	local pointConfig = ConfigReader:getRecordById("StagePracticePoint", self._pointId)

	pointConfig = pointConfig or ConfigReader:getRecordById("BlockPracticePoint", self._pointId)

	if not pointConfig.SpecialSkillShow then
		local specialSkillShow = {}
		local battleData = self:getPlayersData()
		local playerShow = BattleDataHelper:getPassiveSkill(battleData.playerData)
		local enemyShow = {}

		for k, v in pairs(specialSkillShow) do
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
