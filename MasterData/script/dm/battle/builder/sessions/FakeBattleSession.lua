-- chunkname: @/tmp/or_script/lua_compile/dm/battle/builder/sessions/FakeBattleSession.lua

FakeBattleSession = class("FakeBattleSession", BaseBattleSession)

function FakeBattleSession:initialize(serverData)
	super.initialize(self)

	self._playerData = serverData.playerData
	self._enemyData = serverData.enemyData
	self._battleType = serverData.battleType

	self:setRandomSeeds(serverData.logicSeed)
end

function FakeBattleSession:buildBattleData(playerData, enemyData, randomSeed)
	local battleData = {
		playerData = {},
		enemyData = {}
	}

	battleData.playerData = BattleDataHelper:getIntegralPlayerData(playerData)
	battleData.enemyData = BattleDataHelper:getIntegralPlayerData(enemyData, true)

	return battleData
end

function FakeBattleSession:buildCoreBattleLogic()
	local battleData = self:buildBattleData(self._playerData, self._enemyData, self._logicSeed)
	local battleConfig = self:genBattleConfigAndData(battleData, self._logicSeed)
	local battleLogic = self:createBattleLogic(battleConfig, battleData)

	self:_setBattleConfig(battleConfig)

	self._rawBattleData = battleData

	return battleLogic
end

function FakeBattleSession:genBattleConfigAndData(battleData, randomSeed)
	if battleData == nil then
		return
	end

	local battleConfig = self:_getBlockBattleConfig("Normal")
	local maxRound = ConfigReader:getRecordById("ConfigValue", "Fight_MaximumRound").content
	local stageEnergy = self:_getBlockBattleConfig(ConfigReader:getRecordById("ConfigValue", "Fight_StageEnergy").content).StageEnergy
	local battlePhaseConfig = self:_genBattlePhaseConfig(stageEnergy, {
		waitMode = battleConfig and battleConfig.WaitMode,
		waitTime = battleConfig and battleConfig.WaitModeLimit,
		battleMode = battleConfig and battleConfig.BattleMode
	})

	return {
		battlePhaseConfig = battlePhaseConfig,
		randomSeed = randomSeed,
		maxRound = maxRound,
		victoryCfg = {
			{
				type = "TimeOut",
				winner = "SideB"
			}
		}
	}
end

function FakeBattleSession:buildAutoStrategy(playerRole, team, randomSeed)
	return nil
end

function FakeBattleSession:getBattleType()
	return self._battleType
end
