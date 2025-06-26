-- chunkname: @IQIGame\\Module\\Lottery\\LotteryModule.lua

LotteryModule = {
	curSelectPoolIndex = 0,
	curSelectPoolType = 0,
	initSelectPoolIndex = 0
}

function LotteryModule.Reload(pod, drawShowGroupRecords)
	LotteryModule.DrawPodList = {}
	LotteryModule.LastPoolCount = 0

	for k, v in pairs(pod) do
		LotteryModule.LastPoolCount = LotteryModule.LastPoolCount + 1
		LotteryModule.DrawPodList[v.id] = v
	end

	LotteryModule.FirstPoolType()
	LotteryModule.InitShowGroupRecordData(drawShowGroupRecords)
end

function LotteryModule.FirstPoolType()
	LotteryModule.initSelectPoolIndex = 1
end

function LotteryModule.GetPoolDataByType(Id)
	return LotteryModule.DrawPodList[Id]
end

function LotteryModule.PrizePoolIsOpen(Id)
	return LotteryModule.DrawPodList[Id] ~= nil
end

function LotteryModule.PrizePoolDrawTime(Id)
	return LotteryModule.DrawPodList[Id].drawTime
end

function LotteryModule.GetIsOpenPool()
	local openPool = {}
	local waitCheckPool = {}

	ForPairs(LotteryModule.DrawPodList, function(k, v)
		local cardCfg = CfgUtil.GetCardJackpotWithID(v.id)

		if not cardCfg.IsShow then
			return
		end

		if #cardCfg.mutex > 0 then
			table.insert(waitCheckPool, v)
		else
			table.insert(openPool, v)
		end
	end)
	ForPairs(waitCheckPool, function(_, _cfg)
		local cardCfg = CfgUtil.GetCardJackpotWithID(_cfg.id)
		local isMutex = false

		ForPairs(openPool, function(k, v)
			isMutex = ValueInArray(cardCfg.mutex, v.id)

			return isMutex
		end)

		if isMutex then
			return
		end

		table.insert(openPool, _cfg)
	end)
	table.sort(openPool, function(a, b)
		local cardA = CfgUtil.GetCardJackpotWithID(a.id)
		local cardB = CfgUtil.GetCardJackpotWithID(b.id)

		return cardA.Index < cardB.Index
	end)

	return openPool
end

function LotteryModule.PrizePoolHasType(Id)
	local typs = {}

	table.insert(typs, -2)

	local poolCfg = CfgCardJackpotTable[Id]
	local cardDatas = LotteryModule.GetCardTeamData(poolCfg.CardTeam)

	for i = 1, #cardDatas do
		if not LotteryModule.tableHseItem(typs, CfgItemTable[cardDatas[i].ItemId].ItemTypes) then
			table.insert(typs, CfgItemTable[cardDatas[i].ItemId].ItemTypes)
		end
	end

	table.insert(typs, -1)

	return typs
end

function LotteryModule.tableHseItem(tab, item)
	for k, v in pairs(tab) do
		if v == item then
			return true
		end
	end

	return false
end

function LotteryModule.GetCardTeamData(teams)
	local datas = {}

	for k, v in pairsCfg(CfgCardTable) do
		for i = 1, #teams do
			if v.Team == teams[i] then
				table.insert(datas, v)
			end
		end
	end

	return datas
end

function LotteryModule.ScreenTypeDatas(type)
	local datas = {}
	local quality = {}
	local poolCfg = CfgCardJackpotTable[type]
	local cardDatas = LotteryModule.GetCardTeamData(poolCfg.CardTeam)

	for i = 1, #cardDatas do
		local itemId = cardDatas[i].ItemId
		local itemType = CfgItemTable[itemId].ItemTypes
		local itemQuality = CfgItemTable[itemId].Quality

		if datas[itemType] == nil then
			datas[itemType] = {}
		end

		if datas[itemType][itemQuality] == nil then
			datas[itemType][itemQuality] = {}
		end

		if not LotteryModule.HasItem(cardDatas[i], datas[itemType][itemQuality]) then
			table.insert(datas[itemType][itemQuality], cardDatas[i])
		end
	end

	return datas
end

function LotteryModule.HasItem(itemId, table)
	for k, v in pairs(table) do
		if v.ItemId == itemId.ItemId then
			return true
		end
	end

	return false
end

function LotteryModule.IsHeroItem(cid)
	return CfgItemTable[cid].ItemTypes == Constant.ItemType.Hero
end

function LotteryModule.ItemCfg(cid)
	return CfgItemTable[cid]
end

function LotteryModule.IsHaveItem(itemData)
	local itemcfg = CfgItemTable[itemData.srcId]
	local itemType = itemcfg.ItemTypes

	if itemType == Constant.ItemType.Hero then
		for i = 1, #itemData.itemShowPODs do
			if itemData.srcId == itemData.itemShowPODs[i].cid then
				return false
			end
		end

		return true
	else
		return WarehouseModule.GetItemNumByCfgID(itemData.srcId) > 0
	end

	return false
end

function LotteryModule.SendDraw(type, count, isGuide)
	net_draw.draw(type, count, GuideModule.currentGuide ~= nil)
end

function LotteryModule.GetDrawRecord(type)
	net_draw.drawRecord(type)
end

function LotteryModule.RecordDraw(type)
	net_draw.history(type)
end

function LotteryModule.CancelDraw(type)
	net_draw.cancel(type)
end

function LotteryModule.ConfrimDraw(type, currentDraw)
	net_draw.confirm(type, currentDraw)
end

function LotteryModule.LotteryResult(drawResultPODS)
	LotteryModule.isExchangedDrawing = false

	EventDispatcher.Dispatch(EventID.LotteryResultEvent, drawResultPODS)
	StoryModule.SendTreeEvent(999, "0-12-2 Start", "LotteryOnceSuccess")
end

function LotteryModule.NotifyLotteryUpdate(DrawPODs)
	for k, v in pairs(DrawPODs) do
		LotteryModule.DrawPodList[v.id] = v
	end

	EventDispatcher.Dispatch(EventID.LotteryNotifyUpdate)
	EventDispatcher.Dispatch(EventID.LotteryNotifyDrawPoolUpdate)
end

function LotteryModule.NotifyLotteryAdd(DrawPODs)
	for k, v in pairs(DrawPODs) do
		LotteryModule.DrawPodList[v.id] = v
	end

	EventDispatcher.Dispatch(EventID.LotteryAddOrRemove)
	EventDispatcher.Dispatch(EventID.LotteryNotifyDrawPoolUpdate)
end

function LotteryModule.NotifyLotteryRemove(DrawPODs)
	for k, v in pairs(DrawPODs) do
		LotteryModule.DrawPodList[v.id] = nil
	end

	EventDispatcher.Dispatch(EventID.LotteryAddOrRemove)
	EventDispatcher.Dispatch(EventID.LotteryNotifyDrawPoolUpdate)
end

function LotteryModule.LotteryRecords(drawRecordPODS)
	LotteryModule.poolRecords = {}
	LotteryModule.poolRecords = drawRecordPODS

	EventDispatcher.Dispatch(EventID.LotteryRecordResult)
end

function LotteryModule.RecordDrawResult()
	EventDispatcher.Dispatch(EventID.LotteryRecordDrawResultEvent)
end

function LotteryModule.CancelDrawResult()
	return
end

function LotteryModule.ConfrimDrawResult()
	EventDispatcher.Dispatch(EventID.LotteryConfrimDrawResultEvent)
end

function LotteryModule.GetCardPoolDrawLimit(cardJackpotID)
	local cardJackpotData = CfgCardJackpotTable[cardJackpotID]

	return cardJackpotData.FullTimes == nil or cardJackpotData.FullTimes
end

function LotteryModule.GetCardPoolDrawCount(cardJackpotID)
	local podData = LotteryModule.DrawPodList[cardJackpotID]

	return podData.drawTime
end

function LotteryModule.CheckCardPoolDrawLimit(cardJackpotID, count)
	local limitCount = LotteryModule.GetCardPoolDrawLimit(cardJackpotID)

	if limitCount == 0 then
		return false
	end

	local historyCount = LotteryModule.GetCardPoolDrawCount(cardJackpotID)

	return count > limitCount - historyCount
end

function LotteryModule.GetCardPoolDrawType(cardJackpotID)
	local canOnce = true
	local canTen = true
	local cardJackpotData = CfgCardJackpotTable[cardJackpotID]

	if cardJackpotData.CardDrawType ~= nil then
		canOnce = cardJackpotData.CardDrawType[1] == 1
		canTen = cardJackpotData.CardDrawType[2] == 1
	end

	return canOnce, canTen
end

function LotteryModule.GetCardPoolUnitCost(cardJackpotID)
	local cardJackpotData = CfgCardJackpotTable[cardJackpotID]

	return cardJackpotData.OneTime[1], cardJackpotData.OneTime[2]
end

function LotteryModule.CheckCardPoolDrawCost(cardJackpotID, count)
	local costTable = {}

	costTable.costItem, costTable.unitCount = LotteryModule.GetCardPoolUnitCost(cardJackpotID)
	costTable.needCount = costTable.unitCount * count
	costTable.ownCount = WarehouseModule.GetItemNumByCfgID(costTable.costItem)

	return costTable.ownCount >= costTable.needCount, costTable
end

function LotteryModule.RequestDraw(cardJackpotID, count)
	LotteryModule.waitDrawWithByItem = nil

	if LotteryModule.CheckCardPoolDrawLimit(cardJackpotID, count) then
		NoticeModule.ShowNotice(51010)

		return
	end

	local costEnough, costInfo = LotteryModule.CheckCardPoolDrawCost(cardJackpotID, count)

	if costEnough then
		LotteryModule.SendDraw(cardJackpotID, count)

		return
	end

	local shopID, commodityID = LotteryModule.GetCardPollQuickByConfig(cardJackpotID)

	if shopID == 0 then
		NoticeModule.ShowCurrencyNotEnoughTips(costInfo.costItem)

		return
	end

	LotteryModule.waitDrawWithByItem = {
		cardJackpotID = cardJackpotID,
		count = count
	}

	LotteryModule.QuickByCardPoolCost(costInfo.costItem, costInfo.needCount - costInfo.ownCount, shopID, commodityID)
end

function LotteryModule.GetCardPollQuickByConfig(cardJackpotID)
	local shopID = 0
	local commodityID = 0
	local cardJackpotData = CfgCardJackpotTable[cardJackpotID]

	if cardJackpotData.Access ~= nil then
		shopID = cardJackpotData.Access[1] and cardJackpotData.Access[1] or 0
		commodityID = cardJackpotData.Access[2] and cardJackpotData.Access[2] or 0
	end

	return shopID, commodityID
end

function LotteryModule.QuickByCardPoolCost(itemCid, buyNum, shopID, commodityID)
	local commodityData = ShopModule.GetCommodityDataByShopAndCommodityID(shopID, commodityID)

	if not commodityData then
		logError(string.format("【抽卡】没有找到商品数据,商城id = %s,商品id = %s", tostring(shopID), tostring(commodityID)))

		return
	end

	local cfgItemData = CfgUtil.GetItemCfgDataWithID(itemCid)
	local needMoney = buyNum * commodityData:GetPrice()
	local needMoneyItemCid = commodityData:GetPriceIconId()
	local tips = LotteryUIApi:GetItemNotEnoughTips(buyNum, cfgItemData.Name, needMoney, CfgUtil.GetItemCfgDataWithID(needMoneyItemCid).Name)

	local function confirmCallback()
		local moneyAllNum = WarehouseModule.GetItemNumByCfgID(needMoneyItemCid)

		if moneyAllNum < needMoney then
			UIModule.Open(Constant.UIControllerName.ConvertUI, Constant.UILayer.UI, needMoney - moneyAllNum)
		else
			ShopModule.BuyItemRequest(commodityData.cid, buyNum)

			LotteryModule.isExchangedDrawing = true
		end
	end

	local function cancelCallback()
		LotteryModule.isExchangedDrawing = false
	end

	NoticeModule.ShowNoticeByType(5, tips, confirmCallback, cancelCallback)
end

function LotteryModule.GetLotteryBGM()
	return 10000009
end

function LotteryModule.GetCardFreeCount(cardJackpotID)
	local cardJackpotData = CfgCardJackpotTable[cardJackpotID]

	if cardJackpotData.RookieCard then
		return 0
	end

	local poolData = LotteryModule.GetPoolDataByType(cardJackpotID)

	return LotteryModule.GetCardFreeCountByDrawPOD(poolData)
end

function LotteryModule.GetCardFreeCountByDrawPOD(drawPOD)
	local cardJackpotData = CfgCardJackpotTable[drawPOD.id]

	if cardJackpotData.RookieCard then
		return 0
	end

	if not drawPOD.isFree then
		return 0
	end

	if drawPOD.activityId == 0 then
		return 0
	end

	local cfgActivity = CfgUtil.GetCfgActivityDataWithID(drawPOD.activityId)

	if cfgActivity == nil then
		return 0
	end

	local drawFreeCount = cfgActivity.ExtraParam[2] - drawPOD.dayFreeTime

	return drawFreeCount
end

function LotteryModule.CheckHasFreeDraw()
	local hasFreeDraw = false
	local openPool = LotteryModule.GetIsOpenPool()

	ForPairs(openPool, function(_, _drawPOD)
		local freeCount = LotteryModule.GetCardFreeCountByDrawPOD(_drawPOD)

		hasFreeDraw = freeCount > 0

		return hasFreeDraw
	end)

	return hasFreeDraw
end

function LotteryModule.GetCardJackpotShowConfig(cardJackpotID)
	for index, data in pairs(CfgCardJackpotShowTable) do
		if data.CardJackpot == cardJackpotID then
			return data
		end
	end

	return nil
end

function LotteryModule.GetAllCardJackpotShowItems(cardJackpotID)
	local showData = LotteryModule.GetCardJackpotShowConfig(cardJackpotID)
	local cardTeamTable = {}

	ForArray(showData.CardListShow, function(_, _teamId)
		cardTeamTable[_teamId] = true
	end)

	local result = {}

	ForPairs(CfgCardTable, function(_cid, _item)
		if cardTeamTable[_item.Team] ~= true then
			return
		end

		result[_cid] = _item.ItemId
	end)

	return result
end

function LotteryModule.GetAllCardJackpotItems(cardJackpotID)
	local cardJackpotData = CfgCardJackpotTable[cardJackpotID]
	local cardTeamTable = {}

	for _, _teamId in pairs(cardJackpotData.CardTeam) do
		cardTeamTable[_teamId] = true
	end

	local result = {}

	ForPairs(CfgCardTable, function(_cid, _item)
		if cardTeamTable[_item.Team] ~= true then
			return
		end

		result[_cid] = _item.ItemId
	end)

	return result
end

function LotteryModule.InitShowGroupRecordData(recordMap)
	LotteryModule.__ShowGroupRecordData = {}

	ForPairs(recordMap, function(_showGroup, _recordCid)
		LotteryModule.UpdateShowGroupRecordData(_showGroup, _recordCid, false)
	end)
end

function LotteryModule.UpdateShowGroupRecordData(showGroup, recordCid, notice)
	LotteryModule.__ShowGroupRecordData[showGroup] = recordCid

	if not notice then
		return
	end

	EventDispatcher.Dispatch(EventID.LotteryAppointedValueChange, showGroup, recordCid)
end

function LotteryModule.GetShowGroupRecordData(showGroup)
	local recordCid = LotteryModule.__ShowGroupRecordData[showGroup]

	return TryToNumber(recordCid, 0)
end

function LotteryModule.SendChooseShowGroupData(showGroup, recordCid)
	local tempRecordCid = LotteryModule.GetShowGroupRecordData(showGroup)

	if tempRecordCid == recordCid then
		return
	end

	net_draw.chooseShowGroup(showGroup, recordCid)
end

function LotteryModule.GetGroupCardJackpotID(groupCid, realRecordCid)
	local jackpotCid = LotteryModule.GetShowGroupRecordData(groupCid)

	if realRecordCid then
		return jackpotCid
	end

	if jackpotCid <= 0 then
		local cardGroupCfg = CfgCardGroupTable[groupCid]

		jackpotCid = cardGroupCfg.CardJackpotID[1]
	end

	return jackpotCid
end
