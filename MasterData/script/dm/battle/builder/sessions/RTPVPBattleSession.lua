-- chunkname: @/tmp/or_script/lua_compile/dm/battle/builder/sessions/RTPVPBattleSession.lua

RTPVPBattleSession = class("RTPVPBattleSession", BaseBattleSession)

function RTPVPBattleSession:initialize(serverData)
	super.initialize(self)

	self._playerAData = serverData.playerData
	self._playerBData = serverData.enemyData
	self._playerAData.tacticsNeedWait = true
	self._playerBData.tacticsNeedWait = true
	self._seasonId = serverData.seasonId
	self._battleType = serverData.battleType

	self:setRandomSeeds(serverData.logicSeed)
end

function RTPVPBattleSession:buildBattleData(playerAData, playerBData, randomSeed)
	local randomizer = Random:new(randomSeed)
	local playerDrawCard = ConfigReader:getRecordById("ConfigValue", "Fight_PlayerDrawCard").content

	self:_buildCardPool(playerAData, randomizer, playerDrawCard, playerAData.cards)
	self:_buildCardPool(playerBData, randomizer, playerDrawCard, playerBData.cards)

	return BattleDataHelper:getIntegralBattleData({
		playerData = playerAData,
		enemyData = playerBData
	})
end

function RTPVPBattleSession:genBattleConfigAndData(battleData, randomSeed)
	if battleData == nil then
		return
	end

	local maxRound = ConfigReader:getRecordById("ConfigValue", "Fight_MaximumRound").content
	local battleId = ConfigReader:getRecordById("ConfigValue", "Fight_Friend").content

	if self._battleType == "orrtpk" then
		local ruleId = ConfigReader:getDataByNameIdAndKey("RTPKSeason", self._seasonId, "SeasonRule")

		battleId = ConfigReader:getDataByNameIdAndKey("RTPKRule", ruleId, "BattleConfig")
	end

	local battleConfig = self:_getBlockBattleConfig(battleId)

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

function RTPVPBattleSession:buildAutoStrategy(playerRole, team, randomSeed)
	return nil
end

function RTPVPBattleSession:genTeamAiInfo()
	return nil
end

function RTPVPBattleSession:buildCoreBattleLogic()
	local battleData = self:buildBattleData(self._playerAData, self._playerBData, self._logicSeed)
	local battleConfig = self:genBattleConfigAndData(battleData, self._logicSeed)
	local battleLogic = self:createBattleLogic(battleConfig, battleData)

	self:_setBattleConfig(battleConfig)

	self._rawBattleData = battleData

	return battleLogic
end

function RTPVPBattleSession:generateResultSummary()
	local battleSimulator = self._battleSimulator

	if self._battleStatist then
		local statData = self._battleStatist:getSummary()
		local result, winners = self:getBattleResultAndWinnerIds()
		local var_7_0 = {
			logicSeed = self._logicSeed,
			result = result,
			winners = winners,
			statist = self._battleStatist
		}

		var_7_0.opData = battleSimulator:getInputManager():dumpInputHistory()

		return var_7_0
	end
end

function RTPVPBattleSession:_applyBattleConfig(battleData, battleConfig)
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
		masterRageBase = battleConfig.MasterRageBase,
		heroRageBase = battleConfig.HeroRageBase,
		masterRageRules = battleConfig.MasterRageRules,
		heroRageRules = battleConfig.HeroRageRules,
		energy = {
			base = battleConfig.EnemyEnergyBase,
			capacity = battleConfig.Fight_StageEnergyMax[1],
			scale = battleConfig.EnemyEnergyScale
		},
		masterFBReduction = battleConfig.EnemyFBReduction,
		masterpasvs = battleConfig.EnemySpecialPassive,
		masterpasvsParam = battleConfig.EnemySpecialPassiveParm,
		combatAdjust = battleConfig.CombatAdjust
	}

	if battleData.enemyData.rid then
		self:_adjustPlayerData(battleData.enemyData, enemyExtra)
	else
		for i, enemyData in ipairs(battleData.enemyData) do
			self:_adjustPlayerData(enemyData, enemyExtra)
		end
	end
end

function RTPVPBattleSession:getBattleType()
	return "rtpvp"
end

function RTPVPBattleSession:getBattlePassiveSkill(battleData, mainPlayerId)
	local playerShow = {}
	local enemyShow = {}
	local playerStagePassShow = {}
	local enemyStagePassShow = {}

	if battleData.playerData and battleData.playerData.rid == mainPlayerId then
		playerShow = BattleDataHelper:getPassiveSkill(battleData.playerData)
		enemyShow = BattleDataHelper:getPassiveSkill(battleData.enemyData)
		playerStagePassShow = BattleDataHelper:getStagePassiveSkill(battleData.playerData)
		enemyStagePassShow = BattleDataHelper:getStagePassiveSkill(battleData.enemyData)
	else
		enemyShow = BattleDataHelper:getPassiveSkill(battleData.playerData)
		playerShow = BattleDataHelper:getPassiveSkill(battleData.enemyData)
		playerStagePassShow = BattleDataHelper:getStagePassiveSkill(battleData.enemyData)
		enemyStagePassShow = BattleDataHelper:getStagePassiveSkill(battleData.playerData)
	end

	return {
		playerShow = playerShow,
		enemyShow = enemyShow,
		playerStagePassShow = playerStagePassShow,
		enemyStagePassShow = enemyStagePassShow
	}
end
