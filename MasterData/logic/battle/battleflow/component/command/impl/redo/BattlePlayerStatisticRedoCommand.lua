-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/redo/BattlePlayerStatisticRedoCommand.lua

module("logic.battle.battleflow.component.command.impl.redo.BattlePlayerStatisticRedoCommand", package.seeall)

local BattlePlayerStatisticRedoCommand = class("BattlePlayerStatisticRedoCommand", BattleCommandBase)

function BattlePlayerStatisticRedoCommand:parseServerRedoCommand(cmdParser, playerNO)
	local playerStatisticNO = playerNO.playerStatistic
	local cmd = BattlePlayerStatisticRedoCommand:createInstance()

	cmd:setCampId(playerNO.id)
	cmd:setTotalDamageToEnemy(playerStatisticNO.totalDamageToEnemy)
	cmd:setTotalEnemyKilled(playerStatisticNO.totalEnemyKilled)
	cmd:setDeadHeroList(playerStatisticNO.deadHeroes)
	cmd:setDeadEnemyList(playerStatisticNO.deadEnemies)
	cmd:setWeakBrokenList(playerStatisticNO.weakBroken)
	cmd:setExitHeroList(playerStatisticNO.exitHeroes)
	cmd:setExitEnemyList(playerStatisticNO.exitEnemies)
	cmdParser:addCommand(cmd)
end

function BattlePlayerStatisticRedoCommand:onInit()
	self._campId = false
	self._totalDamageToEnemy = false
	self._totalEnemyKilled = false
	self._deadHeroList = {}
	self._deadEnemyList = {}
	self._weakBrokenList = {}
	self._exitHeroList = {}
	self._exitEnemyList = {}
end

function BattlePlayerStatisticRedoCommand:onClear()
	self._campId = false
	self._totalDamageToEnemy = false
	self._totalEnemyKilled = false

	BattleTableUtil.clearTable(self._deadHeroList)
	BattleTableUtil.clearTable(self._deadEnemyList)
	BattleTableUtil.clearTable(self._weakBrokenList)
	BattleTableUtil.clearTable(self._exitHeroList)
	BattleTableUtil.clearTable(self._exitEnemyList)
end

function BattlePlayerStatisticRedoCommand:execute(battleFlow, runningContext)
	local model = battleFlow.model

	if self._campId == model:getOperateCampId() then
		local infoCollector = battleFlow.infoCollector

		infoCollector:setInitialTotalDamageToEnemy(self._totalDamageToEnemy)
		infoCollector:setInitialTotalEnemyKilled(self._totalEnemyKilled)
		infoCollector:setInitialDeadHeroCodeList(self._deadHeroList)
		infoCollector:setInitialDeadEnemyCodeList(self._deadEnemyList)
		infoCollector:setInitialWeakBrokenCodeList(self._weakBrokenList)
		infoCollector:setInitialExitHeroCodeList(self._exitHeroList)
		infoCollector:setInitialExitEnemyCodeList(self._exitEnemyList)
		BattleDispatcher:dispatchEvent(BattleEventType.OnCollectInfoReload)
	end

	self:finish(true)
end

function BattlePlayerStatisticRedoCommand:toString()
	return string.format("[redo] [player statistic redo command campId = %s]", self._campId)
end

function BattlePlayerStatisticRedoCommand:setCampId(campId)
	self._campId = campId

	return self
end

function BattlePlayerStatisticRedoCommand:setTotalDamageToEnemy(totalDamageToEnemy)
	self._totalDamageToEnemy = totalDamageToEnemy

	return self
end

function BattlePlayerStatisticRedoCommand:setTotalEnemyKilled(_totalEnemyKilled)
	self._totalEnemyKilled = totalEnemyKilled

	return self
end

function BattlePlayerStatisticRedoCommand:setDeadHeroList(deadHeroList)
	BattleTableUtil.insertto(self._deadHeroList, deadHeroList)

	return self
end

function BattlePlayerStatisticRedoCommand:setDeadEnemyList(deadEnemyList)
	BattleTableUtil.insertto(self._deadEnemyList, deadEnemyList)

	return self
end

function BattlePlayerStatisticRedoCommand:setWeakBrokenList(weakBrokenList)
	BattleTableUtil.insertto(self._weakBrokenList, weakBrokenList)

	return self
end

function BattlePlayerStatisticRedoCommand:setExitHeroList(exitHeroList)
	BattleTableUtil.insertto(self._exitHeroList, exitHeroList)

	return self
end

function BattlePlayerStatisticRedoCommand:setExitEnemyList(exitEnemyList)
	BattleTableUtil.insertto(self._exitEnemyList, exitEnemyList)

	return self
end

return BattlePlayerStatisticRedoCommand
