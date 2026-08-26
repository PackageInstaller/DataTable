-- chunkname: @modules/logic/summon/model/SummonMainModel.lua

module("modules.logic.summon.model.SummonMainModel", package.seeall)

local SummonMainModel = class("SummonMainModel", BaseModel)

function SummonMainModel:onInit()
	self:releaseViewData()

	self.flagModel = SummonFlagSubModel.New()
end

function SummonMainModel:reInit()
	self:releaseViewData()
	self:releaseServerData()

	self.flagModel = SummonFlagSubModel.New()
end

function SummonMainModel:releaseServerData()
	self._hasNewbiePool = nil
	self._newbieProgress = nil
	self._curPoolIndex = nil
	self._curPoolId = nil
	self._curPool = nil
	self._validServerPoolMap = nil
	self._useInfallibleItemTipDic = nil
	self._useInfallibleItemTriggerDic = nil
	self._itemConvertParam = nil
end

function SummonMainModel:releaseViewData()
	self:clear()

	self._poolList = nil
	self._isFirstTimeOpen = true
end

function SummonMainModel:initCategory(keepSelected)
	self:releaseViewData()

	self._poolList = SummonMainModel.getValidPools()

	self:setList(self._poolList)

	if self:getCount() > 0 then
		self._curPoolIndex = 1
		self._curPool = self:getByIndex(1)
		self._curPoolId = self._curPool.id
	else
		logError("summon pool config is empty!")
	end

	self:_updateSummonDiamondStatus()
end

function SummonMainModel:updateByServerData()
	self:releaseViewData()

	self._poolList = SummonMainModel.getValidPools()

	self:setList(self._poolList)

	if self:getCount() > 0 then
		if self._curPoolId == nil or not self:trySetSelectPoolId(self._curPoolId) then
			self._curPoolIndex = 1
			self._curPool = self:getByIndex(1)
			self._curPoolId = self._curPool.id
		end
	else
		logError("no summon pool available!")
	end

	SummonMainCategoryListModel.instance:initCategory()
end

function SummonMainModel:updateLastPoolId()
	if self._curPoolId then
		SummonController.instance:setLastPoolId(self._curPoolId)
	end
end

function SummonMainModel:getPoolsWithServer(callback, callbackObj)
	local param = {
		callback = callback,
		callbackObj = callbackObj
	}

	SummonRpc.instance:sendGetSummonInfoRequest(SummonMainModel.onGetPoolsWithServer, param)
end

function SummonMainModel.onGetPoolsWithServer(param)
	local callback = param.callback
	local callbackObj = param.callbackObj

	if callback then
		local pools = SummonMainModel.getValidPools()

		if callbackObj then
			param.callback(callbackObj, pools)
		else
			param.callback(pools)
		end
	end
end

function SummonMainModel.equipPoolIsValid()
	local list = SummonConfig.instance:getValidPoolList()

	for i, co in ipairs(list) do
		if SummonMainModel.getResultType(co) == SummonEnum.ResultType.Equip and OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.SummonEquip) then
			return true
		end
	end
end

function SummonMainModel.getValidPools()
	local list = SummonConfig.instance:getValidPoolList()
	local result = {}
	local needCreate = false
	local hasOldNewBie = false

	for i, co in pairs(list) do
		local mo = SummonMainModel.instance:getPoolServerMO(co.id)

		if mo and mo:isOpening() then
			needCreate = true

			if SummonMainModel.getResultType(co) == SummonEnum.ResultType.Equip and not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.SummonEquip) then
				needCreate = false
			elseif SummonMainModel.getADPageTabIndex(co) == SummonEnum.TabContentIndex.CharNewbie and not SummonMainModel.instance:getNewbiePoolExist() then
				needCreate = false
			end

			if needCreate then
				if SummonEnum.OldNewBiePoolId[co.id] then
					hasOldNewBie = true
				end

				table.insert(result, co)
			end
		end
	end

	if hasOldNewBie then
		table.sort(result, SummonMainModel.sortSummonCategory)
	else
		table.sort(result, SummonMainModel.sortSummonCategoryWithNew)
	end

	return result
end

function SummonMainModel.validContinueTenPool(poolId)
	local list = SummonConfig.instance:getValidPoolList()
	local isValid = true

	for _, co in pairs(list) do
		if co.id == poolId then
			local mo = SummonMainModel.instance:getPoolServerMO(co.id)

			if mo and mo:isOpening() then
				if SummonMainModel.getResultType(co) == SummonEnum.ResultType.Equip and not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.SummonEquip) then
					isValid = false

					break
				end

				if SummonMainModel.getADPageTabIndex(co) == SummonEnum.TabContentIndex.CharNewbie and not SummonMainModel.instance:getNewbiePoolExist() then
					isValid = false

					break
				end

				if SummonConfig.poolIsLuckyBag(poolId) then
					local summonServerMO = SummonMainModel.instance:getPoolServerMO(poolId)

					if summonServerMO and summonServerMO.luckyBagMO then
						local gachaMaxTimes = SummonLuckyBagModel.instance:getGachaRemainTimes(poolId)

						if not gachaMaxTimes or gachaMaxTimes < 10 then
							isValid = false
						end
					end
				end
			end

			break
		end
	end

	return isValid
end

function SummonMainModel:isInfallibleSummon(poolId)
	local summonConfig = SummonConfig.instance:getSummon(poolId)

	if summonConfig.infallibleItemId == nil or summonConfig.infallibleItemId == 0 or summonConfig.infallibleItemMaxUseCount <= 0 then
		return false
	end

	local mo = self:getPoolServerMO(poolId)

	return mo and mo.infallibleItemStatus == SummonEnum.InfallibleItemState.Using
end

SummonMainModel.defaultSettings = {
	{
		"ui/viewres/summon/summonmaincharacterview.prefab"
	},
	{
		"ui/viewres/summon/summonmainequipview.prefab"
	},
	{
		"ui/viewres/summon/summonmaincharacternewbie.prefab"
	},
	{
		"ui/viewres/summon/summonmaincharacterprobup.prefab"
	},
	{
		"ui/viewres/summon/summonmainequipprobup.prefab"
	}
}
SummonMainModel.defaultUIClzMap = {
	SummonMainCharacterView,
	SummonMainEquipView,
	SummonMainCharacterNewbie,
	SummonMainCharacterProbUp,
	SummonMainEquipProbUp
}
SummonMainModel.defaultUIClzMapByType = {
	[SummonEnum.Type.ProbUp] = SummonMainCharacterProbUp,
	[SummonEnum.Type.Limit] = SummonMainCharacterProbUp,
	[SummonEnum.Type.StrongCustomOnePick] = SummonStrongOneCustomPickView,
	[SummonEnum.Type.CoBranding] = SummonMainCharacterCoBranding
}

function SummonMainModel:resetTabResSettings()
	local summonSettings = tabletool.copy(SummonMainModel.defaultSettings)
	local clzMap = tabletool.copy(SummonMainModel.defaultUIClzMap)
	local allPoolList = SummonConfig.instance:getValidPoolList()

	self._poolIDTabMap = {}

	for _, co in ipairs(allPoolList) do
		local clz = SummonMainModel.defaultUIClzMapByType[co.type]
		local tabIndexByType = SummonMainModel.getADPageTabIndex(co)
		local defaultClz = SummonMainModel.defaultUIClzMap[tabIndexByType]

		if clz == nil and not string.nilorempty(co.customClz) then
			clz = _G[co.customClz]
		end

		clz = clz or defaultClz

		local defaultPrefabPath = SummonMainModel.defaultSettings[tabIndexByType][1]
		local path

		if not string.nilorempty(co.prefabPath) then
			path = string.format("ui/viewres/summon/%s.prefab", co.prefabPath)
		end

		path = path or defaultPrefabPath

		if clz ~= defaultClz or path ~= defaultPrefabPath then
			table.insert(summonSettings, {
				path
			})
			table.insert(clzMap, clz)

			self._poolIDTabMap[co.id] = #summonSettings
		end
	end

	module_views.SummonADView.tabRes[3] = summonSettings
	self._tab2UIClassDef = clzMap
end

function SummonMainModel.sortSummonCategory(a, b)
	local priorityA = a.priority
	local priorityB = b.priority

	if priorityA ~= priorityB then
		return priorityB < priorityA
	else
		return a.id < b.id
	end
end

function SummonMainModel.sortSummonCategoryWithNew(a, b)
	local priorityA = a.priority
	local priorityB = b.priority

	if SummonMainModel.instance:getNewbiePoolExist() and SummonMainModel.instance:isNewbiePoolGetReward() then
		if SummonMainModel.getADPageTabIndex(a) == SummonEnum.TabContentIndex.CharNewbie then
			priorityA = SummonEnum.NewbieFinishSortOrder
		elseif SummonMainModel.getADPageTabIndex(b) == SummonEnum.TabContentIndex.CharNewbie then
			priorityB = SummonEnum.NewbieFinishSortOrder
		end
	end

	if priorityA ~= priorityB then
		return priorityB < priorityA
	else
		return a.id < b.id
	end
end

function SummonMainModel:setFirstTimeSwitch(value)
	self._isFirstTimeSwitch = value
end

function SummonMainModel:getFirstTimeSwitch()
	return self._isFirstTimeSwitch
end

function SummonMainModel:getCurPool()
	return self:getById(self._curPoolId)
end

function SummonMainModel:createUIClassTab()
	local uiInsts = {}

	for index, clz in ipairs(self._tab2UIClassDef) do
		uiInsts[index] = clz.New()
	end

	return uiInsts
end

function SummonMainModel:getUIClassDef(tabIndex)
	return self._tab2UIClassDef[tabIndex]
end

function SummonMainModel:getCurADPageIndex()
	local curPool = self:getCurPool()

	if curPool == nil then
		return nil
	end

	local poolSpecIndex = self._poolIDTabMap[curPool.id]

	if poolSpecIndex then
		return poolSpecIndex
	else
		return SummonMainModel.getADPageTabIndex(curPool)
	end
end

function SummonMainModel:getADPageTabIndexForUI(poolCfg)
	if poolCfg == nil or self._poolIDTabMap == nil then
		return nil
	end

	local poolSpecIndex = self._poolIDTabMap[poolCfg.id]

	if poolSpecIndex then
		return poolSpecIndex
	else
		return SummonMainModel.getADPageTabIndex(poolCfg)
	end
end

function SummonMainModel.getADPageTabIndex(poolCfg)
	return SummonEnum.Type2PageIndex[poolCfg.type] or SummonEnum.TabContentIndex.CharNormal
end

function SummonMainModel:hasPoolAvailable(poolId)
	if poolId == nil then
		return self:getCount() > 0
	else
		return self:getById(poolId) ~= nil
	end
end

function SummonMainModel:hasPoolGroupAvailable(poolGroupId)
	local list = self:getList()

	if list and #list > 0 then
		for _, poolCo in pairs(list) do
			if poolCo.jumpGroupId == poolGroupId then
				return poolCo
			end
		end
	end

	return nil
end

function SummonMainModel:getPoolServerMO(poolId)
	if self._validServerPoolMap then
		return self._validServerPoolMap[poolId]
	end
end

function SummonMainModel:getServerMOMap()
	return self._validServerPoolMap
end

function SummonMainModel:trySetSelectPoolIndex(index)
	local len = self:getCount()

	if len == 0 then
		return false
	elseif index < 1 then
		index = len
	elseif len < index then
		index = 1
	end

	local co = self:getByIndex(index)

	self._curPoolIndex = index
	self._curPoolId = co.id
	self._curPool = co

	SummonController.instance:setLastPoolId(self._curPoolId)
	self:_updateSummonDiamondStatus()

	return true
end

function SummonMainModel:trySetSelectPoolId(id)
	local co = self:getById(id)

	if co then
		self._curPoolIndex = self:getIndex(co)
		self._curPoolId = id
		self._curPool = co

		SummonController.instance:setLastPoolId(self._curPoolId)
		self:_updateSummonDiamondStatus()

		return true
	end

	return false
end

function SummonMainModel:_updateSummonDiamondStatus()
	local arr = string.splitToNumber(CommonConfig.instance:getConstStr(ConstEnum.SingleSummonPer), "#")
	local costType, costId, count = arr[1], arr[2], arr[3]

	self.everyCostCount = count
	self.costCurrencyType = costType
	self.costCurrencyId = costId
end

function SummonMainModel:getOwnCostCurrencyNum()
	return ItemModel.instance:getItemQuantity(self.costCurrencyType, self.costCurrencyId)
end

SummonMainModel.EmptyDetailDict = {}

function SummonMainModel:getEquipDetailListByPool(poolCo)
	if poolCo then
		return SummonConfig.instance:getEquipDetailByPoolId(poolCo.id) or SummonMainModel.EmptyDetailDict
	else
		return SummonMainModel.EmptyDetailDict
	end
end

function SummonMainModel.sortDetailByLocation(a, b)
	if a.detailCo.location ~= b.detailCo.location then
		return a.detailCo.location < b.detailCo.location
	else
		return a.detailCo.id < b.detailCo.id
	end
end

function SummonMainModel:getCurIndex()
	return self._curPoolIndex
end

function SummonMainModel:getCurId()
	return self._curPoolId
end

function SummonMainModel:setNewbiePoolExist(val)
	self._hasNewbiePool = val
end

function SummonMainModel:getNewbiePoolExist()
	return self._hasNewbiePool
end

function SummonMainModel:isNewbiePoolGetReward()
	return self._isNewbiePoolGetReward
end

function SummonMainModel:setNewbiePoolGetReward()
	local poolId

	if SummonMainModel.instance:getNewbiePoolExist() then
		local list = SummonConfig.instance:getValidPoolList()

		for i, co in pairs(list) do
			local mo = SummonMainModel.instance:getPoolServerMO(co.id)

			if mo and mo:isOpening() and SummonMainModel.getADPageTabIndex(co) == SummonEnum.TabContentIndex.CharNewbie then
				poolId = co.id

				break
			end
		end
	end

	if poolId then
		local mainPoolInfo = SummonMainModel.instance:getPoolServerMO(poolId)
		local poolCo = SummonConfig.instance:getSummonPool(poolId)
		local ssrTimes = SummonConfig.getSummonSSRTimes(poolCo)
		local nextSSRTime = ssrTimes - mainPoolInfo.notSSRcount
		local newbieProgress = self:getNewbieProgress()

		self._isNewbiePoolGetReward = ssrTimes - newbieProgress ~= nextSSRTime
	else
		self._isNewbiePoolGetReward = true
	end
end

function SummonMainModel:setNewbieProgress(val)
	self._newbieProgress = val
end

function SummonMainModel:getNewbieProgress()
	return self._newbieProgress
end

function SummonMainModel:setServerPoolInfos(infos)
	self._validServerPoolMap = self._validServerPoolMap or {}

	local infoSet = {}

	for _, info in ipairs(infos) do
		infoSet[info.poolId] = info

		local mo = self._validServerPoolMap[info.poolId]

		if not mo then
			mo = SummonMainPoolMO.New()

			mo:init(info)

			self._validServerPoolMap[info.poolId] = mo
		else
			mo:update(info)
		end
	end

	for k, mo in pairs(self._validServerPoolMap) do
		if not infoSet[mo.id] then
			self._validServerPoolMap[k] = nil
		end
	end

	self:refreshRecord()
end

function SummonMainModel:getFirstValidPool()
	if self._poolList then
		return self._poolList[1]
	end
end

function SummonMainModel:refreshRecord()
	local poolCfgs = SummonMainModel.getValidPools()

	self.flagModel:init()
	self.flagModel:compareRecord(poolCfgs)
end

function SummonMainModel:categoryHasNew(poolId)
	return (self.flagModel or nil) and self.flagModel:isNew(poolId)
end

function SummonMainModel:hasNextDayFree(poolId)
	local hasFree = SummonConfig.instance:canShowSingleFree(poolId)

	if hasFree then
		local poolCO = SummonConfig.instance:getSummonPool(poolId)
		local poolMO = self:getPoolServerMO(poolId)

		if poolMO and poolMO.usedFreeCount < poolCO.totalFreeCount then
			return true
		end
	end

	return false
end

function SummonMainModel:entryHasNew()
	if self.flagModel then
		return self.flagModel:hasNew()
	end

	return false
end

function SummonMainModel:entryHasFree()
	local result = SummonMainModel.getValidPools()

	for i, co in ipairs(result) do
		local summonMO = self:getPoolServerMO(co.id)

		if summonMO and summonMO.haveFree then
			return true, co.id
		end
	end

	return false, nil
end

function SummonMainModel:entryHasFree10Count()
	local result = SummonMainModel.getValidPools()

	for i, co in ipairs(result) do
		local summonMO = self:getPoolServerMO(co.id)

		if summonMO and summonMO.havefree10Count > 0 then
			return true, co.id
		end
	end

	return false, nil
end

function SummonMainModel:entryHasCanget()
	local result = SummonMainModel.getValidPools()

	for i, co in ipairs(result) do
		local summonMO = self:getPoolServerMO(co.id)

		if summonMO and summonMO:isHasProgressReward() or summonMO:isHasOptionalProgressReward() then
			return true
		end

		if self:isHasCanFinishTaskByPoolId(co.id) then
			return true
		end
	end

	return false
end

function SummonMainModel:isHasCanFinishTaskByPoolId(poolId)
	local goodsCfgList = StoreConfig.instance:getCharageGoodsCfgListByPoolId(poolId)

	if goodsCfgList then
		for _, goodsCfg in ipairs(goodsCfgList) do
			if StoreCharageConditionalHelper.isHasCanFinishGoodsTask(goodsCfg.id) then
				return true
			end
		end
	end

	return false
end

function SummonMainModel:getCustomPickProbability(poolId)
	local co = SummonConfig.instance:getSummonPool(poolId)

	if co and co.type == SummonEnum.Type.CustomPick then
		local params = string.split(co.param, "|")
		local count = tonumber(params[1])
		local probability = string.splitToNumber(params[2], "#")
		local totalprob = 0

		for i = 1, #probability do
			totalprob = totalprob + probability[i]
		end

		return totalprob * 0.001 / count * 100, co.totalPosibility, false
	end

	if co and co.type == SummonEnum.Type.StrongCustomOnePick then
		if SummonCustomPickModel.instance:isHaveFirstSSR(poolId) then
			return 50, 0, false
		else
			return 100, 0, true
		end
	end

	return 0, 0, false
end

function SummonMainModel:getDiscountTime10Server(poolId)
	local serverPool = self:getPoolServerMO(poolId)

	if serverPool then
		return serverPool.discountTime
	end

	return 0
end

function SummonMainModel:getDiscountCostId(poolId, costId)
	local co = SummonConfig.instance:getSummonPool(poolId)
	local tCostId = 0

	if co then
		local discountCost10 = co.discountCost10
		local discountCost10Str = string.split(discountCost10, "|")

		for i, costStr in ipairs(discountCost10Str) do
			local cost = string.splitToNumber(costStr, "#")

			if cost then
				tCostId = cost[2]

				if not costId or costId == tCostId then
					return tCostId
				end
			end
		end
	end

	return tCostId
end

function SummonMainModel:getDiscountTime10(poolId)
	local co = SummonConfig.instance:getSummonPool(poolId)

	if co then
		return co.discountTime10
	end

	return 0
end

function SummonMainModel:getDiscountCost10(poolId, index, costId)
	local disCountTimeconfig = self:getDiscountTime10(poolId)
	local disCountTimeServer = self:getDiscountTime10Server(poolId)
	local disTime = index or disCountTimeconfig - disCountTimeServer + 1

	if disTime <= disCountTimeconfig then
		local co = SummonConfig.instance:getSummonPool(poolId)

		if co then
			local discountCost10 = co.discountCost10
			local discountCost10Str = string.split(discountCost10, "|")

			for i, costStr in ipairs(discountCost10Str) do
				local cost = string.splitToNumber(costStr, "#")

				if cost and (not costId or costId == cost[2]) then
					return cost[3]
				end
			end
		end
	end

	return -1
end

function SummonMainModel:checkHaveFree10Count(poolId)
	local serverPool = self:getPoolServerMO(poolId)

	if serverPool then
		return serverPool.havefree10Count > 0
	end

	return false
end

function SummonMainModel:getNotSSRCount(poolId)
	local serverPool = self:getPoolServerMO(poolId)

	if serverPool then
		return serverPool.notSSRcount
	end

	return 0
end

function SummonMainModel:checkFree10CountOver(poolId)
	local serverPool = self:getPoolServerMO(poolId)
	local co = SummonConfig.instance:getSummonPool(poolId)

	if serverPool then
		return serverPool.totalFree10UseCount >= co.free10MaxUseCount
	end

	return false
end

function SummonMainModel:getCost10ById(poolId, isGetFirstCost, isGetCostItemList)
	local poolCfg = SummonConfig.instance:getSummonPool(poolId)

	if not poolCfg then
		logError(string.format("no summon cost config, poolId:%s", poolId))

		return
	end

	local discount = self:getDiscountTime10Server(poolId)

	if discount > 0 then
		return SummonMainModel.getCostByConfig(poolCfg.cost10, isGetFirstCost, poolCfg.discountCost10, isGetCostItemList)
	end

	return SummonMainModel.getCostByConfig(poolCfg.cost10, isGetFirstCost, nil, isGetCostItemList)
end

function SummonMainModel._getCostToDict(costs)
	local dict

	if costs and not string.nilorempty(costs) then
		dict = {}

		local costsList = string.split(costs, "|")

		for i, costStr in ipairs(costsList) do
			local cost = string.splitToNumber(costStr, "#")

			if cost then
				local cost_type, cost_id, cost_num = cost[1], cost[2], cost[3]

				RoomHelper.add2KeyValue(dict, cost_type, cost_id, cost_num)
			end
		end
	end

	return dict
end

function SummonMainModel.getCostByConfig(costs, isGetFirstCost, discountCost, isGetCostItemList)
	if string.nilorempty(costs) then
		logError("no summon cost config")

		return
	end

	isGetFirstCost = isGetFirstCost == true
	isGetCostItemList = isGetCostItemList == true

	local costs = string.split(costs, "|")
	local costsNumDict = {}
	local itemCostFlagDict = {}
	local firstIdDict = isGetFirstCost and {} or nil
	local firstTypeDict = isGetFirstCost and {} or nil
	local discountDict = SummonMainModel._getCostToDict(discountCost)
	local costListDict = isGetCostItemList and {} or nil

	for i, costStr in ipairs(costs) do
		local cost = string.splitToNumber(costStr, "#")
		local cost_type, cost_id, cost_num = cost[1], cost[2], cost[3]

		if discountDict and discountDict[cost_type] and discountDict[cost_type][cost_id] then
			cost_num = discountDict[cost_type][cost_id]
		end

		local count = ItemModel.instance:getItemQuantity(cost_type, cost_id)
		local ownNum = (costsNumDict[cost_num] or 0) + count

		if isGetFirstCost and count > 0 and not firstIdDict[cost_num] then
			firstIdDict[cost_num] = cost_id
			firstTypeDict[cost_num] = cost_type
		end

		if isGetCostItemList and count > 0 then
			costListDict[cost_num] = costListDict[cost_num] or {}

			table.insert(costListDict[cost_num], cost)
		end

		if i >= #costs or cost_num <= ownNum then
			if isGetFirstCost then
				cost_id = firstIdDict[cost_num] or cost_id
				cost_type = firstTypeDict[cost_num] or cost_type
			end

			return cost_type, cost_id, cost_num, ownNum, cost[3], costListDict and costListDict[cost_num]
		end

		if not itemCostFlagDict[costStr] then
			itemCostFlagDict[costStr] = true
			costsNumDict[cost_num] = ownNum
		end
	end
end

function SummonMainModel.getLastCostByConfig(costs)
	if string.nilorempty(costs) then
		logError("no summon cost config")

		return
	end

	local costs = string.split(costs, "|")
	local cost = string.splitToNumber(costs[#costs], "#")
	local cost_type, cost_id, cost_num = cost[1], cost[2], cost[3]

	return cost_type, cost_id, cost_num
end

function SummonMainModel.getSummonItemIcon(itemType, id)
	itemType = tonumber(itemType)
	id = tonumber(id)

	local config = ItemModel.instance:getItemConfig(itemType, id)

	if not config then
		logError(string.format("getSummonItemIcon no config itemType:%s,id:%s", itemType, id))

		return
	end

	local icon

	return itemType == MaterialEnum.MaterialType.Item and ItemModel.instance:getItemSmallIcon(id) or itemType == MaterialEnum.MaterialType.Currency and ResUrl.getCurrencyItemIcon(config.icon) or ResUrl.getSpecialPropItemIcon(config.icon)
end

function SummonMainModel.getResultType(co)
	local tabIndex = SummonEnum.Type2Result[co.type]

	tabIndex = tabIndex or SummonEnum.ResultType.Char

	return tabIndex
end

function SummonMainModel.getResultTypeById(poolId)
	if poolId then
		local co = SummonConfig.instance:getSummonPool(poolId)

		if co then
			return (SummonMainModel.getResultType(co))
		else
			logError("can't find summon pool config : [" .. tostring(poolId) .. "]")
		end
	end

	return SummonEnum.ResultType.Char
end

function SummonMainModel.isProbUp(poolCo)
	local tabIndex = SummonMainModel.getADPageTabIndex(poolCo)

	return tabIndex == SummonEnum.TabContentIndex.CharProbUp or tabIndex == SummonEnum.TabContentIndex.EquipProbUp
end

function SummonMainModel.getCostCurrencyParam(pool)
	local result = {}

	if pool then
		local costSet = {}

		SummonMainModel.addCurrencyByCostStr(result, pool.cost1, costSet)
	else
		table.insert(result, {
			id = 140001,
			isIcon = true,
			type = MaterialEnum.MaterialType.Item,
			jumpFunc = SummonMainModel.jumpToSummonCostShop
		})
		table.insert(result, {
			id = 140002,
			isIcon = true,
			type = MaterialEnum.MaterialType.Item,
			jumpFunc = SummonMainModel.jumpToSummonCostShop
		})
	end

	table.insert(result, CurrencyEnum.CurrencyType.Diamond)
	table.insert(result, CurrencyEnum.CurrencyType.FreeDiamondCoupon)

	return result
end

function SummonMainModel.jumpToSummonCostShop()
	StoreController.instance:checkAndOpenStoreView(StoreEnum.StoreId.SummonCost)
end

function SummonMainModel._isCurrencyHideAddBtn(itemId)
	if tabletool.indexOf(SummonEnum.CurrencyShowAddItemIds, itemId) then
		return false
	end

	return true
end

function SummonMainModel._isCurrencyShow(itemType, itemId)
	if tabletool.indexOf(SummonEnum.CurrencyShowAddItemIds, itemId) then
		return true
	end

	local count = ItemModel.instance:getItemQuantity(itemType, itemId)

	if count and count > 0 then
		return true
	end

	return false
end

function SummonMainModel.addCurrencyByCostStr(result, costCfgStr, costSet)
	if not string.nilorempty(costCfgStr) then
		local costs = string.split(costCfgStr, "|")

		for _, costStr in ipairs(costs) do
			local cost = string.splitToNumber(costStr, "#")
			local cost_type, cost_id, cost_num = cost[1], cost[2], cost[3]

			if not costSet[cost_id] then
				if SummonMainModel._isCurrencyShow(cost_type, cost_id) then
					local isHideAddBtn = SummonMainModel._isCurrencyHideAddBtn(cost_id)

					table.insert(result, {
						isIcon = true,
						id = cost_id,
						type = cost_type,
						isHideAddBtn = isHideAddBtn,
						jumpFunc = SummonMainModel.jumpToSummonCostShop
					})
				end

				costSet[cost_id] = true
			end
		end
	end
end

function SummonMainModel.getCurrencyByCost(cost_type, cost_id)
	return {
		isIcon = true,
		id = cost_id,
		type = cost_type,
		jumpFunc = SummonMainModel.jumpToSummonCostShop
	}
end

function SummonMainModel:entryNeedReddot()
	local serverMap = self:getServerMOMap()

	if serverMap then
		for poolId, summonMO in pairs(serverMap) do
			local needShow = SummonMainModel.needShowReddot(summonMO, true)

			if needShow then
				return true
			end
		end
	end

	return false
end

function SummonMainModel.needShowReddot(summonMO, isMainView)
	if not summonMO:isOpening() then
		return false
	end

	if summonMO.luckyBagMO and summonMO.luckyBagMO:isGot() and not summonMO.luckyBagMO:isOpened() then
		return true
	end

	if summonMO.haveFree then
		return true
	end

	if isMainView then
		return false
	end

	if summonMO:isHasProgressReward() or summonMO:isHasOptionalProgressReward() then
		return true
	end

	if SummonMainModel.instance:isHasCanFinishTaskByPoolId(summonMO.id) then
		return true
	end

	return false
end

function SummonMainModel:isSummonPoolPackageProp(poolId, orderId)
	if not poolId then
		return false
	end

	local summonInfoMo = self:getPoolServerMO(poolId)

	if not summonInfoMo or not summonInfoMo.propPackageMO then
		return true
	end

	return summonInfoMo.propPackageMO:isOrderProp(orderId)
end

function SummonMainModel:setSummonPoolPackageProp(poolId, orderId, count)
	if not poolId then
		return
	end

	local summonInfoMo = self:getPoolServerMO(poolId)

	if not summonInfoMo or not summonInfoMo.propPackageMO then
		logError("不存在的卡池 id" .. tostring(poolId))

		return
	end

	summonInfoMo.propPackageMO:addSinglePropInfo(orderId, count)
end

function SummonMainModel:canShowDestinyGift(summonPoolId)
	if summonPoolId == nil then
		return false
	end

	local summonPoolConfig = SummonConfig.instance:getSummonPool(summonPoolId)

	if not summonPoolConfig or summonPoolConfig.infallibleItemId == nil or summonPoolConfig.infallibleItemId == 0 then
		return false
	end

	return true
end

function SummonMainModel:setSummonInfallibleState(poolId, status)
	if poolId == nil or status == nil then
		return
	end

	local pool = self:getPoolServerMO(poolId)

	if not pool then
		return
	end

	local poolCo = SummonConfig.instance:getSummonPool(poolId)

	if poolCo.infallibleItemId == nil and poolCo.infallibleItemId == 0 and poolCo.infallibleItemMaxUseCount <= 0 then
		return
	end

	pool.infallibleItemStatus = status

	logNormal("无限抽道具状态改变 卡池id: " .. tostring(poolId) .. " 状态: " .. tostring(status))

	if status == SummonEnum.InfallibleItemState.Used then
		self:setInfallibleItemUsedTrigger(poolCo.infallibleItemId, true)
	end

	SummonController.instance:dispatchEvent(SummonEvent.onSummonInfallibleStatusChange, status)
end

function SummonMainModel:setInfallibleItemUsedTrigger(infallibleItemId, value)
	self._useInfallibleItemTriggerDic = self._useInfallibleItemTriggerDic or {}
	self._useInfallibleItemTriggerDic[infallibleItemId] = value
end

function SummonMainModel:getInfallibleItemUsedTrigger(infallibleItemId)
	if not self._useInfallibleItemTriggerDic then
		return false
	end

	return self._useInfallibleItemTriggerDic[infallibleItemId]
end

function SummonMainModel:checkCanUseInfallibleItem(poolId)
	local poolInfo = self:getPoolServerMO(poolId)

	if not poolInfo then
		return false
	end

	local summonConfig = SummonConfig.instance:getSummonPool(poolId)

	if summonConfig.infallibleItemId == nil or summonConfig.infallibleItemId == 0 or summonConfig.infallibleItemMaxUseCount <= 0 then
		return false
	end

	local itemId = summonConfig.infallibleItemId
	local count = ItemModel.instance:getItemCount(itemId)

	if count <= 0 then
		return false
	end

	return poolInfo.infallibleItemStatus == SummonEnum.InfallibleItemState.Unused
end

SummonMainModel.useInfallibleItemTipKey = "UseInfallibleItemTip"

function SummonMainModel:checkHaveShowUseInfallibleItemTip(poolId)
	if not self._useInfallibleItemTipDic then
		self:initShowUseInfallibleItemTip()
	end

	return self._useInfallibleItemTipDic[poolId] == true
end

function SummonMainModel:setHaveShowUseInfallibleItemTip(poolId, isShow)
	if not self._useInfallibleItemTipDic then
		self:initShowUseInfallibleItemTip()
	end

	self._useInfallibleItemTipDic[poolId] = isShow

	local tempList = {}

	for id, showStatus in pairs(self._useInfallibleItemTipDic) do
		if showStatus == true then
			table.insert(tempList, id)
		end
	end

	if next(tempList) then
		local userKey = string.format("%s_%s", PlayerModel.instance:getMyUserId(), SummonMainModel.useInfallibleItemTipKey)
		local value = table.concat(tempList, "#")

		PlayerPrefsHelper.setString(userKey, value)
	end
end

function SummonMainModel:initShowUseInfallibleItemTip()
	self._useInfallibleItemTipDic = {}

	local userKey = string.format("%s_%s", PlayerModel.instance:getMyUserId(), SummonMainModel.useInfallibleItemTipKey)
	local value = PlayerPrefsHelper.getString(userKey, "")

	if not string.nilorempty(value) then
		local paramList = string.splitToNumber(value, "#")

		if paramList and next(paramList) then
			for _, param in ipairs(paramList) do
				self._useInfallibleItemTipDic[param] = true
			end
		end
	end
end

function SummonMainModel:clearShowUseInfallibleItemTipRecord()
	local userKey = string.format("%s_%s", PlayerModel.instance:getMyUserId(), SummonMainModel.useInfallibleItemTipKey)

	PlayerPrefsHelper.setString(userKey, "")
end

function SummonMainModel:setItemConvertTag(param)
	self._itemConvertParam = param
end

function SummonMainModel:getItemConvertTag()
	return self._itemConvertParam
end

SummonMainModel.instance = SummonMainModel.New()

return SummonMainModel
