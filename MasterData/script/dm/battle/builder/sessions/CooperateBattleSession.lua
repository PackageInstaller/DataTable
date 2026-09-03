-- chunkname: @/tmp/or_script/lua_compile/dm/battle/builder/sessions/CooperateBattleSession.lua

CooperateBattleSession = class("CooperateBattleSession", BaseBattleSession)

function CooperateBattleSession:initialize(serverData, seasonInfo)
	super.initialize(self)

	self._pointId = serverData.pointId
	self._mapId = serverData.mapId
	self._playerData = serverData.playerData
	self._enemyData = serverData.enemyData
	self._herosEffect = serverData.herosEffect or {}
	self._enemyId = self._pointId
	self._playerId = self._playerData.rid
	self._seasonInfo = seasonInfo

	self:setRandomSeeds(serverData.logicSeed, serverData.strategySeedA, serverData.strategySeedB)
end

function CooperateBattleSession:buildBattleData(mapId, pointId, playerData, enemyData, randomSeed)
	self:fillHeroAttrEffect(playerData)
	self:modifyEnemyMasterModel(enemyData)

	local randomizer = Random:new(randomSeed)

	self:_buildCardPool(playerData, randomizer)

	return BattleDataHelper:getIntegralBattleData({
		playerData = playerData,
		enemyData = enemyData
	})
end

function CooperateBattleSession:genBattleConfigAndData(battleData, mapId, pointId, randomSeed)
	if battleData == nil then
		return
	end

	local pointConfig = ConfigReader:getRecordById("CooperateBossBattle", mapId)
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

function CooperateBattleSession:buildCoreBattleLogic()
	local battleData = self:buildBattleData(self._mapId, self._pointId, self._playerData, self._enemyData, self._logicSeed)
	local battleConfig = self:genBattleConfigAndData(battleData, self._mapId, self._pointId, self._logicSeed)
	local battleLogic = self:createBattleLogic(battleConfig, battleData)

	self:_setBattleConfig(battleConfig)

	self._rawBattleData = battleData

	return battleLogic
end

function CooperateBattleSession:generateResultSummary()
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

function CooperateBattleSession:generateDetailedResultSummary(err)
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

function CooperateBattleSession:getBattleType()
	return "cooperateboss"
end

function CooperateBattleSession:getBattlePassiveSkill()
	local battleData = self:getPlayersData()
	local playerStagePassShow = BattleDataHelper:getStagePassiveSkill(battleData.playerData)
	local enemyStagePassShow = BattleDataHelper:getStagePassiveSkill(battleData.enemyData)

	return {
		playerShow = {},
		enemyShow = {},
		playerStagePassShow = playerStagePassShow,
		enemyStagePassShow = enemyStagePassShow
	}
end

function CooperateBattleSession:modifyEnemyMasterModel(enemyData)
	if enemyData and enemyData.master then
		enemyData.master.modelScale = 1.4
	end
end

function CooperateBattleSession:fillHeroAttrEffect(playerData)
	local function isInTable(search, table)
		for k, v in pairs(table) do
			if search == v then
				return true
			end
		end

		return false
	end

	local function caclulateAttrNum(effects)
		local addNum = 0

		for k, v in pairs(effects) do
			if v.attrType == "HURTRATE" and isInTable(v.target, {
				"SELF",
				"ALL",
				"HERO"
			}) and v.effectEvn == "ALL" then
				addNum = addNum + v.attrNum
			end
		end

		return addNum
	end

	local function getIsRecommend(heroId)
		if self._seasonInfo then
			for k, v in pairs(self._seasonInfo.ExcellentHero) do
				if v.Hero then
					for index, id in pairs(v.Hero) do
						if id == heroId then
							return true
						end
					end
				end
			end
		end

		return false
	end

	local level = 1

	for heroId, info in pairs(self._herosEffect) do
		local addNum = 0

		for k, effectId in pairs(info) do
			local effect = BattleSkillAttrEffect:createEffect(effectId, level)

			addNum = addNum + caclulateAttrNum(effect)
		end

		for k, v in pairs(playerData.cards) do
			if v.hero.configId == heroId then
				v.hero.addHurtRate = Strings:get("LOGIN_UI13")
			end
		end
	end

	for k, v in pairs(playerData.cards) do
		if getIsRecommend(v.hero.configId) then
			v.hero.addHurtRate = Strings:get("clubBoss_46")
		end
	end
end
