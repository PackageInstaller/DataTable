-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/store/model/StoreModel.lua

module("logic.extensions.store.model.StoreModel", package.seeall)

local M = class("StoreModel", BaseModel)

function M:ctor()
	self._curSelectData = false
	self._storeTabList = {}
	self._allStoreList = {}
	self._newList = {}
	self._recommendList = nil
	self._allGoodsDataList = {}
end

function M:onReset()
	self._curSelectData = false
	self._curJumpInfo = false
	self._recommendList = nil
	self._newList = {}
end

function M:initStoreTab(navlist)
	for index, value in ipairs(navlist) do
		if value.isOnline == 1 then
			table.insert(self._storeTabList, value)
		end
	end

	table.sort(self._storeTabList, function(item1, item2)
		if not item1 or not item2 then
			return false
		end

		local id1 = item1.code
		local id2 = item2.code
		local sortIndex1 = item1.sortIndex
		local sortIndex2 = item2.sortIndex

		if sortIndex1 == sortIndex2 then
			return id1 < id2
		end

		return sortIndex1 < sortIndex2
	end)
end

function M:initAllStoreCfg(storelist)
	for index, value in ipairs(storelist) do
		local storeMo = StoreMo.New()

		storeMo:initByCfg(value.mallId)
		self:_initStoreList(value.tabId, storeMo)
	end
end

function M:initStoreByAgent(malls)
	local len = #malls
	local serStoreList = {}

	for i = 1, len do
		local storeMo = StoreMo.New()

		storeMo:initByAgent(malls[i])

		local tabId = storeMo:getTabId()

		table.insert(serStoreList, malls[i].mallId)
		self:_initStoreList(tabId, storeMo)
	end

	if self._allStoreList then
		for tabId, storeList in pairs(self._allStoreList) do
			for index, storeMo in pairs(storeList) do
				if not TableUtil.contains(serStoreList, storeMo:getId()) then
					storeMo:setIsOnLine(false)
				end
			end
		end
	end
end

function M:updateStoreByAgent(mall)
	local mallId = mall.mallId

	if self._allStoreList then
		for tabId, storeList in pairs(self._allStoreList) do
			for index, storeMo in pairs(storeList) do
				if mallId == storeMo:getId() then
					storeMo:updateByAgent(mall)
				end
			end
		end
	end
end

function M:_initStoreList(tabId, storeMo)
	if not self._allStoreList[tabId] then
		self._allStoreList[tabId] = {}
	end

	local storeList = self._allStoreList[tabId]

	if not self:_updateStore(storeMo, storeList) then
		table.insert(self._allStoreList[tabId], storeMo)
	end

	self:_sortStoreList(self._allStoreList[tabId])
end

function M:getTabIdByStoreId(storeId)
	for tabId, storeList in pairs(self._allStoreList) do
		for index, storeMo in pairs(storeList) do
			if storeId == storeMo:getId() then
				return storeMo:getTabId()
			end
		end
	end

	return 1001
end

function M:_updateStore(storeMo, storeList)
	for index, sotre in pairs(storeList) do
		if sotre:getId() == storeMo:getId() then
			storeList[index] = storeMo

			return true
		end
	end

	return false
end

function M:_sortStoreList(list)
	table.sort(list, function(item1, item2)
		if not item1 or not item2 then
			return false
		end

		local id1 = item1:getId()
		local id2 = item2:getId()
		local sortIndex1 = item1:getShowIndex()
		local sortIndex2 = item2:getShowIndex()

		if sortIndex1 == sortIndex2 then
			return id1 < id2
		end

		return sortIndex1 < sortIndex2
	end)
end

function M:getStoresByStoreType(type)
	local stores = {}

	for tabId, storeList in pairs(self._allStoreList) do
		for index, storeMo in pairs(storeList) do
			if type == storeMo:getStoreType() and storeMo:getIsOnLine() then
				table.insert(stores, storeMo)
			end
		end
	end

	return stores
end

function M:updateRecommendData()
	local list = StoreConfig.instance:getRecommendDataList()

	self._recommendList = {}

	for index, value in ipairs(list) do
		local storeHotTabMo = StoreHotTabMo.New()

		storeHotTabMo:initByCfg(value)

		if not self._recommendList[value.code] then
			self._recommendList[value.code] = {}
		end

		self._recommendList[value.code] = storeHotTabMo
	end
end

function M:sortRecommendList(list)
	table.sort(list, function(item1, item2)
		if not item1 or not item2 then
			return false
		end

		local sortIndex1 = item1:getSort()
		local sortIndex2 = item2:getSort()

		if sortIndex1 == sortIndex2 then
			return item1:getId() < item2:getId()
		end

		return sortIndex1 < sortIndex2
	end)
end

function M:initGoodsData(dataNo, tabId, storeId)
	if not self._allGoodsDataList[tabId] then
		self._allGoodsDataList[tabId] = {}
	end

	if not self._allGoodsDataList[tabId][storeId] then
		self._allGoodsDataList[tabId][storeId] = {}
	end

	self:_updateGoodList(dataNo, tabId, storeId)
end

function M:_updateGoodList(dataNo, tabId, storeId)
	self:_updateSellOut(dataNo, storeId)

	local isUpdate = false
	local goodsList = self._allGoodsDataList[tabId][storeId]

	for index, goods in pairs(goodsList) do
		if goods:getGoodsId() == dataNo:getGoodsId() then
			if dataNo:getSellOut() and dataNo:isHideSellOut() then
				table.remove(goodsList, index)
			else
				goodsList[index] = dataNo
			end

			isUpdate = true

			break
		end
	end

	if not isUpdate and (not dataNo:getSellOut() or not dataNo:isHideSellOut()) then
		table.insert(self._allGoodsDataList[tabId][storeId], dataNo)
	end
end

function M:_updateSellOut(dataNo, storeId)
	dataNo:setSellState(false)

	local storeType = StoreUtil.getStoreType(storeId)

	if storeType == StoreEnum.MallType.GiftBag then
		local remainedDay = dataNo:getRemainedDay()
		local batchBuyNum = dataNo:getBatchBuyNum()
		local isInEffect = batchBuyNum > 0 and remainedDay > -1

		if dataNo:getRemainedNum() == 0 or isInEffect then
			dataNo:setSellState(true)
		end
	elseif storeType == StoreEnum.MallType.CurrencyExchange or storeType == StoreEnum.MallType.RandomOutput or storeType == StoreEnum.MallType.Fixed then
		local remainedNum = dataNo:getRemainedNum()

		if remainedNum == 0 then
			dataNo:setSellState(true)
		end

		local dailyBuyNum = dataNo:getDailyBuyNum()
		local dailyBuyMaxNum = dataNo:getDailyBuyMaxNum()

		if dailyBuyMaxNum <= dailyBuyNum and dailyBuyMaxNum > 0 then
			dataNo:setSellState(true)
		end
	elseif storeType == StoreEnum.MallType.Skin then
		local skinId = dataNo:getSkinId()
		local hasBuy = HeroSkinModel.instance:getIsSkinUnlock(skinId)

		dataNo:setSellState(hasBuy)
	end
end

function M:sortGoodsList(goodslist)
	table.sort(goodslist, function(item1, item2)
		if not item1 or not item2 then
			return false
		end

		local id1 = item1:getGoodsId()
		local id2 = item2:getGoodsId()
		local sellout1 = item1:getSellOut() and 1 or 0
		local sellout2 = item2:getSellOut() and 1 or 0
		local sortIndex1 = item1:getSortIndex()
		local sortIndex2 = item2:getSortIndex()

		if sellout1 == sellout2 then
			if sortIndex1 == sortIndex2 then
				return id1 < id2
			else
				return sortIndex1 < sortIndex2
			end
		else
			return sellout1 < sellout2
		end
	end)
end

function M:clearGoodsData(storeId)
	local tabId = StoreConfig.instance:getStoreTabId(storeId)

	if not self._allGoodsDataList[tabId] then
		self._allGoodsDataList[tabId] = {}
	end

	self._allGoodsDataList[tabId][storeId] = {}
end

function M:checkGoodsCache(tabId, storeId)
	if not self._allGoodsDataList[tabId] then
		return false
	end

	if not self._allGoodsDataList[tabId][storeId] then
		return false
	end

	return true
end

function M:getGoodsList(tabId, storeId)
	if not self:checkGoodsCache(tabId, storeId) then
		return false
	end

	local tmpTb = self._allGoodsDataList[tabId][storeId]

	self:sortGoodsList(tmpTb)

	return tmpTb
end

function M:getCanBuyGoodsInStore(storeId)
	local tabId = self:getTabIdByStoreId(storeId)
	local storeType = StoreUtil.getStoreType(storeId)
	local goodsList = self:getGoodsList(tabId, storeId)
	local canBuyGoodsIds = {}

	if goodsList and #goodsList > 0 then
		for _, data in ipairs(goodsList or {}) do
			if not data:getSellOut() then
				table.insert(canBuyGoodsIds, data:getGoodsId())
			end
		end
	end

	return canBuyGoodsIds
end

function M:getTabIdByGoodsId(goodsId)
	for tabId, storeMap in pairs(self._allGoodsDataList) do
		for storeId, goodsMapList in pairs(storeMap) do
			for goodsIndex, goodsMap in pairs(goodsMapList) do
				if goodsMap:getGoodsId() == goodsId then
					return tabId, storeId
				end
			end
		end
	end

	return false
end

function M:getGoodMoByGoodsId(goodsId)
	for tabId, storeMap in pairs(self._allGoodsDataList) do
		for storeId, goodsMapList in pairs(storeMap) do
			for goodsIndex, goodsMap in pairs(goodsMapList) do
				if goodsMap:getGoodsId() == goodsId then
					return goodsMap
				end
			end
		end
	end

	return false
end

function M:getStoreTabList()
	local list = {}

	for i = 1, #self._storeTabList do
		local tabCfg = self._storeTabList[i]

		if tabCfg.code == StoreEnum.TabId.SuperValue then
			table.insert(list, tabCfg)
		else
			local storeList = self:getStoreListByTabIndex(tabCfg.code)

			if #storeList > 0 then
				table.insert(list, tabCfg)
			end
		end
	end

	return list
end

function M:getTabIdByTabIndex(tabIndex)
	for index, tabInfo in pairs(self._storeTabList) do
		if index == tabIndex then
			return tabInfo.code
		end
	end

	return false
end

function M:getStoreTabIndexById(tabId)
	for index, tabInfo in ipairs(self._storeTabList) do
		if tabInfo.code == tabId then
			return index
		end
	end

	return false
end

function M:getStoreListByTabIndex(tabId)
	local sotreList = {}

	if self._allStoreList and self._allStoreList[tabId] then
		for index, storeMo in pairs(self._allStoreList[tabId]) do
			if storeMo:getIsOnLine() and storeMo:getIsHasGoods() then
				table.insert(sotreList, storeMo)
			end
		end
	end

	return sotreList
end

function M:getStoreMoByID(storeId)
	for tabId, storeMoList in pairs(self._allStoreList) do
		for index, storeMo in pairs(storeMoList) do
			if storeMo:getId() == storeId and storeMo:getIsOnLine() then
				return storeMo
			end
		end
	end

	return false
end

function M:isStoreOnline(storeId)
	local storeMo = self:getStoreMoByID(storeId)

	if storeMo and storeMo:getIsOnLine() then
		return true
	end

	return false
end

function M:getRecommendList()
	self:updateRecommendData()

	local list = self:_checkRecommendList(self._recommendList)

	self:sortRecommendList(list)

	return list
end

function M:_checkRecommendList(list)
	local tmpList = {}

	for index, recomend in pairs(list) do
		if not recomend:getIsExpired() and recomend:getIsOnline() then
			table.insert(tmpList, recomend)
		end
	end

	return tmpList
end

function M:setJumpInfo(data)
	self._curJumpInfo = data
end

function M:getJumpInfo()
	return self._curJumpInfo
end

function M:setCurSelectTab(data)
	self._curSelectData = data
end

function M:getCurSelectTab()
	return self._curSelectData
end

function M:getIsNeedShowNew(goodsMo)
	if goodsMo:getTag() ~= StoreEnum.GoodsTag.IsNew then
		return false
	end

	local storeId = goodsMo:getStoreId()
	local goodsId = goodsMo:getGoodsId()

	if not self._newList[storeId] then
		self._newList[storeId] = {}

		local key = StoreEnum.StoreLocalStorageKey .. storeId
		local strData = PlayerModel.instance:getLocalStorageString(key)

		if not string.nilorempty(strData) then
			local datas = string.split(strData, "#")

			for i = 1, #datas do
				local temGoodsId = checknumber(datas[i])

				self._newList[storeId][temGoodsId] = true
			end
		end
	end

	return not self._newList[storeId][goodsId]
end

function M:setIsNeedShowNew(goodsMos)
	if not goodsMos then
		return
	end

	local hasChange = false

	for index, goodsMo in ipairs(goodsMos) do
		local storeId = goodsMo:getStoreId()
		local goodsId = goodsMo:getGoodsId()
		local isShow = goodsMo:getTag() == StoreEnum.GoodsTag.IsNew
		local hasCache = self._newList[storeId] and self._newList[storeId][goodsId]

		if not self._newList[storeId] then
			self._newList[storeId] = {}
		end

		if isShow and not hasCache then
			self._newList[storeId][goodsId] = true
			hasChange = true
		end
	end

	if hasChange then
		for storeId, goodsIds in pairs(self._newList) do
			local key = StoreEnum.StoreLocalStorageKey .. storeId
			local strData = ""

			for goodsId, value in pairs(goodsIds) do
				strData = strData .. "#" .. goodsId
			end

			PlayerModel.instance:setLocalStorageString(key, strData)
		end
	end
end

M.instance = M.New()

return M
