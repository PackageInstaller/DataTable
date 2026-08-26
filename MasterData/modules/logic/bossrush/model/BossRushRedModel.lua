-- chunkname: @modules/logic/bossrush/model/BossRushRedModel.lua

module("modules.logic.bossrush.model.BossRushRedModel", package.seeall)

local BossRushRedModel = class("BossRushRedModel", BaseModel)
local tostring = tostring
local next = next
local tinsert = table.insert
local EDotNode = RedDotEnum.DotNode
local kPrefix = "BossRushRed|"
local kDefaultUId = 0
local kMagicNumber = -11235
local kDefaultDisplayNumber = 0

function BossRushRedModel:onInit()
	self:reInit()
end

function BossRushRedModel:reInit()
	self:_stopTick()
	FrameTimerController.onDestroyViewMember(self, "_flushCacheFrameTimer")

	self._unlockBossIdList = {}
	self._delayNeedUpdateDictList = {}
	self._delayUpdateRedValueList = {}
	self._flushDataFrameTimer = nil
end

function BossRushRedModel:_getConfig()
	return BossRushModel.instance:getConfig()
end

function BossRushRedModel:_getActivityId()
	return BossRushConfig.instance:getActivityId()
end

function BossRushRedModel:_getRedDotGroup(defineId)
	return RedDotModel.instance:getRedDotInfo(defineId)
end

function BossRushRedModel:_getRedDotGroupItem(defineId, uid)
	local group = self:_getRedDotGroup(defineId)

	if not group then
		logWarn("[BossRushRedModel] _getRedDotGroupItem: defineId=" .. tostring(defineId) .. " uid=" .. tostring(uid))

		return
	end

	return group.infos[uid]
end

function BossRushRedModel:_getDisplayValue(defineId, uid)
	if not uid or not defineId then
		return kDefaultDisplayNumber
	end

	local group = self:_getRedDotGroup(defineId)

	if not group then
		return kDefaultDisplayNumber
	end

	local groupItem = self:_getRedDotGroupItem(defineId, uid)

	if not groupItem then
		return kDefaultDisplayNumber
	end

	return groupItem.value, true
end

function BossRushRedModel:_getDisplayValueByDSL(defineId, stage, layer)
	local uid = self:getUId(defineId, stage, layer)

	return self:_getDisplayValue(defineId, uid)
end

function BossRushRedModel:_createByDU(defineId, uid)
	return {
		id = defineId,
		uid = uid,
		value = self:_getSavedValue(defineId, uid)
	}
end

function BossRushRedModel:_createByDSL(defineId, stage, layer)
	local uid = self:getUId(defineId, stage, layer)

	return self:_createByDU(defineId, uid)
end

function BossRushRedModel:_getDUByDSL(defineId, stage, layer)
	local uid = self:getUId(defineId, stage, layer)

	return defineId, uid
end

function BossRushRedModel:_getSavedValue(defineId, uid)
	local defaultValue = self:getDefaultValue(defineId)
	local savedValue = self:_get(defineId, uid, defaultValue)
	local isSavedValueValid = self:_isSValueValid(savedValue)

	return savedValue, isSavedValueValid
end

function BossRushRedModel:_getSavedValueByDSL(defineId, stage, layer)
	local uid = self:getUId(defineId, stage, layer)

	return self:_getSavedValue(defineId, uid)
end

function BossRushRedModel:_getDUSValueByDSL(defineId, stage, layer)
	local uid = self:getUId(defineId, stage, layer)
	local savedValue, isSavedValueValid = self:_getSavedValue(defineId, uid)

	return defineId, uid, savedValue, isSavedValueValid
end

function BossRushRedModel:_getValue(defineId, uid)
	local savedValue = self:_getSavedValue(defineId, uid)
	local isSavedValueValid = self:_isSValueValid(savedValue)
	local disPlayValue, isDisplayValueValid = self:_getDisplayValue(defineId, uid)

	return isSavedValueValid, savedValue, disPlayValue, isDisplayValueValid
end

function BossRushRedModel:_getValueByDSL(defineId, stage, layer)
	local uid = self:getUId(defineId, stage, layer)

	return self:_getValue(defineId, uid)
end

function BossRushRedModel:_startFlushData()
	local count = math.max(tabletool.len(self._delayUpdateRedValueList), tabletool.len(self._delayNeedUpdateDictList))

	if count == 0 then
		return
	end

	FrameTimerController.onDestroyViewMember(self, "_flushDataFrameTimer")

	self._flushDataFrameTimer = FrameTimerController.instance:register(self._tryFlushDatas, self, 3, count)

	self._flushDataFrameTimer:Start()
end

function BossRushRedModel:_onTick()
	local list = self._unlockBossIdList

	if not next(list) then
		self:_stopTick()

		return
	end

	for i, stage in pairs(list) do
		local isOnline = BossRushModel.instance:isBossOnline(stage)

		if isOnline and BossRushModel.instance:isBossOpen(stage) then
			list[i] = nil

			self:setIsNewUnlockStage(stage, true)
			self:setIsNewUnlockStageLayer(stage, 1, true)
		end
	end
end

function BossRushRedModel:_initRootRed(refList)
	tinsert(refList, self:_createByDSL(EDotNode.BossRushEnter))
	tinsert(refList, self:_createByDSL(EDotNode.BossRushOpen))
end

function BossRushRedModel:_initBossRed(refList)
	local config = self:_getConfig()
	local stages = config:getStages()

	if not stages then
		return
	end

	for _, v in pairs(stages) do
		local stage = v.stage
		local episodeStages = config:getEpisodeStages(stage)

		tinsert(refList, self:_createByDSL(EDotNode.BossRushBoss, stage))
		tinsert(refList, self:_createByDSL(EDotNode.BossRushNewBoss, stage))
		tinsert(refList, self:_createByDSL(EDotNode.BossRushBossReward, stage))

		for _, layerCO in pairs(episodeStages) do
			local layer = layerCO.layer

			tinsert(refList, self:_createByDSL(EDotNode.BossRushNewLayer, stage, layer))
		end
	end
end

function BossRushRedModel:_isSValueValid(value)
	assert(type(value) == "number")

	return value ~= kMagicNumber
end

function BossRushRedModel:_modifyOrMakeRedDotGroupItem(defineId, uid, newDisplayValue, _is_internal_clean)
	assert(type(newDisplayValue) == "number")

	local oldDisplayValue, isValid = self:_getDisplayValue(defineId, uid)

	if oldDisplayValue == newDisplayValue then
		return
	end

	local groupItem = self:_getRedDotGroupItem(defineId, uid)

	if (not groupItem or nil) and false then
		groupItem:reset({
			ext = groupItem.ext,
			time = groupItem.time,
			value = newDisplayValue
		})
	else
		RedDotRpc.instance:clientAddRedDotGroupList({
			{
				id = defineId,
				uid = uid,
				value = newDisplayValue
			}
		})
	end

	if _is_internal_clean then
		self:_trySave(defineId, uid, kMagicNumber)
	else
		self:_trySave(defineId, uid, newDisplayValue)
	end

	return true
end

function BossRushRedModel:_calcAssociateRedDots(refDict, defineId)
	local ids = RedDotModel.instance:_getAssociateRedDots(defineId)

	for _, id in pairs(ids or {}) do
		refDict[id] = true
	end
end

function BossRushRedModel:_tryShowRedDotGroupItem(defineId, uid, isShow, _is_internal_clean)
	local value = isShow and 1 or 0

	if self:_modifyOrMakeRedDotGroupItem(defineId, uid, value, _is_internal_clean) then
		local dict = {
			[kMagicNumber] = true
		}

		self:_calcAssociateRedDots(dict, defineId)
		RedDotController.instance:dispatchEvent(RedDotEvent.UpdateRelateDotInfo, dict)
	end
end

function BossRushRedModel:_refreshReward(refDict, stage)
	local defineId, uid = self:_getDUByDSL(EDotNode.BossRushBossReward, stage)
	local num1, ok1 = self:_getDisplayValueByDSL(EDotNode.BossRushBossSchedule, stage)
	local num2, ok2 = self:_getDisplayValueByDSL(EDotNode.BossRushBossAchievement, stage)
	local value = 0

	if ok1 then
		value = value + num1
	end

	if ok2 then
		value = value + num2
	end

	if self:_modifyOrMakeRedDotGroupItem(defineId, uid, value) then
		refDict[defineId] = trued
	end
end

function BossRushRedModel:_refreshNewBoss(refDict, stage)
	local defineId, uid, value, ok = self:_getDUSValueByDSL(EDotNode.BossRushNewBoss, stage)

	value = ok and value or 0

	if self:_modifyOrMakeRedDotGroupItem(defineId, uid, value) then
		refDict[defineId] = true
	end
end

function BossRushRedModel:_refreshNewLayer(refDict, stage, layer)
	local defineId, uid, value, ok = self:_getDUSValueByDSL(EDotNode.BossRushNewLayer, stage, layer)

	value = ok and value or 0

	if self:_modifyOrMakeRedDotGroupItem(defineId, uid, value) then
		refDict[defineId] = true
	end
end

function BossRushRedModel:refreshAllStageLayerUnlockState()
	local config = self:_getConfig()
	local stages = config:getStages()

	if not stages then
		return
	end

	for stage, _ in pairs(stages) do
		local stageInfo = BossRushModel.instance:getStageLayersInfo(stage)

		for _, layerInfo in pairs(stageInfo) do
			local isOpenLayer = layerInfo.isOpen
			local layer = layerInfo.layer
			local _, _, oldValue, isOldValueValid = self:_getDUSValueByDSL(EDotNode.BossRushNewLayer, stage, layer)

			if not isOldValueValid then
				if isOpenLayer then
					self:setIsNewUnlockStageLayer(stage, layer, true)
				end
			elseif not isOpenLayer and oldValue >= 1 then
				self:setIsNewUnlockStageLayer(stage, layer, false, true)
			end
		end
	end
end

function BossRushRedModel:_refreshOpen(refDict)
	local defineId, uid, value, ok = self:_getDUSValueByDSL(EDotNode.BossRushOpen)

	value = ok and value or 0

	if self:_modifyOrMakeRedDotGroupItem(defineId, uid, value) then
		refDict[defineId] = true
	end
end

function BossRushRedModel:_refreshBoss(refDict, stage)
	local defineId, uid = self:_getDUByDSL(EDotNode.BossRushBoss, stage)
	local config = self:_getConfig()
	local episodeStages = config:getEpisodeStages(stage)
	local num1, ok1 = self:_getSavedValueByDSL(EDotNode.BossRushNewBoss, stage)
	local num2, ok2 = self:_getDisplayValueByDSL(EDotNode.BossRushBossReward, stage)
	local num3 = 0

	for _, layerCO in pairs(episodeStages) do
		local layer = layerCO.layer
		local n, ok = self:_getSavedValueByDSL(EDotNode.BossRushNewLayer, stage, layer)

		if ok then
			num3 = num3 + n
		end
	end

	local value = num3

	if ok1 then
		value = value + num1
	end

	if ok2 then
		value = value + num2
	end

	if self:_modifyOrMakeRedDotGroupItem(defineId, uid, value) then
		refDict[defineId] = true
	end
end

function BossRushRedModel:_refreshRootInner(refDict)
	local defineId, uid = self:_getDUByDSL(EDotNode.BossRushEnter)
	local config = self:_getConfig()
	local stages = config:getStages()
	local num1, ok1 = self:_getSavedValueByDSL(EDotNode.BossRushOpen)
	local num2 = 0

	for _, v in pairs(stages) do
		local stage = v.stage
		local n, ok = self:_getDisplayValueByDSL(EDotNode.BossRushBoss, stage)

		if ok then
			num2 = num2 + n
		end
	end

	local value = num2

	if ok1 then
		value = value + num1
	end

	local defineId3, uid3 = self:_getDUByDSL(EDotNode.BossRushRankBonus)
	local isShow3 = RedDotModel.instance:isDotShow(defineId3, uid3)

	if isShow3 then
		value = value + 1
	end

	local defineId4, uid4 = self:_getDUByDSL(EDotNode.BossRushHankBookBossMainView)
	local isShow4 = RedDotModel.instance:isDotShow(defineId4, uid4)

	if isShow4 then
		value = value + 1
	end

	value = value + self:_getV3a9ActValue()

	if self:_modifyOrMakeRedDotGroupItem(defineId, uid, value) then
		refDict[defineId] = true
	end
end

function BossRushRedModel:_getV3a9ActValue()
	local value = 0

	for actId, info in pairs(V3a9BossRushEnum.ActReddot) do
		if ActivityHelper.isOpen(actId) then
			local _stages = BossRushConfig.instance:getStages(actId)

			if _stages then
				for _, v in pairs(_stages) do
					if self:isNewUnlockActStage(actId, v.stage) then
						value = value + 1
					end
				end
			end

			if RedDotModel.instance:isDotShow(RedDotEnum.DotNode.V3a9BossRushAct, 0) then
				value = value + 1
			end
		end
	end

	return value
end

function BossRushRedModel:_refreshRoot()
	local config = self:_getConfig()
	local stages = config:getStages()
	local dict = {}

	if not stages then
		return
	end

	for _, v in pairs(stages) do
		local stage = v.stage

		self:_refreshNewBoss(dict, stage)

		local episodeStages = config:getEpisodeStages(stage)

		for _, layerCO in pairs(episodeStages) do
			local layer = layerCO.layer

			self:_refreshNewLayer(dict, stage, layer)
		end

		self:_refreshReward(dict, stage)
		self:_refreshBoss(dict, stage)
	end

	self:_refreshOpen(dict)
	self:_refreshRootInner(dict)

	return dict
end

function BossRushRedModel:_getPrefsKey(defineId, uid)
	local actId = self:_getActivityId()

	if not uid then
		return kPrefix .. tostring(actId) .. tostring(defineId)
	end

	return kPrefix .. tostring(actId) .. tostring(defineId) .. "|" .. tostring(uid)
end

function BossRushRedModel:_save(defineId, uid, value)
	local playerPrefsKey = self:_getPrefsKey(defineId, uid)

	GameUtil.playerPrefsSetNumberByUserId(playerPrefsKey, value)
end

function BossRushRedModel:_get(defineId, uid, defaultValue)
	defaultValue = defaultValue or self:getDefaultValue(defineId)

	local playerPrefsKey = self:_getPrefsKey(defineId, uid)

	return GameUtil.playerPrefsGetNumberByUserId(playerPrefsKey, defaultValue)
end

function BossRushRedModel:_appendRefreshRedDict(dict)
	if type(dict) ~= "table" then
		return
	end

	table.insert(self._delayNeedUpdateDictList, dict)
end

function BossRushRedModel:_waitWarmUpOrJustRun(callback, ...)
	if self:_isWarmUp() then
		local args = {
			...
		}

		table.insert(self._delayUpdateRedValueList, {
			callback = callback,
			args = args
		})

		return
	end

	callback(...)
end

function BossRushRedModel:_tryRunRedDicts()
	local list = self._delayNeedUpdateDictList

	if #list == 0 then
		return true
	end

	local dict = table.remove(list)

	self:updateRelateDotInfo(dict)

	return false
end

function BossRushRedModel:_tryRunValueSetterCallbacks()
	local list = self._delayUpdateRedValueList

	if #list == 0 then
		return true
	end

	local dict = table.remove(list)
	local callback = dict.callback
	local args = dict.args

	callback(unpack(args))

	return false
end

function BossRushRedModel:_tryFlushDatas()
	local done1 = self:_tryRunRedDicts()
	local done2 = self:_tryRunValueSetterCallbacks()

	return done1 or done2
end

function BossRushRedModel:_isWarmUp()
	return self:_getRedDotGroup(EDotNode.BossRushEnter) == nil
end

function BossRushRedModel:isInitReady()
	return BossRushModel.instance:isActOnLine()
end

function BossRushRedModel:_stopTick()
	TaskDispatcher.cancelTask(self._onTick, self)
end

function BossRushRedModel:_startTick()
	self:_stopTick()

	local config = self:_getConfig()
	local stages = config:getStages()
	local list = {}

	if not stages then
		return
	end

	for _, v in pairs(stages) do
		local stage = v.stage
		local isOnline = BossRushModel.instance:isBossOnline(stage)

		if not isOnline and BossRushModel.instance:isBossOpen(stage) then
			list[#list + 1] = stage
		end
	end

	self._unlockBossIdList = list

	if #list > 0 then
		TaskDispatcher.runRepeat(self._onTick, self, 1)
	end
end

function BossRushRedModel:_tryUpdateMissingRed()
	local config = self:_getConfig()
	local stages = config:getStages()
	local activityId = BossRushModel.instance:getActivityId()
	local isOnline = ActivityModel.instance:isActOnLine(activityId)
	local _, _, oldValue, isOldValueValid = self:_getDUSValueByDSL(EDotNode.BossRushOpen)

	if not isOldValueValid then
		if isOnline then
			self:setIsOpenActivity(true)
		end
	elseif not isOnline and oldValue == 1 then
		self:setIsOpenActivity(false, true)
	end

	if not stages then
		return
	end

	for _, v in pairs(stages) do
		local stage = v.stage
		local isOpenStage = BossRushModel.instance:isBossOnline(stage) and BossRushModel.instance:isBossOpen(stage)
		local _, _, oldValue, isOldValueValid = self:_getDUSValueByDSL(EDotNode.BossRushNewBoss, stage)

		if not isOldValueValid then
			if isOpenStage then
				self:setIsNewUnlockStage(stage, true)
			end
		elseif not isOpenStage and oldValue >= 1 then
			self:setIsNewUnlockStage(stage, false, true)
		end

		local episodeStages = config:getEpisodeStages(stage)

		for _, layerCO in pairs(episodeStages) do
			local layer = layerCO.layer
			local isOpenLayer = isOpenStage and BossRushModel.instance:isBossLayerOpen(stage, layer) or false
			local _, _, oldValue, isOldValueValid = self:_getDUSValueByDSL(EDotNode.BossRushNewLayer, stage, layer)

			if not isOldValueValid then
				if isOpenLayer then
					self:setIsNewUnlockStageLayer(stage, layer, true)
				end
			elseif not isOpenLayer and oldValue >= 1 then
				self:setIsNewUnlockStageLayer(stage, layer, false, true)
			end
		end
	end
end

function BossRushRedModel:_flushCache()
	self:_startFlushData()
	self:_tryUpdateMissingRed()
	self:_startTick()
end

function BossRushRedModel:refreshClientCharacterDot()
	if not self:isInitReady() then
		return
	end

	if not self:_isWarmUp() then
		return
	end

	local list = {}

	self:_initRootRed(list)
	self:_initBossRed(list)

	local redList = {}

	for _, v in ipairs(list) do
		local ok = self:_isSValueValid(v.value)

		if ok then
			tinsert(redList, v)
		end
	end

	RedDotRpc.instance:clientAddRedDotGroupList(redList)
end

function BossRushRedModel:updateRelateDotInfo(dict)
	if self:_isWarmUp() then
		self:_appendRefreshRedDict(dict)

		return
	end

	if not dict then
		return
	end

	if not dict[EDotNode.BossRushEnter] then
		return
	end

	local newDict = self:_refreshRoot()

	if not self._flushCacheFrameTimer then
		self._flushCacheFrameTimer = FrameTimerController.instance:register(self._flushCache, self)

		self._flushCacheFrameTimer:Start()
	end

	if not newDict or not next(newDict) then
		return
	end

	if dict[kMagicNumber] then
		return
	end

	RedDotController.instance:dispatchEvent(RedDotEvent.UpdateRelateDotInfo, newDict)
end

function BossRushRedModel:getUId(defineId, stage, layer)
	if EDotNode.BossRushNewLayer == defineId then
		return stage * 1000 + layer
	end

	return stage or kDefaultUId
end

function BossRushRedModel:getDefaultValue(defineId)
	if defineId == EDotNode.BossRushOpen or defineId == EDotNode.BossRushNewBoss or defineId == EDotNode.BossRushNewLayer then
		return kMagicNumber
	end

	return 0
end

function BossRushRedModel:_trySave(defineId, uid, newDisplayValue)
	if defineId == EDotNode.BossRushBossReward or defineId == EDotNode.BossRushBossSchedule or defineId == EDotNode.BossRushBossAchievement then
		return
	end

	local ok, oldSaveValue = self:_getValue(defineId, uid)
	local newSavedValue = oldSaveValue

	if ok then
		newSavedValue = newDisplayValue
	elseif newDisplayValue > 0 then
		newSavedValue = newDisplayValue
	end

	if oldSaveValue ~= newSavedValue then
		self:_save(defineId, uid, newSavedValue)
	end
end

function BossRushRedModel:setIsOpenActivity(bool, _is_internal_clean)
	local defineId, uid = self:_getDUByDSL(EDotNode.BossRushOpen)

	self._waitWarmUpOrJustRun(self, self._tryShowRedDotGroupItem, self, defineId, uid, bool, _is_internal_clean)
end

function BossRushRedModel:setIsNewUnlockStage(stage, bool, _is_internal_clean)
	local defineId, uid = self:_getDUByDSL(EDotNode.BossRushNewBoss, stage)

	self._waitWarmUpOrJustRun(self, self._tryShowRedDotGroupItem, self, defineId, uid, bool, _is_internal_clean)
end

function BossRushRedModel:setIsNewUnlockStageLayer(stage, layer, bool, _is_internal_clean)
	local defineId, uid = self:_getDUByDSL(EDotNode.BossRushNewLayer, stage, layer)

	self._waitWarmUpOrJustRun(self, self._tryShowRedDotGroupItem, self, defineId, uid, bool, _is_internal_clean)
end

function BossRushRedModel:getIsNewUnlockStage(stage)
	return self:checkIsShow(EDotNode.BossRushNewBoss, stage)
end

function BossRushRedModel:getIsNewUnlockStageLayer(stage, layer)
	return self:checkIsShow(EDotNode.BossRushNewLayer, stage, layer)
end

function BossRushRedModel:getIsPlayUnlockAnimStage(stage)
	local actId = self:_getActivityId()
	local playerPrefsKey = string.format(BossRushEnum.PlayUnlockAnimStage, actId, stage)

	return GameUtil.playerPrefsGetNumberByUserId(playerPrefsKey, 0) == 0
end

function BossRushRedModel:setIsPlayUnlockAnimStage(stage, bool)
	local actId = self:_getActivityId()
	local playerPrefsKey = string.format(BossRushEnum.PlayUnlockAnimStage, actId, stage)

	GameUtil.playerPrefsSetNumberByUserId(playerPrefsKey, bool and 0 or 1)
end

function BossRushRedModel:checkIsShow(definedId, stage, layer)
	local ok, value1, value2 = self:_getValueByDSL(definedId, stage, layer)

	return ok and value1 >= 1 or value2 >= 1
end

local sRedDotEnumName, sMyPrintf, sUserId

function BossRushRedModel:_printerWarmUp()
	if not sRedDotEnumName then
		sRedDotEnumName = {}

		for name, _defineId in pairs(RedDotEnum.DotNode) do
			sRedDotEnumName[_defineId] = name
		end
	end

	sMyPrintf = sMyPrintf or getGlobal("ddd") or SLFramework.SLLogger.Log

	if not sUserId then
		local userId = PlayerModel.instance:getMyUserId()

		if userId and userId ~= 0 then
			sUserId = userId
		end
	end
end

function BossRushRedModel:_print(defineId)
	if not SLFramework.FrameworkSettings.IsEditor then
		return
	end

	if not defineId then
		return
	end

	self:_printerWarmUp()
	assert(sRedDotEnumName[defineId], "defineId = " .. defineId)

	function RedDotGroupMo:tostring()
		local id = self.id
		local infos = self.infos
		local groupName = sRedDotEnumName[id]
		local str = string.format("%s(%s):", groupName, tostring(id))
		local isEmpty = true

		for uid, RedDotInfoMO in pairs(infos) do
			if uid ~= 0 then
				local redCount = RedDotInfoMO.value

				str = string.format("%s\n\tuid: %s (%s)", str, tostring(uid), tostring(redCount))
				isEmpty = false
			end
		end

		if isEmpty then
			str = str .. " empty"
		end

		return str
	end

	local RedDotGroupMO = RedDotModel.instance:getRedDotInfo(defineId)

	if not RedDotGroupMO then
		sMyPrintf(sRedDotEnumName[defineId] .. ": null")

		return
	end

	sMyPrintf(RedDotGroupMO:tostring())
end

function BossRushRedModel:logDalayInfo()
	self:_printerWarmUp()
	sMyPrintf("#_delayNeedUpdateDictList=" .. tostring(#self._delayNeedUpdateDictList))
	sMyPrintf("#_delayUpdateRedValueList=" .. tostring(#self._delayUpdateRedValueList))
end

function BossRushRedModel:_delete(defineId, uid)
	local key = self:_getPrefsKey(defineId, uid)
	local userId = PlayerModel.instance:getMyUserId()

	if not userId or userId == 0 then
		userId = sUserId
	end

	if not userId then
		return
	end

	self:_printerWarmUp()

	local prefsKey = key .. "#" .. tostring(userId)

	if PlayerPrefsHelper.hasKey(prefsKey) then
		PlayerPrefsHelper.deleteKey(prefsKey)

		return key
	end

	sMyPrintf("_delete no existed prefsKey!!", prefsKey)
end

function BossRushRedModel:_deleteByDSL(defineId, stage, layer)
	local defineId, uid = self:_getDUByDSL(defineId, stage, layer)
	local deletedKey = self:_delete(defineId, uid)

	if not deletedKey then
		return
	end

	if not SLFramework.FrameworkSettings.IsEditor then
		return
	end

	if not defineId then
		return
	end

	self:_printerWarmUp()

	local str = "deleted " .. tostring(deletedKey)
	local desc = ""

	if stage and layer then
		desc = desc .. string.format("bossid: %s, layer: %s", stage, layer)
	elseif stage then
		desc = desc .. string.format("bossid: %s", stage)
	end

	str = str .. ": " .. desc

	sMyPrintf(str)
end

function BossRushRedModel:_reload()
	if not self:isInitReady() then
		return
	end

	self:_printerWarmUp()
	self:reInit()

	local list = {}

	self:_initRootRed(list)
	self:_initBossRed(list)

	local redList = {}

	for _, v in ipairs(list) do
		local ok = self:_isSValueValid(v.value)

		if ok then
			tinsert(redList, v)
		end
	end

	RedDotRpc.instance:clientAddRedDotGroupList(redList, true)
	sMyPrintf("<color=#00FF00>reload BossRushRedModel finished!!</color>")
end

function BossRushRedModel:setIsV3a9NewUnlockStage(actId, stage, bool)
	if not V3a9BossRushEnum.ActReddot[actId] then
		return
	end

	local mo = V3a9_BossRushModel.instance:getStageMo(actId, stage)

	if not mo then
		return
	end

	local list = {}

	mo:setIsNewUnlockStage(bool)

	local defineId = V3a9BossRushEnum.ActReddot[actId].NewBoss
	local info = {
		id = defineId,
		uid = stage,
		value = bool and 1 or 0
	}

	table.insert(list, info)
	RedDotRpc.instance:clientAddRedDotGroupList(list)
	RedDotController.instance:dispatchEvent(RedDotEvent.UpdateRelateDotInfo, list)
end

function BossRushRedModel:isNewUnlockActStage(actId, stage)
	local key = string.format("%s_%s_%s", V3a9BossRushEnum.PlayerPrefKey.NewUnlockStage, actId, stage)
	local value = GameUtil.playerPrefsGetNumberByUserId(key, 0)

	return value == 0
end

function BossRushRedModel:setIsNewUnlockActStage(actId, stage, isNew)
	local key = string.format("%s_%s_%s", V3a9BossRushEnum.PlayerPrefKey.NewUnlockStage, actId, stage)

	GameUtil.playerPrefsSetNumberByUserId(key, isNew and 0 or 1)
end

BossRushRedModel.instance = BossRushRedModel.New()

return BossRushRedModel
