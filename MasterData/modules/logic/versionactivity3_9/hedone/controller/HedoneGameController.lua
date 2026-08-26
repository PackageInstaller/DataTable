-- chunkname: @modules/logic/versionactivity3_9/hedone/controller/HedoneGameController.lua

module("modules.logic.versionactivity3_9.hedone.controller.HedoneGameController", package.seeall)

local HedoneGameController = class("HedoneGameController", BaseController)

function HedoneGameController:onInit()
	return
end

function HedoneGameController:onInitFinish()
	return
end

function HedoneGameController:addConstEvents()
	return
end

function HedoneGameController:reInit()
	return
end

function HedoneGameController:enterGame(episodeId, gameId)
	local curGameId = HedoneGameModel.instance:getGameId()

	if curGameId or not episodeId or not gameId then
		return
	end

	HedoneGameModel.instance:onEnterGame(episodeId, gameId)
	HedoneSkillMgr.instance:onEnterGame()
	HedoneTriggerMgr.instance:onEnterGame()
	ViewMgr.instance:openView(ViewName.HedoneGameView)
end

function HedoneGameController:startGame()
	if not self._isRunning then
		self._secondElapsedTime = 0

		UpdateBeat:Add(self._onUpdate, self)

		self._isRunning = true
	end
end

function HedoneGameController:stopGame(sourceKey)
	HedoneGameModel.instance:requestStopGame(sourceKey)
end

function HedoneGameController:resumeGame(sourceKey)
	HedoneGameModel.instance:requestResumeGame(sourceKey)
end

function HedoneGameController:resetGame()
	self._secondElapsedTime = 0

	local curEpisodeId = HedoneGameModel.instance:getGameEpisodeId()
	local curGameId = HedoneGameModel.instance:getGameId()

	HedoneGameModel.instance:onEnterGame(curEpisodeId, curGameId)
	HedoneSkillMgr.instance:onEnterGame()
	HedoneTriggerMgr.instance:onEnterGame()
	self:dispatchEvent(HedoneEvent.OnGameReset)
end

function HedoneGameController:exitGame()
	if self._isRunning then
		UpdateBeat:Remove(self._onUpdate, self)

		self._secondElapsedTime = 0
	end

	self._isRunning = false

	HedoneSkillMgr.instance:onExitGame()
	HedoneTriggerMgr.instance:onExitGame()
	HedoneGameModel.instance:clearAllData()
end

function HedoneGameController:_onUpdate()
	local inGuiding = GuideController.instance:isAnyGuideRunning()

	if inGuiding then
		return
	end

	local gameId = HedoneGameModel.instance:getGameId()
	local isStop = HedoneGameModel.instance:getIsStopGame()
	local isGameEnd = HedoneGameModel.instance:getIsGameEnd()

	if isStop or isGameEnd or not gameId then
		return
	end

	local deltaTime = Time.deltaTime
	local nowTime = Time.time

	self:_updateEntityMove(deltaTime)
	HedoneSkillMgr.instance:onUpdate(deltaTime, nowTime)
	HedoneTriggerMgr.instance:onUpdate(deltaTime, nowTime)

	self._secondElapsedTime = self._secondElapsedTime + deltaTime

	if self._secondElapsedTime >= TimeUtil.OneSecond then
		self._secondElapsedTime = self._secondElapsedTime - TimeUtil.OneSecond

		self:_everySecondCall()
	end
end

function HedoneGameController:_updateEntityMove(deltaTime)
	local monsterUidList = HedoneGameModel.instance:getEntityTypeUidList(HedoneGameEnum.EntityType.Monster)

	self:_moveEntities(monsterUidList, deltaTime)

	local bulletUidList = HedoneGameModel.instance:getEntityTypeUidList(HedoneGameEnum.EntityType.Bullet)

	self:_moveEntities(bulletUidList, deltaTime)
	self:dispatchEvent(HedoneEvent.RefreshEntityMove)
end

function HedoneGameController:_moveEntities(uidList, deltaTime)
	if uidList then
		if not #uidList then
			local count = 0

			if count <= 0 then
				return
			end

			for i = 1, count do
				local uid = uidList[i]
				local entityMO = HedoneGameModel.instance:getEntityMO(uid)

				if entityMO then
					entityMO:updateMove(deltaTime)
				end
			end
		end
	end
end

function HedoneGameController:_everySecondCall()
	local isWin = self:_updateGameTime()

	if isWin or not ((not isWin or nil) and self:_playerBeAttacked()) then
		HedoneGameModel.instance:setGameEnd()
		HedoneController.instance:openGameResultView(isWin)
	else
		self:_updateBuffSecondTimeLife()
		self:_checkMonsterWave()
	end

	self:dispatchEvent(HedoneEvent.OnSecondRefresh)
end

function HedoneGameController:_updateGameTime()
	local gameTime = HedoneGameModel.instance:addGameTime()

	HedoneTriggerMgr.instance:tryResetTriggerCount()

	local gameId = HedoneGameModel.instance:getGameId()
	local targetTime = HedoneConfig.instance:getHedoneGameTargetTime(gameId)

	return targetTime > 0 and targetTime <= gameTime
end

function HedoneGameController:_playerBeAttacked()
	local playerMO = HedoneGameModel.instance:getPlayerMO()

	if not playerMO then
		return
	end

	local uidList = HedoneGameModel.instance:getEntityTypeUidList(HedoneGameEnum.EntityType.Monster)

	if not uidList then
		return playerMO:getIsAlive()
	end

	local totalDamage = 0
	local monsterCount = #uidList

	for i = 1, monsterCount do
		local uid = uidList[i]
		local monsterMO = HedoneGameModel.instance:getEntityMO(uid)
		local isAttacking = monsterMO and monsterMO:getIsAttacking()

		if isAttacking then
			local atk = monsterMO:getAttrValue(HedoneGameEnum.Attribute.Atk)

			totalDamage = totalDamage + (atk or 0)

			self:dispatchEvent(HedoneEvent.EntityPlayAnim, uid, HedoneGameEnum.EntityAnimName.Attack)
		end
	end

	if totalDamage <= 0 then
		return playerMO:getIsAlive()
	end

	totalDamage = math.floor(totalDamage + 0.5)

	local isAlive = playerMO:changeHp(-totalDamage)

	if isAlive then
		HedoneTriggerMgr.instance:trigger(HedoneGameEnum.TriggerPoint.AfterPlayerHurt)
	end

	local playerUid = playerMO:getUid()

	self:dispatchEvent(HedoneEvent.OnEntityTakeDamage, playerUid, totalDamage, false, isAlive)

	return isAlive
end

function HedoneGameController:_updateBuffSecondTimeLife()
	local playerMO = HedoneGameModel.instance:getPlayerMO()

	if playerMO then
		playerMO:consumeBuffLife(HedoneGameEnum.BuffLifeRule.Timed)
	end
end

function HedoneGameController:_checkMonsterWave(argsWaveId)
	local newWaveId = argsWaveId or self:_tryGenerateMonsterWave()

	if newWaveId then
		::label_18_0::

		local strRandomParam = HedoneConfig.instance:getHedoneWaveRandomParam(newWaveId)

		if string.nilorempty(strRandomParam) then
			return
		end

		local paramId = self:_pickWaveRandomParamId(strRandomParam)
		local groupId = self:_resolveWaveGroupId(newWaveId, paramId)
		local idPool = self:_buildMonsterIdPool(groupId)

		self:_spawnMonsterWave(groupId, idPool)
		self:dispatchEvent(HedoneEvent.OnStartNewMonsterWave)
	end
end

function HedoneGameController:_tryGenerateMonsterWave()
	local waveId
	local gameId = HedoneGameModel.instance:getGameId()
	local targetTime = HedoneConfig.instance:getHedoneGameTargetTime(gameId)
	local gameTime = HedoneGameModel.instance:getGameTime()
	local endlessWaveData = HedoneConfig.instance:getHedoneConst(HedoneEnum.ConstId.EndlessLevelWave, false, true, "#")
	local endlessWaveTime = endlessWaveData and endlessWaveData[1]

	if targetTime < 0 and endlessWaveTime and endlessWaveTime <= gameTime then
		local intervalTime = endlessWaveData[3]
		local lastGenerateTime = HedoneGameModel.instance:getLastGenerateWaveTime()

		if lastGenerateTime > 0 and intervalTime > gameTime - lastGenerateTime then
			return
		end

		waveId = endlessWaveData[2]

		HedoneGameModel.instance:recordGenerateWaveTime()
	else
		local waveData = HedoneGameModel.instance:getCurWaveData()

		while waveData and gameTime >= waveData.time do
			waveId = waveData.waveId

			HedoneGameModel.instance:addCurWaveIndex()

			waveData = HedoneGameModel.instance:getCurWaveData()
		end
	end

	return waveId
end

local function _getRandomParamItemWeight(item)
	return item.weight
end

function HedoneGameController:_pickWaveRandomParamId(strRandomParam)
	local paramItemList = {}
	local arr = GameUtil.splitString2(strRandomParam, true)

	for i, data in ipairs(arr) do
		paramItemList[i] = {
			paramId = data[1],
			weight = data[2]
		}
	end

	local randomParamItem = HedoneGameHelper.getWeightedRandomPick(paramItemList, _getRandomParamItemWeight)

	return randomParamItem and randomParamItem.paramId
end

local function _getMonsterGroupWeightFunc(groupId)
	return HedoneConfig.instance:getHedoneMonsterGroupWeight(groupId)
end

function HedoneGameController:_resolveWaveGroupId(waveId, paramId)
	local randomType = HedoneConfig.instance:getHedoneWaveRandomType(waveId)

	if randomType == HedoneGameEnum.WaveRandomType.GroupType then
		local groupIdList = HedoneConfig.instance:getHedoneMonsterGroupIdListByType(paramId)

		return HedoneGameHelper.getWeightedRandomPick(groupIdList, _getMonsterGroupWeightFunc)
	elseif randomType == HedoneGameEnum.WaveRandomType.GroupId then
		return paramId
	end

	logError(string.format("HedoneGameController:_resolveWaveGroupId error, randomType:%s not support", randomType))
end

function HedoneGameController:_buildMonsterIdPool(groupId)
	local allMonsterData = HedoneConfig.instance:getHedoneMonsterGroupMonsters(groupId)

	if not allMonsterData then
		return
	end

	local idPool = {}

	for _, data in ipairs(allMonsterData) do
		local id = data.monsterId
		local count = tonumber(data.count) or 0

		if id and count > 0 then
			for _ = 1, count do
				table.insert(idPool, id)
			end
		end
	end

	return idPool
end

function HedoneGameController:_spawnMonsterWave(groupId, idPool)
	if not idPool or #idPool <= 0 then
		return
	end

	local monstersDataList = {}
	local randomIdPool = GameUtil.randomTable(idPool)
	local yLevelPosList = HedoneConfig.instance:getHedoneConst(HedoneEnum.ConstId.MonsterYLevel, false, true, "|")
	local yLevelList = {}

	for yLevel = 1, #yLevelPosList do
		yLevelList[#yLevelList + 1] = yLevel
	end

	local monsterXRange = HedoneConfig.instance:getHedoneConst(HedoneEnum.ConstId.MonsterXRange, false, true, "#")

	if monsterXRange then
		if not monsterXRange[1] then
			local startX = 0
			local randomYLevelList = GameUtil.randomTable(yLevelList)

			for i = 1, #randomYLevelList do
				local id = randomIdPool[i]

				if not id then
					break
				end

				local yLevel = randomYLevelList[i]

				table.insert(monstersDataList, {
					id = id,
					posX = startX,
					posY = yLevelPosList[yLevel],
					yLevel = yLevel,
					entityType = HedoneGameEnum.EntityType.Monster,
					groupId = groupId
				})
			end

			self:addEntityList(monstersDataList)
		end
	end
end

function HedoneGameController:addEntityList(dataList)
	if not dataList or #dataList <= 0 then
		return
	end

	local isGameEnd = HedoneGameModel.instance:getIsGameEnd()

	if isGameEnd then
		return
	end

	local uidList = HedoneGameModel.instance:addEntityMOByList(dataList)

	self:dispatchEvent(HedoneEvent.OnAddEntities, uidList)
end

function HedoneGameController:addEntity(data)
	if not data then
		return
	end

	local isGameEnd = HedoneGameModel.instance:getIsGameEnd()

	if isGameEnd then
		return
	end

	local mo = HedoneGameModel.instance:addEntityMO(data)
	local uid = mo and mo:getUid()

	self:dispatchEvent(HedoneEvent.OnAddEntity, uid)
end

function HedoneGameController:entityTakeDamage(uid, damage, isCrit, skillId, effectGroup)
	if not uid or not damage or damage <= 0 then
		return
	end

	local mo = HedoneGameModel.instance:getEntityMO(uid)

	if not mo then
		return
	end

	damage = math.floor(damage + 0.5)

	local isAlive = mo:changeHp(-damage)

	if not isAlive then
		local entityType = mo:getEntityType()

		if entityType == HedoneGameEnum.EntityType.Monster then
			HedoneGameModel.instance:addMonsterKillCount()
			HedoneTriggerMgr.instance:trigger(HedoneGameEnum.TriggerPoint.AfterEffectKillMonster, effectGroup)
		end
	end

	HedoneGameModel.instance:recordSkillDamage(effectGroup, damage)
	self:dispatchEvent(HedoneEvent.OnEntityTakeDamage, uid, damage, isCrit, isAlive)

	return damage
end

function HedoneGameController:removeEntity(uid)
	if not uid then
		return
	end

	local isGameEnd = HedoneGameModel.instance:getIsGameEnd()

	if isGameEnd then
		return
	end

	HedoneGameModel.instance:removeEntityMO(uid)
	self:dispatchEvent(HedoneEvent.OnRemoveEntity, uid)
end

function HedoneGameController:playerAddExp(exp)
	local isGameEnd = HedoneGameModel.instance:getIsGameEnd()

	if isGameEnd then
		return
	end

	local playerMO = HedoneGameModel.instance:getPlayerMO()
	local isAlive = playerMO and playerMO:getIsAlive()

	if not isAlive then
		return
	end

	playerMO:addExp(exp)

	local getNewSkillCount = 0
	local needExp = playerMO:getLevelUpNeedExp() or 0

	while needExp > 0 and needExp <= playerMO:getCurExp() do
		local result = playerMO:tryLevelUp()

		if not result then
			break
		end

		needExp = playerMO:getLevelUpNeedExp()
		getNewSkillCount = getNewSkillCount + 1
	end

	self:dispatchEvent(HedoneEvent.OnPlayerExpChange, getNewSkillCount)
end

HedoneGameController.instance = HedoneGameController.New()

return HedoneGameController
