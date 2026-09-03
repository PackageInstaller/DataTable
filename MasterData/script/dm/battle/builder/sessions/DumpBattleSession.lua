-- chunkname: @/tmp/or_script/lua_compile/dm/battle/builder/sessions/DumpBattleSession.lua

DumpBattleSession = class("DumpBattleSession", BaseBattleSession)

function DumpBattleSession:initialize(serverData)
	super.initialize(self)

	self._rawBattleData = serverData.battleData
	self._battleConfig = serverData.battleConfig
	self._battleType = serverData.battleType

	self:setRandomSeeds(serverData.logicSeed, serverData.strategySeedA, serverData.strategySeedB)
end

function DumpBattleSession:buildCoreBattleLogic()
	local battleData = self._rawBattleData
	local battleConfig = self._battleConfig

	return (self:createBattleLogic(battleConfig, battleData))
end

function DumpBattleSession:buildAutoStrategy(playerRole, team, randomSeed)
	return nil
end

function DumpBattleSession:generateResultSummary()
	local battleSimulator = self._battleSimulator

	if self._battleStatist then
		local statData = self._battleStatist:getSummary()
		local result, winners = self:getBattleResultAndWinnerIds()
		local var_4_0 = {
			logicSeed = self._logicSeed,
			result = result,
			winners = winners,
			statist = self._battleStatist
		}

		var_4_0.opData = battleSimulator:getInputManager():dumpInputHistory()

		return var_4_0
	end
end

function DumpBattleSession:generateDetailedResultSummary(err)
	local battleSimulator = self._battleSimulator

	if self._battleStatist then
		local statData = self._battleStatist:getSummary()
		local playerIds = self:getParticipantPlayerIds()
		local result, winners = self:getBattleResultAndWinnerIds()

		if self._battleRecorder then
			local battleRecords = self._battleRecorder:dumpRecords()
			local var_5_1 = {
				logicSeed = self._logicSeed,
				strategySeedA = self._strategySeedA,
				strategySeedB = self._strategySeedB,
				result = result,
				winners = winners,
				statist = self._battleStatist
			}

			var_5_1.opData = battleSimulator:getInputManager():dumpInputHistory()
			var_5_1.timelines = self._battleRecorder and self._battleRecorder:dumpRecords()
			var_5_1.playersInfo = {
				challenger = {
					rid = self._playerId,
					playerId = playerIds[kBattleSideA]
				},
				defender = {
					rid = self._enemyId,
					playerId = playerIds[kBattleSideB]
				}
			}
			var_5_1.err = err

			return var_5_1
		end
	end
end

function DumpBattleSession:getBattleType()
	return self._battleType
end
