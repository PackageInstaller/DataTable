-- chunkname: @IQIGame\\Module\\MonthCard\\MonthCardModule.lua

MonthCardModule = {}

function MonthCardModule.Reload(monthCardPOD, monthCardData)
	MonthCardModule.MonthCardStartTime = monthCardPOD.startTime
	MonthCardModule.MonthCardEndTime = monthCardPOD.endTime
	MonthCardModule.monthPrzieState = monthCardPOD.monthPrzieState

	MonthCardModule.__InitNewMonthCard(monthCardData)
end

function MonthCardModule.__InitNewMonthCard(monthCardData)
	if monthCardData ~= nil then
		MonthCardModule.NewMonthCardData = monthCardData
	end

	if MonthCardModule.NewMonthCardData == nil then
		MonthCardModule.NewMonthCardData = {}
	end
end

function MonthCardModule.GetMonthResidualDays()
	local secondTime = MonthCardModule.MonthCardEndTime / 1000 - PlayerModule.GetServerTime()

	if secondTime < 0 then
		secondTime = 0
	end

	local MonthCardDay = GetTimeDurationNum(secondTime)

	return MonthCardDay
end

function MonthCardModule.GetItemShow(itemAwards)
	NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, itemAwards)
end

function MonthCardModule.GetMonthCardAward()
	net_monthCard.receiveMonthCardAward()
end

function MonthCardModule.ReceiveMonthCardAwardResult(itemShowPODS)
	EventDispatcher.Dispatch(EventID.OnReceiveMonthCardAwardResult)
	MonthCardModule.GetItemShow(itemShowPODS)
end

function MonthCardModule.notifyMonthCardAward(itemShowPODS)
	MonthCardModule.GetItemShow(itemShowPODS)
end

function MonthCardModule.notifyMonthCard(monthCardPOD)
	MonthCardModule.Reload(monthCardPOD)
end

function MonthCardModule.notifyMonthCard_New(monthCardData)
	ForPairs(monthCardData, function(_cardCid, _time)
		MonthCardModule.NewMonthCardData[_cardCid] = _time
	end)
	EventDispatcher.Dispatch(EventID.OnNewMonthCardDataChange)
end

function MonthCardModule.GetNewCardEndTime(cardCid)
	return TryToNumber(MonthCardModule.NewMonthCardData[cardCid], 0)
end

function MonthCardModule.GetNewCardEndDay(cardItemCid)
	if MonthCardModule.NewMonthCardData == nil then
		return 0
	end

	local endTime = MonthCardModule.NewMonthCardData[cardItemCid]

	if endTime == nil then
		return 0
	end

	local day = getDateTimeDiffDay_New(endTime / 1000, PlayerModule.GetServerTime())

	if day < 0 then
		day = 0
	end

	return day
end

function MonthCardModule.BuyNewMonthCard(data)
	if data.commodityData.BuyType == Constant.BuyShopType.Rmb then
		SDKLoginModule.GetPaySign(data.commodityData.Id, "CNY")
	end
end

function MonthCardModule.Shutdown()
	return
end
