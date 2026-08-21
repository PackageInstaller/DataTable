-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/BattleInfoCollector.lua

module("logic.battle.battleflow.component.BattleInfoCollector", package.seeall)

local BattleInfoCollector = class("BattleInfoCollector", IBattleFlowComp)

function BattleInfoCollector:onInit()
	self._initialTotalDamageToEnemy = 0
	self._initialTotalEnemyKilled = 0
	self._selfDeadEntityCodeTable = {}
	self._enemyDeadEntityCodeTable = {}
	self._weakPointBrokenEntityCodeTable = {}
	self._selfArriveEvacuationCodeTable = {}
	self._enemyArriveEvacuationCodeTable = {}
end

function BattleInfoCollector:onStart()
	self._unitMgr = self.flow.unitMgr or false
	self._model = self.flow.model or false

	self:_setEvent(true)
end

function BattleInfoCollector:onClear()
	self:_setEvent(false)

	self._unitMgr = false
	self._model = false
	self._initialTotalDamageToEnemy = 0
	self._initialTotalEnemyKilled = 0

	BattleTableUtil.clearTable(self._selfDeadEntityCodeTable)
	BattleTableUtil.clearTable(self._enemyDeadEntityCodeTable)
	BattleTableUtil.clearTable(self._weakPointBrokenEntityCodeTable)
	BattleTableUtil.clearTable(self._selfArriveEvacuationCodeTable)
	BattleTableUtil.clearTable(self._enemyArriveEvacuationCodeTable)
end

function BattleInfoCollector:onUndoReset()
	self._initialTotalDamageToEnemy = 0
	self._initialTotalEnemyKilled = 0

	BattleTableUtil.clearTable(self._selfDeadEntityCodeTable)
	BattleTableUtil.clearTable(self._enemyDeadEntityCodeTable)
	BattleTableUtil.clearTable(self._weakPointBrokenEntityCodeTable)
	BattleTableUtil.clearTable(self._selfArriveEvacuationCodeTable)
	BattleTableUtil.clearTable(self._enemyArriveEvacuationCodeTable)
end

function BattleInfoCollector:_setEvent(add)
	if add then
		BattleDispatcher:addEventListener(BattleEventType.OnEntityDead, self._onEntityDead, self)
		BattleDispatcher:addEventListener(BattleEventType.OnWeakPointBroken, self._onWeakPointBroken, self)
		BattleDispatcher:addEventListener(BattleEventType.OnArriveEvacuationPoint, self._onArriveEvacuationPoint, self)
	else
		BattleDispatcher:removeEventListener(BattleEventType.OnEntityDead, self._onEntityDead, self)
		BattleDispatcher:removeEventListener(BattleEventType.OnWeakPointBroken, self._onWeakPointBroken, self)
		BattleDispatcher:removeEventListener(BattleEventType.OnArriveEvacuationPoint, self._onArriveEvacuationPoint, self)
	end
end

function BattleInfoCollector:setInitialTotalDamageToEnemy(totalDamageToEnemy)
	self._initialTotalDamageToEnemy = totalDamageToEnemy
end

function BattleInfoCollector:setInitialTotalEnemyKilled(totalEnemyKilled)
	self._initialTotalEnemyKilled = totalEnemyKilled
end

function BattleInfoCollector:setInitialDeadHeroCodeList(list)
	self:_listToCountTable(self._selfDeadEntityCodeTable, list)
end

function BattleInfoCollector:setInitialDeadEnemyCodeList(list)
	self:_listToCountTable(self._enemyDeadEntityCodeTable, list)
end

function BattleInfoCollector:setInitialWeakBrokenCodeList(list)
	self:_listToCountTable(self._weakPointBrokenEntityCodeTable, list)
end

function BattleInfoCollector:setInitialExitHeroCodeList(list)
	self:_listToCountTable(self._selfArriveEvacuationCodeTable, list)
end

function BattleInfoCollector:setInitialExitEnemyCodeList(list)
	self:_listToCountTable(self._enemyArriveEvacuationCodeTable, list)
end

function BattleInfoCollector:getSelfTotalDeadCount()
	return table.nums(self._selfDeadEntityCodeTable)
end

function BattleInfoCollector:getEnemyDeadCountOfEntityCode(entityCode)
	return self._enemyDeadEntityCodeTable[entityCode] or 0
end

function BattleInfoCollector:getInitialTotalDamageToEnemy()
	return self._initialTotalDamageToEnemy
end

function BattleInfoCollector:getEnemyTotalDeadCount()
	local total = 0

	for k, count in pairs(self._enemyDeadEntityCodeTable) do
		total = count + total
	end

	return total
end

function BattleInfoCollector:hasWeakPointBrokenOfEntityCode(entityCode)
	return self._weakPointBrokenEntityCodeTable[entityCode] > 0
end

function BattleInfoCollector:hasAnyWeakPointBroken()
	for _, count in pairs(self._weakPointBrokenEntityCodeTable) do
		if count > 0 then
			return true
		end
	end

	return false
end

function BattleInfoCollector:getTotalCountOfEntityCode(entityCode)
	local battleFieldInfo = self._model:getBattleFieldInfo()
	local entityInfos = battleFieldInfo.entityInfos
	local totalCount = 0

	for _, entityInfo in pairs(entityInfos) do
		if entityInfo.entityCode == entityCode then
			totalCount = totalCount + 1
		end
	end

	return totalCount
end

function BattleInfoCollector:_onEntityDead(evtId, entityId)
	local unit = self._unitMgr:getUnit(entityId)

	if not unit then
		if BattleLog.enableError then
			BattleLog.error(string.format("Cannot find unit %s", entityId))
		end

		return
	end

	local entityCode = unit.property:getEntityCode()

	if BattleCampRelationUtil.isSameOfOperateCamp(unit) then
		self._selfDeadEntityCodeTable[entityCode] = (self._selfDeadEntityCodeTable[entityCode] or 0) + 1

		self:_notifyCollectInfoUpdate()
	elseif BattleCampRelationUtil.isEnemyOfOperateCamp(unit) then
		self._enemyDeadEntityCodeTable[entityCode] = (self._enemyDeadEntityCodeTable[entityCode] or 0) + 1

		self:_notifyCollectInfoUpdate()
	end
end

function BattleInfoCollector:_onWeakPointBroken(evtId, entityId)
	local unit = self._unitMgr:getUnit(entityId)
	local entityCode = unit and unit.property:getEntityCode()
	local count = self._weakPointBrokenEntityCodeTable[entityCode] or 0

	self._weakPointBrokenEntityCodeTable[entityCode] = count + 1

	self:_notifyCollectInfoUpdate()
end

function BattleInfoCollector:_onArriveEvacuationPoint(_, entityId)
	local unit = self._unitMgr:getUnit(entityId)
	local entityCode = unit and unit.property:getEntityCode()

	if unit then
		if BattleCampRelationUtil.isSameOrFriendOfOperateCamp(unit) then
			self._selfArriveEvacuationCodeTable[entityCode] = (self._selfArriveEvacuationCodeTable[entityCode] or 0) + 1

			self:_notifyCollectInfoUpdate()
		elseif BattleCampRelationUtil.isEnemyOfOperateCamp(unit) then
			self._enemyArriveEvacuationCodeTable[entityCode] = (self._enemyArriveEvacuationCodeTable[entityCode] or 0) + 1

			self:_notifyCollectInfoUpdate()
		end
	end
end

function BattleInfoCollector:getSameOrFriendTotalArriveEvacuationCount()
	local total = 0

	for k, count in pairs(self._selfArriveEvacuationCodeTable) do
		total = total + count
	end

	return total
end

function BattleInfoCollector:getEnemyTotalArriveEvacuationCount()
	local total = 0

	for k, count in pairs(self._enemyArriveEvacuationCodeTable) do
		total = total + count
	end

	return total
end

function BattleInfoCollector:_notifyCollectInfoUpdate()
	BattleDispatcher:dispatchEvent(BattleEventType.OnCollectInfoUpdate)
end

function BattleInfoCollector:_listToCountTable(countTable, list)
	for _, key in ipairs(list) do
		local count = countTable[key] or 0

		countTable[key] = count + 1
	end
end

return BattleInfoCollector
