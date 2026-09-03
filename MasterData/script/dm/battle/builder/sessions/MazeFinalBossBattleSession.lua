-- chunkname: @/tmp/or_script/lua_compile/dm/battle/builder/sessions/MazeFinalBossBattleSession.lua

MazeFinalBossBattleSession = class("MazeFinalBossBattleSession", StageMazeBattleSession)

function MazeFinalBossBattleSession:buildBattleData(pointId, playerData, enemyData, randomSeed)
	local randomizer = Random:new(randomSeed)
	local playerDrawCard = ConfigReader:getRecordById("ConfigValue", "Fight_PlayerDrawCard").content

	self:_buildCardPool(playerData, randomizer, playerDrawCard, playerData.cards)

	return BattleDataHelper:getIntegralBattleData({
		playerData = playerData,
		enemyData = enemyData
	})
end

function MazeFinalBossBattleSession:getBattleType()
	return "mazeFinal"
end
