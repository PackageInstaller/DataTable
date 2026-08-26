-- chunkname: @modules/logic/sp02/dungeonmap/model/AtomicDungeonModel.lua

module("modules.logic.sp02.dungeonmap.model.AtomicDungeonModel", package.seeall)

local AtomicDungeonModel = class("AtomicDungeonModel", BaseModel)

function AtomicDungeonModel:onInit()
	self:reInit()
end

function AtomicDungeonModel:reInit()
	self.finishElementMap = {}
	self.curInElementId = 0
	self.mapInfoTab = {}
	self.polygonInfoTab = {}
	self.newElementList = {}
	self.curElementMoTab = {}
	self.elementFightParam = nil
	self.curFightEpisodeId = nil
	self.isInMapSelectState = true
	self.curMapId = nil
	self.isDraggingMap = false
	self.arenaInfoTab = {}
	self.unlockProgressInfoTab = {}
	self.showTipToastList = {}
	self.showRewardToastList = {}
	self.showTipToastElementMap = {}
	self.fightResultData = nil
	self.canClickElement = true
	self.storyOptionParam = nil
	self.polygonFightParam = nil
	self.needPopupCommonProState = false
	self.newUnlockMapList = {}
	self.newUnlockDataBaseList = {}
	self.gmCurMapId = 0
	self.keyElementLocalDataMap = {}
	self.curKeyElementMap = {}
	self.hardFightElementMoTab = {}
	self.needPlayPolygonEnterFinish = false
end

function AtomicDungeonModel:updateInfo(info)
	self:updateOutsideInfo(info.outsideInfo)
	self:updateMapInfo(info.mapInfo)
	self:updatePolygonInfo(info.polygonInfo)
end

function AtomicDungeonModel:updateOutsideInfo(info)
	local arenaCoList = AtomicDungeonConfig.instance:getAllArenaConfigList()

	if #info.arenaInfos == 0 then
		for _, config in ipairs(arenaCoList) do
			local initData = {
				currentAlarm = 0,
				oldAlarm = 0,
				arenaId = config.arenaId
			}

			self:initArenaInfo(initData)
		end
	else
		for _, infoData in ipairs(info.arenaInfos) do
			self:initArenaInfo(infoData)
		end
	end

	if #info.unlockProgresses == 0 then
		for _, config in ipairs(arenaCoList) do
			local arenaUnlockSeqList = AtomicDungeonConfig.instance:getArenaUnlockSeqList(config.arenaId)

			for _, mapId in ipairs(arenaUnlockSeqList) do
				local initData = {
					finishConditionCount = 0,
					mapId = mapId
				}

				self:initUnlockProgressInfo(initData)
			end
		end
	else
		for _, infoData in ipairs(info.unlockProgresses) do
			self:initUnlockProgressInfo(infoData)
		end
	end
end

function AtomicDungeonModel:initArenaInfo(info)
	local arenaInfo = self.arenaInfoTab[info.arenaId]

	arenaInfo = arenaInfo or {}
	arenaInfo.arenaId = info.arenaId
	arenaInfo.currentAlarm = info.currentAlarm or 0
	self.arenaInfoTab[info.arenaId] = arenaInfo
end

function AtomicDungeonModel:initUnlockProgressInfo(info)
	local progressInfo = self.unlockProgressInfoTab[info.mapId]

	progressInfo = progressInfo or {}
	progressInfo.mapId = info.mapId
	progressInfo.finishConditionCount = info.finishConditionCount or 0
	self.unlockProgressInfoTab[info.mapId] = progressInfo
end

function AtomicDungeonModel:updateMapInfo(mapInfo)
	self:setCurInElementId(mapInfo.currEleId)
	self:setMapData(mapInfo.maps)
	self:setAllElementInfo(mapInfo.elements)
end

function AtomicDungeonModel:updatePolygonInfo(info)
	for index, polygonInfo in ipairs(info.polygons) do
		local polygonMo = self.polygonInfoTab[polygonInfo.id]

		if not polygonMo then
			polygonMo = AtomicDungeonPolygonMo.New()

			polygonMo:init(polygonInfo.id)

			self.polygonInfoTab[polygonInfo.id] = polygonMo
		end

		polygonMo:updateInfo(polygonInfo)
	end
end

function AtomicDungeonModel:getPolygonMo(polygonId)
	return self.polygonInfoTab[polygonId]
end

function AtomicDungeonModel:getPolygonInfoTab()
	return self.polygonInfoTab
end

function AtomicDungeonModel:getArenaInfo(curArenaId)
	if not self.arenaInfoTab[curArenaId] then
		self.arenaInfoTab[curArenaId] = {}
		self.arenaInfoTab[curArenaId].arenaId = curArenaId
		self.arenaInfoTab[curArenaId].currentAlarm = 0
	end

	return self.arenaInfoTab[curArenaId]
end

function AtomicDungeonModel:getUnlockProgressInfo(curMapId)
	return self.unlockProgressInfoTab[curMapId]
end

function AtomicDungeonModel:updateAlarmPush(info)
	local arenaInfo = self.arenaInfoTab[info.arenaId]

	if arenaInfo then
		arenaInfo.oldAlarm = info.oldAlarm
		arenaInfo.currentAlarm = info.newAlarm
	else
		logError("更新警戒值失败，请检查本地信息：" .. info.arenaId)
	end
end

function AtomicDungeonModel:getCurArenaInfoData()
	local curmMapId = self:getCurMapId()
	local mapConfig = AtomicDungeonConfig.instance:getDungeonMapConfig(curmMapId)

	return self:getArenaInfo(mapConfig.arenaId)
end

function AtomicDungeonModel:getCurAlarmLevel()
	local alarmLevelUpValue = AtomicConfig.instance:getConstValue(AtomicEnum.ConstId.AlarmLevelUpValue, true)
	local maxAlarmLevel = AtomicConfig.instance:getConstValue(AtomicEnum.ConstId.MaxAlarmLevel, true)
	local curArenaInfo = self:getCurArenaInfoData()

	if curArenaInfo then
		local curAlarmLevel = Mathf.Floor((curArenaInfo.currentAlarm or 0) / alarmLevelUpValue)

		return Mathf.Clamp(curAlarmLevel, 0, maxAlarmLevel)
	end
end

function AtomicDungeonModel:getOldAlarmLevel()
	local alarmLevelUpValue = AtomicConfig.instance:getConstValue(AtomicEnum.ConstId.AlarmLevelUpValue, true)
	local maxAlarmLevel = AtomicConfig.instance:getConstValue(AtomicEnum.ConstId.MaxAlarmLevel, true)
	local oldAlarm = self:getOldAlarm()
	local oldAlarmLevel = Mathf.Floor(oldAlarm / alarmLevelUpValue)

	return Mathf.Clamp(oldAlarmLevel, 0, maxAlarmLevel)
end

function AtomicDungeonModel:setOldAlarmValue()
	local curArenaInfo = self:getCurArenaInfoData()

	if curArenaInfo then
		curArenaInfo.oldAlarm = curArenaInfo.currentAlarm or 0
	end
end

function AtomicDungeonModel:getOldAlarm()
	local curArenaInfo = self:getCurArenaInfoData()

	return (curArenaInfo and curArenaInfo.oldAlarm or nil) and (curArenaInfo.oldAlarm or curArenaInfo.currentAlarm)
end

function AtomicDungeonModel:setCurInElementId(elementId)
	self.curInElementId = elementId
end

function AtomicDungeonModel:getCurInElementId()
	return self.curInElementId
end

function AtomicDungeonModel:getCurElementInMapId()
	local elementCo = AtomicDungeonConfig.instance:getElementConfig(self.curInElementId)

	return (elementCo or nil) and (elementCo.mapId or self:getDefaultMapId())
end

function AtomicDungeonModel:setMapData(mapsInfo, isPush)
	for index, mapInfo in ipairs(mapsInfo) do
		local mapMo = self.mapInfoTab[mapInfo.id]

		if not mapMo then
			mapMo = AtomicDungeonMapMo.New()

			mapMo:init(mapInfo.id)

			self.mapInfoTab[mapInfo.id] = mapMo

			if isPush then
				table.insert(self.newUnlockMapList, mapInfo.id)
			end
		end

		mapMo:updateInfo(mapInfo)
	end
end

function AtomicDungeonModel:getMapInfo(mapId)
	return self.mapInfoTab[mapId]
end

function AtomicDungeonModel:getNewUnlockMapList()
	return self.newUnlockMapList
end

function AtomicDungeonModel:cleanNewUnlockMapList()
	self.newUnlockMapList = {}
end

function AtomicDungeonModel:checkNewUnlockDungeonMap()
	local newUnlockMapList = self:getNewUnlockMapList()

	if #newUnlockMapList == 0 then
		return false
	end

	local curMapId = self:getCurMapId()
	local newUnlockMapId = newUnlockMapList[#newUnlockMapList]

	if curMapId == newUnlockMapId then
		self:cleanNewUnlockMapList()

		return false
	end

	local newUnlockMapCo = AtomicDungeonConfig.instance:getDungeonMapConfig(newUnlockMapId)
	local newUnlockMapInfoCo = AtomicDungeonConfig.instance:getMapInfoConfig(newUnlockMapCo.infoId)

	if newUnlockMapInfoCo.type == AtomicDungeonEnum.MapType.Puzzle then
		self:cleanNewUnlockMapList()

		return false
	end

	return true
end

function AtomicDungeonModel:setAllElementInfo(elementInfos)
	for _, elementInfo in ipairs(elementInfos) do
		self:updateElementInfo(elementInfo)
	end
end

function AtomicDungeonModel:updateElementInfo(elementInfo)
	local elementMo = self.curElementMoTab[elementInfo.id]

	if not elementMo then
		elementMo = AtomicElementMo.New()

		elementMo:init(elementInfo.id)

		self.curElementMoTab[elementInfo.id] = elementMo
	end

	elementMo:updateInfo(elementInfo)

	if elementMo.status == AtomicDungeonEnum.ElementStatus.Delete then
		local mapId = elementMo.config.mapId
		local arenaId = AtomicDungeonConfig.instance:getDungeonMapId(mapId)

		self.curElementMoTab[elementMo.id] = nil
		self.hardFightElementMoTab[arenaId] = nil
		self.finishElementMap[elementMo.id] = nil

		return
	end

	if elementMo.status == AtomicDungeonEnum.ElementStatus.Finish then
		self.finishElementMap[elementInfo.id] = true
	end

	if elementMo:checkIsHardFightElement() then
		local mapId = elementMo.config.mapId
		local arenaId = AtomicDungeonConfig.instance:getDungeonMapId(mapId)

		if elementMo.status == AtomicDungeonEnum.ElementStatus.Delete or elementMo.status == AtomicDungeonEnum.ElementStatus.Finish then
			self.curElementMoTab[elementMo.id] = nil
			self.hardFightElementMoTab[arenaId] = nil
			self.finishElementMap[elementMo.id] = nil
		else
			self.hardFightElementMoTab[arenaId] = elementMo
		end
	end
end

function AtomicDungeonModel:getElementMo(elementId)
	return self.curElementMoTab[elementId]
end

function AtomicDungeonModel:isElementFinish(elementId)
	return self.finishElementMap[elementId]
end

function AtomicDungeonModel:getHardFightElementMo(mapId)
	local arenaId = AtomicDungeonConfig.instance:getDungeonMapId(mapId)
	local hardFightElementMo = self.hardFightElementMoTab[arenaId]

	if hardFightElementMo and hardFightElementMo.status == AtomicDungeonEnum.ElementStatus.Delete then
		self.curElementMoTab[hardFightElementMo.id] = nil
		self.hardFightElementMoTab[arenaId] = nil
	end

	return hardFightElementMo
end

function AtomicDungeonModel:getNewElementList()
	return self.newElementList
end

function AtomicDungeonModel:cleanNewElements()
	self.newElementList = {}
	self.showTipToastElementMap = {}
end

function AtomicDungeonModel:addNewElement(elementInfos)
	for _, elementInfo in ipairs(elementInfos) do
		if elementInfo.status == AtomicDungeonEnum.ElementStatus.Normal then
			local elementCo = AtomicDungeonConfig.instance:getElementConfig(elementInfo.id)

			if (elementCo.type ~= AtomicDungeonEnum.ElementType.DataBase and elementCo.isEmergency ~= 1 or elementCo.type == AtomicDungeonEnum.ElementType.DataBase and tonumber(elementCo.parm) ~= 0 or elementCo.isEmergency == 1 and not self.curElementMoTab[elementInfo.id]) and not elementCo.canDisappear then
				table.insert(self.newElementList, elementCo)
			end
		end
	end

	self:addNewKeyElement()
end

function AtomicDungeonModel:getCurAllElementCoList(mapId)
	local curElementsList = {}

	for elementId, elementMo in pairs(self.curElementMoTab) do
		if self:checkElementCanShow(mapId, elementId) then
			table.insert(curElementsList, elementMo.config)
		end
	end

	return curElementsList
end

function AtomicDungeonModel:checkElementCanShow(mapId, elementId)
	local isElementFinish = self:isElementFinish(elementId)
	local elementMo = self.curElementMoTab[elementId]

	if elementMo and (elementMo.status == AtomicDungeonEnum.ElementStatus.Delete or elementMo:checkIsHardFightElement()) then
		return false
	end

	if elementMo and elementMo.config and elementMo.config.mapId == mapId then
		if elementMo:isExpired() then
			return false
		end

		if elementMo.config.type == AtomicDungeonEnum.ElementType.DataBase and tonumber(elementMo.config.parm) ~= 1 then
			return false
		end

		return elementMo.config.isPermanent == 1 or not isElementFinish
	end

	return false
end

function AtomicDungeonModel:setLastElementFightParam(param)
	self.elementFightParam = {}
	self.elementFightParam.lastEpisodeId = param.episodeId
	self.elementFightParam.lastElementId = param.elementId

	self:setCurFightEpisodeId(param.episodeId)
end

function AtomicDungeonModel:getLastElementFightParam()
	return self.elementFightParam
end

function AtomicDungeonModel:cleanLastElementFightParam()
	self.elementFightParam = nil
end

function AtomicDungeonModel:setLastPolygonFightParam(param)
	self.polygonFightParam = {}
	self.polygonFightParam.episodeId = param.episodeId
	self.polygonFightParam.polygonId = param.polygonId
	self.polygonFightParam.hardIndex = param.hardIndex
	self.polygonFightParam.mapId = param.mapId
	self.polygonFightParam.isInMapSelectState = param.isInMapSelectState

	self:setCurFightEpisodeId(param.episodeId)
end

function AtomicDungeonModel:getLastPolygonFightParam()
	return self.polygonFightParam
end

function AtomicDungeonModel:cleanLastPolygonFightParam()
	self.polygonFightParam = nil
end

function AtomicDungeonModel:setFightResultData(info)
	self.fightResultData = {}
	self.fightResultData.fightType = info.fightType
	self.fightResultData.episodeId = info.episodeId

	self:updateElementInfo(info.element)

	self.fightResultData.bonuseList = {}

	for index, materialData in ipairs(info.bonuses) do
		local MaterialDataMO = MaterialDataMO.New()

		MaterialDataMO:init(materialData)
		table.insert(self.fightResultData.bonuseList, MaterialDataMO)
	end

	self.fightResultData.result = info.result
end

function AtomicDungeonModel:cleanFightResultData()
	self.fightResultData = nil
end

function AtomicDungeonModel:getFightResultData()
	return self.fightResultData
end

function AtomicDungeonModel:setCurFightEpisodeId(episodeId)
	self.curFightEpisodeId = episodeId
end

function AtomicDungeonModel:getCurFightEpisodeId()
	return self.curFightEpisodeId
end

function AtomicDungeonModel:setIsMapSelect(state)
	self.isInMapSelectState = state
end

function AtomicDungeonModel:getIsInMapSelectState()
	return self.isInMapSelectState
end

function AtomicDungeonModel:getIsInPolygonState(mapId)
	local curMapId = mapId or self:getCurMapId()
	local mapConfig = AtomicDungeonConfig.instance:getDungeonMapConfig(curMapId)
	local mapInfoConfig = AtomicDungeonConfig.instance:getMapInfoConfig(mapConfig.infoId)

	return mapInfoConfig and mapInfoConfig.type == AtomicDungeonEnum.MapType.Polygon
end

function AtomicDungeonModel:setCurMapId(mapId)
	self.curMapId = mapId
end

function AtomicDungeonModel:getCurMapId()
	if not self.curMapId and self.fightResultData and self.fightResultData.episodeId and self.fightResultData.episodeId > 0 then
		self.curMapId = AtomicController.instance:getPlayerPrefs(AtomicDungeonEnum.LocalPrefsKey.CurFightMapId, self:getDefaultMapId())

		if self.polygonFightParam and self.polygonFightParam.isInMapSelectState then
			self:setIsMapSelect(true)
		else
			self:setIsMapSelect(false)
		end
	end

	return self.curMapId or self:getDefaultMapId()
end

function AtomicDungeonModel:getMapIdByEpisodeId(episodeId)
	local fightElementCoList = AtomicDungeonConfig.instance:getFightElementCoList()

	for _, fightElementCo in ipairs(fightElementCoList) do
		if fightElementCo.episodeId == episodeId then
			local elementCo = AtomicDungeonConfig.instance:getElementConfig(fightElementCo.id)

			return elementCo.mapId
		end
	end
end

function AtomicDungeonModel:getMapInfoId(curMapId)
	local mapConfig = AtomicDungeonConfig.instance:getDungeonMapConfig(curMapId)

	return mapConfig.infoId
end

function AtomicDungeonModel:setDraggingMapState(isDragging)
	self.isDraggingMap = isDragging
end

function AtomicDungeonModel:getDraggingMapState()
	return self.isDraggingMap
end

function AtomicDungeonModel:setCanClickElementState(state)
	self.canClickElement = state
end

function AtomicDungeonModel:getCanClickElementState()
	return self.canClickElement
end

function AtomicDungeonModel:checkConditionCanUnlock(conditionStr)
	local canUnlock = true

	if string.nilorempty(conditionStr) then
		return canUnlock
	end

	local unlockInfoParam = {}
	local unlockConditionList = GameUtil.splitString2(conditionStr)

	for index, conditionData in ipairs(unlockConditionList) do
		if conditionData[1] == AtomicDungeonEnum.ConditionType.Finish then
			if not self:isElementFinish(tonumber(conditionData[2])) then
				canUnlock = false
			end

			unlockInfoParam = {
				type = conditionData[1],
				elementId = tonumber(conditionData[2])
			}
		elseif conditionData[1] == AtomicDungeonEnum.ConditionType.Explore then
			local mapId = tonumber(conditionData[2])
			local mapMo = self:getMapInfo(mapId)

			if not mapMo or mapMo and mapMo.exploreValue < tonumber(conditionData[3]) then
				canUnlock = false
			end

			local var_59_0 = {
				type = conditionData[1]
			}

			if mapMo then
				var_59_0.exploreValue = mapMo.exploreValue or 0
			end

			unlockInfoParam = var_59_0
		end

		if not canUnlock then
			break
		end
	end

	return canUnlock, unlockInfoParam
end

function AtomicDungeonModel:checkPolygonUnlock(mapId)
	local arenaMapConfig = AtomicDungeonConfig.instance:getDungeonMapConfig(mapId)
	local polygonId = AtomicDungeonConfig.instance:getPolygonIdByArenaMapId(arenaMapConfig.arenaId)
	local mapConfig = AtomicDungeonConfig.instance:getDungeonMapConfig(polygonId)
	local mapInfoMo = self:getMapInfo(polygonId)

	if not string.nilorempty(mapConfig.unlockCondition) then
		local canUnlock, unlockInfoParam = self:checkConditionCanUnlock(mapConfig.unlockCondition)

		return (mapInfoMo or nil) and true, unlockInfoParam
	end

	return true
end

function AtomicDungeonModel:getPolygonEnterCoData(mapId)
	local arenaId = AtomicDungeonConfig.instance:getDungeonMapId(mapId)
	local polygonEnterCo = AtomicDungeonConfig.instance:getPolygonEnterConfig(arenaId)
	local polygonEnterData = {}

	polygonEnterData.id = polygonEnterCo.id
	polygonEnterData.name = polygonEnterCo.name
	polygonEnterData.pos = polygonEnterCo.pos
	polygonEnterData.unlockCondition = polygonEnterCo.unlockCondition
	polygonEnterData.icon = polygonEnterCo.icon
	polygonEnterData.mapId = polygonEnterCo.mapId
	polygonEnterData.type = AtomicDungeonEnum.ElementType.PolygonEnter
	polygonEnterData.isPolygonEnter = true
	polygonEnterData.needFollow = 1
	polygonEnterData.isPermanent = 0

	return polygonEnterData
end

function AtomicDungeonModel:getPolygonDiffResult(polygonId)
	local polygonMo = self:getPolygonMo(polygonId)

	return polygonMo and polygonMo:getCurPassDiff() or 0
end

function AtomicDungeonModel:checkCanShowPolygon(mapId)
	local mapConfig = AtomicDungeonConfig.instance:getDungeonMapConfig(mapId)
	local mapInfoConfig = AtomicDungeonConfig.instance:getMapInfoConfig(mapConfig.infoId)
	local polygonId = mapId

	if mapInfoConfig.type == AtomicDungeonEnum.MapType.Normal then
		polygonId = AtomicDungeonConfig.instance:getPolygonIdByArenaMapId(mapConfig.arenaId)
	end

	local polygonMo = self:getPolygonMo(polygonId)
	local polygonConfig = AtomicDungeonConfig.instance:getPolygonConfig(polygonId)
	local canUnlock, unlockInfoParam = self:checkConditionCanUnlock(polygonConfig.unlockCondition)

	return (polygonMo or nil) and true, unlockInfoParam
end

function AtomicDungeonModel:isHaveUnlockPolygon()
	local polygonCoList = AtomicDungeonConfig.instance:getAllPolygonCoList()

	for index, polygonCo in ipairs(polygonCoList) do
		local canShow = self:checkCanShowPolygon(polygonCo.id)

		if canShow then
			return true
		end
	end

	return false
end

function AtomicDungeonModel:setStoryOptionParam(param)
	self.storyOptionParam = param
end

function AtomicDungeonModel:getStoryOptionParam()
	return self.storyOptionParam
end

function AtomicDungeonModel:getPolygonProgress(isBackSub)
	local progress = 0
	local polygonCoList = AtomicDungeonConfig.instance:getAllPolygonCoList()
	local dataList = isBackSub and {} or nil

	for i, v in ipairs(polygonCoList) do
		local polygonMo = self:getPolygonMo(v.id)
		local curProgress = polygonMo and polygonMo:getCurPassDiff() or 0

		if isBackSub then
			local diffList = AtomicDungeonConfig.instance:getAllPolygonDiffCoList(v.id)
			local data = {}

			data.curProgress = curProgress
			data.totalProgress = #diffList
			data.name = v.name

			table.insert(dataList, data)
		end

		progress = progress + curProgress
	end

	return progress, dataList
end

function AtomicDungeonModel:setShowTipToastElementId(elementId)
	self.showTipToastElementMap[elementId] = true
end

function AtomicDungeonModel:checkTipToastElementHasShow(elementId)
	return self.showTipToastElementMap[elementId]
end

function AtomicDungeonModel:cleanTipToastList()
	self.showTipToastList = {}
end

function AtomicDungeonModel:setNeedPopupCommonProState(need)
	self.needPopupCommonProState = need
end

function AtomicDungeonModel:getNeedPopupCommonProViewState()
	return self.needPopupCommonProState
end

function AtomicDungeonModel:checkElementInNewList(elementId)
	for index, elementCo in ipairs(self.newElementList) do
		if elementCo.id == elementId then
			return true
		end
	end

	return false
end

function AtomicDungeonModel:getAlarmRuleList()
	local curAlarmLevel = self:getCurAlarmLevel()

	if curAlarmLevel <= 0 then
		return {}
	end

	local constId = AtomicEnum.ConstId["AdditionRule" .. curAlarmLevel]
	local additionRule = AtomicConfig.instance:getConstValue(constId)

	if string.nilorempty(additionRule) then
		return {}
	end

	return (FightStrUtil.instance:getSplitString2Cache(additionRule, true, "|", "#"))
end

function AtomicDungeonModel:checkTalentUnlock()
	local constStr = AtomicConfig.instance:getConstValue(AtomicEnum.ConstId.TalentUnlock)
	local elementList = string.splitToNumber(constStr, "#")

	for index, elementId in ipairs(elementList) do
		if not self:isElementFinish(elementId) then
			return false
		end
	end

	return true
end

function AtomicDungeonModel:setGMCurMapId(mapId)
	local mapInfo = self:getMapInfo(mapId)

	if not mapInfo and mapId > 0 then
		logError("未获取该地图信息，请进入外围后解锁所有地图使用")
	end

	self.gmCurMapId = mapId
end

function AtomicDungeonModel:getMapIdByArenaMapId(arenaMapId)
	if self.gmCurMapId > 0 then
		local gmArenaMapId = AtomicDungeonConfig.instance:getDungeonMapId(self.gmCurMapId)

		if gmArenaMapId == arenaMapId then
			return self.gmCurMapId
		end
	end

	local mapInfoConfig = AtomicDungeonConfig.instance:getMapInfoConfig(arenaMapId)
	local mapIdList = AtomicDungeonConfig.instance:getArenaUnlockSeqList((mapInfoConfig.type == AtomicDungeonEnum.MapType.Polygon or nil) and AtomicDungeonConfig.instance:getArenaMapIdByPolygonMapId(arenaMapId))
	local curMapId = 0

	for _, mapId in ipairs(mapIdList) do
		local mapInfo = self:getMapInfo(mapId)

		if not mapInfo then
			break
		end

		local mapConfig = AtomicDungeonConfig.instance:getDungeonMapConfig(mapId)
		local mapInfoConfig = AtomicDungeonConfig.instance:getMapInfoConfig(mapConfig.infoId)

		if mapInfoConfig.type == AtomicDungeonEnum.MapType.Normal then
			curMapId = mapInfo.id
		end
	end

	if curMapId == 0 then
		return self:getDefaultMapId(arenaMapId)
	end

	return curMapId
end

function AtomicDungeonModel:getDefaultMapId(arenaMapId)
	local curArenaMapId = arenaMapId or 1
	local defaultMapIdList = AtomicDungeonConfig.instance:getArenaUnlockSeqList(curArenaMapId)

	return defaultMapIdList[1]
end

function AtomicDungeonModel:checkArenaMapIsPolygon(arenaMapId)
	local mapInfoCo = AtomicDungeonConfig.instance:getMapInfoConfig(arenaMapId)

	return mapInfoCo.type == AtomicDungeonEnum.MapType.Polygon
end

function AtomicDungeonModel:getPreMapUnFinishDataBaseAndEmergencyElementList()
	local isInPolygonState = self:getIsInPolygonState()

	if isInPolygonState then
		return {}
	end

	local curMapId = self:getCurMapId()
	local mapConfig = AtomicDungeonConfig.instance:getDungeonMapConfig(curMapId)
	local mapIdList = AtomicDungeonConfig.instance:getArenaUnlockSeqList(mapConfig.arenaId)
	local needShowElementList = {}

	for index, mapId in ipairs(mapIdList) do
		local elementCoList = self:getCurAllElementCoList(mapId)

		for _, elementCo in ipairs(elementCoList) do
			if elementCo.type == AtomicDungeonEnum.ElementType.DataBase and elementCo.dataBase > 0 and tonumber(elementCo.parm) == 1 then
				table.insert(needShowElementList, elementCo.id)
			end

			if elementCo.isEmergency == 1 then
				local elementMo = self:getElementMo(elementCo.id)

				if elementMo and elementMo:showEmergency() then
					table.insert(needShowElementList, elementCo.id)
				end
			end
		end

		if mapId == curMapId then
			break
		end
	end

	return needShowElementList
end

function AtomicDungeonModel:getCurArenaMapProgress(arenaMapId)
	local curMapId = self:getMapIdByArenaMapId(arenaMapId)
	local curMapAllElementCoList = AtomicDungeonConfig.instance:getMapAllElementCoList(curMapId)
	local progressElementCoList = {}

	for index, elementCo in ipairs(curMapAllElementCoList) do
		if elementCo.type ~= AtomicDungeonEnum.ElementType.DataBase and elementCo.isEmergency ~= 1 and not elementCo.canDisappear then
			table.insert(progressElementCoList, elementCo)
		end
	end

	if #progressElementCoList == 0 then
		return 0, 0, 1
	end

	local alarmLevelUpValue = AtomicConfig.instance:getConstValue(AtomicEnum.ConstId.AlarmLevelUpValue, true)
	local eachElemenetExplore = alarmLevelUpValue / #progressElementCoList
	local mapIdList = AtomicDungeonConfig.instance:getArenaUnlockSeqList(arenaMapId)
	local curMapIndex = tabletool.indexOf(mapIdList, curMapId)
	local nextMapIndex = Mathf.Min(curMapIndex + 1, #mapIdList)
	local nextMapId = mapIdList[nextMapIndex]
	local nextMapConfig = AtomicDungeonConfig.instance:getDungeonMapConfig(nextMapId)
	local unlockConditionList = GameUtil.splitString2(nextMapConfig.unlockCondition)
	local unlockTargetExplore = 0

	for _, conditionData in ipairs(unlockConditionList) do
		if conditionData[1] == AtomicDungeonEnum.ConditionType.Explore then
			unlockTargetExplore = tonumber(conditionData[3])

			break
		end
	end

	local needFinishCount = Mathf.Ceil(unlockTargetExplore / eachElemenetExplore)
	local curFinishCount = 0

	for _, elementCo in ipairs(progressElementCoList) do
		if self:isElementFinish(elementCo.id) then
			curFinishCount = curFinishCount + 1
		end
	end

	return curFinishCount, needFinishCount, curMapIndex
end

function AtomicDungeonModel:setNewUnlockDataBaseList(unlockLibraryIds)
	for index, dataBaseId in ipairs(unlockLibraryIds) do
		table.insert(self.newUnlockDataBaseList, dataBaseId)
	end
end

function AtomicDungeonModel:getNewUnlockDataBaseList()
	return self.newUnlockDataBaseList
end

function AtomicDungeonModel:cleanNewUnlockDataBaseList()
	self.newUnlockDataBaseList = {}
end

function AtomicDungeonModel:getCurMapEmergencyElement()
	local curMapId = self:getCurMapId()
	local curMapAllElementCoList = AtomicDungeonConfig.instance:getMapAllElementCoList(curMapId)
	local preMapUnFinishDataBaseAndEmergencyElementList = self:getPreMapUnFinishDataBaseAndEmergencyElementList()

	for index, elementCo in ipairs(curMapAllElementCoList) do
		local elementMo = self:getElementMo(elementCo.id)

		if elementMo and elementCo.isEmergency == 1 and elementMo:showEmergency() then
			return elementCo
		end
	end

	for index, elementId in pairs(preMapUnFinishDataBaseAndEmergencyElementList) do
		local elementCo = AtomicDungeonConfig.instance:getElementConfig(elementId)
		local elementMo = self:getElementMo(elementCo.id)

		if elementMo and elementCo.isEmergency == 1 and elementMo:showEmergency() then
			return elementCo
		end
	end

	return nil
end

function AtomicDungeonModel:setKeyElementData(keyElementId, posX, posY)
	local keyElementData = self.keyElementLocalDataMap[keyElementId]

	if not keyElementData then
		keyElementData = {}

		local config = AtomicDungeonConfig.instance:getKeyElementConfig(keyElementId)
		local posList = not string.nilorempty(config.pos) and string.splitToNumber(config.pos, "#") or {
			0,
			0
		}

		keyElementData.posX = posList[1]
		keyElementData.posY = posList[2]
	end

	keyElementData.id = keyElementId
	keyElementData.posX = posX or keyElementData.posX
	keyElementData.posY = posY or keyElementData.posY
	self.keyElementLocalDataMap[keyElementId] = keyElementData
end

function AtomicDungeonModel:saveLocalKeyElementData()
	local keyElementDataList = {}

	for keyElementId, keyElementData in pairs(self.keyElementLocalDataMap) do
		table.insert(keyElementDataList, keyElementData)
	end

	local saveStr = cjson.encode(keyElementDataList)

	AtomicController.instance:setPlayerPrefs(AtomicDungeonEnum.LocalPrefsKey.PolygonKeyElementData, saveStr)
end

function AtomicDungeonModel:initLocalKeyElementData()
	local saveStr = AtomicController.instance:getPlayerPrefs(AtomicDungeonEnum.LocalPrefsKey.PolygonKeyElementData, "")

	if not string.nilorempty(saveStr) then
		local keyElementDataList = cjson.decode(saveStr)

		for _, keyElementData in ipairs(keyElementDataList) do
			self:setKeyElementData(keyElementData.id, keyElementData.posX, keyElementData.posY)
		end
	end
end

function AtomicDungeonModel:getKeyElementData(keyElementId)
	if not self.keyElementLocalDataMap[keyElementId] then
		self:setKeyElementData(keyElementId)
	end

	return self.keyElementLocalDataMap[keyElementId]
end

function AtomicDungeonModel:initKeyElementFinishState(mapId)
	local isInPolygonState = self:getIsInPolygonState(mapId)

	if not isInPolygonState then
		return
	end

	local keyElementCoList = AtomicDungeonConfig.instance:getMapKeyElementConfigList(mapId)

	for _, keyElementCo in ipairs(keyElementCoList) do
		self:checkKeyElementFinish(keyElementCo.id)
	end
end

function AtomicDungeonModel:checkKeyElementFinish(keyElementId)
	if not self:isElementFinish(keyElementId) then
		local keyElementConfig = AtomicDungeonConfig.instance:getKeyElementConfig(keyElementId)

		if keyElementConfig then
			local isKeyElementFinish = true
			local doorIdList = string.splitToNumber(keyElementConfig.doorIdList, "#")

			for _, doorId in ipairs(doorIdList) do
				local doorElementMo = self:getElementMo(doorId)

				if not doorElementMo or doorElementMo and not doorElementMo:getKeyElementDataPutState(keyElementId) then
					isKeyElementFinish = false

					break
				end
			end

			if isKeyElementFinish then
				self.finishElementMap[keyElementId] = true
			end
		end
	end

	return self:isElementFinish(keyElementId)
end

function AtomicDungeonModel:getCurCanShowKeyElementCoList(mapId)
	local canShowKeyElementCoList = {}
	local isInPolygonState = self:getIsInPolygonState(mapId)

	if not isInPolygonState then
		return canShowKeyElementCoList
	end

	local keyElementCoList = AtomicDungeonConfig.instance:getMapKeyElementConfigList(mapId)

	for _, keyElementCo in ipairs(keyElementCoList) do
		if self:checkKeyElementCanShow(keyElementCo.id) then
			table.insert(canShowKeyElementCoList, keyElementCo)
		end
	end

	return canShowKeyElementCoList
end

function AtomicDungeonModel:checkKeyElementCanShow(keyElementId)
	local keyElementCo = AtomicDungeonConfig.instance:getKeyElementConfig(keyElementId)
	local canUnlock = self:checkConditionCanUnlock(keyElementCo.unlockCondition)
	local isElementFinish = self:checkKeyElementFinish(keyElementCo.id)

	return not isElementFinish and canUnlock
end

function AtomicDungeonModel:initKeyElementMap()
	local keyElementCoList = AtomicDungeonConfig.instance:getAllKeyElementCoList()

	for _, keyElementCo in ipairs(keyElementCoList) do
		if self:checkConditionCanUnlock(keyElementCo.unlockCondition) then
			local elementMo = self.curKeyElementMap[keyElementCo.id]

			elementMo = elementMo or {
				id = keyElementCo.id,
				config = keyElementCo
			}

			if self:checkKeyElementFinish(keyElementCo.id) then
				elementMo.status = AtomicDungeonEnum.ElementStatus.Finish or AtomicDungeonEnum.ElementStatus.Normal
			end

			self.curKeyElementMap[keyElementCo.id] = elementMo

			self:setKeyElementData(keyElementCo.id)
		end
	end
end

function AtomicDungeonModel:getKeyElementMo(keyElementId)
	return self.curKeyElementMap[keyElementId]
end

function AtomicDungeonModel:addNewKeyElement()
	local isInPolygonState = self:getIsInPolygonState()

	if not isInPolygonState then
		return
	end

	local curMapId = self:getCurMapId()
	local canShowKeyElementCoList = self:getCurCanShowKeyElementCoList(curMapId)

	for _, keyElementCo in ipairs(canShowKeyElementCoList) do
		if not self.curKeyElementMap[keyElementCo.id] then
			table.insert(self.newElementList, keyElementCo)
		end
	end
end

function AtomicDungeonModel:getCurTouchElementId(curPosX, curPosY)
	local mapId = self:getCurMapId()
	local touchElementList = {}
	local isInPolygonState = self:getIsInPolygonState(mapId)

	if not isInPolygonState then
		return touchElementList
	end

	local curPosVector = Vector2(curPosX, curPosY)
	local curElementsList = self:getCurAllElementCoList(mapId)

	for _, elementCo in ipairs(curElementsList) do
		if not string.nilorempty(elementCo.pos) then
			local posData = string.splitToNumber(elementCo.pos, "#")

			if Vector2.Distance(curPosVector, Vector2(posData[1], posData[2])) <= AtomicDungeonEnum.PolygonElementTouchDistance then
				table.insert(touchElementList, elementCo.id)
			end
		end
	end

	return touchElementList
end

function AtomicDungeonModel:checkIsHardFightEpisode(episodeId)
	local hardFightEpisodeIdList = AtomicDungeonConfig.instance:getHardFightEpisodeIdList()

	return tabletool.indexOf(hardFightEpisodeIdList, episodeId)
end

function AtomicDungeonModel:setNeedPlayPolygonEnterFinish(state)
	self.needPlayPolygonEnterFinish = state
end

function AtomicDungeonModel:getNeedPlayPolygonEnterFinish()
	return self.needPlayPolygonEnterFinish
end

function AtomicDungeonModel:cleanEmergencyAddSeconds(elementList)
	for _, elementId in pairs(elementList) do
		local elementMo = self:getElementMo(elementId)

		if elementMo and elementMo.config.isEmergency == 1 then
			elementMo:cleanEmergencyAddSeconds()
		end
	end
end

function AtomicDungeonModel:getElementStatData(elementId)
	local statData = {}
	local elementConfig = AtomicDungeonConfig.instance:getElementConfig(elementId)

	elementConfig = elementConfig or AtomicDungeonConfig.instance:getKeyElementConfig(elementId)
	statData.mapId = self:getCurMapId()
	statData.elementId = elementConfig.id
	statData.elementType = elementConfig.type
	statData.alamrLevel = self:getCurAlarmLevel()

	return statData
end

function AtomicDungeonModel:getMapAllFinishElementIdList(mapId)
	local mapFinishElementIdList = {}
	local arenaId = AtomicDungeonConfig.instance:getDungeonMapId(mapId)

	for elementId, state in pairs(self.finishElementMap) do
		local elementConfig = AtomicDungeonConfig.instance:getElementConfig(elementId)

		elementConfig = elementConfig or AtomicDungeonConfig.instance:getKeyElementConfig(elementId)

		if elementConfig then
			local elementArenaId = AtomicDungeonConfig.instance:getDungeonMapId(elementConfig.mapId)

			if arenaId == elementArenaId then
				table.insert(mapFinishElementIdList, elementId)
			end
		end
	end

	return mapFinishElementIdList
end

AtomicDungeonModel.instance = AtomicDungeonModel.New()

return AtomicDungeonModel
