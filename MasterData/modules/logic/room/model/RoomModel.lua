-- chunkname: @modules/logic/room/model/RoomModel.lua

module("modules.logic.room.model.RoomModel", package.seeall)

local RoomModel = class("RoomModel", BaseModel)

function RoomModel:onInit()
	self:_clearData()
end

function RoomModel:reInit()
	self:_clearData()
end

function RoomModel:clear()
	RoomModel.super.clear(self)
	self:_clearData()
end

function RoomModel:_clearData()
	self._eidtInfo = nil
	self._obInfo = nil
	self._visitParam = nil
	self._enterParam = nil
	self._gameMode = RoomEnum.GameMode.Ob
	self._debugParam = nil
	self._roomInfoDict = {}
	self._buildingInfoDict = {}
	self._buildingIdCountDict = {}
	self._clickBuildingUidDict = {}
	self._buildingInfoList = {}
	self._formulaIdCountDict = {}
	self._blockPackageIds = {}
	self._specialBlockIds = {}
	self._specialBlockInfoList = {}
	self._themeItemMOListDict = {}
	self._roomLevel = 0
	self._interactionCount = 0
	self._existInteractionDict = {}
	self._characterPositionDict = {}
	self._hasGetRoomThemes = {}
	self._hasEdit = nil
	self._roadInfoListDict = {}
	self._atmosphereCacheData = nil

	if self._characterModel then
		self._characterModel:clear()
	else
		self._characterModel = BaseModel.New()
	end
end

function RoomModel:setEditInfo(info)
	self._eidtInfo = info

	self:_setInfoByMode(info, RoomEnum.GameMode.Edit)

	if info and info.blockPackages then
		self:_addBlockPackageIdByPackageInfos(info.blockPackages)
	end
end

function RoomModel:getEditInfo()
	return self._eidtInfo
end

function RoomModel:setObInfo(info)
	self._obInfo = info

	self:_setInfoByMode(info, RoomEnum.GameMode.Ob)

	if info and info.blockPackages then
		self:_addBlockPackageIdByPackageInfos(info.blockPackages)
	end

	if info and info.hasGetRoomThemes then
		self:setGetThemeRewardIds(info.hasGetRoomThemes)
	end
end

function RoomModel:getObInfo()
	return self._obInfo
end

function RoomModel:setInfoByMode(info, gameMode)
	if gameMode == RoomEnum.GameMode.Ob then
		self:setObInfo(info)
	elseif gameMode == RoomEnum.GameMode.Edit then
		self:setEditInfo(info)
	else
		self:_setInfoByMode(info, gameMode)
	end
end

function RoomModel:_setInfoByMode(info, gameMode)
	self._roomInfoDict[gameMode] = info

	self:setRoadInfoListByMode(info and info.roadInfos, gameMode)
end

function RoomModel:getRoadInfoListByMode(gameMode)
	return self._roadInfoListDict[gameMode]
end

function RoomModel:setRoadInfoListByMode(roadInfos, gameMode)
	local roadList = {}

	self._roadInfoListDict[gameMode] = roadList

	if roadInfos then
		for i = 1, #roadInfos do
			table.insert(roadList, RoomTransportHelper.serverRoadInfo2Info(roadInfos[i]))
		end
	end
end

function RoomModel:removeRoadInfoByIdsMode(ids, gameMode)
	local roadList = self._roadInfoListDict[gameMode]

	if roadList then
		for i = #roadList, 1, -1 do
			local roadInfo = roadList[i]

			if tabletool.indexOf(ids, roadInfo.id) then
				table.remove(roadList, i)
			end
		end
	end
end

function RoomModel:getInfoByMode(gameMode)
	return self._roomInfoDict[gameMode]
end

function RoomModel:setGameMode(gameMode)
	self._gameMode = gameMode
end

function RoomModel:getGameMode()
	return self._gameMode
end

function RoomModel:setEnterParam(enterParam)
	self._enterParam = enterParam
end

function RoomModel:getEnterParam()
	return self._enterParam
end

function RoomModel:setVisitParam(visitParam)
	self._visitParam = visitParam
end

function RoomModel:getVisitParam()
	return self._visitParam
end

function RoomModel:setDebugParam(debugParam)
	self._debugParam = debugParam
end

function RoomModel:getDebugParam()
	return self._debugParam
end

function RoomModel:getBuildingInfoList()
	return self._buildingInfoList
end

function RoomModel:resetBuildingInfos()
	local buildingInfos = self._buildingInfoList

	for i = 1, #buildingInfos do
		buildingInfos[i].use = false
	end
end

function RoomModel:setBuildingInfos(buildingInfos)
	self._buildingIdCountDict = {}
	self._buildingInfoList = {}
	self._buildingInfoDict = {}

	self:updateBuildingInfos(buildingInfos)
end

function RoomModel:updateBuildingInfos(buildingInfos)
	for i, buildingInfo in ipairs(buildingInfos) do
		local buildingId = buildingInfo.defineId
		local info = self._buildingInfoDict[buildingInfo.uid]

		if not info then
			info = {}
			self._buildingInfoDict[buildingInfo.uid] = info
			info.uid = buildingInfo.uid
			info.buildingId = buildingId
			info.defineId = buildingId

			table.insert(self._buildingInfoList, info)

			self._buildingIdCountDict[buildingId] = (self._buildingIdCountDict[buildingId] or 0) + 1
		end

		info.use = buildingInfo.use or false
		info.x = buildingInfo.x or 0
		info.y = buildingInfo.y or 0
		info.rotate = buildingInfo.rotate or 0
		info.level = buildingInfo.level or 0
	end
end

function RoomModel:getBuildingCount(buildingId)
	return self._buildingIdCountDict[buildingId] or 0
end

function RoomModel:getBuildingInfoByBuildingUid(buildingUid)
	return self._buildingInfoDict[buildingUid]
end

function RoomModel:blockPackageGainPush(msg)
	self:_addBlockPackageIdByPackageInfos(msg.blockPackages)
end

function RoomModel:_addBlockPackageIdByPackageInfos(blockPackageInfos)
	if not blockPackageInfos then
		return
	end

	for i = 1, #blockPackageInfos do
		self:_addBlockPackageId(blockPackageInfos[i].blockPackageId)
	end
end

function RoomModel:_addBlockPackageId(blockPackageId)
	if not self:isHasBlockPackageById(blockPackageId) then
		table.insert(self._blockPackageIds, blockPackageId)
	end
end

function RoomModel:setGetThemeRewardIds(themeIds)
	if not themeIds then
		return
	end

	self._hasGetRoomThemes = {}

	for i = 1, #themeIds do
		table.insert(self._hasGetRoomThemes, themeIds[i])
	end
end

function RoomModel:addGetThemeRewardId(themeId)
	table.insert(self._hasGetRoomThemes, themeId)
end

function RoomModel:isHasBlockPackageById(blockPackageId)
	local index = tabletool.indexOf(self._blockPackageIds, blockPackageId)

	return not not index
end

function RoomModel:isHasBlockById(blockId)
	local index = tabletool.indexOf(self._specialBlockIds, blockId)

	if index then
		return true
	end

	local blockCfg = RoomConfig.instance:getBlock(blockId)

	if blockCfg and blockCfg.ownType == RoomBlockEnum.OwnType.Package and tabletool.indexOf(self._blockPackageIds, blockCfg.packageId) then
		return true
	end

	return false
end

function RoomModel:isHasRoomThemeById(themeId)
	local themeMOlist = self:getThemeItemMOListById(themeId)

	if themeMOlist == nil or #themeMOlist < 1 then
		return false
	end

	for i = 1, #themeMOlist do
		local themeMO = themeMOlist[i]

		if themeMO.itemNum > themeMO:getItemQuantity() then
			return false
		end
	end

	return true
end

function RoomModel:setBlockPackageIds(packageIds)
	local tIds = {}

	tabletool.addValues(tIds, packageIds)

	self._blockPackageIds = tIds
end

function RoomModel:setSpecialBlockInfoList(blockInfos)
	local tInfos = {}

	tabletool.addValues(tInfos, blockInfos)

	self._specialBlockInfoList = tInfos
	self._specialBlockIds = {}

	for _, info in ipairs(tInfos) do
		table.insert(self._specialBlockIds, info.blockId)
	end
end

function RoomModel:addSpecialBlockIds(blockIds)
	local createTime = ServerTime.now()

	for i = 1, #blockIds do
		local blockId = blockIds[i]

		if blockId and tabletool.indexOf(self._specialBlockIds, blockId) == nil then
			table.insert(self._specialBlockIds, blockId)
			table.insert(self._specialBlockInfoList, {
				blockId = blockId,
				createTime = createTime
			})
		end
	end
end

function RoomModel:getBlockPackageIds()
	return self._blockPackageIds
end

function RoomModel:getSpecialBlockIds()
	return self._specialBlockIds
end

function RoomModel:getSpecialBlockInfoList()
	return self._specialBlockInfoList
end

function RoomModel:setFormulaInfos(formulaInfos)
	self._formulaIdCountDict = {}

	self:addFormulaInfos(formulaInfos)
end

function RoomModel:addFormulaInfos(formulaInfos)
	for i, formulaInfo in ipairs(formulaInfos) do
		local formulaId = formulaInfo.id

		self._formulaIdCountDict[formulaId] = (self._formulaIdCountDict[formulaId] or 0) + 1
	end
end

function RoomModel:getFormulaCount(formulaId)
	return self._formulaIdCountDict[formulaId] or 0
end

function RoomModel:updateRoomLevel(roomLevel)
	self._roomLevel = roomLevel
end

function RoomModel:getRoomLevel()
	return self._roomLevel
end

function RoomModel:setCharacterList(heroDatas)
	local roomCharacterMOList = {}

	if heroDatas then
		for _, info in ipairs(heroDatas) do
			local characterMO = RoomCharacterMO.New()

			characterMO:init(RoomInfoHelper.serverInfoToCharacterInfo(info))
			table.insert(roomCharacterMOList, characterMO)
		end
	end

	self._characterModel:setList(roomCharacterMOList)
end

function RoomModel:getCharacterList()
	return self._characterModel:getList()
end

function RoomModel:removeCharacterById(heroId)
	self._characterModel:remove(self._characterModel:getById(heroId))
end

function RoomModel:getCharacterById(heroId)
	return self._characterModel:getById(heroId)
end

function RoomModel:getThemeItemMO(themeId, itemId, itemType)
	local moList = self:getThemeItemMOListById(themeId)

	if not moList then
		for i = 1, #moList do
			local mo = moList[i]

			if mo.id == itemId and mo.materialType == itemType then
				return mo
			end
		end
	end

	return nil
end

function RoomModel:getThemeItemMOListById(themeId)
	local moList = self._themeItemMOListDict[themeId]

	if not moList then
		local themeCfg = RoomConfig.instance:getThemeConfig(themeId)

		if themeCfg then
			moList = {}

			self:_addThemeMOToListByStr(themeCfg.packages, moList, MaterialEnum.MaterialType.BlockPackage)
			self:_addThemeMOToListByStr(themeCfg.building, moList, MaterialEnum.MaterialType.Building)

			self._themeItemMOListDict[themeId] = moList
		end
	end

	return moList
end

function RoomModel:findHasGetThemeRewardThemeId()
	local cfgList = RoomConfig.instance:getThemeConfigList()

	for i = 1, #cfgList do
		local themeId = cfgList[i].id

		if self:isHasGetThemeRewardById(themeId) then
			return themeId
		end
	end
end

function RoomModel:isGetThemeRewardById(themeId)
	return tabletool.indexOf(self._hasGetRoomThemes, themeId)
end

function RoomModel:isHasGetThemeRewardById(themeId)
	if tabletool.indexOf(self._hasGetRoomThemes, themeId) then
		return false
	end

	local reswardList = RoomConfig.instance:getThemeCollectionRewards(themeId)

	if not reswardList or #reswardList < 1 then
		return false
	end

	local moList = self:getThemeItemMOListById(themeId)

	if not moList or #moList < 1 then
		return false
	end

	for i = 1, #moList do
		local mo = moList[i]
		local count = mo:getItemQuantity()

		for _, resward in ipairs(reswardList) do
			if #resward >= 3 and resward[1] == mo.materialType and resward[2] == mo.itemId then
				count = resward[3] + count
			end
		end

		if count < mo.itemNum then
			return false
		end
	end

	return true
end

function RoomModel:isFinshThemeById(themeId)
	local moList = self:getThemeItemMOListById(themeId)

	if not moList or #moList < 1 then
		return false
	end

	for i = 1, #moList do
		local mo = moList[i]
		local count = mo:getItemQuantity()

		if count < mo.itemNum then
			return false
		end
	end

	return true
end

function RoomModel:_addThemeMOToListByStr(str, molist, materialType)
	molist = molist or {}

	local nums = GameUtil.splitString2(str, true)

	for _, item in ipairs(nums) do
		local mo = RoomThemeItemMO.New()
		local itemId = item[1]
		local cfg = ItemModel.instance:getItemConfig(materialType, itemId)

		if cfg then
			if not cfg.numLimit then
				local itemNum = 1

				mo:init(itemId, itemNum, materialType)
				table.insert(molist, mo)
			end
		end
	end

	return molist
end

function RoomModel:updateInteraction(info)
	self._interactionCount = info.interactionCount
	self._existInteractionDict = {}

	for i, interactionInfo in ipairs(info.infos) do
		local config = RoomConfig.instance:getCharacterInteractionConfig(interactionInfo.id)

		if config then
			if interactionInfo.finish then
				self._existInteractionDict[interactionInfo.id] = RoomCharacterEnum.InteractionState.Complete or RoomCharacterEnum.InteractionState.Start
			end
		end
	end
end

function RoomModel:getExistInteractionDict()
	return self._existInteractionDict
end

function RoomModel:getInteractionCount()
	return self._interactionCount
end

function RoomModel:getInteractionState(interactionId)
	return self._existInteractionDict[interactionId] or RoomCharacterEnum.InteractionState.None
end

function RoomModel:interactStart(interactionId)
	self._interactionCount = self._interactionCount + 1
	self._existInteractionDict[interactionId] = RoomCharacterEnum.InteractionState.Start
end

function RoomModel:interactComplete(interactionId)
	self._existInteractionDict[interactionId] = RoomCharacterEnum.InteractionState.Complete
end

function RoomModel:updateCharacterPoint()
	self._characterPositionDict = {}

	local roomCharacterMOList = RoomCharacterModel.instance:getList()

	for i, roomCharacterMO in ipairs(roomCharacterMOList) do
		self._characterPositionDict[roomCharacterMO.heroId] = roomCharacterMO.currentPosition
	end
end

function RoomModel:getCharacterPosition(heroId)
	return self._characterPositionDict[heroId]
end

function RoomModel:setEditFlag()
	self._hasEdit = true
end

function RoomModel:clearEditFlag()
	self._hasEdit = nil
end

function RoomModel:hasEdit()
	return self._hasEdit
end

function RoomModel:getOpenAndEndAtmosphereList(buildingId)
	local openList = {}
	local endList = {}
	local atmosphereList = RoomConfig.instance:getBuildingAtmospheres(buildingId)
	local nowTime = ServerTime.now()

	for _, atmosphereId in ipairs(atmosphereList) do
		local openTime = RoomConfig.instance:getAtmosphereOpenTime(atmosphereId)
		local durationDay = RoomConfig.instance:getAtmosphereDurationDay(atmosphereId)
		local endTime = openTime + durationDay * TimeUtil.OneDaySecond

		if openTime <= nowTime and nowTime <= endTime then
			local isTrigger, isAddToEnd = self:isAtmosphereTrigger(atmosphereId)

			if isTrigger then
				openList[#openList + 1] = atmosphereId
			elseif isAddToEnd then
				endList[#endList + 1] = atmosphereId
			end
		else
			endList[#endList + 1] = atmosphereId
		end
	end

	return openList, endList
end

function RoomModel:getAtmosphereCacheData()
	if not self._atmosphereCacheData then
		self._atmosphereCacheData = {}

		local strCacheData = GameUtil.playerPrefsGetStringByUserId(RoomEnum.AtmosphereCacheKey, "")

		if not string.nilorempty(strCacheData) then
			local numsList = GameUtil.splitString2(strCacheData, true) or {}

			for _, nums in ipairs(numsList) do
				if nums and #nums > 1 then
					self._atmosphereCacheData[nums[1]] = nums[2]
				end
			end
		end
	end

	return self._atmosphereCacheData
end

function RoomModel:setAtmosphereHasPlay(atmosphereId)
	local nowTime = ServerTime.now()
	local atmosphereCacheData = self:getAtmosphereCacheData()

	atmosphereCacheData[atmosphereId] = nowTime

	local str = ""
	local isFirst = true

	for kId, vTime in pairs(atmosphereCacheData) do
		if isFirst then
			isFirst = false
			str = kId .. "#" .. vTime
		else
			str = str .. "|" .. kId .. "#" .. vTime
		end
	end

	GameUtil.playerPrefsSetStringByUserId(RoomEnum.AtmosphereCacheKey, str)
end

local function _noneTrigger()
	return false
end

local function _isDisposableTrigger(atmosphereId, lastPlayTime)
	local result = false

	if not RoomModel._checkAtmospherCdTime(atmosphereId, lastPlayTime) then
		return result
	end

	local openTime = RoomConfig.instance:getAtmosphereOpenTime(atmosphereId)
	local durationDay = RoomConfig.instance:getAtmosphereDurationDay(atmosphereId)
	local endTime = openTime + durationDay * TimeUtil.OneDaySecond

	if lastPlayTime < openTime or endTime < lastPlayTime then
		result = true
	end

	return result
end

local function _isIntegralPointTrigger(atmosphereId, lastPlayTime)
	local result = false
	local nowTime = ServerTime.now()
	local integralHour = math.modf((nowTime + TimeUtil.OneMinuteSecond) / TimeUtil.OneHourSecond)
	local integralSecond = integralHour * TimeUtil.OneHourSecond
	local integralPreMin = integralSecond - TimeUtil.OneMinuteSecond
	local integralNextMin = integralSecond + TimeUtil.OneMinuteSecond
	local inPlayTime = integralPreMin <= nowTime and nowTime <= integralNextMin
	local hasPlayed = integralPreMin <= lastPlayTime and lastPlayTime <= integralNextMin

	if inPlayTime and not hasPlayed and RoomModel._checkAtmospherCdTime(atmosphereId, lastPlayTime) then
		result = true
	end

	local isAddToEnd = not result

	return result, isAddToEnd
end

function RoomModel._isCdTimeAtmosphereTrigger(atmosphereId, lastPlayTime)
	local result = false

	if not RoomModel._checkAtmospherCdTime(atmosphereId, lastPlayTime) then
		return result
	end

	local openTime = RoomConfig.instance:getAtmosphereOpenTime(atmosphereId)
	local durationDay = RoomConfig.instance:getAtmosphereDurationDay(atmosphereId)
	local nowTime = ServerTime.now()
	local endTime = openTime + durationDay * TimeUtil.OneDaySecond

	if openTime <= nowTime and nowTime <= endTime then
		result = true
	end

	return result
end

function RoomModel._checkAtmospherCdTime(atmosphereId, lastPlayTime)
	local cfg = RoomConfig.instance:getAtmosphereCfg(atmosphereId)

	if cfg then
		if not cfg.cdtimes then
			local cdTime = 0

			if cdTime and cdTime ~= 0 then
				local nowTime = ServerTime.now()

				if cdTime > nowTime - lastPlayTime then
					return false
				end
			end

			return true
		end
	end
end

local triggerType2Func = {
	[RoomEnum.AtmosphereTriggerType.None] = _noneTrigger,
	[RoomEnum.AtmosphereTriggerType.Disposable] = _isDisposableTrigger,
	[RoomEnum.AtmosphereTriggerType.IntegralPoint] = _isIntegralPointTrigger,
	[RoomEnum.AtmosphereTriggerType.CDTime] = RoomModel._isCdTimeAtmosphereTrigger
}

function RoomModel:isAtmosphereTrigger(atmosphereId)
	local result = false
	local isAddToEnd = false
	local triggerType = RoomConfig.instance:getAtmosphereTriggerType(atmosphereId)
	local triggerFunc = triggerType2Func[triggerType]

	if triggerFunc then
		local atmosphereCacheData = self:getAtmosphereCacheData()

		if not atmosphereCacheData[atmosphereId] then
			result, isAddToEnd = triggerFunc(atmosphereId, atmosphereCacheData[atmosphereId])
		end
	else
		logError(string.format("RoomModel:isAtmosphereTrigger error atmosphereId:%s triggerType:%s not defined", atmosphereId, triggerType))
	end

	return result, isAddToEnd
end

RoomModel.instance = RoomModel.New()

return RoomModel
