-- chunkname: @IQIGame\\Module\\Mall\\MallModule.lua

MallModule = {
	_mallTypeTable = {},
	id2BoughtTimesDic = {}
}

local TaskUIData = require("IQIGame.Module.Task.TaskUIData")

function MallModule.Reload(mallBuyCountRecords)
	MallModule.id2BuyTimesDic = mallBuyCountRecords

	for i, v in pairsCfg(CfgMallTable) do
		if v.BuyLimitShow > 0 and v.LimitType == 0 then
			v.LimitTimes = v.BuyLimitShow
			v.LimitType = 1
		end
	end
end

function MallModule.GetGuildRandomMall(RandomGroup)
	if PlayerModule.PlayerInfo.randomMalls then
		return PlayerModule.PlayerInfo.randomMalls[RandomGroup]
	end

	return nil
end

function MallModule.GetResidueBuyTimes(cid)
	local residueTimes = CfgMallTable[cid].LimitTimes

	if MallModule.id2BuyTimesDic[cid] ~= nil then
		residueTimes = CfgMallTable[cid].LimitTimes - MallModule.id2BuyTimesDic[cid]
	end

	if CfgMallTable[cid].BuyLimitShow ~= 0 then
		residueTimes = math.min(residueTimes, CfgMallTable[cid].BuyLimitShow - MallModule.GetBoughtTimes(cid))
	end

	return residueTimes
end

function MallModule.GetMallIsStartSell(mallCid)
	local cfgMallData = CfgMallTable[mallCid]
	local nowTime = PlayerModule.GetServerTime()
	local startSellTime = PlayerModule.PlayerInfo.mallStartSellTime[mallCid]

	startSellTime = startSellTime == nil and 0 or startSellTime

	if nowTime < startSellTime + cfgMallData.SalesTime then
		return true
	end

	return false
end

function MallModule.GetBoughtTimes(mallCid)
	local value = SaveDataModule.GetString("Mall", PlayerModule.PlayerInfo.baseInfo.pid .. Constant.SaveServerDataKey.GoodsBoughtTimes .. mallCid)
	local boughtTimes = 0

	if value ~= nil then
		local args = string.split(value, "|")
		local year = tonumber(args[1])
		local month = tonumber(args[2])
		local day = tonumber(args[3])

		boughtTimes = tonumber(args[4])

		local dateTable = getDateTimeTable(PlayerModule.GetServerTime())

		if year ~= dateTable.year or month ~= dateTable.month or day ~= dateTable.day then
			SaveDataModule.SaveString("Mall", PlayerModule.PlayerInfo.baseInfo.pid .. Constant.SaveServerDataKey.GoodsBoughtTimes .. mallCid, dateTable.year .. "|" .. dateTable.month .. "|" .. dateTable.day .. "|" .. 0)

			boughtTimes = 0
		end
	end

	return boughtTimes
end

function MallModule.GetRechargeTaskDatum(childType)
	local ret = {}
	local processing = TaskModule.GetTaskProcessing(TaskModule.TaskType.RECHARGE_TASK)
	local finished = TaskModule.GetTaskFinished(TaskModule.TaskType.RECHARGE_TASK)

	for i = 1, #processing do
		local taskData = processing[i]
		local uiTaskData = TaskUIData.New(taskData.cid, taskData.finNum, taskData.tgtNum, TaskModule.TaskStatus.CURRENT_TASK, taskData.createTime)

		table.insert(ret, uiTaskData)
	end

	for i = 1, #finished do
		local taskCid = finished[i]
		local cfgTaskData = CfgMainQuestTable[taskCid]
		local cfgTargetData = CfgTargetTable[cfgTaskData.TargetId]
		local uiTaskData = TaskUIData.New(taskCid, cfgTargetData.TargetNum, cfgTargetData.TargetNum, TaskModule.TaskStatus.FINISH_TASK)

		table.insert(ret, uiTaskData)
	end

	table.sort(ret, function(a, b)
		return a.cid < b.cid
	end)

	return ret
end

function MallModule.IsShowRechargeTaskRedPoint()
	local allowShow = CfgDiscreteDataTable[6520087].Data[1] == 1
	local processing = TaskModule.GetTaskProcessing(TaskModule.TaskType.RECHARGE_TASK)

	for i = 1, #processing do
		local taskData = processing[i]

		if taskData.finNum >= taskData.tgtNum then
			return allowShow
		end
	end

	return false
end

function MallModule.CheckExistRedPointOnTab(tabType)
	if tabType == 4 then
		return MallModule.IsShowRechargeTaskRedPoint()
	end

	for i, v in pairs(CfgMallTypeTable) do
		if v.Type == tabType and MallModule.CheckExistRedPointOnShop(v.Id) then
			return true
		end
	end

	return false
end

function MallModule.CheckExistRedPointOnShop(mallTypeCid)
	local mallTypeType = CfgMallTypeTable[mallTypeCid].Type

	if mallTypeType == 4 then
		return MallModule.IsShowRechargeTaskRedPoint()
	end

	for i, v in pairs(CfgMallTable) do
		if v.MallType == mallTypeCid and mallTypeType ~= 1 and v.SellType == Constant.Mall_SellType.Free and MallModule.CheckIsRightChannel(v) and MallModule.InRightTime(v) and ConditionModule.Check(v.ConditionId) and ConditionModule.Check(v.ShowConditionId) then
			if v.LimitType ~= 0 then
				if MallModule.GetResidueBuyTimes(v.Id) ~= 0 then
					return true
				else
					return false
				end
			end

			return true
		end
	end

	return false
end

function MallModule.InRightTime(cfgMallData)
	if cfgMallData.TimeLimitType == 0 then
		return true
	end

	local openTime = cfgDateTimeToTimeStamp(cfgMallData.TimeLimitOpen, PlayerModule.TimeZone)
	local endTime = cfgDateTimeToTimeStamp(cfgMallData.TimeLimitEnd, PlayerModule.TimeZone)
	local serverTime = PlayerModule.GetServerTime()

	return openTime <= serverTime and serverTime <= endTime
end

function MallModule.CheckExistRedPointOnMall()
	for i, v in pairs(CfgMallTypeTable) do
		if v.FunctionButton == Constant.Mall_EntranceType.MainCity and MallModule.CheckExistRedPointOnShop(v.Id) then
			return true
		end
	end

	return false
end

function MallModule.CheckIsRightChannel(cfgMallData)
	local ret = false

	if #cfgMallData.Channels > 0 then
		local curChannel = tostring(PlayerModule.PlayerInfo.baseInfo.channelNo)

		for i1, v1 in ipairs(cfgMallData.Channels) do
			if curChannel == v1 then
				ret = true

				break
			end
		end
	else
		ret = true

		for i2, v2 in ipairs(cfgMallData.InvisibleChannels) do
			if curChannel == v2 then
				ret = false

				break
			end
		end
	end

	return ret
end

function MallModule.CheckExistGoods(entranceType)
	for i, v in pairsCfg(CfgMallTypeTable) do
		if v.FunctionButton == entranceType and #MallModule.GetTabLeftDatum(v.Type, entranceType) ~= 0 then
			return true
		end
	end

	return false
end

function MallModule.CheckGoodsIsSelling(mallCid)
	if not UnlockFunctionModule.IsUnlock(Constant.UnlockType.MALL) then
		return false
	end

	local cfgMallData = CfgMallTable[mallCid]
	local cfgMallTypeData = CfgMallTypeTable[cfgMallData.MallType]
	local leftTabDatum = MallModule.GetTabLeftDatum(cfgMallTypeData.Type, cfgMallTypeData.FunctionButton)

	if #leftTabDatum > 0 then
		local goodDatum = MallModule.GetTabLeftGoodsDatum(cfgMallTypeData)

		for i, v in pairs(goodDatum) do
			if v.Id == mallCid then
				return true
			end
		end
	end

	return false
end

function MallModule.GetTabLeftDatum(mallType, entranceType)
	local serverTime = math.floor(PlayerModule.GetServerTime())
	local tabLeftDatum = {}

	for i, v in pairsCfg(CfgMallTypeTable) do
		if v.FunctionButton == entranceType and v.Type == mallType then
			local isValid = true

			if v.TimeLimitType == Constant.MallTimeLimitType.TIME_STAMP and (serverTime < cfgDateTimeToTimeStamp(v.TimeLimitOpen, PlayerModule.TimeZone) or serverTime > cfgDateTimeToTimeStamp(v.TimeLimitEnd, PlayerModule.TimeZone)) then
				isValid = false
			end

			if isValid and #MallModule.GetTabLeftGoodsDatum(v) == 0 then
				isValid = false
			end

			if isValid then
				tabLeftDatum[#tabLeftDatum + 1] = v
			end
		end
	end

	table.sort(tabLeftDatum, function(a, b)
		return a.Tab < b.Tab
	end)

	return tabLeftDatum
end

function MallModule.GetTabLeftGoodsDatum(cfgMallType)
	local serverTime = math.floor(PlayerModule.GetServerTime())
	local goodDatum = {}

	for i, v in pairsCfg(CfgMallTable) do
		if v.MallType == cfgMallType.Id then
			local isValid = true
			local realCfgData = v

			if isValid and v.ShowConditionId ~= 0 and not ConditionModule.Check(v.ShowConditionId) then
				isValid = false
			end

			if v.MallLinkageMallGoods ~= 0 then
				v = CfgMallTable[v.MallLinkageMallGoods]
			end

			if isValid and v.LimitType == Constant.Mall_LimitType.Life and MallModule.GetResidueBuyTimes(v.Id) == 0 then
				isValid = false
			end

			if isValid and v.TimeLimitType == Constant.MallTimeLimitType.TIME_STAMP then
				if serverTime < cfgDateTimeToTimeStamp(v.TimeLimitOpen, PlayerModule.TimeZone) then
					isValid = false
				end

				if serverTime > cfgDateTimeToTimeStamp(v.TimeLimitEnd, PlayerModule.TimeZone) then
					isValid = false
				end
			end

			isValid = isValid and MallModule.CheckIsRightChannel(v)

			if isValid then
				goodDatum[#goodDatum + 1] = realCfgData
			end
		end
	end

	table.sort(goodDatum, function(a, b)
		return a.Sort < b.Sort
	end)

	return goodDatum
end

function MallModule.OpenActivityMall(mallEntranceType, customMallCids)
	if MallModule.CheckExistGoods(mallEntranceType) then
		UIModule.Open(Constant.UIControllerName.ActivityMallUI, Constant.UILayer.UI, {
			entranceType = mallEntranceType,
			customMallCids = customMallCids
		})
	else
		NoticeModule.ShowNoticeNoCallback(21057004)
	end
end

function MallModule.CheckCanBuyMall(mallCid, count)
	if not UnlockFunctionModule.IsUnlock(Constant.UnlockType.MALL) then
		return 8
	end

	local cfgMallData = CfgMallTable[mallCid]

	if cfgMallData.TimeLimitType == Constant.MallTimeLimitType.TIME_STAMP then
		if cfgDateTimeToTimeStamp(cfgMallData.TimeLimitOpen, PlayerModule.TimeZone) > math.floor(PlayerModule.GetServerTime()) then
			return 1
		end

		if cfgDateTimeToTimeStamp(cfgMallData.TimeLimitEnd, PlayerModule.TimeZone) < math.floor(PlayerModule.GetServerTime()) then
			return 2
		end
	end

	if cfgMallData.ConditionId ~= 0 and not ConditionModule.Check(cfgMallData.ConditionId) then
		return 3
	end

	if count == 0 then
		return 4
	end

	if cfgMallData.SellType == Constant.Mall_SellType.PayPoint then
		if PlayerModule.PlayerInfo.baseInfo.payPoint < cfgMallData.PayPoint * count then
			return 5
		end
	elseif cfgMallData.SellType == Constant.Mall_SellType.Item and cfgMallData.Price[2] * count > WarehouseModule.GetItemNumByCfgID(cfgMallData.Price[1]) then
		if cfgMallData.Price[1] == Constant.ItemID.TREASURE then
			return 6
		else
			return 7
		end
	end

	return 0
end

function MallModule.BuyMall(mallCid, count)
	local cfgMallData = CfgMallTable[mallCid]
	local checkRet = MallModule.CheckCanBuyMall(mallCid, count)

	if checkRet == 1 then
		NoticeModule.ShowNotice(21040055)
	elseif checkRet == 2 then
		NoticeModule.ShowNotice(21040055)
	elseif checkRet == 3 then
		NoticeModule.ShowNotice(21040055)
	elseif checkRet == 4 then
		NoticeModule.ShowNotice(21040055)
	elseif checkRet == 5 then
		NoticeModule.MoneyDeficitTip(2, cfgMallData.PayPoint * count - PlayerModule.PlayerInfo.baseInfo.payPoint)
	elseif checkRet == 6 then
		NoticeModule.MoneyDeficitTip(1, cfgMallData.Price[2] * count - WarehouseModule.GetItemNumByCfgID(cfgMallData.Price[1]))
	elseif checkRet == 7 then
		NoticeModule.ShowNoticeNoCallback(21045004, CfgItemTable[cfgMallData.Price[1]].Name)
	elseif checkRet == 0 then
		if cfgMallData.SellType == Constant.Mall_SellType.RMB then
			MallModule.ReqPay(cfgMallData.PayMoney)
		else
			MallModule.BuyGoods(cfgMallData.Id, count)
		end
	end
end

function MallModule.GetSaveKey(mallCid)
	return PlayerModule.PlayerInfo.baseInfo.pid .. "MALL_BUY__TIMES_LIMIT" .. mallCid
end

function MallModule.GetGoodsDesc(mallCid)
	local cfgMallData = CfgMallTable[mallCid]

	if cfgMallData.GoodsType ~= 2 then
		return BuyPanelUIApi:GetString("goDesc", cfgMallData.Desc)
	end

	local names = {}
	local nums = {}

	if cfgMallData.SellType == 3 then
		local cfgPayData = CfgPayTable[cfgMallData.PayMoney]

		if cfgPayData.GetPaypoint ~= 0 then
			names[#names + 1] = CfgItemTable[Constant.ItemID.ID_PAYPOINT_SHOW].Name
			nums[#nums + 1] = cfgPayData.GetPaypoint
		end

		for i, v in ipairs(cfgPayData.GetItems) do
			if i % 2 ~= 0 then
				names[#names + 1] = CfgItemTable[v].Name
				nums[#nums + 1] = cfgPayData.GetItems[i + 1]
			end
		end
	else
		for i, v in ipairs(cfgMallData.Item) do
			names[#names + 1] = CfgItemTable[v].Name
			nums[#nums + 1] = cfgMallData.ItemNum[i]
		end
	end

	return BuyPanelUIApi:GetString("goPackageDesc", names, nums)
end

function MallModule.BuyGoods(mallCid, num)
	if CfgMallTable[mallCid].BuyLimitShow ~= 0 then
		local boughtTimes = MallModule.GetBoughtTimes(mallCid)

		if boughtTimes >= CfgMallTable[mallCid].BuyLimitShow or CfgMallTable[mallCid].BuyLimitShow < boughtTimes + num then
			NoticeModule.ShowNoticeNoCallback(21040020)

			return
		end
	end

	net_mall.buy(mallCid, num)
end

function MallModule.OnBuyGoodsResult(mallCid, num, getItems)
	if CfgMallTable[mallCid].BuyLimitShow ~= 0 then
		local boughtTimes = MallModule.GetBoughtTimes(mallCid) + num
		local dateTable = getDateTimeTable(PlayerModule.GetServerTime())

		SaveDataModule.SaveString("Mall", PlayerModule.PlayerInfo.baseInfo.pid .. Constant.SaveServerDataKey.GoodsBoughtTimes .. mallCid, dateTable.year .. "|" .. dateTable.month .. "|" .. dateTable.day .. "|" .. boughtTimes)
	end

	PlayerModule.PlayerInfo.mallBuyCountHistory[mallCid] = (PlayerModule.PlayerInfo.mallBuyCountHistory[mallCid] or 0) + num

	EventDispatcher.Dispatch(EventID.BuyGoodsSuccess, mallCid)

	local rewards = {}

	for i, v in ipairs(getItems) do
		table.insert(rewards, {
			cid = v.cid,
			num = v.num
		})
	end

	local cfgMallData = CfgMallTable[mallCid]

	if cfgMallData.MallType ~= 1010709 and cfgMallData.EffectId == 0 and cfgMallData.EffectShow == "" then
		NoticeModule.ShowNotice(21040056)

		if cfgMallData.SellType ~= Constant.Mall_SellType.RMB and #rewards > 0 then
			NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, rewards)
		end
	else
		UIModule.Open(Constant.UIControllerName.LotteryGashaponUI, Constant.UILayer.UI, {
			mallCid,
			rewards
		})
	end
end

function MallModule.ReqPay(payCid)
	SDKLoginModule.CreateRechargeOrder(payCid)
end

function MallModule.OnNotifyMallRefresh(mallBuyCountRecords)
	MallModule.id2BuyTimesDic = mallBuyCountRecords

	EventDispatcher.Dispatch(EventID.UpdateMall)
end

function MallModule.OnNotifyRecharge(id, getPayPoint, exBonus)
	if exBonus ~= nil and #exBonus ~= 0 then
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, exBonus)
	end
end

function MallModule.OnNotifyPayInfo()
	EventDispatcher.Dispatch(EventID.NotifyPayInfo)
end

function MallModule.OnNotifyMonthCard()
	EventDispatcher.Dispatch(EventID.NotifyMonthCard)
end

function MallModule.NotifyMallStartSellTime(mallStartSellTime)
	if PlayerModule.PlayerInfo.mallStartSellTime == nil then
		PlayerModule.PlayerInfo.mallStartSellTime = {}
	end

	for i, v in pairs(mallStartSellTime) do
		PlayerModule.PlayerInfo.mallStartSellTime[i] = v
	end

	EventDispatcher.Dispatch(EventID.NotifyStartSellTime)
end
