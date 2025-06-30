-- chunkname: @IQIGame\\Module\\Shop\\ShopModule.lua

ShopModule = {}

function ShopModule.Initialize()
	ShopModule._InitData()
	ShopModule._AddEventListeners()
end

function ShopModule.Reload(shopPODs)
	for _, v in pairsCfg(CfgShopTable) do
		ShopModule._CreateShopData(v)
	end

	ShopModule.ResetAllTypeSort()
	ShopModule._CreateShopSecondaryTagData()
end

function ShopModule._AddEventListeners()
	return
end

function ShopModule._RemoveEventListeners()
	return
end

function ShopModule.Shutdown()
	ShopModule._RemoveEventListeners()
end

function ShopModule._InitData()
	ShopModule._CreateShopModuleInfo()
	ShopModule._CreateShopFirstTapData()
	ShopModule._CreateMonthCardCommodityData()
end

function ShopModule._CreateShopModuleInfo()
	ShopModule.limitCyclicTime = 4
	ShopModule.dayChangeSecond = 86400
	ShopModule.curShopDataData = nil
	ShopModule.isClientRequest = false
	ShopModule.shopDataDic = {}
	ShopModule.shopDataSortList = {}
	ShopModule.shopTypeIdTable = {
		TokenB = 4,
		GiftBag = 2,
		SoulStone = 5,
		TokenA = 3,
		Resource = 1
	}
	ShopModule.shopFirstTapList = nil
end

function ShopModule._CreateShopData(ShopCfg)
	local ShopData = ShopData.New()

	ShopData:Initialize(ShopCfg)

	if ShopData.shopCfgData ~= nil then
		ShopModule._SetShopTypeDic(ShopData)
	end
end

function ShopModule._SetShopTypeDic(ShopData)
	if ShopModule.shopDataDic[ShopData.id] == nil then
		ShopModule.shopDataDic[ShopData.id] = ShopData
	end
end

function ShopModule._IsContentShopType(RefreshType, type)
	for i = 1, #RefreshType do
		if type == RefreshType[i] then
			return true
		end
	end

	return false
end

function ShopModule._SortByWeight(tb1, tb2)
	local state1 = tb1.sellType == Constant.ShopSellType.NonSellOut and 1 or 0
	local state2 = tb2.sellType == Constant.ShopSellType.NonSellOut and 1 or 0

	if state1 == state2 then
		if tb1.sortWeight < tb2.sortWeight then
			return true
		elseif tb1.sortWeight == tb2.sortWeight then
			if tb1.cid < tb2.cid then
				return true
			end

			return false
		else
			return false
		end
	else
		return state2 < state1
	end
end

function ShopModule._CreateShopFirstTapData()
	ShopModule.shopFirstTapList = {}

	for _, v in pairsCfg(CfgShopTable) do
		local cfgShop = v

		if cfgShop.Branch == 0 and cfgShop.Open ~= 0 then
			table.insert(ShopModule.shopFirstTapList, cfgShop)
		end
	end

	table.sort(ShopModule.shopFirstTapList, function(a, b)
		return a.Order < b.Order
	end)
end

function ShopModule._CreateShopSecondaryTagData()
	ShopModule.shopSecondaryTapList = {}

	for i, v in pairsCfg(ShopModule.shopDataDic) do
		local shopData = v

		if shopData.shopCfgData.Branch ~= 0 then
			if not ShopModule.shopSecondaryTapList[shopData.shopCfgData.Type] then
				ShopModule.shopSecondaryTapList[shopData.shopCfgData.Type] = {}
			end

			if shopData.shopCfgData.Open == 1 then
				table.insert(ShopModule.shopSecondaryTapList[shopData.shopCfgData.Type], i)
			end
		end
	end

	for k, v in pairs(ShopModule.shopSecondaryTapList) do
		table.sort(v, function(a, b)
			return CfgShopTable[a].Order < CfgShopTable[b].Order
		end)
	end
end

function ShopModule._CreateMonthCardCommodityData()
	ShopModule.monthCardCommodityData = nil

	local shopCid

	for _, v in pairsCfg(CfgShopTable) do
		if v.Type == Constant.ShopType.MonthCard.Type then
			shopCid = v.Id

			break
		end
	end

	ShopModule.monthCardCommodityData = ShopModule.findOneByCommodityByShopId(shopCid)
end

function ShopModule.ResetAllTypeSort()
	for _, v in pairsCfg(ShopModule.shopTypeIdTable) do
		ShopModule.GetSortForTypeDataList(v)
	end
end

function ShopModule.GetSortForTypeDataList(ShopTypeId)
	local _ret = {}

	if ShopModule.shopDataDic[ShopTypeId] == nil then
		return _ret
	end

	for _, v in pairsCfg(ShopModule.shopDataDic[ShopTypeId].itemDic) do
		local itemDic = v

		if itemDic.isShow then
			table.insert(_ret, v)
		end
	end

	table.sort(_ret, ShopModule._SortByWeight)

	ShopModule.shopDataSortList[ShopTypeId] = _ret

	return _ret
end

function ShopModule.GetDebrisPersonalityMax_MultiplyReturnTwo()
	local list = {}
	local currencyTable = {}

	for _, v in pairsCfg(WarehouseModule.AllItems) do
		local itemData = v
		local config = itemData:GetCfg()

		if config.ItemTypes == Constant.ItemType.HeroDebris then
			local LikeIdWarlockData = WarlockModule.WarlockDataDic[config.LikeId]

			if LikeIdWarlockData and LikeIdWarlockData:IsMaxSelfPersonalityLv() then
				local combinationId = config.CombinationId[2]
				local combinationConfig = CfgCombinationTable[combinationId]

				if combinationConfig == nil then
					logError("有错误的合成id,请检查表Combination  道具id " .. config.Id .. " 合成id " .. combinationId)
				end

				local weight = combinationConfig.Output[2] / combinationConfig.Combination[2]
				local reclaim = CfgCombinationTable[combinationId].Output
				local num = v.num * weight

				if currencyTable[reclaim[1]] == nil then
					currencyTable[reclaim[1]] = {
						id = reclaim[1],
						num = num,
						CombinationId = combinationId
					}
				else
					currencyTable[reclaim[1]].num = currencyTable[reclaim[1]].num + num
				end

				table.insert(list, v)
			end
		end
	end

	local currencyList = {}

	for _, v in pairsCfg(currencyTable) do
		table.insert(currencyList, v)
	end

	table.sort(currencyList, function(a, b)
		return a.id < b.id
	end)

	return list, currencyList
end

function ShopModule.SetCurShopDataData(id)
	ShopModule.curShopDataData = ShopModule.shopDataDic[id]

	if ShopModule.curShopDataData then
		ShopModule.curShopDataData:Refresh()
	end
end

function ShopModule.GetCurShowMoneyType()
	return ShopModule.curShopDataData.shopCfgData.MoneyType
end

function ShopModule.GetShopFirstTapData(enterType, shopType)
	local data = {}

	for _, v in pairs(ShopModule.shopFirstTapList) do
		if v.Open == enterType and v.ShopType == shopType then
			table.insert(data, v)
		end
	end

	return data
end

function ShopModule.GetShopFirstTabDataWithTypes(types)
	local data = {}

	for _, type in pairs(types) do
		for _, v in pairs(ShopModule.shopFirstTapList) do
			if v.Type == type then
				table.insert(data, v)
			end
		end
	end

	return data
end

function ShopModule.GetSecondaryTagDataWithType(shopType)
	local secondData = ShopModule.shopSecondaryTapList[shopType]

	if secondData == nil then
		return nil
	end

	local dataList = {}

	for i = 1, #secondData do
		local cfgData = ShopModule.GetSortForTypeDataList(secondData[i])

		if #cfgData > 0 then
			table.insert(dataList, secondData[i])
		end
	end

	return dataList
end

function ShopModule.GetShopTypeIDWithShopType(shopType)
	for i, v in pairsCfg(ShopModule.shopDataDic) do
		if v.shopCfgData.Type == shopType then
			return i
		end
	end
end

function ShopModule.GetShopDataWithShopID(shopID)
	return ShopModule.shopDataDic[shopID]
end

function ShopModule.GetShopCommodityDataWithCommodityId(commodityId)
	local commodityData

	ForPairs(ShopModule.shopDataDic, function(_, _shopData)
		ForPairs(_shopData.itemDic, function(_id, _data)
			if _id == commodityId then
				commodityData = _data

				return true
			end
		end)

		if commodityData ~= nil then
			return true
		end
	end)

	return commodityData
end

function ShopModule.GetCommodityDataByShopAndCommodityID(shopID, commodityID)
	for _, shopData in pairs(ShopModule.shopDataDic) do
		if shopData.id == shopID then
			for _, commodityData in pairs(shopData.itemDic) do
				if commodityData.cid == commodityID then
					return commodityData
				end
			end
		end
	end

	return nil
end

function ShopModule.GetShopCommodityDataWithItemId(itemID)
	for _, shopData in pairs(ShopModule.shopDataDic) do
		for _, commodityData in pairs(shopData.itemDic) do
			if commodityData.config.ItemId == itemID then
				return commodityData
			end
		end
	end

	return nil
end

function ShopModule.GetShopCommodityDataWithShopType(shopType)
	for _, v in pairsCfg(CfgShopTable) do
		local cfgShopCell = v

		if cfgShopCell.Type == shopType then
			return cfgShopCell.Commodity
		end
	end
end

function ShopModule.GetAllItemsWithShopType(shopType)
	local shopItems = {}

	for _, v in pairsCfg(ShopModule.shopDataDic) do
		if v.shopCfgData.Type == shopType then
			for _, item in pairsCfg(v.itemDic) do
				table.insert(shopItems, item)
			end
		end
	end

	return shopItems
end

function ShopModule.GetSortShopDataList()
	local sortShopTypeTable = {}
	local ItemDic = {}

	for _, v in pairsCfg(ShopModule.shopDataDic) do
		if ItemDic[v.shopCfgData.Type] == nil then
			table.insert(sortShopTypeTable, v)
		end
	end

	table.sort(sortShopTypeTable, function(a, b)
		return a.BaseData.Order < b.BaseData.Order
	end)

	return sortShopTypeTable
end

function ShopModule.GetShopCfgWithID(ID)
	return CfgShopTable[ID]
end

function ShopModule.GetGiftItemsListWithID(ID)
	local itemList = {}
	local cfg = CfgItemTable[ID].ActionParams

	for i = 1, getCfgTableLength(cfg), 2 do
		local item = {
			ID = cfg[i],
			Num = cfg[i + 1]
		}

		table.insert(itemList, item)
	end

	return itemList
end

function ShopModule.GetRecommendShopData()
	local recommendShopData = {}
	local shopCommodityData = ShopModule.GetAllItemsWithShopType(Constant.ShopType.GiftBag.Type)

	for _, v in pairsCfg(shopCommodityData) do
		local commodityData = v

		if commodityData.isRecommend and commodityData.isShow and commodityData.sellType ~= Constant.ShopSellType.SellOut then
			table.insert(recommendShopData, commodityData)
		end
	end

	return recommendShopData
end

function ShopModule.GetRecommendShopDataByConfig()
	local recommendCfgDatas = {}

	for k, v in pairsCfg(CfgShopBannerListTable) do
		local serverTime = PlayerModule.GetServerTime()
		local openTime = 0
		local closeTime = 0

		if not LuaUtility.StrIsNullOrEmpty(v.OpenTime) then
			openTime = cfgDateTimeToTimeStamp(v.OpenTime)
			closeTime = cfgDateTimeToTimeStamp(v.OpenTime) + v.Duration[1]
		end

		local checkResult = ConditionModule.CheckOneOfMultipleIsPass(ConditionModule.CheckMultiple(v.ShowConditionID))

		if LuaUtility.StrIsNullOrEmpty(v.OpenTime) then
			if checkResult then
				table.insert(recommendCfgDatas, v)
			end
		elseif checkResult and openTime < serverTime and serverTime < closeTime then
			table.insert(recommendCfgDatas, v)
		end
	end

	table.sort(recommendCfgDatas, function(a, b)
		return a.Sort < b.Sort
	end)

	return recommendCfgDatas
end

function ShopModule.GetMonthCardShopData()
	local recommendShopData = {}

	table.insert(recommendShopData, ShopModule.GetMonthCardInfo())
	ForPairs(CfgMonthCardTable, function(_, _cfgData)
		table.insert(recommendShopData, ShopModule.__CreateNewMonthCardInfo(_cfgData))
	end)

	return recommendShopData
end

function ShopModule.__CreateNewMonthCardInfo(monthCardData)
	local info = {
		isMonthCard = true,
		isNewMonthCard = true,
		buyReward = monthCardData.Reward,
		dayReward = monthCardData.DailyReward,
		monthCardCid = monthCardData.Id,
		monthCardData = monthCardData,
		commodityData = CfgCommodityTable[monthCardData.CommodityId]
	}

	return info
end

function ShopModule.GetMonthCardInfo()
	local info = {
		isMonthCard = true,
		name = ShopUIApi:GetMonthCardText(),
		buyReward = CfgDiscreteDataTable[Constant.MonthCardCfgID.BuyReward],
		dayReward = CfgDiscreteDataTable[Constant.MonthCardCfgID.DayReward],
		commodityData = ShopModule.GetMonthCardCommodityData(),
		startTime = tonumber(SignInModule.MonthCardStartTime),
		endTime = tonumber(SignInModule.MonthCardEndTime)
	}

	return info
end

function ShopModule.GetMonthCardCommodityData()
	return ShopModule.monthCardCommodityData
end

function ShopModule.IsTimeHasNotArrivedForCommodityOpen(time)
	return time > math.ceil(PlayerModule.GetServerTime())
end

function ShopModule.IsEndForCommodityBuyTime(time)
	return time <= math.ceil(PlayerModule.GetServerTime())
end

function ShopModule.IsHasExtraCanUse(useExtraNum, oldExtraNum)
	return useExtraNum < oldExtraNum
end

function ShopModule.GetFirstRechargeTaskIsFinish()
	local taskList = TaskSystemModule.GetTaskListByPlayer(Constant.MainTaskType.Recharge, Constant.ExtendTaskType.Recharge_Frist)

	if table.len(taskList) == 0 then
		return true
	end

	for i = 1, #taskList do
		if taskList[i].status == Constant.TaskStatus.hadGot then
			return true
		end
	end

	return false
end

function ShopModule.GetHasFreeCommodity(commodityDatas)
	for k, v in pairs(commodityDatas) do
		if v.config.Free and v.buyNum < v.config.Time and v.isBuy then
			return true
		end
	end

	return false
end

function ShopModule.GetResidueTimeTomorrow()
	local currentTimeTable = getDateTimeTable(PlayerModule.GetServerTime())
	local hour = currentTimeTable.hour
	local minute = currentTimeTable.min
	local second = currentTimeTable.sec

	if hour < 4 then
		hour = hour + 24
	end

	local refreshHour = 27
	local refreshMinute = 59
	local refreshSecond = 60
	local seconds = (refreshHour - hour) * 3600 + (refreshMinute - minute) * 60 + (refreshSecond - second)

	return seconds
end

function ShopModule.GetResidueTimeWeekly(num)
	local currentTimeTable = getDateTimeTable(PlayerModule.GetServerTime())
	local day = currentTimeTable.wday - 1
	local hour = currentTimeTable.hour
	local minute = currentTimeTable.min
	local second = currentTimeTable.sec

	if hour < 4 then
		hour = hour + 24
	end

	local formatDay = day == 0 and 7 or day
	local refreshDay
	local refreshHour = 27
	local refreshMinute = 59
	local refreshSecond = 60

	if formatDay < num then
		refreshDay = num - 1
	else
		refreshDay = num + 7 - 1
	end

	local seconds = (refreshDay - formatDay) * 24 * 3600 + (refreshHour - hour) * 3600 + (refreshMinute - minute) * 60 + (refreshSecond - second)

	return seconds
end

function ShopModule.GetResidueTimeMonth(num)
	local currentTimeTable = getDateTimeTable(PlayerModule.GetServerTime())
	local day = currentTimeTable.day
	local hour = currentTimeTable.hour
	local minute = currentTimeTable.min
	local second = currentTimeTable.sec

	if hour < 4 then
		hour = hour + 24
	end

	local refreshDay

	if day < num then
		refreshDay = num - 1
	else
		local bigMonthDay = 31
		local smallMonthDay = 30
		local bigMonth = {
			1,
			nil,
			1,
			nil,
			1,
			nil,
			1,
			1,
			nil,
			1,
			nil,
			1
		}
		local smallMonth = {
			[6] = 1,
			[9] = 1,
			[4] = 1,
			[11] = 1
		}
		local monthDay = 0

		if bigMonth[currentTimeTable.month] then
			monthDay = bigMonthDay
		elseif smallMonth[currentTimeTable.month] then
			monthDay = smallMonthDay
		elseif currentTimeTable.month == 2 then
			monthDay = ShopModule.IsLeapYear(currentTimeTable.year) and 29 or 28
		end

		refreshDay = monthDay + num - 1
	end

	local refreshHour = 27
	local refreshMinute = 59
	local refreshSecond = 60
	local seconds = (refreshDay - day) * 24 * 3600 + (refreshHour - hour) * 3600 + (refreshMinute - minute) * 60 + (refreshSecond - second)

	return seconds
end

function ShopModule.GetResidueTimeSpan(buyTime, num)
	local refreshTime = tonumber(buyTime) / 1000 + (num - 1) * 24 * 3600 + 14400
	local seconds = refreshTime - PlayerModule.GetServerTime()

	return seconds
end

function ShopModule.IsLeapYear(year)
	if year % 4 == 0 and year % 100 ~= 0 or year % 400 == 0 then
		return true
	else
		return false
	end
end

function ShopModule.UpdateShopByShopID(shopID)
	local shopData = ShopModule.shopDataDic[shopID]

	if shopData then
		shopData:Refresh()
	end
end

function ShopModule.GetCommodityBuyCount(commondityId)
	local commodityBuyRecord = PlayerModule.PlayerInfo.commodityBuyRecords[commondityId]

	if commodityBuyRecord == nil then
		return 0
	end

	return commodityBuyRecord
end

function ShopModule.BuyItemRequest(commodityID, num)
	net_shop.buy(commodityID, num)
end

function ShopModule.RefreshShop()
	return
end

function ShopModule.DebrisRecycle(id)
	net_shop.refresh(id)
end

function ShopModule.MarkShow(shopCid, position)
	net_shop.markShow(shopCid, position)
end

function ShopModule.BuyItemResultSucceed(itemShowPODS, commodityBuyRecords)
	for k, v in pairs(commodityBuyRecords) do
		PlayerModule.PlayerInfo.commodityBuyRecords[k] = v
	end

	if LotteryModule.isExchangedDrawing then
		EventDispatcher.Dispatch(EventID.LotteryMainBuyDrawing)

		LotteryModule.isExchangedDrawing = false

		return
	end

	ShopModule.NotifychangeShopItems(commodityBuyRecords)
	EventDispatcher.Dispatch(EventID.BuyItemResult)

	ShopModule.frameTimer = FrameTimer.New(function()
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, itemShowPODS)

		if ShopModule.frameTimer then
			ShopModule.frameTimer:Stop()

			ShopModule.frameTimer = nil
		end
	end, 2, 1):Start()
end

function ShopModule.NotifychangeShopItems(commodityBuyRecords)
	local shopSet = {}

	for k, v in pairs(commodityBuyRecords) do
		local commodityCfg = CfgCommodityTable[k]

		if commodityCfg then
			shopSet[commodityCfg.ShopID] = 1
		end
	end

	for k, v in pairs(shopSet) do
		local shopData = ShopModule.shopDataDic[k]

		if shopData then
			shopData:Refresh()
		end
	end

	ShopModule._CreateShopSecondaryTagData()
	EventDispatcher.Dispatch(EventID.NotifyChangeShopItems)
end

function ShopModule.UpgradeShopResult()
	EventDispatcher.Dispatch(EventID.ShopUpgradeEvent)
end

function ShopModule.MarkShowResult(shopItemPOD)
	return
end

function ShopModule.findByCommodityByShopId(shopId)
	local cfgs = {}

	for _, v in pairsCfg(CfgCommodityTable) do
		if shopId == v.ShopID then
			table.insert(cfgs, v)
		end
	end

	return cfgs
end

function ShopModule.findOneByCommodityByShopId(shopId)
	for _, v in pairsCfg(CfgCommodityTable) do
		if shopId == v.ShopID then
			return v
		end
	end

	return nil
end

function ShopModule.BuyItem(shopData, buyNum)
	if shopData.config.BuyType == Constant.BuyShopType.Rmb then
		SDKLoginModule.GetPaySign(shopData.config.Id)
	else
		if not shopData.config.Free then
			local price = shopData:GetFinalPrice()

			if not WarehouseModule.GetUseMoneyIsEnough(shopData:GetPriceIconId(), price * buyNum) then
				NoticeModule.ShowCurrencyNotEnoughTips(shopData:GetPriceIconId())

				return
			end
		end

		ShopModule.BuyItemRequest(shopData.cid, buyNum)
	end
end
