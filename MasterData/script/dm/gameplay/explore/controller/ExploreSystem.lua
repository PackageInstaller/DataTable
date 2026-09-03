-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/explore/controller/ExploreSystem.lua

ExploreSystem = class("ExploreSystem", Facade, _M)

ExploreSystem:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ExploreSystem:has("_exploreService", {
	is = "r"
}):injectWith("ExploreService")
ExploreSystem:has("_rankSystem", {
	is = "r"
}):injectWith("RankSystem")
ExploreSystem:has("_customDataSystem", {
	is = "r"
}):injectWith("CustomDataSystem")
ExploreSystem:has("_partyManage", {
	is = "r"
})
ExploreSystem:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")
ExploreSystem:has("_taskSystem", {
	is = "r"
}):injectWith("TaskSystem")
ExploreSystem:has("_shopSystem", {
	is = "r"
}):injectWith("ShopSystem")
ExploreSystem:has("_currentPointId", {
	is = "rw"
})

ExploreZombieState = {
	kClose = 0,
	kOpen = 1,
	kHide = -1
}
ExploreCloseChooseId = "999"

local MapOpenType = {
	openType = 1
}

function ExploreSystem:initialize()
	super.initialize(self)

	self._currentPointId = ""
	self._isFirst = true
	self._showStack = {
		false
	}
end

function ExploreSystem:userInject(injector)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_EXPLORE_SAVE_LOG, self, self.syncLog)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PLAYER_SYNCHRONIZED, self, self.syncMapAndPointStatus)
end

function ExploreSystem:dispose()
	super.dispose(self)
end

function ExploreSystem:checkEnabled(param)
	local unlock, tips = self._systemKeeper:isUnlock("BlockSp_All")

	if not unlock then
		return unlock, tips
	end

	unlock, tips = self._systemKeeper:isUnlock("Map_Explore")

	return unlock, tips
end

function ExploreSystem:tryEnter(param)
	local unlock, tips = self:checkEnabled(param)

	if not unlock then
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = tips
		}))

		return
	end

	local mapKey = self._developSystem:getExplore():getCurPointId()

	if mapKey and #mapKey > 0 then
		self._currentPointId = self._developSystem:getExplore():getCurPointId()

		local view = self:getInjector():getInstance("ExploreMapView")
		local event = ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
			pointId = mapKey
		})

		self:dispatch(event)

		return
	end

	self:cleanExploreData()

	local function callback()
		local view = self:getInjector():getInstance("ExploreView")

		self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil))
	end

	self._rankSystem:cleanUpRankListByType(RankType.kMap)

	local sendData = {
		rankStart = 1,
		type = RankType.kMap,
		rankEnd = self._rankSystem:getRequestRankCountPerTime()
	}

	self._rankSystem:requestRankData(sendData, callback)
end

function ExploreSystem:syncShop(data)
	if data.data.shop then
		self._shopSystem:syncDiffShop(data.data)
	end
end

function ExploreSystem:syncLog(logData)
	logData = logData:getData()

	local data = CommonUtils.getDataFromLocalByKey(EXPLORE_LOG_KEY)

	data = data or {
		logIdArr = {},
		logIdMap = {}
	}

	if logData.caseId and logData.logId then
		local key = logData.caseId .. "$" .. logData.logId

		data.logIdMap[key] = true
		data.logIdArr[#data.logIdArr + 1] = key

		CommonUtils.saveDataToLocalByKey(data, EXPLORE_LOG_KEY)
	end
end

function ExploreSystem:syncMapAndPointStatus()
	self:updateMapStatus()
	self:updateMapTypeStatus()
	self:syncCanSpeed()
end

function ExploreSystem:updateMapTypeStatus()
	local playerLevel = self._developSystem:getLevel()

	for i, obj in pairs(self:getMapTypeDic()) do
		local isLock = false
		local lockTip = ""
		local condition = obj:getUnlockCondition()
		local openType = obj:getOpenType()

		if openType == 1 then
			isLock = true
			lockTip = Strings:get("EXPLORE_UI112")
		else
			if condition.LEVEL then
				isLock = playerLevel < condition.LEVEL
				lockTip = isLock and Strings:get("EXPLORE_UI2", {
					level = condition.LEVEL
				}) or ""
			end

			if condition.ALLDP then
				local preStatus = isLock

				isLock = isLock or condition.ALLDP > self._totalDp
				lockTip = preStatus and lockTip or isLock and Strings:get("EXPLORE_UI71", {
					dpNum = condition.ALLDP
				}) or lockTip
			end

			if condition.PREPOINT then
				local preStatus = isLock

				for i, v in pairs(condition.PREPOINT) do
					if v > obj:getTimes() then
						isLock = true
						lockTip = preStatus and lockTip or Strings:get("EXPLORE_UI6", {
							times = v
						})

						break
					end
				end
			end
		end

		obj:setLockTip(lockTip)
		obj:setLock(isLock)
	end
end

function ExploreSystem:updateMapStatus()
	local playerLevel = self._developSystem:getLevel()

	for id, obj in pairs(self:getPointMap()) do
		local isLock = false
		local lockTip = ""
		local condition = obj:getUnlockCondition()
		local openType = obj:getOpenType()

		if openType == 1 then
			isLock = true
			lockTip = Strings:get("EXPLORE_UI112")
		else
			if condition.LEVEL then
				isLock = playerLevel < condition.LEVEL
				lockTip = isLock and Strings:get("EXPLORE_UI2", {
					level = condition.LEVEL
				}) or ""
			end

			if condition.DP then
				local mapObj = self:getMapTypeDic()[obj:getMapType()]
				local preStatus = isLock

				isLock = isLock or condition.DP > mapObj:getDpNum()
				lockTip = preStatus and lockTip or isLock and Strings:get("EXPLORE_UI5", {
					dpNum = condition.DP
				}) or lockTip
			end

			if condition.ALLDP then
				local preStatus = isLock

				isLock = isLock or condition.ALLDP > self._totalDp
				lockTip = preStatus and lockTip or isLock and Strings:get("EXPLORE_UI5", {
					dpNum = condition.ALLDP
				}) or lockTip
			end

			if condition.PREPOINT then
				local preStatus = isLock

				for i, v in pairs(condition.PREPOINT) do
					local targetObj = self:getMapPointObjById(i)

					if v > targetObj:getMapTaskCount() then
						isLock = true
						lockTip = preStatus and lockTip or Strings:get("EXPLORE_UI6", {
							times = v
						})

						break
					end
				end
			end
		end

		obj:setLockTip(lockTip)
		obj:setLock(isLock)
	end
end

function ExploreSystem:cleanExploreData()
	CommonUtils.saveDataToLocalByKey({
		logIdArr = {},
		logIdMap = {}
	}, EXPLORE_LOG_KEY)
	self:setAutoBattleStatus(false)

	local pointData = self:getMapPointObjById(self._currentPointId)

	if pointData then
		pointData:setBuff({})
		pointData:setMapObjProgress({})

		self._currentPointId = ""
	end

	local customKey = CustomDataKey.kExploreFinish
	local customData = self._customDataSystem:getValue(PrefixType.kGlobal, customKey)

	if customData then
		self._customDataSystem:setValue(PrefixType.kGlobal, customKey, "0")
	end

	customKey = CustomDataKey.kExploreBuff
	customData = self._customDataSystem:getValue(PrefixType.kGlobal, CustomDataKey.kExploreBuff)

	if customData then
		self._customDataSystem:setValue(PrefixType.kGlobal, customKey, "")
	end

	self._autoPlayMapId = nil
end

function ExploreSystem:getMapPointIds()
	return self._developSystem:getExplore():getPointIdArray()
end

function ExploreSystem:getMapPointObjById(id)
	return self._developSystem:getExplore():getMapPointObjById(id)
end

function ExploreSystem:getPointMap()
	return self._developSystem:getExplore():getPointMap()
end

function ExploreSystem:getDailyRecommendTimes()
	local bagSystem = self._developSystem:getBagSystem()
	local time1 = bagSystem:getTimeRecordById(TimeRecordType.kMapDailyRewardTimes):getTime()
	local time2 = self._developSystem:getPlayer():getEffectCenter():getExtraUpById("map")

	return time1 + time2
end

function ExploreSystem:doReset(resetId, value)
	value = value or 0

	if resetId == ResetId.kMapDailyRewardReset or resetId == resetId.kMapPointReset then
		self:dispatch(Event:new(EVT_EXPLORE_RESET_MAPCOUNT))
	end
end

function ExploreSystem:getTaskDescByCondition(condition)
	local conditionkeeper = self:getInjector():getInstance(Conditionkeeper)
	local str = ""

	for i = 1, #condition do
		str = i ~= 1 and str .. "," .. conditionkeeper:getConditionDesc(condition[i]) or str .. conditionkeeper:getConditionDesc(condition[i])
	end

	return str
end

function ExploreSystem:getHpMax()
	return (ConfigReader:requireDataByNameIdAndKey("ConfigValue", "MapInitTeamHP", "content"))
end

function ExploreSystem:getCostItemMap()
	return (ConfigReader:requireDataByNameIdAndKey("ConfigValue", "Map_HP_Item", "content"))
end

function ExploreSystem:getItemRecoverNum()
	return (ConfigReader:requireDataByNameIdAndKey("ConfigValue", "Map_HP_ItemEffect", "content"))
end

function ExploreSystem:getMapDailyRewardTime()
	local config = ConfigReader:getRecordById("Reset", ResetId.kMapDailyRewardReset)

	if config and config.ResetSystem then
		local resetData = config.ResetSystem

		return resetData.max or resetData.setValue or 0
	end

	return 0
end

function ExploreSystem:getHpBuff(hp)
	local numMap = ConfigReader:requireDataByNameIdAndKey("ConfigValue", "MapHPBuff", "content")

	for i = 1, #numMap do
		if hp >= tonumber(numMap[i][1]) and hp <= tonumber(numMap[i][2]) then
			return numMap[i][4], numMap[i][5]
		end
	end

	return ""
end

function ExploreSystem:getMapTask(ids)
	local task = {}
	local taskModels = self._taskSystem:getShowMapTaskList()

	for i = 1, #taskModels do
		local value = taskModels[i]
		local id = value:getId()

		if ids[id] then
			local var_24_0 = {
				status = value:getStatus()
			}

			var_24_0.desc = value:getDesc() ~= "" and value:getDesc() or self:getTaskDescByCondition(value:getCondition())
			var_24_0.id = id
			var_24_0.taskType = value:getTaskType()
			var_24_0.reward = value:getConfig().Reward
			var_24_0.taskValues = value:getTaskValueList()
			task[#task + 1] = var_24_0
		end
	end

	table.sort(task, function(a, b)
		return a.id < b.id
	end)

	return task
end

function ExploreSystem:getMapTypes()
	return self._developSystem:getExplore():getMapTypeArr()
end

function ExploreSystem:getMapTypesOpen()
	local mapTypeArr = self._developSystem:getExplore():getMapTypeArr()
	local tab = {}

	for k, data in pairs(mapTypeArr) do
		local openType = data:getOpenType()

		if openType ~= MapOpenType.openType then
			tab[#tab + 1] = data
		end
	end

	return tab
end

function ExploreSystem:getMapTypesDic(id)
	return self:getMapTypeDic()[id]
end

function ExploreSystem:getMapTasksById(id)
	local mapData = self:getMapTypesDic(id)
	local showData = {}
	local showDataTemp = {}
	local keys = {}
	local curDp = mapData:getDpNum()
	local length = #mapData:getDPTask()

	for i = 1, length do
		local id = mapData:getDPTask()[i]
		local taskData = mapData:getTaskMap()[id]
		local targetMapName = taskData:getTargetMapName()

		if curDp >= taskData:getNeedDP() and targetMapName ~= "" then
			if not showDataTemp[targetMapName] then
				table.insert(keys, targetMapName)

				showDataTemp[targetMapName] = {}
			end

			table.insert(showDataTemp[targetMapName], {
				type = "task",
				id = id
			})
		end
	end

	table.sort(keys, function(a, b)
		return a < b
	end)

	for i = 1, #keys do
		local key = keys[i]
		local tasks = showDataTemp[key]

		table.sort(tasks, function(a, b)
			local dataA = mapData:getTaskMapById(a.id)
			local dataB = mapData:getTaskMapById(b.id)

			if dataA:getIsComplete() and dataB:getIsComplete() or not dataA:getIsComplete() and not dataB:getIsComplete() then
				return a.id < b.id
			end

			return not dataA:getIsComplete() and dataB:getIsComplete()
		end)
		table.insert(showData, {
			type = "title",
			text = Strings:get(key)
		})

		for j = 1, #tasks do
			table.insert(showData, tasks[j])
		end
	end

	return showData
end

function ExploreSystem:getMapTypeDic()
	return self._developSystem:getExplore():getMapTypeDic()
end

function ExploreSystem:getEnterTotalTimes()
	local config = ConfigReader:getRecordById("Reset", ResetId.kMapPointReset)

	if config and config.ResetSystem then
		local resetData = config.ResetSystem

		return resetData.max or resetData.setValue or 0
	end

	return 0
end

function ExploreSystem:getEnterTimes()
	return self._developSystem:getExplore():getEnterTimes()
end

function ExploreSystem:getTabFilterMap()
	if self._tabFilterMap then
		return self._tabFilterMap
	end

	self._tabFilterMap = {
		function(item)
			return item:getType() ~= ItemPages.kOther and item:getSubType() ~= ItemTypes.K_POWER
		end,
		function(item)
			local id = item:getConfigId()
			local config = ConfigReader:getRecordById("MapItem", id)

			return item:getType() == ItemPages.kOther and not not config
		end,
		function(item)
			local id = item:getConfigId()
			local config = ConfigReader:getRecordById("MapItem", id)

			return item:getType() == ItemPages.kOther and not config
		end
	}

	return self._tabFilterMap
end

function ExploreSystem:getAllEntryIds(style)
	local function filterFunc(entry)
		return true
	end

	local allEntryIds = self._developSystem:getExplore():getExploreBag():getEntryIds(filterFunc)

	local function isEnergyItem(item)
		return item and item:getType() == ItemPages.kConsumable and item:getSubType() == ComsumableKind.kActionPoint
	end

	local function isCurrency(item)
		return item and item:getType() == ItemPages.kCurrency and item:getSubType() ~= ComsumableKind.kActionPoint
	end

	local function isBox(item)
		if item then
			return item:getType() == ItemPages.kConsumable and item:getSubType() == ComsumableKind.kBox
		end
	end

	local function isDiamondBox(item)
		if item then
			return item:getType() == ItemPages.kConsumable and item:getSubType() == ComsumableKind.kDiamondBox
		end
	end

	local function isCrystalItem(item)
		if item then
			return item:getType() == ItemPages.kConsumable and item:getSubType() == ComsumableKind.kCrystalItem
		end
	end

	table.sort(allEntryIds, function(entryIdA, entryIdB)
		local entryA = self:getEntryById(entryIdA)
		local entryB = self:getEntryById(entryIdB)
		local itemA = entryA.item
		local itemB = entryB.item

		repeat
			local aCurrencyFlag = isCurrency(itemA) and 1 or 0
			local bCurrencyFlag = isCurrency(itemB) and 1 or 0

			if aCurrencyFlag + bCurrencyFlag ~= 0 then
				if aCurrencyFlag + bCurrencyFlag == 1 then
					return aCurrencyFlag == 1
				else
					break
				end
			end

			local aEnergyFlag = isEnergyItem(itemA) and 1 or 0
			local bEnergyFlag = isEnergyItem(itemB) and 1 or 0

			if aEnergyFlag + bEnergyFlag ~= 0 then
				if aEnergyFlag + bEnergyFlag == 1 then
					return aEnergyFlag == 1
				else
					break
				end
			end

			local aBoxFlag = isDiamondBox(itemA) and 1 or 0
			local bBoxFlag = isDiamondBox(itemB) and 1 or 0

			if aBoxFlag + bBoxFlag ~= 0 then
				if aBoxFlag + bBoxFlag == 1 then
					return aBoxFlag == 1
				else
					break
				end
			end

			local aBoxFlag = isCrystalItem(itemA) and 1 or 0
			local bBoxFlag = isCrystalItem(itemB) and 1 or 0

			if aBoxFlag + bBoxFlag ~= 0 then
				if aBoxFlag + bBoxFlag == 1 then
					return aBoxFlag == 1
				else
					break
				end
			end

			local aBoxFlag = isBox(itemA) and 1 or 0
			local bBoxFlag = isBox(itemB) and 1 or 0

			if aBoxFlag + bBoxFlag ~= 0 and aBoxFlag + bBoxFlag == 1 then
				return aBoxFlag == 1
			end

			do break end
			break
		until true

		if itemA:getQuality() ~= itemB:getQuality() then
			return itemA:getQuality() > itemB:getQuality()
		end

		local weightA = itemA:getType()
		local weightB = itemB:getType()

		if weightA and weightA ~= weightB then
			return weightB < weightA
		end

		return itemA:getSort() > itemB:getSort()
	end)

	return allEntryIds
end

function ExploreSystem:getEntryById(entryId)
	return self._developSystem:getExplore():getExploreBag():getEntryById(entryId)
end

function ExploreSystem:getCountByCurrencyType(entryId)
	local entry = self:getEntryById(entryId)

	return (entry or nil) and (entry.count or 0)
end

function ExploreSystem:enterMapById(callback, params, blockUI, ins)
	self._exploreService:enterMapById(function(response)
		if response.resCode == GS_SUCCESS then
			self._currentPointId = self._developSystem:getExplore():getCurPointId()

			if ins and ins._isDisposed then
				return
			end

			local pointData = self:getPointMap()[self._currentPointId]

			if pointData then
				pointData:synchronize(response.data)
			end

			if callback and checkDependInstance(ins) then
				callback(response)
			end
		end
	end, params, blockUI)
end

function ExploreSystem:deleteItems(list)
	if list.items then
		for k, v in pairs(list.items) do
			self._developSystem:getExplore():getExploreBag():removeItem(k)
		end
	end
end

function ExploreSystem:getItemCount(itemId)
	local entry = self:getEntryById(tostring(itemId))

	if itemId == CurrencyIdKind.kPower then
		return self:getPower()
	end

	return (entry ~= nil or nil) and (entry.count or 0)
end

function ExploreSystem:checkIsShowRedPoint()
	local mapKey = self._developSystem:getExplore():getCurPointId()

	if mapKey and #mapKey > 0 then
		return true
	end

	return false
end

function ExploreSystem:isRecommendPoint(targetWeek)
	local gameServerAgent = self:getInjector():getInstance("GameServerAgent")
	local times = self:getDailyRecommendTimes()
	local isRecommend = false
	local resetHour = 5
	local curTime = gameServerAgent:remoteTimestamp()
	local hour = TimeUtil:remoteDate(nil, curTime).hour
	local curWeekDay = ResetUtils:getRemoteWeek(curTime)

	for i = 1, #targetWeek do
		if curWeekDay - targetWeek[i] == 0 then
			if resetHour <= hour then
				isRecommend = true

				break
			end
		elseif (targetWeek[i] == 7 and curWeekDay == 1 or curWeekDay - targetWeek[i] == 1) and hour < resetHour then
			isRecommend = true

			break
		end
	end

	return isRecommend and times > 0
end

function ExploreSystem:getAutoBattleStatus()
	return self._developSystem:getPlayer():getExplore():getAutoBattle()
end

function ExploreSystem:setAutoBattleStatus(auto)
	self._developSystem:getPlayer():getExplore():setAutoBattle(auto)
end

function ExploreSystem:canAuto(pointData)
	local condition = pointData:getUnlockAuto()
	local maxProgress = pointData:getMaxProgress()
	local mapObj = self:getMapTypesDic(pointData:getMapType())
	local tip = ""
	local unlock = true

	if condition.DP and condition.DP > mapObj:getDpNum() then
		tip = Strings:get("EXPLORE_UI105", {
			dpNum = condition.DP
		})
		unlock = false
	end

	if condition.MapGuide and maxProgress < condition.MapGuide then
		if not unlock then
			tip = Strings:get("EXPLORE_UI106", {
				num = condition.MapGuide,
				dpNum = condition.DP
			})
		else
			tip = Strings:get("EXPLORE_UI98", {
				num = condition.MapGuide
			})
			unlock = false
		end
	end

	return unlock, tip
end

function ExploreSystem:getSpeedEffect()
	local params = ConfigReader:getDataByNameIdAndKey("SkillSpecialEffect", "SpFunc_WorldmapSpeedUp", "Parameter")

	if params and params.type and params.value then
		local value = self._developSystem:getPlayer():getEffectCenter():getSpEffectById(params.type)

		if value then
			return params.value
		end
	end

	return false
end

function ExploreSystem:getSpeedStatus()
	return (cc.UserDefault:getInstance():getStringForKey(UserDefaultKey.kExploreSpeedKey))
end

function ExploreSystem:canSpeed()
	return self:getSpeedEffect() and self:getSpeedStatus() == "1"
end

function ExploreSystem:syncCanSpeed()
	if self:getSpeedEffect() and self:getSpeedStatus() == "" then
		self:setCanSpeed("1")
	end
end

function ExploreSystem:setCanSpeed(canSpeed)
	if canSpeed ~= "0" and canSpeed ~= "1" then
		return
	end

	cc.UserDefault:getInstance():setStringForKey(UserDefaultKey.kExploreSpeedKey, canSpeed)
end

function ExploreSystem:KeepAutoPlayTeamHpEnough(callback)
	local pointData = self:getMapPointObjById(self._currentPointId)

	if pointData and pointData:getTeams()[1] then
		local hp = pointData:getTeams()[1]:getHp()
		local hpMax = self:getHpMax()
		local minHp = ConfigReader:getDataByNameIdAndKey("ConfigValue", "MapAutoUseTeamHP", "content")
		local count = self:getItemCount(self:getCostItemMap())

		if hp < hpMax and hp < minHp and count > 0 then
			self:requestUseHpItem(function()
				if callback then
					callback()
				end
			end, {
				mainId = "1"
			})

			return
		end
	end

	if callback then
		callback()
	end
end

function ExploreSystem:checkPointInTargetRectByGrid(curGrid, triggerRect)
	if curGrid.x >= triggerRect.minX and curGrid.x <= triggerRect.maxX and curGrid.y >= triggerRect.minY and curGrid.y <= triggerRect.maxY then
		return true
	end

	return false
end

function ExploreSystem:getGridByPos(pos)
	local grid = {}

	grid.y = ExploreTypeCfgInfo.blockGridNumSize.height - 1 - math.floor(pos.y / ExploreTypeCfgInfo.blockGridSize.height)
	grid.x = math.floor(pos.x / ExploreTypeCfgInfo.blockGridSize.width)

	return grid
end

function ExploreSystem:getRectByGrid(grid, offsetRect)
	local x1 = grid.x + offsetRect[1][1]
	local x2 = grid.x + offsetRect[2][1]
	local y1 = grid.y + offsetRect[1][2]
	local y2 = grid.y + offsetRect[2][2]
	local minX, minY, maxX, maxY = x1, y1, x2, y2

	if maxX < minX then
		minX = x2
		maxX = x1
	end

	if maxY < minY then
		minY = y2
		maxY = y1
	end

	return {
		minX = minX,
		minY = minY,
		maxX = maxX,
		maxY = maxY
	}
end

function ExploreSystem:move(callback, params, blockUI, ins)
	self._exploreService:move(function(response)
		if callback and checkDependInstance(ins) then
			callback(response)
		end
	end, params, blockUI)
end

function ExploreSystem:requestGetDPTaskReward(callback, params, blockUI, ins)
	self._exploreService:requestGetDPTaskReward(function(response)
		if response.resCode == GS_SUCCESS and callback and checkDependInstance(ins) then
			callback(response)
		end
	end, params, blockUI)
end

function ExploreSystem:requestExploreFinish(params, callback, blockUI, ins)
	self._exploreService:requestExploreFinish(function(response)
		if response.resCode == GS_SUCCESS then
			self:cleanExploreData()

			local data = response.data

			for i, v in pairs(params) do
				data[i] = v
			end

			local view = self:getInjector():getInstance("ExploreFinishView")

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, {
				data = data,
				callback = function()
					self:dispatch(Event:new(EVT_EXPLORE_FINISH, params))
				end
			}))
		end
	end, params, blockUI)
end

function ExploreSystem:startTrigger(callback, params, blockUI, ins)
	self._exploreService:startTrigger(function(response)
		if response.resCode == GS_SUCCESS then
			self:syncShop(response)

			if callback and checkDependInstance(ins) then
				callback(response)
			end
		end
	end, params, blockUI)
end

function ExploreSystem:endTrigger(callback, params, blockUI, ins)
	self._exploreService:endTrigger(function(response)
		if response.resCode == GS_SUCCESS then
			local function finishCallBack()
				self:syncShop(response)

				if callback and checkDependInstance(ins) then
					callback(response)
				end

				self:dispatch(Event:new(EVT_EXPLORE_END_SUCC))
			end

			if response.data.reviewFailed then
				local data = {
					title = Strings:get("Tip_Remind"),
					title1 = Strings:get("UITitle_EN_Tishi"),
					content = Strings:get("FAC_Des"),
					sureBtn = {
						text1 = "FAC_Btn"
					}
				}
				local outSelf, delegate = self, {}

				function delegate:willClose(popupMediator, data)
					finishCallBack()
				end

				local view = self:getInjector():getInstance("AlertView")

				self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
					transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
				}, data, delegate))
			else
				finishCallBack()
			end
		end
	end, params, blockUI)
end

function ExploreSystem:requestPublishPointComment(callback, params, blockUI, ins)
	self._exploreService:requestPublishPointComment(function(response)
		if response.resCode == GS_SUCCESS and callback and checkDependInstance(ins) then
			callback(response)
		end
	end, params, blockUI)
end

function ExploreSystem:requestSupportPointComment(callback, params, blockUI, ins)
	self._exploreService:requestSupportPointComment(function(response)
		if response.resCode == GS_SUCCESS and callback and checkDependInstance(ins) then
			callback(response)
		end
	end, params, blockUI)
end

function ExploreSystem:requestGetPointComment(callback, params, blockUI, ins)
	self._exploreService:requestGetPointComment(function(response)
		if response.resCode == GS_SUCCESS and callback and checkDependInstance(ins) then
			callback(response)
		end
	end, params, blockUI)
end

function ExploreSystem:debugMove(callback, params, blockUI, ins)
	self._exploreService:debugMove(function(response)
		if response.resCode == GS_SUCCESS and callback and checkDependInstance(ins) then
			callback(response)
		end
	end, params, blockUI)
end

function ExploreSystem:requestUseHpItem(callback, params, blockUI, ins)
	self._exploreService:requestUseHpItem(function(response)
		if response.resCode == GS_SUCCESS then
			if callback and checkDependInstance(ins) then
				callback(response)
			end

			self:dispatch(Event:new(EVT_EXPLORE_ADDPOWER_SUCC))
		end
	end, params, blockUI)
end

function ExploreSystem:requestSetCurTeam(callback, params, blockUI, ins)
	self._exploreService:requestCurTeam(function(response)
		if response.resCode == GS_SUCCESS then
			self:dispatch(Event:new(EVT_EXPLORE_SETTEAM_SUCC, params))
			self:dispatch(ShowTipEvent({
				tip = Strings:get("EXPLORE_UI122")
			}))

			if callback and checkDependInstance(ins) then
				callback(response)
			end
		end
	end, params, blockUI)
end

function ExploreSystem:requestSaveTeam(callback, params, blockUI, ins)
	self._exploreService:requestSaveTeam(function(response)
		if response.resCode == GS_SUCCESS and callback and checkDependInstance(ins) then
			callback(response)
		end
	end, params, blockUI)
end

function ExploreSystem:requestUseItem(callback, params, blockUI, ins)
	self._exploreService:requestUseItem(function(response)
		if response.resCode == GS_SUCCESS and callback and checkDependInstance(ins) then
			callback(response)
		end
	end, params, blockUI)
end

function ExploreSystem:requestGetBattleData(callback, params, blockUI, ins)
	self._exploreService:requestGetBattleData(function(response)
		if response.resCode == GS_SUCCESS and callback and checkDependInstance(ins) then
			callback(response)
		end
	end, params, blockUI)
end

function ExploreSystem:requestSweepPoint(pointId, times, callback)
	local params = {
		pointId = pointId,
		times = times
	}

	self._exploreService:requestSwppePoint(params, true, function(response)
		if response.resCode == GS_SUCCESS and callback then
			callback(response)
		end
	end)
end

function ExploreSystem:getPointConfigById(pointId)
	return ConfigReader:getRecordById("MapBattlePoint", pointId)
end

function ExploreSystem:getFightFinishData(isClean)
	if isClean then
		self._fightFinishData = nil
	end

	return self._fightFinishData
end

function ExploreSystem:immediateBattle(pointId, battleDataS, extraData)
	local playerData = battleDataS.playerData
	local enemyData = battleDataS.enemyData
	local randomSeed1 = tonumber(tostring(os.time()):reverse():sub(1, 6))
	local randomSeed2 = tonumber(tostring(os.time() / 2):reverse():sub(1, 6))
	local randomSeed3 = tonumber(tostring(os.time() / 3):reverse():sub(1, 6))
	local outSelf, battleDelegate = self, {}
	local battleSession = ExploreBattleSession:new({
		playerData = playerData,
		enemyData = enemyData,
		pointId = pointId,
		logicSeed = randomSeed1,
		strategySeedA = randomSeed2,
		strategySeedB = randomSeed3
	})

	battleSession:buildAll()

	local battleData = battleSession:getPlayersData()
	local battleConfig = battleSession:getBattleConfig()
	local battleSimulator = battleSession:getBattleSimulator()
	local battleLogic = battleSimulator:getBattleLogic()

	battleSession:setupAIController()

	local battleInterpreter = BattleInterpreter:new()

	battleInterpreter:setRecordsProvider(battleSession:getBattleRecordsProvider())

	local battleDirector = LocalBattleDirector:new()

	battleDirector:setBattleSimulator(battleSimulator)
	battleDirector:setBattleInterpreter(battleInterpreter)

	local timeout = 600000
	local elapsed = 0
	local err
	local interval = 50

	battleSimulator:start(interval)

	while true do
		local status = battleSimulator:tick(interval)

		elapsed = elapsed + interval

		if status ~= nil then
			break
		end

		if timeout ~= nil and timeout <= elapsed then
			err = {
				log = "Battle simulator timed out!",
				code = BattleErrorCode.kTimeOut
			}

			break
		end
	end

	return battleSession:getDetailedResultSummary(err)
end

function ExploreSystem:enterBattle(pointId, battleDataS, extraData, isAutoPlay)
	local playerData = battleDataS.playerData
	local enemyData = battleDataS.enemyData
	local battleType = SettingBattleTypes.kExplore
	local isAuto, timeScale = self:getInjector():getInstance(SettingSystem):getSettingModel():getBattleSetting(battleType)
	local isReplay = false
	local skipTime = tonumber(ConfigReader:getDataByNameIdAndKey("ConfigValue", "Arena_SkipBattle_WaitTime", "content"))
	local systemKeeper = self:getInjector():getInstance("SystemKeeper")

	local function callback(report)
		self:endTrigger(function(response)
			self._fightFinishData = {
				response = response,
				extraData = extraData,
				isWin = report.result == 1
			}

			local function tempFunc()
				self:dispatch(Event:new(EVT_EXPLORE_FIGHT_FINISH))
			end

			if isAutoPlay then
				tempFunc()

				return
			end

			local view = self:getInjector():getInstance("ExploreBattleFinishView")

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, {
				report = response.data,
				callBack = tempFunc
			}))
		end, {
			objectId = extraData.objData:getId(),
			params = report
		}, true)
	end

	if isAutoPlay then
		callback(self:immediateBattle(pointId, battleDataS))

		return
	end

	local outSelf, battleDelegate = self, {}
	local randomSeed = tonumber(tostring(os.time()):reverse():sub(1, 6))
	local battleSession = ExploreBattleSession:new({
		playerData = playerData,
		enemyData = enemyData,
		pointId = pointId,
		logicSeed = randomSeed
	})

	battleSession:buildAll()

	local battleData = battleSession:getPlayersData()
	local battleConfig = battleSession:getBattleConfig()
	local battleSimulator = battleSession:getBattleSimulator()
	local battleLogic = battleSimulator:getBattleLogic()
	local battleInterpreter = BattleInterpreter:new()

	battleInterpreter:setRecordsProvider(battleSession:getBattleRecordsProvider())

	local battleDirector = LocalBattleDirector:new()

	battleDirector:setBattleSimulator(battleSimulator)
	battleDirector:setBattleInterpreter(battleInterpreter)

	local battlePassiveSkill = battleSession:getBattlePassiveSkill()
	local logicInfo = {
		director = battleDirector,
		interpreter = battleInterpreter,
		teams = battleSession:genTeamAiInfo(),
		mainPlayerId = {
			playerData.rid
		}
	}
	local systemKeeper = self:getInjector():getInstance("SystemKeeper")
	local unlockSpeed, tipsSpeed = systemKeeper:isUnlock("BattleSpeed")
	local speedOpenSta = systemKeeper:getBattleSpeedOpen("explore_battle")

	function battleDelegate:onAMStateChanged(sender, isAuto)
		outSelf:getInjector():getInstance(SettingSystem):getSettingModel():setBattleSetting(battleType, isAuto)
	end

	function battleDelegate:onLeavingBattle()
		BattleLoader:popBattleView(outSelf)
	end

	function battleDelegate:onPauseBattle(continueCallback, leaveCallback)
		local popupDelegate = {}

		function popupDelegate:willClose(sender, data)
			if data.opt == BattlePauseResponse.kLeave then
				leaveCallback()
				outSelf:dispatch(Event:new(EVT_EXPLORE_STATUR_REFRESH))
			else
				continueCallback(data.hpShow, data.effectShow)
			end
		end

		local pauseView = outSelf:getInjector():getInstance("battlePauseView")

		outSelf:dispatch(ViewEvent:new(EVT_SHOW_POPUP, pauseView, nil, {}, popupDelegate))
	end

	function battleDelegate:tryLeaving(callback)
		callback(true)
	end

	function battleDelegate:onBattleFinish(result)
		local realData = battleSession:getResultSummary()

		callback(realData)
	end

	function battleDelegate:onDevWin()
		local realData = {
			randomSeed = 123321,
			opData = "dev",
			result = kBattleSideAWin,
			winners = {
				playerData.rid
			},
			statist = {
				totalTime = 10000,
				roundCount = 4,
				players = {
					[playerData.rid] = {
						unitsDeath = 0,
						hpRatio = 0.99999,
						unitsTotal = 3,
						unitSummary = {}
					},
					[pointId] = {
						unitsDeath = 20,
						hpRatio = 0,
						unitsTotal = 20,
						unitSummary = {}
					}
				}
			}
		}

		callback(realData)
	end

	function battleDelegate:onTimeScaleChanged(timeScale)
		outSelf:getInjector():getInstance(SettingSystem):getSettingModel():setBattleSetting(battleType, nil, timeScale)
	end

	function battleDelegate:showBossCome(pauseFunc, resumeCallback, paseSta)
		local popupDelegate = {}

		function popupDelegate:willClose(sender, data)
			if resumeCallback then
				resumeCallback()
			end
		end

		local bossView = outSelf:getInjector():getInstance("battleBossComeView")

		outSelf:dispatch(ViewEvent:new(EVT_SHOW_POPUP, bossView, nil, {
			paseSta = paseSta
		}, popupDelegate))

		if pauseFunc then
			pauseFunc()
		end
	end

	function battleDelegate:onShowRestraint(continueCallback)
		local popupDelegate = {}

		function popupDelegate:willClose(sender)
			continueCallback()
		end

		local view = outSelf:getInjector():getInstance("battlerofessionalRestraintView")

		outSelf:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, {}, popupDelegate))
	end

	local pointConfig = self:getPointConfigById(pointId)

	if not pointConfig.Background then
		local battleSpeed_Display = ConfigReader:getDataByNameIdAndKey("ConfigValue", "BattleSpeed_Display", "content")
		local battleSpeed_Actual = ConfigReader:getDataByNameIdAndKey("ConfigValue", "BattleSpeed_Actual", "content")
		local var_104_0 = {
			battleType = battleSession:getBattleType(),
			battleData = battleData,
			battleConfig = battleConfig,
			isReplay = isReplay,
			logicInfo = logicInfo,
			delegate = battleDelegate
		}
		local var_104_1 = {
			opPanelClazz = "BattleUIMediator",
			mainView = "battlePlayer",
			opPanelRes = "asset/ui/BattleUILayer.csb",
			canChangeSpeedLevel = true,
			finalHitShow = true,
			finalTaskFinishShow = true,
			battleSettingType = battleType,
			bulletTimeEnabled = BattleLoader:getBulletSetting("BulletTime_PVE_Map"),
			bgm = pointConfig.BGM,
			background = pointConfig.Background,
			refreshCost = ConfigReader:getRecordById("ConfigValue", "TacticsCard_Reload").content,
			battleSuppress = BattleDataHelper:getBattleSuppress()
		}

		var_104_1.hpShow = self:getInjector():getInstance(SettingSystem):getSettingModel():getHpShowSetting()
		var_104_1.effectShow = self:getInjector():getInstance(SettingSystem):getSettingModel():getEffectShowSetting()
		var_104_1.passiveSkill = battlePassiveSkill
		var_104_1.unlockMasterSkill = self:getInjector():getInstance(SystemKeeper):isUnlock("Master_BattleSkill")
		var_104_1.finishWaitTime = BattleDataHelper:getBattleFinishWaitTime("explore_battle")
		var_104_1.changeMaxNum = ConfigReader:getDataByNameIdAndKey("MapBattlePoint", pointId, "BossRound") or 1

		local var_104_2 = {}
		local var_104_3 = {}

		var_104_3.visible = speedOpenSta and self:getInjector():getInstance(SystemKeeper):canShow("BattleSpeed")
		var_104_3.lock = not unlockSpeed
		var_104_3.tip = tipsSpeed
		var_104_3.speedConfig = battleSpeed_Actual
		var_104_3.speedShowConfig = battleSpeed_Display
		var_104_3.timeScale = timeScale
		var_104_2.speed = var_104_3
		var_104_2.skip = {
			enable = true,
			waitTips = "ARENA_SKIP_TIP",
			visible = (systemKeeper:isUnlock("Arena_SkipBattleCountdown") or nil) and true,
			skipTime = skipTime
		}

		local var_104_4 = {}

		var_104_4.visible = self:getInjector():getInstance(SystemKeeper):canShow("AutoFight")
		var_104_4.state = isAuto
		var_104_4.lock = not systemKeeper:isUnlock("AutoFight")
		var_104_2.auto = var_104_4
		var_104_2.pause = {
			visible = true
		}

		local var_104_5 = {}

		var_104_5.visible = self:getInjector():getInstance(SystemKeeper):canShow("Button_CombateDominating")
		var_104_5.lock = not self:getInjector():getInstance(SystemKeeper):isUnlock("Button_CombateDominating")
		var_104_2.restraint = var_104_5
		var_104_1.btnsShow = var_104_2
		var_104_0.viewConfig = var_104_1
		var_104_0.loadingType = LoadingType.KMapExplore

		local data = var_104_0

		BattleLoader:pushBattleView(self, data)
	end
end

function ExploreSystem:enterQuickBattle(pointId, battleDataS, extraData)
	local battleType = SettingBattleTypes.kExplore
	local isAuto, timeScale = self:getInjector():getInstance(SettingSystem):getSettingModel():getBattleSetting(battleType)

	local function callback(report)
		self:endTrigger(function(response)
			local function tempFunc()
				self:dispatch(Event:new(EVT_EXPLORE_FIGHT_FINISH))
			end

			self._fightFinishData = {
				response = response,
				extraData = extraData,
				isWin = report.result == 1
			}

			local view = self:getInjector():getInstance("ExploreBattleFinishView")

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, {
				quickbattle = true,
				report = response.data,
				callBack = tempFunc
			}))
		end, {
			objectId = extraData.objData:getId(),
			params = report
		}, true)
	end

	callback(self:immediateBattle(pointId, battleDataS))
end

function ExploreSystem:enterZombieView(pointId)
	local pointObj = self:getMapPointObjById(pointId)
	local zombieData = pointObj:getMechanism()
	local view = self:getInjector():getInstance("ExploreZombieView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, {
		pointId = pointId
	}))
end

function ExploreSystem:useZombieItem(id, callback)
	local params = {
		type = "item"
	}
	local param = {}

	param[id] = 1
	params.param = param

	self._exploreService:requestUseZombieItem(function(response)
		if response.resCode == GS_SUCCESS and callback then
			callback()
		end
	end, params, true)
end

function ExploreSystem:getZombieOpenSta(pointId)
	local pointObj = self:getMapPointObjById(pointId)

	return pointObj:getMapObjMechanismOpen()
end

function ExploreSystem:getColorByItemId(id, num)
	local isCurrency = false

	for k, v in pairs(CurrencyIdKind) do
		if id == v then
			isCurrency = true

			break
		end
	end

	if isCurrency then
		local config = ConfigReader:getRecordById("ResourcesIcon", id)

		if config then
			local seg = config.Segmentation
			local _Quality = config.Quality
			local name = Strings:get(config.Name)

			for k, v in pairs(seg) do
				if num < v then
					return _Quality[k], name
				elseif num >= seg[#seg] then
					return _Quality[#seg], name
				end
			end
		end
	else
		local configitem = ConfigReader:getRecordById("ItemConfig", id)

		if configitem then
			local color = configitem.Quality
			local name = Strings:get(configitem.Name)

			return color, name
		end

		configitem = ConfigReader:getRecordById("HeroEquipBase", id)

		if configitem then
			local color = configitem.Rareity
			local name = Strings:get(configitem.Name)

			return color, name
		end
	end
end

function ExploreSystem:showTips(data)
	if self._isFirst then
		self._isFirst = false

		return
	end

	if not self:getShowTips() then
		return
	end

	local filter = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Activity_Point_Hide", "content")
	local count = 0

	self._tipsQueue = {}
	self._idsQueue = {}

	for k, v in pairs(data) do
		local show = true

		for kf, vf in pairs(filter) do
			if v.itemId == vf then
				show = false
			end
		end

		local olditem = self:getEntryById(k)
		local addnum = 0

		addnum = olditem and v.count - olditem.count or v.count

		if addnum > 0 then
			local color, name = self:getColorByItemId(k, addnum)
			local colorvalue = GameStyle:getColor(color)

			colorvalue = colorvalue or GameStyle:getColor(1)

			local rr = string.format("%#x", colorvalue.r)
			local gg = string.format("%#x", colorvalue.g)
			local bb = string.format("%#x", colorvalue.b)
			local rgb = {
				rr,
				gg,
				bb
			}
			local rgbhex = ""

			for k, v in pairs(rgb) do
				rgbhex = rgbhex .. string.split(v, "x")[2]
			end

			rgbhex = "#" .. rgbhex

			local str = ""
			local templateStr = Strings:get("Map_Reward_Text", {
				fontName = TTF_FONT_FZYH_M,
				colorvalue = rgbhex,
				itemname = name,
				itemnum = addnum
			})

			str = str .. templateStr

			if show == true then
				count = count + 1
				self._tipsQueue[count] = str
				self._idsQueue[count] = v.itemId
			end
		end
	end

	local delay = 0.2

	self._showConut = 0
	self._schedulerID = LuaScheduler:getInstance():schedule(handler(self, self.showQueueTips), delay, false)
end

function ExploreSystem:showEquipTips(data)
	if self._isFirst then
		self._isFirst = false

		return
	end

	if not self:getShowTips() then
		return
	end

	local count = 0

	self._tipsQueue = {}
	self._idsQueue = {}

	local bag = self._developSystem:getExplore():getExploreBag()

	for k, v in pairs(data) do
		local oldCount = bag:getEquipCount(k)
		local addCount = v - oldCount

		for i = 1, addCount do
			local show = true
			local addnum = 1
			local color, name = self:getColorByItemId(k, addnum)
			local colorvalue = GameStyle:getEquipRarityColor(color)
			local rr = string.format("%#x", colorvalue.r)
			local gg = string.format("%#x", colorvalue.g)
			local bb = string.format("%#x", colorvalue.b)
			local rgb = {
				rr,
				gg,
				bb
			}
			local rgbhex = ""

			for k, v in pairs(rgb) do
				rgbhex = rgbhex .. string.split(v, "x")[2]
			end

			rgbhex = "#" .. rgbhex

			local str = ""
			local templateStr = Strings:get("Map_Reward_Text", {
				fontName = TTF_FONT_FZYH_M,
				colorvalue = rgbhex,
				itemname = name,
				itemnum = addnum
			})

			str = str .. templateStr

			if show == true then
				count = count + 1
				self._tipsQueue[count] = str
			end
		end
	end

	local delay = 0.2

	self._showConut = 0
	self._schedulerID = LuaScheduler:getInstance():schedule(handler(self, self.showQueueTips), delay, false)
end

local soundDic = ConfigReader:getDataByNameIdAndKey("ConfigValue", "MapSound", "content")

function ExploreSystem:showQueueTips()
	self._showConut = self._showConut + 1

	if self._showConut <= #self._tipsQueue then
		local itemId = self._idsQueue[self._showConut]

		AudioEngine:getInstance():playEffect((soundDic[itemId] or nil) and soundDic[itemId], false)
		self:dispatch(ShowTipEvent({
			duration = 0.4,
			tip = self._tipsQueue[self._showConut]
		}))
	elseif self._schedulerID then
		LuaScheduler:getInstance():unschedule(self._schedulerID)

		self._schedulerID = nil
	end
end

function ExploreSystem:pushShowStack(show)
	table.insert(self._showStack, show)
end

function ExploreSystem:popShowStack()
	table.remove(self._showStack)
end

function ExploreSystem:getShowTips()
	local stackTopIndex = #self._showStack

	return self._showStack[stackTopIndex]
end

function ExploreSystem:initAutoPlayCfg()
	if self._autoPlayMapId == self._currentPointId then
		return
	end

	self._autoPlayMapId = self._currentPointId
	self._pointCfg = self:getMapPointObjById(self._autoPlayMapId)
	self._exploreData = self._developSystem:getPlayer():getExplore()
	self._currentMapInfo = self._exploreData:getPointMap()[self._autoPlayMapId]
	self._mapAutoCfg = self._pointCfg:getMapAuto()

	local idInfo = string.split(self._currentMapInfo:getCurAutoId(), "_")

	self._curAutoId = tonumber(idInfo[1]) or 1
	self._curAutoCaseId = tonumber(idInfo[2]) or 0
	self._currentAutoPlayCfg = ConfigReader:requireRecordById("MapAuto", self._mapAutoCfg[self._curAutoId])

	self:nextAutoPlayStep()
end

function ExploreSystem:getCurrentAutoPlayCfg()
	return self._currentAutoPlayCfg
end

function ExploreSystem:nextAutoPlayCase()
	self._curAutoCaseId = self._curAutoCaseId + 1

	return self._currentAutoPlayCfg.Cases[self._curAutoCaseId]
end

function ExploreSystem:getAutoPlayCase()
	return self._currentAutoPlayCfg.Cases[self._curAutoCaseId]
end

function ExploreSystem:nextAutoPlayStep(isSkipCase)
	if not isSkipCase and self:nextAutoPlayCase() then
		return
	end

	self._curAutoId = self._curAutoId + 1
	self._curAutoCaseId = 1

	local autoId = self._mapAutoCfg[self._curAutoId]

	if not autoId then
		self._currentAutoPlayCfg = nil

		return
	end

	self._currentAutoPlayCfg = ConfigReader:requireRecordById("MapAuto", autoId)
end

function ExploreSystem:updateAutoId()
	self._exploreService:updateAutoId(function()
		return
	end, {
		autoId = self._curAutoId .. "_" .. self._curAutoCaseId
	})
end
