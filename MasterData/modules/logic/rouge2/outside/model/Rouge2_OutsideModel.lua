-- chunkname: @modules/logic/rouge2/outside/model/Rouge2_OutsideModel.lua

module("modules.logic.rouge2.outside.model.Rouge2_OutsideModel", package.seeall)

local Rouge2_OutsideModel = class("Rouge2_OutsideModel", BaseModel)

function Rouge2_OutsideModel:onInit()
	self:reInit()
end

function Rouge2_OutsideModel:reInit()
	self._reviewInfoList = {}
	self._rougeGameRecord = nil
	self._bossBattleInfo = nil
	self.newUnlockCollectionList = {}
	self.newPassCollectionList = {}
	self._unlockCollectionDic = {}
	self._tempLocalDataList = {}

	self:_setRougeOutSideInfo()
	self:initLocalRedDot()
end

function Rouge2_OutsideModel:initLocalRedDot()
	self._localDataListDic = {}
	self._localDataMapDic = {}
end

function Rouge2_OutsideModel:onReceiveGetRougeOutsideInfoReply(msg)
	self:updateRougeOutsideInfo(msg.rougeInfo)
end

function Rouge2_OutsideModel:updateRougeOutsideInfo(rougeInfo)
	self:_setRougeOutSideInfo()
	tabletool.clear(self.newPassCollectionList)

	if self._rougeGameRecord then
		for _, itemId in ipairs(rougeInfo.totalRecordInfo.passCollections) do
			if not Rouge2_OutsideModel.instance:collectionIsPass(itemId) then
				logNormal("肉鸽2 添加新解锁造物 itemId:" .. itemId)
				table.insert(self.newPassCollectionList, itemId)
			end
		end
	else
		self._rougeGameRecord = Rouge2_GameRecordInfoMO.New()
	end

	if rougeInfo.totalRecordInfo then
		self._rougeGameRecord:init(rougeInfo.totalRecordInfo)
	end

	tabletool.clear(self._reviewInfoList)

	if rougeInfo.review then
		for _, info in ipairs(rougeInfo.review) do
			local mo = Rouge2_ReviewMO.New()

			mo:init(info)
			table.insert(self._reviewInfoList, mo)
		end
	end

	self:updateBossBattleInfo(rougeInfo.bossBattleInfo)
	self:checkAVGRedDot()
	self:checkIllustrationRedDot()
	Rouge2_OutsideController.instance:dispatchEvent(Rouge2_OutsideEvent.OnUpdateRougeOutsideInfo)
end

function Rouge2_OutsideModel:updateBossBattleInfo(bossBattleInfo)
	if bossBattleInfo then
		self._bossBattleInfo = self._bossBattleInfo or Rouge2_BossBattleInfoMO.New()

		self._bossBattleInfo:init(bossBattleInfo)
		self:checkBossBattleRewardRedDot()
		Rouge2_OutsideController.instance:dispatchEvent(Rouge2_OutsideEvent.OnUpdateBossBattleInfo)
	end
end

function Rouge2_OutsideModel:checkFormulaRedDot()
	local unlockFormulaList = Rouge2_AlchemyModel.instance:getUnlockFormulaList()
	local haveShowRedDotDic = self:getLocalDataDic(Rouge2_OutsideEnum.LocalData.Formula)
	local haveStatItemDic = self:getLocalDataDic(Rouge2_OutsideEnum.LocalStatData.Formula)
	local redDotInfoList = {}
	local statInfoList = {}

	for _, itemId in ipairs(unlockFormulaList) do
		if not haveShowRedDotDic[itemId] then
			local info = Rouge2_OutsideController.buildSingleInfo(itemId, true)

			table.insert(redDotInfoList, info)
		end

		if not haveStatItemDic[itemId] then
			table.insert(statInfoList, itemId)
		end
	end

	if next(statInfoList) then
		Rouge2_StatController.instance:statUnlockIllustration(Rouge2_StatController.FavoriteType.Formula, statInfoList)
		self:addLocalDataList(Rouge2_OutsideEnum.LocalStatData.Formula, statInfoList)
	end

	Rouge2_OutsideController.instance:setRedDotState(RedDotEnum.DotNode.V3a2_Rouge_Favorite_Formula, redDotInfoList)
end

function Rouge2_OutsideModel:checkIllustrationRedDot()
	local illustrationConfigList = Rouge2_OutSideConfig.instance:getIllustrationList()
	local haveShowRedDotDic = self:getLocalDataDic(Rouge2_OutsideEnum.LocalData.Illustration)
	local redDotInfoList = {}

	for _, mo in ipairs(illustrationConfigList) do
		local config = mo.config

		if config.type == Rouge2_OutsideEnum.IllustrationDetailType.Illustration and config.eventId and self:passedEventId(config.eventId) and not haveShowRedDotDic[config.id] then
			local info = Rouge2_OutsideController.buildSingleInfo(config.id, true)

			table.insert(redDotInfoList, info)
		end
	end

	Rouge2_OutsideController.instance:setRedDotState(RedDotEnum.DotNode.V3a2_Rouge_Review_Illustration, redDotInfoList)
end

function Rouge2_OutsideModel:checkAVGRedDot()
	local storyMoList = Rouge2_OutSideConfig.instance:getStoryList()
	local haveShowRedDotDic = self:getLocalDataDic(Rouge2_OutsideEnum.LocalData.Avg)
	local redDotInfoList = {}

	for _, mo in ipairs(storyMoList) do
		local config = mo.config

		if not string.nilorempty(config.eventId) then
			local illustrationId = tonumber(config.eventId)
			local illustrationConfig = Rouge2_OutSideConfig.instance:getIllustrationConfig(illustrationId)

			if illustrationConfig and self:passedEventId(illustrationConfig.eventId) and not haveShowRedDotDic[illustrationId] then
				local info = Rouge2_OutsideController.buildSingleInfo(illustrationId, true)

				table.insert(redDotInfoList, info)
			end
		else
			local storyIdList = string.splitToNumber(config.storyIdList, "#")

			if next(storyIdList) then
				for _, storyId in ipairs(storyIdList) do
					if StoryModel.instance:isStoryHasPlayed(storyId) and not haveShowRedDotDic[storyId] then
						local info = Rouge2_OutsideController.buildSingleInfo(storyId, true)

						table.insert(redDotInfoList, info)
					end
				end
			end
		end
	end

	Rouge2_OutsideController.instance:setRedDotState(RedDotEnum.DotNode.V3a2_Rouge_Review_AVG, redDotInfoList)
end

function Rouge2_OutsideModel:checkTalentRedDot()
	local allTalentConfig = Rouge2_OutSideConfig.instance:getTalentConfigListByType(Rouge2_Enum.TalentType.Common)
	local haveActiveCount = Rouge2_TalentModel.instance:getActiveTalentPoint()
	local redDotInfoList = {}

	if haveActiveCount < #allTalentConfig then
		for _, config in ipairs(allTalentConfig) do
			if not Rouge2_TalentModel.instance:isTalentActive(config.geniusId) and Rouge2_TalentModel.instance:isTalentUnlock(config.geniusId) and Rouge2_TalentModel.instance:isTalentCanActive(config.geniusId) then
				local info = Rouge2_OutsideController.buildSingleInfo(config.geniusId, true)

				table.insert(redDotInfoList, info)

				break
			end
		end
	end

	Rouge2_OutsideController.instance:setRedDotState(RedDotEnum.DotNode.V3a2_Rouge_Talent_Button, redDotInfoList)
end

function Rouge2_OutsideModel:checkCollectionRedDot()
	local haveShowItemDic = self:getLocalDataDic(Rouge2_OutsideEnum.LocalData.Collection)
	local redDotInfoList = {}

	if next(self._unlockCollectionDic) then
		for itemId, _ in pairs(self._unlockCollectionDic) do
			local config = Rouge2_OutSideConfig.getItemConfig(itemId)

			if config and self:collectionIsPass(config.id) and not haveShowItemDic[itemId] then
				local info = Rouge2_OutsideController.buildSingleInfo(itemId, true)

				table.insert(redDotInfoList, info)
			end
		end
	end

	Rouge2_OutsideController.instance:setRedDotState(RedDotEnum.DotNode.V3a2_Rouge_Favorite_Collection, redDotInfoList)
end

function Rouge2_OutsideModel:checkBossBattleRewardRedDot()
	local battleInfo = self:getBossBattleInfo()
	local bossInfoList = battleInfo and battleInfo:getBossInfoList()
	local redDotInfoList = {}

	if bossInfoList then
		for _, bossInfo in ipairs(bossInfoList) do
			local bossId = bossInfo:getBossId()
			local hasAnyRewardCanGet = bossInfo and bossInfo:hasAnyRewardCanGet()
			local value = hasAnyRewardCanGet and 1 or 0
			local redDotInfo = {
				id = RedDotEnum.DotNode.Rouge2BossReward,
				uid = bossId,
				value = value
			}

			table.insert(redDotInfoList, redDotInfo)
		end
	end

	RedDotRpc.instance:clientAddRedDotGroupList(redDotInfoList)
end

function Rouge2_OutsideModel:checkCollectionStat()
	local haveStatItemDic = self:getLocalDataDic(Rouge2_OutsideEnum.LocalStatData.Collection)
	local statInfoList = {}

	if next(self._unlockCollectionDic) then
		for itemId, _ in pairs(self._unlockCollectionDic) do
			local config = Rouge2_OutSideConfig.getItemConfig(itemId)

			if config and self:collectionIsPass(config.id) and not haveStatItemDic[itemId] then
				table.insert(statInfoList, itemId)
			end
		end

		if next(statInfoList) then
			self:addLocalDataList(Rouge2_OutsideEnum.LocalStatData.Collection, statInfoList)
			Rouge2_StatController.instance:statUnlockIllustration(Rouge2_StatController.FavoriteType.Collection, statInfoList)
		end
	end
end

function Rouge2_OutsideModel:checkStoreRedDot()
	local haveShowItemDic = self:getLocalDataDic(Rouge2_OutsideEnum.LocalData.Store)
	local redDotInfoList = {}
	local storeIdList = Rouge2_StoreModel.instance:getOpenStageIdList()

	if next(storeIdList) then
		for _, storeId in pairs(storeIdList) do
			local config = Rouge2_OutSideConfig.instance:getRewardStageConfigById(storeId)

			if config and not haveShowItemDic[storeId] and not Rouge2_StoreModel.instance:isStoreAllClaimed(storeId) then
				local info = Rouge2_OutsideController.buildSingleInfo(storeId, true)

				table.insert(redDotInfoList, info)
			end
		end
	end

	Rouge2_OutsideController.instance:setRedDotState(RedDotEnum.DotNode.V3a2_Rouge_Store_Tab, redDotInfoList)
end

function Rouge2_OutsideModel:onGetCollectionInfo(relicts, buffs, autoBuffs)
	tabletool.clear(self.newUnlockCollectionList)
	tabletool.addValues(relicts, buffs)
	tabletool.addValues(relicts, autoBuffs)

	for _, itemId in ipairs(relicts) do
		local config = Rouge2_OutSideConfig.getItemConfig(itemId)

		if config and not self._unlockCollectionDic[itemId] and not string.nilorempty(config.outUnlock) then
			table.insert(self.newUnlockCollectionList, itemId)
		end
	end

	tabletool.clear(self._unlockCollectionDic)

	if next(relicts) then
		for _, itemId in ipairs(relicts) do
			local config = Rouge2_OutSideConfig.getItemConfig(itemId)

			if config then
				self._unlockCollectionDic[itemId] = true
			end
		end
	end

	self:checkCollectionRedDot()
	self:checkCollectionStat()
end

function Rouge2_OutsideModel:getNewUnlockCollectionList()
	return self.newUnlockCollectionList
end

function Rouge2_OutsideModel:getNewPassCollectionList()
	return self.newPassCollectionList
end

function Rouge2_OutsideModel:getReviewInfoList()
	return self._reviewInfoList
end

function Rouge2_OutsideModel:getRougeGameRecord()
	return self._rougeGameRecord
end

function Rouge2_OutsideModel:getBossBattleInfo()
	return self._bossBattleInfo
end

function Rouge2_OutsideModel:_setRougeOutSideInfo()
	self._config = Rouge2_OutSideConfig.instance
end

function Rouge2_OutsideModel:config()
	return self._config
end

function Rouge2_OutsideModel:passedDifficulty()
	if not self._rougeGameRecord then
		return 0
	end

	return self._rougeGameRecord.maxDifficulty or 0
end

function Rouge2_OutsideModel:isPassedDifficulty(difficulty)
	return difficulty <= self:passedDifficulty()
end

function Rouge2_OutsideModel:isOpenedDifficulty(difficulty)
	local difficultyCO = Rouge2_Config.instance:getDifficultyCoById(difficulty)

	return self:isPassedDifficulty(difficultyCO.preDifficulty)
end

function Rouge2_OutsideModel:isUnlockCareer(careerId)
	local careerConfig = Rouge2_CareerConfig.instance:getCareerConfig(careerId)
	local unlockCondition = careerConfig and careerConfig.unlock
	local unlockRemainTime = self:getCareerUnlockRemainTime(careerId)

	if unlockRemainTime > 0 then
		return false, ToastEnum.Rouge2LockCareer
	end

	if string.nilorempty(unlockCondition) then
		return true
	end

	return true
end

function Rouge2_OutsideModel:getCareerUnlockRemainTime(careerId)
	local careerConfig = Rouge2_CareerConfig.instance:getCareerConfig(careerId)
	local unlockTimeStr = careerConfig and careerConfig.unlockTime

	if string.nilorempty(unlockTimeStr) then
		return 0
	end

	local unlockTime = TimeUtil.stringToTimestamp(unlockTimeStr) - ServerTime.clientToServerOffset()

	return unlockTime - ServerTime.now()
end

function Rouge2_OutsideModel:endCdTs()
	if not self._rougeGameRecord then
		return 0
	end

	local fromTs = self._rougeGameRecord:lastGameEndTimestamp()

	if fromTs <= 0 then
		return 0
	end

	local duration = self._config:getAbortCDDuration()

	if duration == 0 then
		return 0
	end

	return fromTs + duration
end

function Rouge2_OutsideModel:leftCdSec()
	return self:endCdTs() - ServerTime.now()
end

function Rouge2_OutsideModel:isInCdStart()
	return self:leftCdSec() > 0
end

local TRUE = 1
local FALSE = 0

function Rouge2_OutsideModel:getIsNewUnlockDifficulty(difficulty)
	return self:_getUnlockDifficulty(difficulty, FALSE) == TRUE
end

function Rouge2_OutsideModel:setIsNewUnlockDifficulty(difficulty, isNew)
	self:_saveUnlockDifficulty(difficulty, (isNew or nil) and (TRUE or FALSE))
end

local kPrefix = "RougeOutside|"
local kLastMarkPrefix = "LastMark|"

function Rouge2_OutsideModel:_getPrefsKeyPrefix()
	return kPrefix
end

function Rouge2_OutsideModel:_saveInteger(key, value)
	GameUtil.playerPrefsSetNumberByUserId(key, value)
end

function Rouge2_OutsideModel:_getInteger(key, defaultValue)
	return GameUtil.playerPrefsGetNumberByUserId(key, defaultValue)
end

local kDifficultyPrefix = "D|"

function Rouge2_OutsideModel:_getPrefsKeyDifficulty(difficulty)
	assert(type(difficulty) == "number")

	return self:_getPrefsKeyPrefix() .. kDifficultyPrefix .. tostring(difficulty)
end

function Rouge2_OutsideModel:_saveUnlockDifficulty(difficulty, value)
	local playerPrefsKey = self:_getPrefsKeyDifficulty(difficulty)

	self:_saveInteger(playerPrefsKey, value)
end

function Rouge2_OutsideModel:_getUnlockDifficulty(difficulty, defaultValue)
	local playerPrefsKey = self:_getPrefsKeyDifficulty(difficulty)

	return self:_getInteger(playerPrefsKey, defaultValue)
end

function Rouge2_OutsideModel:_getPrefsKeyLastMarkDifficulty()
	return self:_getPrefsKeyPrefix() .. kLastMarkPrefix .. kDifficultyPrefix
end

function Rouge2_OutsideModel:setLastMarkSelectedDifficulty(value)
	local playerPrefsKey = self:_getPrefsKeyLastMarkDifficulty()

	self:_saveInteger(playerPrefsKey, value)
end

function Rouge2_OutsideModel:getLastMarkSelectedDifficulty(defaultValue)
	local playerPrefsKey = self:_getPrefsKeyLastMarkDifficulty()

	return self:_getInteger(playerPrefsKey, defaultValue)
end

function Rouge2_OutsideModel:passedLayerId(layerId)
	if not self._rougeGameRecord then
		return false
	end

	return self._rougeGameRecord:passedLayerId(layerId)
end

function Rouge2_OutsideModel:collectionIsPass(id)
	if not self._rougeGameRecord then
		return false
	end

	return self._rougeGameRecord:collectionIsPass(id)
end

function Rouge2_OutsideModel:storyIsPass(id)
	if not self._rougeGameRecord then
		return false
	end

	return self._rougeGameRecord:storyIsPass(id)
end

function Rouge2_OutsideModel:collectionIsUnlock(id)
	return self._unlockCollectionDic[id]
end

function Rouge2_OutsideModel:passedAnyEventId(list)
	for i, v in ipairs(list) do
		if self:passedEventId(v) then
			return true
		end
	end

	return false
end

function Rouge2_OutsideModel:passedEventId(eventId)
	if not self._rougeGameRecord then
		return false
	end

	return self._rougeGameRecord:passedEventId(eventId)
end

function Rouge2_OutsideModel:passAnyOneEnd()
	return self._rougeGameRecord and self._rougeGameRecord:passAnyOneEnd()
end

function Rouge2_OutsideModel:passEndId(endId)
	return self._rougeGameRecord and self._rougeGameRecord:passEndId(endId)
end

function Rouge2_OutsideModel:passEntrustId(entrustId)
	return self._rougeGameRecord and self._rougeGameRecord:passEntrustId(entrustId)
end

function Rouge2_OutsideModel:switchCollectionInfoType()
	local curInfoType = self:getCurCollectionInfoType()
	local isCurComplex = curInfoType == Rouge2_OutsideEnum.CollectionInfoType.Complex

	if isCurComplex then
		self._curInfoType = Rouge2_OutsideEnum.CollectionInfoType.Simple or Rouge2_OutsideEnum.CollectionInfoType.Complex
	end

	Rouge2_OutsideController.instance:dispatchEvent(Rouge2_OutsideEvent.SwitchCollectionInfoType)
	self:_saveCollectionInfoType(self._curInfoType)
end

function Rouge2_OutsideModel:getCurCollectionInfoType()
	if not self._curInfoType then
		local key = self:_getCollectionInfoTypeSaveKey()

		self._curInfoType = tonumber(PlayerPrefsHelper.getNumber(key, Rouge2_OutsideEnum.DefaultCollectionInfoType))
	end

	return self._curInfoType
end

function Rouge2_OutsideModel:_saveCollectionInfoType(infoType)
	infoType = infoType or Rouge2_OutsideEnum.DefaultCollectionInfoType

	local key = self:_getCollectionInfoTypeSaveKey()

	PlayerPrefsHelper.setNumber(key, infoType)
end

function Rouge2_OutsideModel._getCollectionInfoTypeSaveKey()
	return (string.format("%s_%s", PlayerModel.instance:getMyUserId(), PlayerPrefsKey.Rouge2CollectionInfoType))
end

function Rouge2_OutsideModel._getCollectionRedDotSaveKey(playerPrefsKey)
	return (string.format("%s_%s", PlayerModel.instance:getMyUserId(), playerPrefsKey))
end

function Rouge2_OutsideModel:initLocalDataListAndMap(key)
	local userKey = Rouge2_OutsideModel._getCollectionRedDotSaveKey(key)
	local dataStr = PlayerPrefsHelper.getString(userKey, "")
	local list = string.splitToNumber(dataStr, "#")
	local idDic = {}

	for _, id in ipairs(list) do
		idDic[id] = true
	end

	self._localDataListDic[key] = list
	self._localDataMapDic[key] = idDic

	return list, idDic
end

function Rouge2_OutsideModel:getLocalDataList(localDataType)
	local key = Rouge2_OutsideEnum.LocalDataType2PlayerKey[localDataType]

	if not key then
		logError("肉鸽2 不存在的本地红点 type:" .. localDataType)

		return nil
	end

	if not self._localDataListDic[key] then
		self:initLocalDataListAndMap(key)
	end

	return self._localDataListDic[key]
end

function Rouge2_OutsideModel:getLocalDataDic(localDataType)
	local key = Rouge2_OutsideEnum.LocalDataType2PlayerKey[localDataType]

	if not key then
		logError("肉鸽2 不存在的本地红点 type:" .. localDataType)

		return nil
	end

	if not self._localDataMapDic[key] then
		self:initLocalDataListAndMap(key)
	end

	return self._localDataMapDic[key]
end

function Rouge2_OutsideModel:addLocalDataList(localDataType, list)
	local key = Rouge2_OutsideEnum.LocalDataType2PlayerKey[localDataType]

	if not key then
		logError("肉鸽2 不存在的本地红点 type:" .. localDataType)

		return
	end

	local curList = self:getLocalDataList(localDataType)
	local dic = self:getLocalDataDic(localDataType)

	if list and next(list) then
		for _, id in ipairs(list) do
			if not dic[id] then
				table.insert(curList, id)

				dic[id] = true
			end
		end

		self:saveLocalDataList(key, curList)

		if localDataType == Rouge2_OutsideEnum.LocalData.Formula then
			self:checkFormulaRedDot()
		elseif localDataType == Rouge2_OutsideEnum.LocalData.Avg then
			self:checkAVGRedDot()
		elseif localDataType == Rouge2_OutsideEnum.LocalData.Illustration then
			self:checkIllustrationRedDot()
		elseif localDataType == Rouge2_OutsideEnum.LocalData.Collection then
			self:checkCollectionRedDot()
		elseif localDataType == Rouge2_OutsideEnum.LocalData.Store then
			self:checkStoreRedDot()
		end

		logNormal("肉鸽2 saveLocalDataList type:" .. localDataType)
	end
end

function Rouge2_OutsideModel:addLocalData(localDataType, id)
	local key = Rouge2_OutsideEnum.LocalDataType2PlayerKey[localDataType]

	if not key then
		logError("肉鸽2 不存在的本地红点 type:" .. localDataType)

		return
	end

	self:addLocalDataList(key, {
		id
	})
end

function Rouge2_OutsideModel:saveLocalDataList(key, dataList)
	local userKey = self._getCollectionRedDotSaveKey(key)
	local dataStr = next(dataList) and table.concat(dataList, "#") or ""

	PlayerPrefsHelper.setString(userKey, dataStr)
end

function Rouge2_OutsideModel:addTempLocalDataList(type, id)
	if self._tempLocalDataList[type] == nil then
		self._tempLocalDataList[type] = {}
	end

	table.insert(self._tempLocalDataList[type], id)
end

function Rouge2_OutsideModel:saveTempLocalDataList()
	if next(self._tempLocalDataList) then
		for type, localDataList in pairs(self._tempLocalDataList) do
			self:addLocalDataList(type, localDataList)
		end
	end
end

function Rouge2_OutsideModel:clearTempLocalDataList()
	if next(self._tempLocalDataList) then
		for type, localDataList in pairs(self._tempLocalDataList) do
			tabletool.clear(localDataList)
		end
	end
end

function Rouge2_OutsideModel:clearLocalData()
	for _, type in pairs(Rouge2_OutsideEnum.LocalData) do
		local key = Rouge2_OutsideEnum.LocalDataType2PlayerKey[type]

		if not key then
			logError("肉鸽2 不存在的本地红点 type:" .. type)

			return
		end

		self:saveLocalDataList(key, {})

		local list = self:getLocalDataList(type)
		local dic = self:getLocalDataDic(type)

		tabletool.clear(list)
		tabletool.clear(dic)
	end

	for _, type in pairs(Rouge2_OutsideEnum.LocalStatData) do
		local key = Rouge2_OutsideEnum.LocalDataType2PlayerKey[type]

		if not key then
			logError("肉鸽2 不存在的本地红点 type:" .. type)

			return
		end

		self:saveLocalDataList(key, {})

		local list = self:getLocalDataList(type)
		local dic = self:getLocalDataDic(type)

		tabletool.clear(list)
		tabletool.clear(dic)
	end

	self:checkFormulaRedDot()
	self:checkAVGRedDot()
	self:checkIllustrationRedDot()
	self:checkCollectionRedDot()
	self:checkStoreRedDot()
	logError("肉鸽2 清除本地红点数据成功")
end

function Rouge2_OutsideModel:isFinishOneRouge()
	local constConfig = Rouge2_OutSideConfig.instance:getConstConfigById(Rouge2_Enum.OutSideConstId.RougeNewGuideStartTime)

	if constConfig == nil then
		return false
	end

	if constConfig.value == nil or string.nilorempty(constConfig.value) then
		return false
	end

	local lastTime = TimeUtil.stringToTimestamp(constConfig.value) * TimeUtil.OneSecondMilliSecond
	local reviewInfo = Rouge2_OutsideModel.instance:getReviewInfoList()

	if not reviewInfo or next(reviewInfo) == nil then
		return false
	end

	for _, info in ipairs(reviewInfo) do
		if lastTime <= tonumber(info.finishTime) then
			return true
		end
	end

	return false
end

Rouge2_OutsideModel.instance = Rouge2_OutsideModel.New()

return Rouge2_OutsideModel
