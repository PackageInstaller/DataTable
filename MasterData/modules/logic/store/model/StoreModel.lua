-- chunkname: @modules/logic/store/model/StoreModel.lua

module("modules.logic.store.model.StoreModel", package.seeall)

local StoreModel = class("StoreModel", BaseModel)

function StoreModel:onInit()
	self._storeMODict = {}
	self._chargeStoreDic = {}
	self._allPackageDic = {}
	self._chargePackageStoreDic = {}
	self._versionChargePackageDict = {}
	self._onceTimeChargePackageDict = {}
	self._recommendPackageList = {}
	self._taskGoodsIdList = {}
	self._packageType2GoodsDict = {
		[StoreEnum.StoreId.VersionPackage] = self._versionChargePackageDict,
		[StoreEnum.StoreId.OneTimePackage] = self._onceTimeChargePackageDict,
		[StoreEnum.StoreId.NormalPackage] = self._chargePackageStoreDic
	}
	self._curPackageStore = StoreEnum.StoreId.NormalPackage
	self.monthCardInfo = nil
	self._packageStoreRpcLeftNum = 0
	self.cachePackageGoodsDic = {}
end

function StoreModel:reInit()
	self:onInit()
end

function StoreModel:getStoreInfosReply(info)
	local storeInfos = info.storeInfos

	if storeInfos and #storeInfos > 0 then
		for i, storeInfo in ipairs(storeInfos) do
			local storeMO = StoreMO.New()

			storeMO:init(storeInfo)

			self._storeMODict[storeMO.id] = storeMO

			local isPackageStore = StoreConfig.instance:isPackageStore(storeMO.id)

			if isPackageStore then
				local targetStoreId = self:getCurPackageStore()

				if targetStoreId ~= 0 and targetStoreId == storeMO.id then
					self:updatePackageStoreList(storeMO.id)
				end
			elseif storeMO.id == StoreEnum.StoreId.Skin then
				StoreClothesGoodsItemListModel.instance:setMOList(storeMO:getGoodsList())
			end
		end
	end
end

function StoreModel:buyGoodsReply(info)
	local storeMO = self._storeMODict[info.storeId]

	if storeMO then
		storeMO:buyGoodsReply(info.goodsId, info.num)
	end
end

function StoreModel:initChargeInfo(infos)
	self._chargeStoreDic = {}
	self._allPackageDic = {}
	self._chargePackageStoreDic = {}
	self._versionChargePackageDict = {}
	self._onceTimeChargePackageDict = {}
	self._skinChargeDict = {}
	self._recommendPackageList = {}
	self._taskGoodsIdList = {}
	self._packageType2GoodsDict = {
		[StoreEnum.StoreId.VersionPackage] = self._versionChargePackageDict,
		[StoreEnum.StoreId.OneTimePackage] = self._onceTimeChargePackageDict,
		[StoreEnum.StoreId.NormalPackage] = self._chargePackageStoreDic,
		[StoreEnum.StoreId.RecommendPackage] = self._recommendPackageList,
		[StoreEnum.StoreId.MediciPackage] = {}
	}

	local skinChargeInfoList = {}

	for _, chargeInfo in pairs(infos) do
		local goodsConfig = StoreConfig.instance:getChargeGoodsConfig(chargeInfo.id, true)

		if goodsConfig then
			if goodsConfig.belongStoreId == StoreEnum.StoreId.Charge or goodsConfig.belongStoreId == StoreEnum.StoreId.PubbleCharge or goodsConfig.belongStoreId == StoreEnum.StoreId.GlowCharge then
				local chargeGoodsMO = StoreChargeGoodsMO.New()

				chargeGoodsMO:init(StoreEnum.StoreId.Charge, chargeInfo)

				self._chargeStoreDic[chargeInfo.id] = chargeGoodsMO
			elseif goodsConfig.belongStoreId == StoreEnum.StoreId.Skin then
				table.insert(skinChargeInfoList, chargeInfo)
			else
				local goodsMO = StorePackageGoodsMO.New()

				goodsMO:initCharge(goodsConfig.belongStoreId, chargeInfo)

				self._allPackageDic[chargeInfo.id] = goodsMO

				if goodsConfig.belongStoreId == StoreEnum.StoreId.NormalPackage then
					self._chargePackageStoreDic[chargeInfo.id] = goodsMO
				elseif goodsConfig.belongStoreId == StoreEnum.StoreId.VersionPackage then
					self._versionChargePackageDict[chargeInfo.id] = goodsMO
				elseif goodsConfig.belongStoreId == StoreEnum.StoreId.OneTimePackage then
					self._onceTimeChargePackageDict[chargeInfo.id] = goodsMO
				elseif self._packageType2GoodsDict[goodsConfig.belongStoreId] then
					self._packageType2GoodsDict[goodsConfig.belongStoreId][chargeInfo.id] = goodsMO
				end

				if goodsConfig.taskid and goodsConfig.taskid ~= 0 then
					table.insert(self._taskGoodsIdList, chargeInfo.id)
				end
			end
		end
	end

	self:_updateSkinChargePackage(skinChargeInfoList)
	self:updatePackageStoreList(self._curPackageStore)
end

function StoreModel:_updateSkinChargePackage(chargeInfoList)
	self._skinChargeDict = self._skinChargeDict or {}
	chargeInfoList = chargeInfoList or {}

	for _, chargeInfo in ipairs(chargeInfoList) do
		self:_addSkinChargePackage(chargeInfo)
	end

	StoreController.instance:dispatchEvent(StoreEvent.SkinChargePackageUpdate)
end

function StoreModel:_addSkinChargePackage(chargeInfo)
	self._skinChargeDict = self._skinChargeDict or {}

	local storeSkinChargeMo = StoreSkinChargeMo.New()

	storeSkinChargeMo:init(StoreEnum.StoreId.Skin, chargeInfo)

	self._skinChargeDict[chargeInfo.id] = storeSkinChargeMo
end

function StoreModel:chargeOrderComplete(id)
	local mo = self._chargeStoreDic[id]

	self.updateChargeStore = false

	if mo == nil then
		mo = StoreEnum.ChargeStoreMonthCardDic[id] and self._allPackageDic[id] or self._chargePackageStoreDic[id] or self._versionChargePackageDict[id] or self._onceTimeChargePackageDict[id]
	else
		self.updateChargeStore = true
	end

	if mo then
		mo.buyCount = mo.buyCount + 1

		local goodsId = mo.config.id

		if StoreEnum.ChargeStoreMonthCardDic[goodsId] then
			ChargeRpc.instance:sendGetMonthCardInfoRequest(self.updateGoodsInfo, self)
		else
			self:updateGoodsInfo()
		end
	end
end

function StoreModel:updateGoodsInfo()
	if self.updateChargeStore then
		local storeId = self:getCurChargetStoreId()

		StoreChargeGoodsItemListModel.instance:setMOList(self._chargeStoreDic, storeId)
	else
		self:updatePackageStoreList(self._curPackageStore)
	end
end

function StoreModel:getCurChargetStoreId()
	return self._curChargeStoreId or 0
end

function StoreModel:setCurChargeStoreId(storeId)
	self._curChargeStoreId = storeId
end

function StoreModel:setCurPackageStore(storeId)
	self._curPackageStore = storeId
end

function StoreModel:getCurPackageStore()
	return self._curPackageStore or 0
end

function StoreModel:setPackageStoreRpcNum(v)
	self._packageStoreRpcLeftNum = v
end

function StoreModel:setCurBuyPackageId(id)
	self._curBuyPackageId = id
end

function StoreModel:getCurBuyPackageId()
	return self._curBuyPackageId
end

function StoreModel:updatePackageStoreList(storeId)
	local id = storeId or StoreEnum.StoreId.Package

	self._packageStoreRpcLeftNum = self._packageStoreRpcLeftNum - 1

	if self._packageStoreRpcLeftNum < 1 then
		if not storeId or storeId == StoreEnum.StoreId.RecommendPackage then
			local recommendGoodMoList = self:getRecommendPackageList(true)

			StorePackageGoodsItemListModel.instance:setMOList(nil, recommendGoodMoList)
		else
			local goodMoList = self._packageType2GoodsDict[storeId]

			StorePackageGoodsItemListModel.instance:setMOList(self:getStoreMO(id), goodMoList)
		end

		StoreController.instance:dispatchEvent(StoreEvent.UpdatePackageStore)
	end
end

function StoreModel:getStoreMO(id)
	return self._storeMODict[id]
end

function StoreModel:getGoodsMO(goodsId)
	if self._allPackageDic[goodsId] then
		return self._allPackageDic[goodsId]
	else
		for _, storeMO in pairs(self._storeMODict) do
			local goodsMO = storeMO:getGoodsMO(goodsId)

			if goodsMO then
				return goodsMO
			end
		end
	end
end

function StoreModel:getChargeGoods()
	return self._chargeStoreDic
end

function StoreModel:getChargeGoodsMo(goodsId)
	return self._chargeStoreDic[goodsId]
end

function StoreModel:isStoreSkinChargePackageValid(skinId)
	local goodsId = StoreConfig.instance:getSkinChargeGoodsId(skinId)

	return (self._skinChargeDict and self._skinChargeDict[goodsId] or nil) and true
end

function StoreModel:isStoreDecorateGoodsValid(materialId)
	local goodsId = StoreConfig.instance:getDecorateGoodsIdById(materialId)

	return (self:getGoodsMO(goodsId) or nil) and true
end

function StoreModel:getRecommendPackageList(refresh)
	if not refresh then
		return self._recommendPackageList
	end

	self._recommendPackageList = {}

	local recommendPackageNum = CommonConfig.instance:getConstNum(ConstEnum.RecommendStoreCount) or StoreEnum.RecommendPackageMaxCount

	if recommendPackageNum == 0 then
		return self._recommendPackageList
	end

	local tempList = {}

	for _, stroeId in ipairs(StoreEnum.RecommendPackageStoreIdList) do
		local packageMOs = self:getPackageGoodList(stroeId)

		if packageMOs then
			for _p, packageMo in pairs(packageMOs) do
				tempList[#tempList + 1] = packageMo
			end
		end
	end

	if #tempList > 1 then
		table.sort(tempList, self._packageSortFunction)
	end

	local curIdx = 1

	for i = 1, #tempList do
		local goodMo = tempList[i]

		if self:checkShowInRecommand(goodMo, goodMo.isChargeGoods) then
			self._recommendPackageList[curIdx] = goodMo

			if curIdx == recommendPackageNum then
				break
			end

			curIdx = curIdx + 1
		end
	end

	return self._recommendPackageList
end

function StoreModel:isGoodInRecommendList(goodsId)
	local recommendPackageList = self:getRecommendPackageList(false)

	for _, goodMo in ipairs(recommendPackageList) do
		if goodMo.goodsId == goodsId then
			return true
		end
	end
end

function StoreModel:getPackageGoodList(storeId)
	local allPackages = {}
	local chargePackages = self._packageType2GoodsDict[storeId]

	if not chargePackages then
		return allPackages
	end

	for _, pacgageGoodData in pairs(chargePackages) do
		allPackages[pacgageGoodData.id] = pacgageGoodData
	end

	local storeMO = self:getStoreMO(storeId)

	if storeMO then
		local goodsList = storeMO:getGoodsList()

		for _, mo in pairs(goodsList) do
			local goodsMO = StorePackageGoodsMO.New()

			goodsMO:init(storeId, mo.goodsId, mo.buyCount, mo.offlineTime)

			allPackages[mo.goodsId] = goodsMO
		end
	end

	return allPackages
end

function StoreModel:getPackageGoodValidList(storeId)
	local validGoods = {}

	if storeId == StoreEnum.StoreId.RecommendPackage then
		validGoods = self:getRecommendPackageList(true)
	else
		local allGoods = self:getPackageGoodList(storeId)

		for _, goodMo in pairs(allGoods) do
			if self:checkValid(goodMo, goodMo.isChargeGoods) then
				validGoods[#validGoods + 1] = goodMo
			end
		end
	end

	return validGoods
end

function StoreModel:getSummonPoolPackageValidList(summonPoolId)
	if summonPoolId == nil then
		return nil
	end

	local configOrderList = SummonConfig.instance:getSummonPoolPackageConfigList(summonPoolId)

	if configOrderList == nil or next(configOrderList) == nil then
		logError("不存在卡池礼包数据 id: " .. tostring(summonPoolId))

		return nil
	end

	for order, config in ipairs(configOrderList) do
		if string.nilorempty(config.packageRecommend) then
			logError("卡池礼包数据为空 id: " .. tostring(summonPoolId) .. " order: " .. tostring(order))
		end

		local result = {}
		local goodsIdList = string.splitToNumber(config.packageRecommend, "#")

		for _, goodsId in ipairs(goodsIdList) do
			local goodsMo = self:getGoodsMO(goodsId)

			if goodsMo == nil then
				logNormal("找不到对应的卡池礼包 id: " .. tostring(summonPoolId) .. " order: " .. tostring(order) .. " 礼包id:" .. tostring(goodsId))
			elseif not goodsMo:isSoldOut() then
				table.insert(result, goodsMo)
			end
		end

		if next(result) then
			return result
		end
	end

	return nil
end

function StoreModel:isSummonPoolPackageValid(summonPoolId, order)
	if summonPoolId == nil or order == nil then
		return false
	end

	local config = SummonConfig.instance:getSummonPoolPackageConfig(summonPoolId, order)

	if config == nil then
		logError("不存在卡池礼包数据 id: " .. tostring(summonPoolId))

		return false
	end

	if string.nilorempty(config.packageRecommend) then
		logError("卡池礼包数据为空 id: " .. tostring(summonPoolId))

		return false
	end

	local goodsIdList = string.splitToNumber(config.packageRecommend, "#")

	for _, goodsId in ipairs(goodsIdList) do
		local goodsMo = self:getGoodsMO(goodsId)

		if goodsMo and (not goodsMo:isSoldOut() or StoreCharageConditionalHelper.isCharageTaskNotFinish(goodsMo.goodsId)) then
			return true
		end
	end

	return false
end

function StoreModel:checkValid(goodsMO, isChargeGoods)
	isChargeGoods = isChargeGoods or false

	local show = true

	if goodsMO:isSoldOut() then
		if isChargeGoods and goodsMO.refreshTime == StoreEnum.ChargeRefreshTime.Forever then
			show = false
		end

		if isChargeGoods == false and goodsMO.config.refreshTime == StoreEnum.RefreshTime.Forever then
			show = false
		end

		if not show and StoreCharageConditionalHelper.isCharageTaskNotFinish(goodsMO.goodsId) then
			show = true
		end
	end

	show = show and self:checkPreGoodsId(goodsMO.config.preGoodsId)

	return show
end

function StoreModel:checkShowInRecommand(goodsMO, isChargeGoods)
	if goodsMO.config.notShowInRecommend then
		return false
	end

	if goodsMO.config.id == StoreEnum.MonthCardGoodsId then
		if not self:hasPurchaseMonthCard() then
			return true
		else
			return not StoreModel.instance:IsMonthCardDaysEnough()
		end
	end

	isChargeGoods = isChargeGoods or false

	local show = true

	if goodsMO:isSoldOut() then
		show = goodsMO.config.taskid ~= nil and goodsMO.config.taskid ~= 0 and StoreCharageConditionalHelper.isCharageTaskNotFinish(goodsMO.goodsId) or false
	end

	show = show and self:checkPreGoodsId(goodsMO.config.preGoodsId)

	return show
end

function StoreModel:checkPreGoodsId(goodsId)
	if goodsId == 0 then
		return true
	end

	local preGoodsMO = self:getGoodsMO(goodsId)
	local isSoldOut = preGoodsMO and preGoodsMO:isSoldOut()

	return isSoldOut and (isSoldOut and preGoodsMO and preGoodsMO.config.taskid ~= nil and preGoodsMO.config.taskid ~= 0 or nil) and StoreCharageConditionalHelper.isCharageTaskFinish(preGoodsMO.goodsId)
end

function StoreModel:getBuyCount(storeId, goodsId)
	local storeMO = self._storeMODict[storeId]

	if not storeMO then
		return 0
	end

	return storeMO:getBuyCount(goodsId)
end

function StoreModel:isTabMainRedDotShow(tabid)
	local storedotinfos = self:getAllRedDotInfo()

	if storedotinfos then
		for _, v in pairs(storedotinfos) do
			local belongStore
			local isActRedDot = false
			local goodsMo = self:getGoodsMO(v.uid)

			if goodsMo then
				belongStore = StoreConfig.instance:getTabConfig(goodsMo.belongStoreId)
			else
				belongStore = StoreConfig.instance:getTabConfig(v.uid)
				isActRedDot = true
			end

			if belongStore then
				local firsttabId = belongStore.belongFirstTab

				if firsttabId == 0 then
					local secondTabId = belongStore.belongSecondTab

					if secondTabId ~= 0 then
						firsttabId = StoreConfig.instance:getTabConfig(secondTabId).belongFirstTab
					end
				end

				if firsttabId == 0 then
					firsttabId = belongStore.id
				end

				if v.value > 0 and tabid == firsttabId then
					return true, isActRedDot
				end
			end
		end
	end

	return false
end

function StoreModel:isTabFirstRedDotShow(tabid)
	local storedotinfos = self:getAllRedDotInfo()

	if storedotinfos then
		for _, v in pairs(storedotinfos) do
			local goodsMo = self:getGoodsMO(v.uid)

			if goodsMo then
				local goodId = goodsMo.goodsId
				local isRecommandPackTab = tabid == StoreEnum.StoreId.RecommendPackage
				local isPerMonthLimit = goodsMo.refreshTime == StoreEnum.ChargeRefreshTime.Month
				local isPerWeekLimit = goodsMo.refreshTime == StoreEnum.ChargeRefreshTime.Week

				if isRecommandPackTab and self:isGoodInRecommendList(goodId) and not isPerWeekLimit and not isPerMonthLimit then
					return true
				else
					if tabid == StoreEnum.StoreId.HighSummon and goodsMo.belongStoreId == tabid and v.value > 0 then
						return true
					end

					local secondtab = StoreConfig.instance:getTabConfig(goodsMo.belongStoreId).belongSecondTab

					if v.value > 0 and tabid == secondtab then
						return true
					end
				end
			end

			if v.value > 0 and v.uid == tabid then
				return true, true
			end
		end
	end

	return false
end

function StoreModel:isTabSecondRedDotShow(tabid)
	local storedotinfos = self:getAllRedDotInfo()

	if storedotinfos then
		for _, v in pairs(storedotinfos) do
			local goodsMo = self:getGoodsMO(v.uid)

			if goodsMo and v.value > 0 and tabid == goodsMo.belongStoreId then
				return true
			end
		end
	end

	return false
end

function StoreModel:isPackageStoreTabRedDotShow(tabid)
	local storedotinfos = self:getAllRedDotInfo()

	if storedotinfos then
		for _, v in pairs(storedotinfos) do
			local goodsMo = self:getGoodsMO(v.uid)

			if goodsMo then
				local goodId = goodsMo.goodsId

				if tabid == StoreEnum.StoreId.RecommendPackage and self:isGoodInRecommendList(goodId) then
					return true
				elseif v.value > 0 and tabid == goodsMo.belongStoreId then
					return true
				end
			end
		end
	end

	return false
end

function StoreModel:getAllRedDotInfo()
	local dotInfo1 = RedDotModel.instance:getRedDotInfo(RedDotEnum.DotNode.StoreTab)
	local dotInfo2 = RedDotModel.instance:getRedDotInfo(RedDotEnum.DotNode.StoreGoodsRead)
	local dotInfo3 = RedDotModel.instance:getRedDotInfo(RedDotEnum.DotNode.StoreChargeGoodsRead)
	local dotInfo4 = RedDotModel.instance:getRedDotInfo(RedDotEnum.DotNode.V1a6FurnaceTreasure)
	local allInfo = {}

	if dotInfo1 then
		for _, v in pairs(dotInfo1.infos) do
			table.insert(allInfo, v)
		end
	end

	if dotInfo2 then
		for _, v in pairs(dotInfo2.infos) do
			table.insert(allInfo, v)
		end
	end

	if dotInfo3 then
		for _, v in pairs(dotInfo3.infos) do
			table.insert(allInfo, v)
		end
	end

	if dotInfo4 then
		for _, v in pairs(dotInfo4.infos) do
			table.insert(allInfo, v)
		end
	end

	if self._taskGoodsIdList then
		self._taskGoodsId2DotInfoDict = self._taskGoodsId2DotInfoDict or {}

		for _, goodsId in ipairs(self._taskGoodsIdList) do
			local dotInfoMo = self._taskGoodsId2DotInfoDict[goodsId]

			if not dotInfoMo then
				dotInfoMo = RedDotInfoMo.New()
				self._taskGoodsId2DotInfoDict[goodsId] = dotInfoMo

				dotInfoMo:init({
					value = 0,
					time = 0,
					ext = "",
					id = goodsId
				})
			end

			dotInfoMo.value = 0

			local hasCanFinishTask = StoreCharageConditionalHelper.isHasCanFinishGoodsTask(goodsId)

			if hasCanFinishTask then
				dotInfoMo.value = 1

				table.insert(allInfo, dotInfoMo)
			end
		end
	end

	local skinGoodsList = StoreClothesGoodsItemListModel.instance:getList()

	if skinGoodsList then
		self._skinGoodsId2DotInfoDict = self._skinGoodsId2DotInfoDict or {}

		for _, goodsMo in ipairs(skinGoodsList) do
			local goodsId = goodsMo.goodsId
			local dotInfoMo = self._skinGoodsId2DotInfoDict[goodsId]

			if not dotInfoMo then
				dotInfoMo = RedDotInfoMo.New()
				self._skinGoodsId2DotInfoDict[goodsId] = dotInfoMo

				dotInfoMo:init({
					value = 0,
					time = 0,
					ext = "",
					id = goodsId
				})
			end

			dotInfoMo.value = 0

			if goodsMo:checkShowNewRedDot() then
				dotInfoMo.value = 1

				table.insert(allInfo, dotInfoMo)
			end
		end
	end

	return allInfo
end

function StoreModel:checkTaskRewardRedDotType_1(goodsId, taskConfig, haveCanFinishTask)
	if taskConfig.redDot == nil or taskConfig == 0 then
		return
	end

	local redDotId = taskConfig.redDot
	local redDotInfo = {
		time = 0,
		ext = "",
		id = goodsId,
		value = haveCanFinishTask and 1 or 0
	}
	local reddotItemInfo = {
		replaceAll = false,
		defineId = redDotId,
		infos = {
			redDotInfo
		}
	}
	local redDotInfos = {
		reddotItemInfo
	}

	RedDotModel.instance:updateRedDotInfo(redDotInfos)

	local refreshlist = {}
	local ids = RedDotModel.instance:_getAssociateRedDots(redDotId)

	for _, id in pairs(ids) do
		refreshlist[id] = true
	end

	logNormal("更新连锁礼包红点状态 id:" .. tostring(goodsId) .. " 是否可领取: " .. tostring(haveCanFinishTask))
	RedDotController.instance:dispatchEvent(RedDotEvent.UpdateRelateDotInfo, refreshlist)
end

function StoreModel:isHasTaskGoodsReward()
	if self._taskGoodsIdList then
		for _, goodsId in ipairs(self._taskGoodsIdList) do
			if StoreCharageConditionalHelper.isHasCanFinishGoodsTask(goodsId) then
				return true
			end
		end
	end

	return false
end

function StoreModel:isGoodsItemRedDotShow(goodsid)
	local dotInfo = RedDotModel.instance:getRedDotInfo(RedDotEnum.DotNode.StoreTab)

	if dotInfo then
		local storedotinfos = dotInfo.infos

		for _, v in pairs(storedotinfos) do
			if v.uid == goodsid and v.value > 0 then
				return true
			end
		end
	end

	if StoreCharageConditionalHelper.isHasCanFinishGoodsTask(goodsid) then
		return true
	end

	return false
end

function StoreModel:isStoreTabLock(storeId)
	local co = StoreConfig.instance:getStoreConfig(storeId)

	if co and co.needClearStore > 0 then
		local goodsinfos = self._storeMODict[co.needClearStore].goodsInfos

		for _, v in pairs(goodsinfos) do
			if v.goodsId then
				local goodsCo = StoreConfig.instance:getGoodsConfig(v.goodsId)

				if goodsCo and v.buyCount < goodsCo.maxBuyCount then
					return true
				end
			end
		end
	end

	return false
end

StoreModel.ignoreStoreTab = {
	StoreEnum.BossRushStore,
	StoreEnum.TowerStore,
	{
		StoreEnum.StoreId.RoomFishingStore
	},
	{
		StoreEnum.StoreId.TwinssychubeEquipStore
	}
}

function StoreModel:checkContainIgnoreStoreTab(storeId)
	for _, storeTab in pairs(self.ignoreStoreTab) do
		if LuaUtil.tableContains(storeTab, storeId) then
			return true
		end
	end

	return false
end

function StoreModel:getFirstTabs(filterOpen, order)
	local tabList = {}

	for i, tabConfig in ipairs(lua_store_entrance.configList) do
		if not StoreConfig.instance:hasTab(tabConfig.belongFirstTab) and not StoreConfig.instance:hasTab(tabConfig.belongSecondTab) then
			local isIgnore = self:checkContainIgnoreStoreTab(tabConfig.id)

			if not ((tabConfig.id == StoreEnum.StoreId.DecorateStore and #DecorateStoreModel.instance:getDecorateGoodList(StoreEnum.StoreId.NewDecorateStore) == 0 and #DecorateStoreModel.instance:getDecorateGoodList(StoreEnum.StoreId.OldDecorateStore) == 0 or nil) and true) and (not filterOpen or self:isTabOpen(tabConfig.id)) then
				table.insert(tabList, tabConfig)
			end
		end
	end

	if order and #tabList > 1 then
		table.sort(tabList, self._tabSortFunction)
	end

	return tabList
end

function StoreModel:getSecondTabs(firstTabId, filterOpen, order)
	local tabList = {}

	for i, tabConfig in ipairs(lua_store_entrance.configList) do
		if StoreConfig.instance:hasTab(tabConfig.belongFirstTab) and tabConfig.belongFirstTab == firstTabId and (not filterOpen or self:isTabOpen(tabConfig.id)) then
			table.insert(tabList, tabConfig)
		end
	end

	if order and #tabList > 1 then
		if firstTabId == StoreEnum.StoreId.Package and not self:isNewPlayer() then
			table.sort(tabList, self._tabPackageSortFunction)
		else
			table.sort(tabList, self._tabSortFunction)
		end
	end

	return tabList
end

function StoreModel:isNewPlayer()
	local registerTime = ServerTime.timeInLocal(PlayerModel.instance:getPlayerRegisterTime() / TimeUtil.OneSecondMilliSecond)
	local curTime = ServerTime.now()

	if math.max(0, curTime - registerTime) >= StoreEnum.NewPlayerRegisterLimit * TimeUtil.OneDaySecond then
		return false
	end

	return true
end

function StoreModel:getRecommendSecondTabs(firstTabId, filterOpen)
	local tabList = {}

	for i, tabConfig in ipairs(lua_store_entrance.configList) do
		if StoreConfig.instance:hasTab(tabConfig.belongFirstTab) and tabConfig.belongFirstTab == firstTabId and (not filterOpen or self:isTabOpen(tabConfig.id)) then
			table.insert(tabList, tabConfig)
		end
	end

	for i, v in ipairs(lua_store_recommend.configList) do
		if v.type == 0 then
			table.insert(tabList, v)
		end
	end

	return tabList
end

function StoreModel:getThirdTabs(secondTabId, filterOpen, order)
	local tabList = {}

	for i, tabConfig in ipairs(lua_store_entrance.configList) do
		if StoreConfig.instance:hasTab(tabConfig.belongSecondTab) and tabConfig.belongSecondTab == secondTabId and (not filterOpen or self:isTabOpen(tabConfig.id)) then
			table.insert(tabList, tabConfig)
		end
	end

	if order and #tabList > 1 then
		table.sort(tabList, self._tabSortFunction)
	end

	return tabList
end

function StoreModel:isTabOpen(tabId)
	local tabConfig = StoreConfig.instance:getTabConfig(tabId)

	if tabConfig then
		if tabConfig.openId and tabConfig.openId ~= 0 and not OpenModel.instance:isFunctionUnlock(tabConfig.openId) then
			return false
		end

		if tabConfig.openHideId and tabConfig.openHideId ~= 0 and OpenModel.instance:isFunctionUnlock(tabConfig.openHideId) then
			return false
		end

		local openTimeStamp, endTimeStamp

		if not string.nilorempty(tabConfig.openTime) then
			openTimeStamp = TimeUtil.stringToTimestamp(tabConfig.openTime)
		end

		if not string.nilorempty(tabConfig.endTime) then
			endTimeStamp = TimeUtil.stringToTimestamp(tabConfig.endTime)
		end

		if string.nilorempty(tabConfig.openTime) and string.nilorempty(tabConfig.endTime) then
			-- block empty
		elseif string.nilorempty(tabConfig.endTime) then
			if openTimeStamp >= ServerTime.now() then
				return false
			end
		elseif string.nilorempty(tabConfig.openTime) then
			if endTimeStamp <= ServerTime.now() then
				return false
			end
		else
			local openTime = openTimeStamp
			local endTime = endTimeStamp
			local diff = StoreConfig.instance:getOpenTimeDiff(openTime, endTime, ServerTime.now())

			if diff <= 0 then
				return false
			end
		end

		if tabConfig.storeId == StoreEnum.StoreId.Package and GameFacade.isKOLTest() then
			return false
		end

		if StoreConfig.instance:getTabHierarchy(tabConfig.id) == 2 then
			if tabConfig.storeId and tabConfig.storeId ~= 0 then
				return true
			else
				local thirdTabConfigs = self:getThirdTabs(tabConfig.id, true, false)

				if thirdTabConfigs and #thirdTabConfigs > 0 then
					return true
				end
			end
		else
			return true
		end
	end

	return false
end

function StoreModel._tabSortFunction(xConfig, yConfig)
	return xConfig.order > yConfig.order
end

function StoreModel._tabPackageSortFunction(xConfig, yConfig)
	if xConfig.id == StoreEnum.StoreId.OneTimePackage then
		return false
	end

	if yConfig.id == StoreEnum.StoreId.OneTimePackage then
		return true
	end

	return xConfig.order > yConfig.order
end

function StoreModel._packageSortFunction(goodsMo1, goodsMo2)
	local cfg1 = goodsMo1.config
	local cfg2 = goodsMo2.config

	return cfg1.order < cfg2.order
end

function StoreModel:jumpTabIdToSelectTabId(jumpTabId)
	local firstTabId, secondTabId, thirdTabId = 0, 0, 0
	local tabHierarchy = StoreConfig.instance:getTabHierarchy(jumpTabId)

	if tabHierarchy == 3 then
		thirdTabId = jumpTabId

		local thirdTabConfig = StoreConfig.instance:getTabConfig(jumpTabId)

		secondTabId = thirdTabConfig and thirdTabConfig.belongSecondTab or 0

		local secondTabConfig = StoreConfig.instance:getTabConfig(secondTabId)

		firstTabId = secondTabConfig and secondTabConfig.belongFirstTab or 0
	elseif tabHierarchy == 2 then
		secondTabId = jumpTabId

		local thirdTabConfigs = self:getThirdTabs(jumpTabId, true, true)

		if thirdTabConfigs and #thirdTabConfigs > 0 then
			thirdTabId = thirdTabConfigs[1].id
		end

		local secondTabConfig = StoreConfig.instance:getTabConfig(secondTabId)

		firstTabId = secondTabConfig and secondTabConfig.belongFirstTab or 0
	else
		firstTabId = jumpTabId

		local secondTabConfigs = self:getSecondTabs(jumpTabId, true, true)

		if firstTabId == StoreEnum.StoreId.Package then
			for i = 1, #secondTabConfigs do
				local secondTabsGoods = self:getPackageGoodValidList(secondTabConfigs[i].id)

				if #secondTabsGoods > 0 then
					secondTabId = secondTabConfigs[i].id

					break
				end
			end

			thirdTabId = 0
		elseif firstTabId == StoreEnum.StoreId.DecorateStore then
			for i = 1, #secondTabConfigs do
				local secondTabsGoods = DecorateStoreModel.instance:getDecorateGoodList(secondTabConfigs[i].id)

				if #secondTabsGoods > 0 then
					secondTabId = secondTabConfigs[i].id

					break
				end
			end

			thirdTabId = 0
		elseif secondTabConfigs and #secondTabConfigs > 0 then
			secondTabId = secondTabConfigs[1].id

			local thirdTabConfigs = self:getThirdTabs(secondTabConfigs[1].id, true, true)

			if thirdTabConfigs and #thirdTabConfigs > 0 then
				thirdTabId = thirdTabConfigs[1].id
			end
		else
			secondTabId = firstTabId
		end
	end

	return firstTabId, secondTabId, thirdTabId
end

function StoreModel:jumpTabIdToStoreId(jumpTabId)
	local storeId = 0
	local firstTabId, secondTabId, thirdTabId = self:jumpTabIdToSelectTabId(jumpTabId)
	local thirdConfig = StoreConfig.instance:getTabConfig(thirdTabId)
	local secondConfig = StoreConfig.instance:getTabConfig(secondTabId)
	local firstConfig = StoreConfig.instance:getTabConfig(firstTabId)

	storeId = thirdConfig and thirdConfig.storeId or 0

	if storeId == 0 then
		storeId = secondConfig and secondConfig.storeId or 0
	end

	if storeId == 0 then
		storeId = firstConfig and firstConfig.storeId or 0
	end

	return storeId
end

function StoreModel:updateMonthCardInfo(monthCardInfo)
	if monthCardInfo then
		if self.monthCardInfo then
			self.monthCardInfo:update(monthCardInfo)
		else
			self.monthCardInfo = StoreMonthCardInfoMO.New()

			self.monthCardInfo:init(monthCardInfo)
		end
	end
end

function StoreModel:getMonthCardInfo()
	return self.monthCardInfo
end

function StoreModel:hasPurchaseMonthCard()
	return self.monthCardInfo ~= nil
end

function StoreModel:IsMonthCardDaysEnough()
	local result = false

	if self:hasPurchaseMonthCard() then
		local monthCardInfo = self:getMonthCardInfo()
		local remainDay = monthCardInfo:getRemainDay()
		local remindDay = CommonConfig.instance:getConstNum(ConstEnum.MonthCardPurchaseRemindDay)

		result = remindDay < remainDay
	end

	return result
end

function StoreModel:isSkinDiscountNotSoldOut()
	local storeGoodsMo = StoreModel.instance:getGoodsMO(StoreEnum.V3a3_SkinDiscountItemId)

	if storeGoodsMo and storeGoodsMo:isSoldOut() then
		return false
	end

	return true
end

function StoreModel:getCostStr(num)
	return "¥", num
end

function StoreModel:getCostSymbolAndPrice(goodId)
	local config = StoreConfig.instance:getChargeGoodsConfig(goodId)

	return "¥", config.price
end

function StoreModel:getCostPriceFull(goodId)
	local config = StoreConfig.instance:getChargeGoodsConfig(goodId)

	return string.format("¥%d", config.price)
end

function StoreModel:getOriginCostPriceFull(goodId)
	local config = StoreConfig.instance:getChargeGoodsConfig(goodId)

	return string.format("¥%d", config.originalCost)
end

function StoreModel:checkTabShowNewTag(tabId)
	local storeMO = self:getStoreMO(tabId)

	if storeMO then
		local goodsList = storeMO:getGoodsList()

		for _, mo in pairs(goodsList) do
			if mo:needShowNew() then
				return true
			end
		end
	end

	return false
end

function StoreModel:setNewRedDotKey(tabId)
	local key = PlayerPrefsKey.StoreViewShowNew .. tabId

	GameUtil.playerPrefsSetStringByUserId(key, tabId)
end

function StoreModel:checkShowNewRedDot(tabId)
	local key = PlayerPrefsKey.StoreViewShowNew .. tabId
	local value = GameUtil.playerPrefsGetStringByUserId(key, nil)

	if value then
		return false
	end

	return true
end

function StoreModel:isSkinGoodsCanRepeatBuy(goodsMo, skinId)
	local mo = goodsMo

	if not mo then
		return false
	end

	local isSkinGoods = skinId == nil

	if skinId == nil then
		local productInfo = string.splitToNumber(mo.config.product, "#")

		skinId = productInfo[2]
	end

	local skinCo = SkinConfig.instance:getSkinCo(skinId)

	if not skinCo then
		return false
	end

	local storeId = mo.config.storeId
	local unavailableStore = skinCo.unavailableStore

	if not string.nilorempty(unavailableStore) then
		local unavailableStoreList = string.split(unavailableStore, "#")

		for _, _storeId in ipairs(unavailableStoreList or {}) do
			if storeId == _storeId then
				return false
			end
		end
	end

	if string.nilorempty(skinCo.repeatBuyTime) then
		return false
	end

	local serverTime = ServerTime.now()
	local time = TimeUtil.stringToTimestamp(skinCo.repeatBuyTime)

	if time < serverTime then
		return false
	end

	local isSoldOut = mo:isSoldOut()

	if not isSoldOut and isSkinGoods then
		local chargeGoodsId = StoreConfig.instance:getSkinChargeGoodsId(skinId)

		if chargeGoodsId then
			local chargeGoodsMo = self._skinChargeDict[chargeGoodsId]

			isSoldOut = chargeGoodsMo and chargeGoodsMo:isSoldOut()
		end
	end

	local alreadyHas = HeroModel.instance:checkHasSkin(skinId)

	return alreadyHas and not isSoldOut
end

function StoreModel:isSkinCanShowMessageBox(skinId)
	if self:isSkinHasStoreId(skinId) then
		local prefsKey = PlayerPrefsKey.SkinCanShowMessageBox
		local val = GameUtil.playerPrefsGetStringByUserId(prefsKey, "")
		local tab = string.splitToNumber(val, "#")
		local isFind = tabletool.indexOf(tab, skinId) ~= nil

		if not isFind then
			table.insert(tab, skinId)
			GameUtil.playerPrefsSetStringByUserId(prefsKey, table.concat(tab, "#"))

			return true
		end
	end
end

function StoreModel:isSkinHasStoreId(skinId)
	if not skinId then
		return
	end

	local co = lua_skin.configDict[skinId]

	if not co then
		return
	end

	local serverTime = ServerTime.now()

	if not string.nilorempty(co.repeatBuyTime) then
		local time = TimeUtil.stringToTimestamp(co.repeatBuyTime)

		if time < serverTime then
			return
		end
	end

	local goodsId = co.skinStoreId

	if goodsId == 0 then
		return
	end

	local goodsMo = self:getGoodsMO(goodsId)

	if not goodsMo then
		return
	end

	local goodsConfig = goodsMo.config
	local openTime = string.nilorempty(goodsConfig.onlineTime) and serverTime or TimeUtil.stringToTimestamp(goodsConfig.onlineTime) - ServerTime.clientToServerOffset()
	local endTime = string.nilorempty(goodsConfig.offlineTime) and serverTime or TimeUtil.stringToTimestamp(goodsConfig.offlineTime) - ServerTime.clientToServerOffset()

	if goodsConfig.isOnline then
		local isOpen = not (openTime > serverTime or serverTime > endTime)
		local flag = isOpen and not goodsMo:isSoldOut()

		return flag, goodsId
	end
end

function StoreModel:getPackageGoodMo(goodsId)
	local config = StoreConfig.instance:getChargeGoodsConfig(goodsId)

	if not config then
		return
	end

	local storeId = config.belongStoreId
	local list = self:getPackageGoodList(storeId)

	if list then
		for k, v in pairs(list) do
			if v.goodsId == goodsId then
				return v
			end
		end
	end
end

function StoreModel:markPackageGoodsNewRedDot(goodsId)
	self.cachePackageGoodsDic[goodsId] = true
end

function StoreModel:isMarkPackageGoodsNewRedDot(goodsId)
	return self.cachePackageGoodsDic and self.cachePackageGoodsDic[goodsId]
end

function StoreModel:clearMarkedPackageGoodsNewRedDot()
	tabletool.clear(self.cachePackageGoodsDic)
end

function StoreModel:getMarkedPackageGoodsNewRedDot()
	return self.cachePackageGoodsDic
end

StoreModel.instance = StoreModel.New()

return StoreModel
