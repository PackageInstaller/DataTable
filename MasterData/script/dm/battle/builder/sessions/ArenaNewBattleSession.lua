-- chunkname: @/tmp/or_script/lua_compile/dm/battle/builder/sessions/ArenaNewBattleSession.lua

ArenaNewBattleSession = class("ArenaNewBattleSession", ArenaBattleSession)

function ArenaNewBattleSession:buildAutoStrategy(playerRole, team, randomSeed)
	local strategy = SequenceSeatStrategy:new(team, Random:new(randomSeed))

	if strategy.setDefaultInitWaitingCD then
		local defaultCD = ConfigReader:getRecordById("ConfigValue", "Fight_DefaultInitWaitingCD") and ConfigReader:getRecordById("ConfigValue", "Fight_DefaultInitWaitingCD").content or 500

		strategy:setDefaultInitWaitingCD(defaultCD)
	end

	return strategy
end

function ArenaNewBattleSession:getBattleType()
	return "chessArena"
end

function ArenaBattleSession:buildBattleData(playerData, enemyData, randomSeed)
	local randomizer = Random:new(randomSeed)
	local playerDrawCard = ConfigReader:getRecordById("ConfigValue", "Fight_PlayerDrawCard").content

	self._integralBattleData = BattleDataHelper:getIntegralBattleData({
		playerData = playerData,
		enemyData = enemyData
	})

	return self._integralBattleData
end

function ArenaNewBattleSession:getBattleSimulator()
	local delegate = {}

	function delegate.battleStart(battleContext)
		local friend = self._integralBattleData.playerData
		local friend_ = {}

		friend_.id = friend.rid
		friend_.leadStageLevel = friend.leadStageLevel
		friend_.leadStageId = friend.leadStageId
		friend_.waves = {
			{
				master = {
					modelId = friend.waves[1].master.modelId
				}
			}
		}

		local enemy = self._integralBattleData.enemyData
		local enemy_ = {}

		enemy_.id = enemy.rid
		enemy_.leadStageLevel = enemy.leadStageLevel
		enemy_.leadStageId = enemy.leadStageId
		enemy_.waves = {
			{
				master = {
					modelId = enemy.waves[1].master.modelId
				}
			}
		}

		local processRecorder = battleContext:getObject("BattleRecorder")
		local currentFrame = processRecorder:getCurrentFrame()

		processRecorder:recordEventAtFrame(kBRMainLine, 40, "ShowMasterArea", {
			friend = friend_,
			enemy = enemy_
		})
	end

	self._battleSimulator:setDelegate(delegate)

	return self._battleSimulator
end
