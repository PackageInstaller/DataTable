-- chunkname: @modules/logic/sp01/assassin2/outside/model/AssassinStealthGameModel.lua

module("modules.logic.sp01.assassin2.outside.model.AssassinStealthGameModel", package.seeall)

local AssassinStealthGameModel = class("AssassinStealthGameModel", BaseModel)

function AssassinStealthGameModel:onInit()
	self:clearAll()
end

function AssassinStealthGameModel:reInit()
	self:clearData()
	self:setMapPosRecordOnFight()
	self:setMapPosRecordOnTurn()
	self:setIsShowHeroHighlight(true)
end

function AssassinStealthGameModel:clearAll()
	self:clear()
	self:clearData()
end

function AssassinStealthGameModel:clearData()
	self:clearPickHeroData()
	self:clearStealthGameData()
	self:setIsFightReturn()
end

function AssassinStealthGameModel:clearPickHeroData()
	self._pickHeroList = {}
	self._pickHeroDict = {}
end

function AssassinStealthGameModel:clearStealthGameData()
	self._missionData = {}
	self._heroDict = {}
	self._enemyDict = {}
	self._gridDict = {}
	self._gridInteractiveDict = {}
	self._grid2EntityDict = {}

	self:setMapId()
	self:setRound()
	self:setEvent()
	self:setSelectedHero()
	self:setSelectedEnemy()
	self:setIsPlayerTurn(true)
	self:setGameState()
	self:setAlertLevel()
	self:setSelectedSkillProp()
	self:setGameRequestData()
	self:setEnemyOperationData()
end

function AssassinStealthGameModel:addHeroPick(assassinHeroId)
	table.insert(self._pickHeroList, assassinHeroId)
	self:_updatePickHeroDict()
end

function AssassinStealthGameModel:removeHeroPick(assassinHeroId)
	local pickIndex = self:getHeroPickIndex(assassinHeroId)

	table.remove(self._pickHeroList, pickIndex)
	self:_updatePickHeroDict()
end

function AssassinStealthGameModel:_updatePickHeroDict()
	self._pickHeroDict = {}

	for index, id in ipairs(self._pickHeroList) do
		self._pickHeroDict[id] = index
	end
end

function AssassinStealthGameModel:initGameSceneData(serverSceneData)
	self:clearStealthGameData()
	self:setMapId(serverSceneData.mapId)
	self:setRound(serverSceneData.round)
	self:setEvent(serverSceneData.currentEventId)
	self:setGridDataByList(serverSceneData.grids)
	self:addHeroDataByList(serverSceneData.heros)
	self:addEnemyDataByList(serverSceneData.monsters)
	self:setMissionData(serverSceneData.mission)
	self:setInteractiveList(serverSceneData.interactives)

	local battleGridCount = #serverSceneData.battleGridIds

	if serverSceneData.nextRound ~= 0 or battleGridCount > 0 then
		self:setIsPlayerTurn(false)
	else
		self:setIsPlayerTurn(true)
	end

	self:setGameRequestData(serverSceneData.battleGridIds, serverSceneData.nextRound, serverSceneData.changingMapId)
	self:setGameState(serverSceneData.state)
	self:setAlertLevel(serverSceneData.alertLevel)
	self:setEnemyMoveDir(serverSceneData.direction)
end

function AssassinStealthGameModel:updateGameSceneDataOnNewRound(serverSceneData)
	self:setMapId(serverSceneData.mapId)
	self:setRound(serverSceneData.round)
	self:setEvent(serverSceneData.currentEventId)
	self:setGridDataByList(serverSceneData.grids)
	self:updateHeroDataByList(serverSceneData.heros)
	self:updateEnemyDataByList(serverSceneData.monsters)
	self:setMissionData(serverSceneData.mission)
	self:setInteractiveList(serverSceneData.interactives)
	self:setGameRequestData(serverSceneData.battleGridIds, serverSceneData.nextRound, serverSceneData.changingMapId)
	self:setGameState(serverSceneData.state)
	self:setAlertLevel(serverSceneData.alertLevel)
	self:setEnemyMoveDir(serverSceneData.direction)
end

function AssassinStealthGameModel:_addEntity2GridDict(uid, isEnemy)
	local entityMo = isEnemy and self:getEnemyMo(uid, true) or self:getHeroMo(uid, true)

	if not entityMo then
		return
	end

	local newEntityUid = entityMo:getUid()
	local gridId, pointIndex = entityMo:getPos()
	local oldEntityUid = self:getGridPointEntity(gridId, pointIndex)

	if oldEntityUid then
		logWarn(string.format(" AssassinStealthGameModel:_addEntity2GridDict error, pos has entity, gridId:%s, pointIndex:%s, oldUid:%s, newUid:%s", gridId, pointIndex, oldEntityUid, newEntityUid))
	end

	local point2EntityDict = self._grid2EntityDict[gridId]

	if not point2EntityDict then
		point2EntityDict = {}
		self._grid2EntityDict[gridId] = point2EntityDict
	end

	point2EntityDict[pointIndex] = {
		uid = newEntityUid,
		isEnemy = isEnemy and true or false
	}
end

function AssassinStealthGameModel:_removeEntity2GridDict(uid, gridId, pointIndex)
	local posEntityUid = self:getGridPointEntity(gridId, pointIndex)

	if not posEntityUid or posEntityUid ~= uid then
		logWarn(string.format("AssassinStealthGameModel:_removeEntity2GridDict error, uid not same, gridId:%s, pointIndex:%s, posUid:%s, targetUid:%s", gridId, pointIndex, posEntityUid, uid))

		return
	end

	self._grid2EntityDict[gridId][pointIndex] = nil
end

function AssassinStealthGameModel:_changeGrid2EntityDict(uid, oldGridId, oldPointPos, isEnemy)
	if not uid then
		return
	end

	self:_removeEntity2GridDict(uid, oldGridId, oldPointPos)
	self:_addEntity2GridDict(uid, isEnemy)
end

function AssassinStealthGameModel:setMapId(mapId)
	self._mapId = mapId
end

function AssassinStealthGameModel:setRound(round)
	self._round = round
end

function AssassinStealthGameModel:setEvent(eventId)
	self._eventId = eventId
end

function AssassinStealthGameModel:setEnemyMoveDir(dir)
	self._enemyMoveDir = dir
end

function AssassinStealthGameModel:setGridDataByList(gridDataList)
	for _, gridData in ipairs(gridDataList) do
		self:setGridData(gridData)
	end
end

function AssassinStealthGameModel:setGridData(gridData)
	local gridId = gridData.gridId
	local gridMo = self:getGridMo(gridId)

	if not gridMo then
		gridMo = AssassinStealthGameGridMO.New()
		self._gridDict[gridId] = gridMo
	end

	gridMo:updateData(gridData)
end

function AssassinStealthGameModel:addHeroDataByList(heroDataList)
	for _, heroData in ipairs(heroDataList) do
		self:addHeroData(heroData)
	end
end

function AssassinStealthGameModel:addHeroData(heroData)
	local uid = heroData.uid
	local heroMo = self:getHeroMo(uid)

	if heroMo then
		return
	end

	heroMo = AssassinStealthGameHeroMO.New()

	heroMo:updateData(heroData)

	self._heroDict[uid] = heroMo

	self:_addEntity2GridDict(uid, false)
end

function AssassinStealthGameModel:updateHeroDataByList(heroDataList)
	if not heroDataList then
		return
	end

	for _, heroData in ipairs(heroDataList) do
		self:updateHeroData(heroData)
	end
end

function AssassinStealthGameModel:updateHeroData(heroData)
	local uid = heroData.uid
	local heroMo = self:getHeroMo(uid, true)

	if heroMo then
		local oldGridId, oldPointIndex = heroMo:getPos()

		heroMo:updateData(heroData)
		self:_changeGrid2EntityDict(uid, oldGridId, oldPointIndex, false)
	else
		logError(string.format("AssassinStealthGameModel:updateHeroData error, no heroMo, uid:%s", uid))
	end
end

function AssassinStealthGameModel:removeHeroData(uid)
	local heroMo = self:getHeroMo(uid)

	if heroMo then
		local gridId, pointIndex = heroMo:getPos()

		self:_removeEntity2GridDict(uid, gridId, pointIndex)
	end

	self._heroDict[uid] = nil
end

function AssassinStealthGameModel:setSelectedHero(uid)
	self._selectedHero = uid
end

function AssassinStealthGameModel:addEnemyDataByList(enemyDataList)
	for _, enemyData in ipairs(enemyDataList) do
		self:addEnemyData(enemyData)
	end
end

function AssassinStealthGameModel:addEnemyData(enemyData)
	local uid = enemyData.uid
	local enemyMo = self:getEnemyMo(uid)

	if enemyMo then
		return
	end

	enemyMo = AssassinStealthGameEnemyMO.New()

	enemyMo:updateData(enemyData)

	self._enemyDict[uid] = enemyMo

	self:_addEntity2GridDict(uid, true)
end

function AssassinStealthGameModel:updateEnemyDataByList(enemyDataList)
	if not enemyDataList then
		return
	end

	for _, enemyData in ipairs(enemyDataList) do
		self:updateEnemyData(enemyData)
	end
end

function AssassinStealthGameModel:updateEnemyData(enemyData)
	local uid = enemyData.uid
	local enemyMo = self:getEnemyMo(uid)

	if enemyMo then
		local oldGridId, oldPointIndex = enemyMo:getPos()

		enemyMo:updateData(enemyData)
		self:_changeGrid2EntityDict(uid, oldGridId, oldPointIndex, true)
	else
		logError(string.format("AssassinStealthGameModel:updateEnemyData error, no enemyMo, uid:%s", uid))
	end
end

function AssassinStealthGameModel:updateEnemyPos(enemyUid, gridId, pointIndex)
	local enemyMo = self:getEnemyMo(enemyUid, true)

	if enemyMo then
		local oldGridId, oldPointIndex = enemyMo:getPos()

		enemyMo:updatePos(gridId, pointIndex)
		self:_changeGrid2EntityDict(enemyUid, oldGridId, oldPointIndex, true)
	else
		logError(string.format("AssassinStealthGameModel:updateEnemyPos error, no enemyMo, uid:%s", enemyUid))
	end
end

function AssassinStealthGameModel:removeEnemyData(uid)
	local enemyMo = self:getEnemyMo(uid)

	if enemyMo then
		local gridId, pointIndex = enemyMo:getPos()

		self:_removeEntity2GridDict(uid, gridId, pointIndex)
	end

	self._enemyDict[uid] = nil
end

function AssassinStealthGameModel:setSelectedEnemy(uid)
	self._selectedEnemy = uid
end

function AssassinStealthGameModel:setMissionData(missionData)
	self._missionData.id = missionData.id
	self._missionData.progress = missionData.progress
	self._missionData.targetProgress = missionData.targetProgress
end

function AssassinStealthGameModel:setInteractiveList(interactiveIdList)
	for _, interactiveId in ipairs(interactiveIdList) do
		self:setInteractiveData(interactiveId)
	end
end

function AssassinStealthGameModel:setInteractiveData(interactiveId)
	local gridId = AssassinConfig.instance:getInteractGridId(interactiveId)

	self._gridInteractiveDict[gridId] = interactiveId
end

function AssassinStealthGameModel:setFinishedInteractive(interactiveId)
	local gridId = AssassinConfig.instance:getInteractGridId(interactiveId)

	self._gridInteractiveDict[gridId] = nil
end

function AssassinStealthGameModel:setIsPlayerTurn(isPlayerTurn)
	self._isPlayerTurn = isPlayerTurn
end

function AssassinStealthGameModel:setGameState(gameState)
	self._gameState = gameState
end

function AssassinStealthGameModel:setAlertLevel(alertLevel)
	self._alterLevel = alertLevel
end

function AssassinStealthGameModel:setSelectedSkillProp(skillPropId, isSkill)
	self._selectedSkillProp = skillPropId
	self._isSkill = not not isSkill
end

function AssassinStealthGameModel:setGameRequestData(battleGridIds, nextRound, changingMapId)
	self._battleGridIds = battleGridIds
	self._nextRound = nextRound
	self._changingMapId = changingMapId
end

function AssassinStealthGameModel:setIsFightReturn(isFightReturn)
	self._isFightReturn = isFightReturn
end

function AssassinStealthGameModel:setMapPosRecordOnFight(posX, posY, scale)
	self._fightRecordMapPosX = posX
	self._fightRecordMapPosY = posY
	self._fightRecordMapScale = scale
end

function AssassinStealthGameModel:setMapPosRecordOnTurn(posX, posY, scale)
	self._turnRecordMapPosX = posX
	self._turnRecordMapPosY = posY
	self._turnRecordMapScale = scale
end

function AssassinStealthGameModel:setIsShowHeroHighlight(isShow)
	self._isShowHeroHl = isShow
end

function AssassinStealthGameModel:setEnemyOperationData(enemyOperationData)
	self._enemyOperationData = enemyOperationData
end

function AssassinStealthGameModel:getHeroPickIndex(assassinHeroId)
	return self._pickHeroDict[assassinHeroId]
end

function AssassinStealthGameModel:getPickHeroCount()
	return #self._pickHeroList
end

function AssassinStealthGameModel:getPickHeroList()
	return self._pickHeroList
end

function AssassinStealthGameModel:getMapId()
	if not self._mapId then
		logError("AssassinStealthGameModel:getMapId error, mapId is nil")
	end

	return self._mapId
end

function AssassinStealthGameModel:getMissionId()
	return self._missionData.id
end

function AssassinStealthGameModel:getMissionProgress()
	return self._missionData.progress, self._missionData.targetProgress
end

function AssassinStealthGameModel:getHeroMo(uid, nilError)
	local result = self._heroDict[uid]

	if not result and nilError then
		logError(string.format("AssassinStealthGameModel:getHeroMo error, heroMo is nil, uid:%s", uid))
	end

	return result
end

function AssassinStealthGameModel:getHeroUidByAssassinHeroId(targetHeroId)
	if self._heroDict then
		for uid, heroMo in pairs(self._heroDict) do
			local heroId = heroMo:getHeroId()

			if heroId == targetHeroId then
				return uid
			end
		end
	end
end

function AssassinStealthGameModel:getEnemyMo(uid, nilError)
	local result = self._enemyDict[uid]

	if not result and nilError then
		logError(string.format("AssassinStealthGameModel:getEnemyMo error, enemyMo is nil, uid:%s", uid))
	end

	return result
end

function AssassinStealthGameModel:getGridMo(gridId)
	return self._gridDict[gridId]
end

local function _sortHeroUid(aUid, bUid)
	local aIsSelected = AssassinStealthGameModel.instance:isSelectedHero(aUid)
	local bIsSelected = AssassinStealthGameModel.instance:isSelectedHero(bUid)

	if aIsSelected ~= bIsSelected then
		return bIsSelected
	end

	return aUid < bUid
end

function AssassinStealthGameModel:getHeroUidList()
	local result = {}

	for _, heroMo in pairs(self._heroDict) do
		result[#result + 1] = heroMo:getUid()
	end

	table.sort(result, _sortHeroUid)

	return result
end

function AssassinStealthGameModel:getEnemyUidList()
	local result = {}

	for _, enemyMo in pairs(self._enemyDict) do
		result[#result + 1] = enemyMo:getUid()
	end

	return result
end

function AssassinStealthGameModel:getSelectedHero()
	return self._selectedHero
end

function AssassinStealthGameModel:getSelectedHeroGameMo()
	local selectedHeroUid = self:getSelectedHero()

	return self:getHeroMo(selectedHeroUid)
end

function AssassinStealthGameModel:isSelectedHero(uid)
	return self._selectedHero == uid
end

function AssassinStealthGameModel:getSelectedEnemy()
	return self._selectedEnemy
end

function AssassinStealthGameModel:getSelectedEnemyGameMo()
	local selectedEnemy = self:getSelectedEnemy()

	return self:getEnemyMo(selectedEnemy)
end

function AssassinStealthGameModel:isSelectedEnemy(uid)
	return self._selectedEnemy == uid
end

function AssassinStealthGameModel:getRound()
	return self._round
end

function AssassinStealthGameModel:isPlayerTurn()
	return self._isPlayerTurn
end

function AssassinStealthGameModel:getEventId()
	return self._eventId
end

function AssassinStealthGameModel:getEnemyMoveDir()
	return self._enemyMoveDir
end

function AssassinStealthGameModel:isAlertBellRing()
	return self._alterLevel and self._alterLevel > 0
end

function AssassinStealthGameModel:getGridInteractId(gridId)
	return self._gridInteractiveDict and self._gridInteractiveDict[gridId]
end

function AssassinStealthGameModel:isQTEInteractGrid(gridId)
	local interactId = self:getGridInteractId(gridId)

	return not not interactId
end

function AssassinStealthGameModel:getGridAllEntityList(gridId)
	local result = {}
	local point2EntityDict = self._grid2EntityDict[gridId]

	if point2EntityDict then
		for _, entityData in pairs(point2EntityDict) do
			result[#result + 1] = {
				uid = entityData.uid,
				isEnemy = entityData.isEnemy
			}
		end
	end

	return result
end

function AssassinStealthGameModel:getGridEntityIdList(gridId, isEnemy, excludeUid)
	local result = {}
	local point2EntityDict = self._grid2EntityDict[gridId]

	if point2EntityDict then
		isEnemy = not not isEnemy

		for _, entityData in pairs(point2EntityDict) do
			local uid = entityData.uid

			if isEnemy == entityData.isEnemy and uid ~= excludeUid then
				result[#result + 1] = uid
			end
		end
	end

	return result
end

function AssassinStealthGameModel:getGridPointEntity(gridId, pointIndex)
	local uid, isEnemy
	local point2EntityDict = self._grid2EntityDict[gridId]
	local entityData = point2EntityDict and point2EntityDict[pointIndex]

	if entityData then
		uid = entityData.uid
		isEnemy = entityData.isEnemy
	end

	return uid, isEnemy
end

function AssassinStealthGameModel:getGridEmptyPointIndex(gridId)
	local mapId = self:getMapId()
	local gridMo = self:getGridMo(gridId)
	local tracePointIndex = gridMo and gridMo:getTracePointIndex()
	local maxPointCount = AssassinConfig.instance:getGridMaxPointCount()

	for pointIndex = 1, maxPointCount do
		local pointType = AssassinConfig.instance:getGridPointType(mapId, gridId, pointIndex)

		if tracePointIndex ~= pointIndex and pointType == AssassinEnum.StealthGamePointType.Empty then
			local posEntityUid = self:getGridPointEntity(gridId, pointIndex)

			if not posEntityUid then
				return pointIndex
			end
		end
	end
end

function AssassinStealthGameModel:isHasAliveEnemy(gridId)
	local result = false
	local enemyUidList = self:getGridEntityIdList(gridId, true)

	for _, enemyUid in ipairs(enemyUidList) do
		local isDead = AssassinStealthGameHelper.isDeadEnemy(enemyUid)

		if not isDead then
			result = true

			break
		end
	end

	return result
end

function AssassinStealthGameModel:getExposeRate(gridId)
	local minRate = AssassinEnum.StealthConst.MinExposeRate
	local maxRate = AssassinEnum.StealthConst.MaxExposeRate
	local eventId = self:getEventId()
	local eventType = AssassinConfig.instance:getEventType(eventId)
	local gridMo = self:getGridMo(gridId)
	local isGridNotExpose = gridMo and gridMo:hasTrapType(AssassinEnum.StealGameTrapType.Smog)

	if eventType == AssassinEnum.EventType.NotExpose or isGridNotExpose then
		return minRate
	end

	local mapId = self:getMapId()
	local isEasyExpose = AssassinConfig.instance:getGridIsEasyExpose(mapId, gridId)

	if isEasyExpose then
		return maxRate * AssassinEnum.StealthConst.ShowExposeRatePoint
	end

	local eventChangeExposeRate = minRate

	if eventType == AssassinEnum.EventType.ChangExposeRate then
		local cfgEventChangeRate = tonumber(AssassinConfig.instance:getEventParam(eventId))

		eventChangeExposeRate = cfgEventChangeRate and cfgEventChangeRate / AssassinEnum.StealthConst.ConfigExposeRatePoint or minRate
	end

	local totalNotExposeRate = maxRate
	local enemyUidList = self:getGridEntityIdList(gridId, true)

	for _, enemyUid in ipairs(enemyUidList) do
		local enemyMo = self:getEnemyMo(enemyUid)
		local exposeRate = enemyMo and enemyMo:getExposeRate()

		if exposeRate then
			local realExposeRate = Mathf.Clamp(exposeRate + eventChangeExposeRate, minRate, maxRate)

			totalNotExposeRate = totalNotExposeRate * (maxRate - realExposeRate)

			if totalNotExposeRate == minRate then
				break
			end
		end
	end

	return (maxRate - totalNotExposeRate) * AssassinEnum.StealthConst.ShowExposeRatePoint
end

function AssassinStealthGameModel:getGameState()
	return self._gameState
end

function AssassinStealthGameModel:getHeroSkillPropList(heroUid)
	local result = {}
	local gameHeroMo = self:getHeroMo(heroUid, true)

	if gameHeroMo then
		local skillId = gameHeroMo:getActiveSkillId()

		if skillId then
			result[#result + 1] = {
				isSkill = true,
				id = skillId
			}
		end

		local itemIdList = gameHeroMo:getItemIdList()

		for _, itemId in ipairs(itemIdList) do
			result[#result + 1] = {
				isSkill = false,
				id = itemId
			}
		end
	end

	return result
end

function AssassinStealthGameModel:getSelectedSkillProp()
	return self._selectedSkillProp, self._isSkill
end

function AssassinStealthGameModel:getBattleGridIds()
	return self._battleGridIds
end

function AssassinStealthGameModel:getNeedNextRound()
	return self._nextRound
end

function AssassinStealthGameModel:getNeedChangingMap()
	return self._changingMapId
end

function AssassinStealthGameModel:getIsNeedRequest()
	local progress, targetProgress = self:getMissionProgress()

	if targetProgress <= progress then
		return true
	end

	local changingMapId = self:getNeedChangingMap()

	if changingMapId and changingMapId ~= 0 then
		return true
	end

	local battleGridIds = self:getBattleGridIds()
	local battleGrid = battleGridIds and battleGridIds[1]

	if battleGrid then
		return true
	end

	local needNextRound = self:getNeedNextRound()

	if needNextRound and needNextRound ~= 0 then
		return true
	end
end

function AssassinStealthGameModel:getIsFightReturn()
	return self._isFightReturn
end

function AssassinStealthGameModel:getMapPosRecordOnFight()
	return self._fightRecordMapPosX, self._fightRecordMapPosY, self._fightRecordMapScale
end

function AssassinStealthGameModel:getMapPosRecordOnTurn()
	return self._turnRecordMapPosX, self._turnRecordMapPosY, self._turnRecordMapScale
end

function AssassinStealthGameModel:getIsShowHeroHighlight()
	return self._isShowHeroHl
end

function AssassinStealthGameModel:getEnemyOperationData()
	return self._enemyOperationData
end

function AssassinStealthGameModel:getHasEnemyOperation()
	local enemyOperationData = self:getEnemyOperationData()

	if enemyOperationData then
		if enemyOperationData.summons then
			local hasBornData = #enemyOperationData.summons > 0

			if enemyOperationData.attacks then
				local hasAttackData = #enemyOperationData.attacks > 0

				if enemyOperationData.moves then
					local hasMoveData = #enemyOperationData.moves > 0

					if enemyOperationData.hero then
						local hasExposeHeroData = #enemyOperationData.hero > 0

						if enemyOperationData.battleGrids then
							local hasBattleGridData = #enemyOperationData.battleGrids > 0

							if hasBornData or hasAttackData or hasMoveData or hasExposeHeroData or hasBattleGridData then
								return true
							end

							local heroUidList = self:getHeroUidList()

							for _, heroUid in ipairs(heroUidList) do
								local isCanBeScan = AssassinStealthGameHelper.isHeroCanBeScan(heroUid)

								if isCanBeScan then
									local heroGameMo = self:getHeroMo(heroUid, true)
									local gridId = heroGameMo:getPos()
									local enemyWillScan = AssassinStealthGameHelper.isGridEnemyWillScan(gridId)

									if enemyWillScan then
										return true
									end
								end
							end
						end
					end
				end
			end
		end
	end

	return false
end

AssassinStealthGameModel.instance = AssassinStealthGameModel.New()

return AssassinStealthGameModel
