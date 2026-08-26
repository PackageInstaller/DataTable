-- chunkname: @modules/logic/versionactivity3_3/arcade/model/game/ArcadeGameModel.lua

module("modules.logic.versionactivity3_3.arcade.model.game.ArcadeGameModel", package.seeall)

local ArcadeGameModel = class("ArcadeGameModel", BaseModel)

function ArcadeGameModel:onInit()
	self._gridModel = BaseModel.New()

	self:clearAllData()
end

function ArcadeGameModel:reInit()
	self:clearAllData()
end

function ArcadeGameModel:clearAllData()
	self:setDifficulty()
	self:setCurAreaIndex()
	self:setTransferNodeIndex()
	self:setCurRoomId()
	self:setChangingRoom()
	self:setIsPlayerTurn()
	self:setIsPauseGame()
	self:setGameIsEnd()
	self:setNearEventEntity()
	self:resetNegativeOperationRound()

	self._maxScore = 0
	self._passLevel = 0
	self._killMonsterNum = 0
	self._allCoinNum = 0
	self._genUid = 0
	self._gameSwitchDict = {}
	self._gameAttributeDict = {}
	self._unlockCharacterDict = {}
	self._unlockHandBookDict = {}
	self._gameTempAttrDict = {}
	self._portalExtractDict = {}

	self:clearAllEntityMO(true)
	self._gridModel:clear()
end

function ArcadeGameModel:onEnterArcadeGame()
	self:_initGameAttribute()
	self:_initCharacterMO()
	self:_initGridMO()
	self:setGameIsEnd(false)
end

function ArcadeGameModel:_initGameAttribute()
	self._gameAttributeDict = {}

	for _, attrId in pairs(ArcadeGameEnum.GameAttribute) do
		self._gameAttributeDict[attrId] = ArcadeConfig.instance:getAttributeInitVal(attrId)
	end

	self._gameSwitchDict = {}

	for _, attrId in pairs(ArcadeGameEnum.GameSwitch) do
		local initVal = ArcadeConfig.instance:getAttributeInitVal(attrId)

		self._gameSwitchDict[attrId] = initVal > 0
	end
end

function ArcadeGameModel:_initCharacterMO()
	local characterId = ArcadeHeroModel.instance:getEquipHeroId()
	local characterData = {
		entityType = ArcadeGameEnum.EntityType.Character,
		id = characterId
	}

	self._arcadeGameCharacterMO = ArcadeGameCharacterMO.New(characterData)

	local skillSetMO = self._arcadeGameCharacterMO:getSkillSetMO()
	local difficulty = self:getDifficulty()
	local difficultyAddSkillId = ArcadeConfig.instance:getDifficultyAddSkill(difficulty)

	skillSetMO:addSkillById(difficultyAddSkillId)

	local talentMOList = ArcadeHeroModel.instance:getTalentMoList()

	for _, talentMO in ipairs(talentMOList) do
		local talentLevel = talentMO:getLevel()
		local skillList = talentMO:getSkillIdsByLevel(talentLevel)

		if skillList then
			for _, skillId in ipairs(skillList) do
				skillSetMO:addSkillById(skillId)
			end
		end
	end
end

function ArcadeGameModel:_initGridMO()
	local size = ArcadeGameEnum.Const.RoomSize

	for gridX = 1, size do
		for gridY = 1, size do
			self:getGridMOByXY(gridX, gridY)
		end
	end
end

function ArcadeGameModel:onRestartArcadeGame(serverInfo)
	self:clearAllData()

	local attrDict = {}
	local attrContainer = serverInfo.attrContainer

	for _, data in ipairs(attrContainer.attrValues) do
		attrDict[data.id] = {
			base = data.base,
			rate = data.rate,
			extra = data.extra
		}
	end

	self:_setRestartGameData(serverInfo, attrDict)
	self:_setRestartCharacterData(serverInfo, attrDict)
	self:setGameIsEnd(false)
end

function ArcadeGameModel:_setRestartGameData(serverInfo, serverAttrDict)
	local prop = serverInfo.prop
	local jsonPortalExtract = prop.hotfix[1]

	if not string.nilorempty(jsonPortalExtract) then
		local portalExtractDict = cjson.decode(jsonPortalExtract)

		if portalExtractDict then
			for portalIdStr, count in pairs(portalExtractDict) do
				local portalId = tonumber(portalIdStr)

				self._portalExtractDict[portalId] = count
			end
		end
	end

	self:setDifficulty(prop.difficulty)
	self:setCurAreaIndex(prop.areaId)
	self:setCurRoomId(prop.roomId)
	self:setTransferNodeIndex(prop.progress)

	self._killMonsterNum = prop.maxKillMonsterNum
	self._allCoinNum = prop.totalGainGoldNum
	self._maxScore = prop.highestScore
	self._passLevel = prop.clearedRoomNum
	self._gameAttributeDict = {}
	self._gameTempAttrDict = {}

	for _, attrId in pairs(ArcadeGameEnum.GameAttribute) do
		local val
		local attrData = serverAttrDict[attrId]

		val = attrData and attrData.base
		val = val or ArcadeConfig.instance:getAttributeInitVal(attrId)
		self._gameAttributeDict[attrId] = val
		self._gameTempAttrDict[attrId] = 0
	end

	self._gameSwitchDict = {}

	for _, attrId in pairs(ArcadeGameEnum.GameSwitch) do
		local val
		local attrData = serverAttrDict[attrId]

		val = attrData and attrData.base
		val = val or ArcadeConfig.instance:getAttributeInitVal(attrId)
		val = val or ArcadeConfig.instance:getAttributeInitVal(attrId)
		self._gameSwitchDict[attrId] = val > 0
	end

	local extendInfo = serverInfo.extendInfo

	for _, book in ipairs(extendInfo.addedBook.books) do
		local type = book.type

		for _, id in ipairs(book.eleId) do
			self:addUnlockHandBookItem(type, id)
		end
	end

	for _, characterId in ipairs(extendInfo.unlockRoleIds) do
		self:addUnlockCharacter(characterId)
	end

	self:_initGridMO()
end

function ArcadeGameModel:_setRestartCharacterData(serverInfo, serverAttrDict)
	local characterData = {
		entityType = ArcadeGameEnum.EntityType.Character,
		id = serverInfo.player.id,
		extraParam = {
			restart = true
		}
	}

	self._arcadeGameCharacterMO = ArcadeGameCharacterMO.New(characterData)

	self._arcadeGameCharacterMO:setDataFromServerInfo(serverInfo, serverAttrDict)
end

function ArcadeGameModel:onResetArcadeGame()
	local difficulty = self:getDifficulty()

	self:clearAllData()
	self:setDifficulty(difficulty)
	self:onEnterArcadeGame()
end

function ArcadeGameModel:_generateUid()
	self._genUid = self._genUid + 1

	return self._genUid
end

function ArcadeGameModel:addEntityMOByList(moDataList, needGenUid)
	if not moDataList then
		return
	end

	local resultList = {}

	for _, moData in ipairs(moDataList) do
		local mo = self:addEntityMO(moData, needGenUid)

		if moData.delayTimeShow then
			mo.delayTimeShow = tonumber(moData.delayTimeShow)
		end

		resultList[#resultList + 1] = mo
	end

	return resultList
end

function ArcadeGameModel:addNegativeOperationRound()
	self._negativeRound = (self._negativeRound or 0) + 1
end

function ArcadeGameModel:resetNegativeOperationRound()
	self._negativeRound = 0
end

function ArcadeGameModel:addEntityMO(moData, needGenUid)
	if not moData then
		return
	end

	local entityType = moData.entityType
	local moCls = ArcadeGameEnum.EntityTypeMOCls[entityType]

	if not moCls then
		logError(string.format("ArcadeGameModel:addEntityMO error, entityType:%s no moCls define", entityType))

		return
	end

	local id = moData.id
	local uid = id

	if needGenUid then
		uid = self:_generateUid()
	end

	moData.uid = uid

	local mo = moCls.New(moData)
	local typeDict = ArcadeGameHelper.checkDictTable(self._moDict, entityType)
	local typeList = ArcadeGameHelper.checkDictTable(self._moList, entityType)

	typeDict[uid] = mo
	typeList[#typeList + 1] = mo

	local handBookType

	if entityType == ArcadeGameEnum.EntityType.Monster then
		handBookType = ArcadeGameEnum.HandBookType.Monster
	elseif entityType == ArcadeGameEnum.EntityType.Floor then
		handBookType = ArcadeGameEnum.HandBookType.Floor
	end

	if handBookType then
		self:addUnlockHandBookItem(handBookType, id)
	end

	return mo
end

function ArcadeGameModel:removeEntityMO(entityType, targetUid)
	if not entityType or not targetUid then
		return
	end

	local dict = self._moDict[entityType]

	if dict then
		dict[targetUid] = nil
	end

	local list = self._moList[entityType]

	if list then
		for i, mo in ipairs(list) do
			local uid = mo:getUid()

			if uid == targetUid then
				table.remove(list, i)

				return
			end
		end
	end
end

function ArcadeGameModel:removeEntityMOByType(entityType)
	if self._moDict then
		self._moDict[entityType] = nil
	end

	if self._moList then
		self._moList[entityType] = nil
	end
end

function ArcadeGameModel:clearAllEntityMO(includeCharacter)
	if includeCharacter then
		self._arcadeGameCharacterMO = nil
	end

	self._moDict = {}
	self._moList = {}
end

function ArcadeGameModel:refreshMaxScore()
	local characterMO = self:getCharacterMO()

	if not characterMO then
		return
	end

	local curScore = characterMO:getResourceCount(ArcadeGameEnum.CharacterResource.Score)

	if not self._maxScore or curScore > self._maxScore then
		self._maxScore = curScore
	end
end

function ArcadeGameModel:setDifficulty(difficulty)
	self._difficulty = difficulty
end

function ArcadeGameModel:setCurAreaIndex(areaIndex)
	self._curAreaIndex = areaIndex
end

function ArcadeGameModel:setTransferNodeIndex(roomNodeIndex)
	self._transferNodeIndex = roomNodeIndex
end

function ArcadeGameModel:setCurRoomId(roomId)
	self._curRoomId = roomId
end

function ArcadeGameModel:setChangingRoom(isChanging)
	self._isChangingRoom = isChanging
end

function ArcadeGameModel:setIsPlayerTurn(isPlayerTurn)
	self._isPlayerTurn = isPlayerTurn
end

function ArcadeGameModel:setIsPauseGame(isPause)
	self._isPauseGame = isPause
end

function ArcadeGameModel:setGameIsEnd(isEnd)
	self._isEndGame = isEnd
end

function ArcadeGameModel:addPassLevelCount()
	self._passLevel = (self._passLevel or 0) + 1
end

function ArcadeGameModel:addKillMonsterNum(count)
	count = count or 1
	self._killMonsterNum = (self._killMonsterNum or 0) + count

	self:triggerEntityCounterRecord(ArcadeGameEnum.EntityType.Character, nil, ArcadeGameEnum.GameCounter.MonsterKillsSinceAddSkill, nil, count)
end

function ArcadeGameModel:triggerEntityCounterRecord(entityType, uid, counterName, counterParam, count)
	local mo = self:getMOWithType(entityType, uid)

	if not mo then
		return
	end

	mo:triggerSkillSetMOCounterRecord(counterName, counterParam, count)
end

function ArcadeGameModel:triggerEntityTypeCounterRecord(targetEntityType, counterName, counterParam, count)
	local gridMOList = self:getGridMOList()

	for _, gridMO in ipairs(gridMOList) do
		gridMO:triggerSkillSetMOCounterRecord(counterName, counterParam, count)
	end

	if self._moList then
		for entityType, typeList in pairs(self._moList) do
			if not targetEntityType or entityType == targetEntityType then
				for _, mo in ipairs(typeList) do
					mo:triggerSkillSetMOCounterRecord(counterName, counterParam, count)
				end
			end
		end
	end
end

function ArcadeGameModel:addGainCoinNum(count)
	self._allCoinNum = (self._allCoinNum or 0) + (count or 0)
end

function ArcadeGameModel:setGameAttribute(attrId, value)
	if not attrId or not value then
		return
	end

	local min = ArcadeConfig.instance:getAttributeMin(attrId, true)
	local max = ArcadeConfig.instance:getAttributeMax(attrId, true)

	self._gameAttributeDict[attrId] = GameUtil.clamp(value, min, max)
end

function ArcadeGameModel:setGameTempAttribute(attrId, value)
	if attrId and value then
		self._gameTempAttrDict[attrId] = value
	end
end

function ArcadeGameModel:getGameTempAttribute(attrId)
	return self._gameTempAttrDict[attrId] or 0
end

function ArcadeGameModel:clearGameTempAttribute()
	for _, attrId in pairs(ArcadeGameEnum.GameAttribute) do
		self._gameTempAttrDict[attrId] = 0
	end
end

function ArcadeGameModel:setGameSwitch(attrId, isOn)
	if not attrId then
		return
	end

	self._gameSwitchDict[attrId] = not not isOn
end

function ArcadeGameModel:addGoodsHasResetTimes()
	self._goodsHasResetTimes = (self._goodsHasResetTimes or 0) + 1
end

function ArcadeGameModel:clearGoodsHasResetTimes()
	self._goodsHasResetTimes = 0
end

function ArcadeGameModel:addUnlockCharacter(characterId)
	local cfg = ArcadeConfig.instance:getCharacterCfg(characterId, true)

	if not cfg then
		return
	end

	self._unlockCharacterDict[characterId] = true

	self:addUnlockHandBookItem(ArcadeGameEnum.HandBookType.Character, characterId)
end

function ArcadeGameModel:addUnlockHandBookItem(handBookType, id)
	local typeDict = ArcadeGameHelper.checkDictTable(self._unlockHandBookDict, handBookType)

	typeDict[id] = true
end

function ArcadeGameModel:setNearEventEntity(entityType, uid)
	self._eventEntityType = entityType
	self._eventEntityUid = uid
end

function ArcadeGameModel:addPortalExtractionCount(portalId)
	self._portalExtractDict[portalId] = (self._portalExtractDict[portalId] or 0) + 1
end

function ArcadeGameModel:isFinishGameGuide()
	local isForbidGuide = GuideController.instance:isForbidGuides()

	if isForbidGuide then
		return true
	end

	local guideList = ArcadeConfig.instance:getArcadeConst(ArcadeEnum.ConstId.FirstGameGuideList, true, "#")

	if guideList then
		for _, guideId in ipairs(guideList) do
			local isFinish = GuideModel.instance:isGuideFinish(guideId)

			if not isFinish then
				return false
			end
		end
	end

	return true
end

function ArcadeGameModel:getIsInGuideLevel(difficulty)
	difficulty = difficulty or self:getDifficulty()

	local isFinishGuide = self:isFinishGameGuide()

	return difficulty == ArcadeGameEnum.Const.GuideDifficulty and not isFinishGuide
end

function ArcadeGameModel:getDifficulty()
	return self._difficulty
end

function ArcadeGameModel:getCurAreaIndex()
	return self._curAreaIndex or 0
end

function ArcadeGameModel:getTransferNodeIndex()
	return self._transferNodeIndex or 0
end

function ArcadeGameModel:getLevelCount()
	local curLevelIndex = 0
	local totalLevelCount = 0
	local curAreaIndex = self:getCurAreaIndex()
	local diff = self:getDifficulty()
	local areaList = ArcadeConfig.instance:getDifficultyAreaList(diff)

	for i, areaId in ipairs(areaList) do
		local nodeCount = ArcadeConfig.instance:getAreaNodeCount(areaId)
		local areaLevelCount = nodeCount + 1

		totalLevelCount = totalLevelCount + areaLevelCount

		if i < curAreaIndex then
			curLevelIndex = curLevelIndex + areaLevelCount
		end
	end

	local curNodeIndex = self:getTransferNodeIndex()

	curLevelIndex = curLevelIndex + curNodeIndex + 1

	return totalLevelCount, curLevelIndex
end

function ArcadeGameModel:getCurRoomId()
	return self._curRoomId
end

function ArcadeGameModel:getIsChangingRoom()
	self._isChangingRoom = true
end

function ArcadeGameModel:getRoomPortalIdList()
	local difficulty = self:getDifficulty()
	local curAreaIndex = self:getCurAreaIndex()
	local areaId = ArcadeConfig.instance:getDifficultyAreaIdByIndex(difficulty, curAreaIndex)
	local curNodeIndex = self:getTransferNodeIndex()
	local nextNodeIndex = curNodeIndex + 1
	local nodeCount = ArcadeConfig.instance:getAreaNodeCount(areaId)
	local portalIdList = {}

	if nextNodeIndex <= nodeCount then
		portalIdList = ArcadeConfig.instance:getPortalList(areaId, nextNodeIndex)
	else
		local nextAreaIndex = curAreaIndex + 1
		local nextAreaId = ArcadeConfig.instance:getDifficultyAreaIdByIndex(difficulty, nextAreaIndex)

		if nextAreaId then
			local areaPortalId = ArcadeConfig.instance:getArcadeConst(ArcadeEnum.ConstId.AreaPortalId, true)

			portalIdList = {
				areaPortalId
			}
		end
	end

	return portalIdList
end

function ArcadeGameModel:getIsPlayerTurn()
	return self._isPlayerTurn
end

function ArcadeGameModel:getIsPauseGame()
	return self._isPauseGame
end

function ArcadeGameModel:getIsEndGame()
	return self._isEndGame
end

function ArcadeGameModel:getMOWithType(entityType, uid)
	if not entityType and not uid then
		return
	end

	if entityType == ArcadeGameEnum.EntityType.Character then
		return self:getCharacterMO()
	elseif entityType == ArcadeGameEnum.EntityType.Grid then
		return (self._gridModel:getById(uid))
	else
		local dict = self._moDict[entityType]

		return dict and dict[uid]
	end
end

function ArcadeGameModel:getCharacterMO()
	return self._arcadeGameCharacterMO
end

function ArcadeGameModel:getGridMOByXY(gridX, gridY)
	local gridId = ArcadeGameHelper.getGridId(gridX, gridY)
	local gridMO = self._gridModel:getById(gridId)

	if not gridMO then
		gridMO = ArcadeGameFloorGridMO.New(gridX, gridY)

		self._gridModel:addAtLast(gridMO)
	end

	return gridMO
end

function ArcadeGameModel:getGridMOList()
	return self._gridModel:getList()
end

function ArcadeGameModel:getEntityMOList(entityType)
	local list

	if entityType == ArcadeGameEnum.EntityType.Grid then
		list = self:getGridMOList()
	elseif entityType == ArcadeGameEnum.EntityType.Character then
		local characterMO = self:getCharacterMO()

		list = {
			characterMO
		}
	else
		list = self._moList[entityType]
	end

	return list
end

function ArcadeGameModel:getEntityUidList(entityType)
	local result = {}
	local list = self:getEntityMOList(entityType)

	if list then
		for i, mo in ipairs(list) do
			result[i] = mo:getUid()
		end
	end

	return result
end

function ArcadeGameModel:getMonsterList()
	return self:getEntityMOList(ArcadeGameEnum.EntityType.Monster)
end

function ArcadeGameModel:getMaxScore()
	return self._maxScore or 0
end

function ArcadeGameModel:getPassLevelCount()
	return self._passLevel or 0
end

function ArcadeGameModel:getKillMonsterNum()
	return self._killMonsterNum or 0
end

function ArcadeGameModel:getAllCoinNum()
	return self._allCoinNum or 0
end

function ArcadeGameModel:getGameAttribute(attrId)
	if not self._gameAttributeDict[attrId] then
		if not self._gameTempAttrDict[attrId] then
			local temp = 0

			return self._gameAttributeDict[attrId] + temp
		end
	end
end

function ArcadeGameModel:getGameAttrNoTemp(attrId)
	return self._gameAttributeDict[attrId] or 0
end

function ArcadeGameModel:getExtraMonsterCount()
	local roomId = self:getCurRoomId()
	local roomType = ArcadeConfig.instance:getRoomType(roomId)

	return (roomType == ArcadeGameEnum.RoomType.Normal or roomType == ArcadeGameEnum.RoomType.Elite or nil) and self:getGameAttribute(ArcadeGameEnum.GameAttribute.ExtraMonster)
end

function ArcadeGameModel:getGameSwitchIsOn(attrId)
	return not not self._gameSwitchDict[attrId]
end

function ArcadeGameModel:getGoodsHasResetTimes()
	return self._goodsHasResetTimes or 0
end

function ArcadeGameModel:getIsCanResetGoods()
	local isChangingRoom = self:getIsChangingRoom()
	local isGamePause = self:getIsPauseGame()

	if isChangingRoom or isGamePause then
		return false
	end

	local roomId = self:getCurRoomId()
	local roomType = ArcadeConfig.instance:getRoomType(roomId)
	local isOpenReset = self:getGameSwitchIsOn(ArcadeGameEnum.GameSwitch.CanResetStore)
	local canResetTimes = ArcadeConfig.instance:getArcadeConst(ArcadeEnum.ConstId.StoreRoomResetTimes, true)
	local haveResetTimes = self:getGoodsHasResetTimes()
	local characterMO = self:getCharacterMO()
	local hasCoin = characterMO and characterMO:getResourceCount(ArcadeGameEnum.CharacterResource.GameCoin) or 0
	local resetCost = self:getGameAttribute(ArcadeGameEnum.GameAttribute.ResetStoreCost)

	if roomType ~= ArcadeGameEnum.RoomType.Store or not isOpenReset or canResetTimes <= haveResetTimes or hasCoin < resetCost then
		return false
	end

	return true
end

function ArcadeGameModel:getUnlockCharacterDict()
	return self._unlockCharacterDict
end

function ArcadeGameModel:getUnlockHandBookDict()
	return self._unlockHandBookDict
end

function ArcadeGameModel:getNegativeOperationRound()
	return self._negativeRound or 0
end

function ArcadeGameModel:getNearEventEntity()
	return self._eventEntityType, self._eventEntityUid
end

function ArcadeGameModel:getPortalExtractionCount(portalId)
	return self._portalExtractDict[portalId] or 0
end

function ArcadeGameModel:getPortalExtractDict()
	local result = {}

	if self._portalExtractDict then
		for portalId, count in pairs(self._portalExtractDict) do
			result[tostring(portalId)] = count
		end
	end

	return result
end

function ArcadeGameModel:onExitArcadeGame()
	self:clearAllData()
end

ArcadeGameModel.instance = ArcadeGameModel.New()

return ArcadeGameModel
