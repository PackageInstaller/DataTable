-- chunkname: @IQIGame\\Module\\PurchaseTips\\PurchaseTipModule.lua

PurchaseTipModule = {
	isClosePurchaseTip = false,
	purchaseTipList = {}
}

function PurchaseTipModule.Reload()
	PurchaseTipModule.isClosePurchaseTip = false

	PurchaseTipModule.RefreshTips()
	PurchaseTipModule.AddListener()

	local timer = ModuleTimerUtil.NewTimer(Constant.ModuleTimerName.PurchaseTip, function()
		PurchaseTipModule.CheckLimitSellMall()
	end, 1, -1)

	timer:Start()
end

function PurchaseTipModule.Shutdown()
	PurchaseTipModule.RemoveListener()
	ModuleTimerUtil.Stop(Constant.ModuleTimerName.PurchaseTip)
end

function PurchaseTipModule.AddListener()
	EventDispatcher.AddEventListener(EventID.PlayerInfoChanged, PurchaseTipModule.OnPlayerInfoChanged)
	EventDispatcher.AddEventListener(EventID.ExChangeItemSuccessEvent, PurchaseTipModule.OnPlayerInfoChanged)
	EventDispatcher.AddEventListener(EventID.BuyGoodsSuccess, PurchaseTipModule.OnPlayerInfoChanged)
	EventDispatcher.AddEventListener(EventID.PlayerNumAttrsChange, PurchaseTipModule.OnChangeValue)
	EventDispatcher.AddEventListener(EventID.NotifyStartSellTime, PurchaseTipModule.OnNotifyStartSellTime)
	EventDispatcher.AddEventListener(EventID.UpdateMall, PurchaseTipModule.OnUpdateMall)
end

function PurchaseTipModule.RemoveListener()
	EventDispatcher.RemoveEventListener(EventID.PlayerInfoChanged, PurchaseTipModule.OnPlayerInfoChanged)
	EventDispatcher.RemoveEventListener(EventID.ExChangeItemSuccessEvent, PurchaseTipModule.OnPlayerInfoChanged)
	EventDispatcher.RemoveEventListener(EventID.BuyGoodsSuccess, PurchaseTipModule.OnPlayerInfoChanged)
	EventDispatcher.RemoveEventListener(EventID.PlayerNumAttrsChange, PurchaseTipModule.OnChangeValue)
	EventDispatcher.RemoveEventListener(EventID.NotifyStartSellTime, PurchaseTipModule.OnNotifyStartSellTime)
	EventDispatcher.RemoveEventListener(EventID.UpdateMall, PurchaseTipModule.OnUpdateMall)
end

function PurchaseTipModule.RefreshTips()
	PurchaseTipModule.purchaseTipList = {}

	for i, v in pairsCfg(CfgPurchaseTipsTable) do
		if v.Type == 1 then
			local cfgExchange

			for i, v in pairsCfg(CfgExchangeTable) do
				if v.GetItem == Constant.ItemID.ENERGY then
					cfgExchange = v

					break
				end
			end

			if cfgExchange then
				local count, costItemCid, costItemNum, nextIndex = ChurchModule.GetExchangeInfo(cfgExchange)

				if count > 0 then
					table.insert(PurchaseTipModule.purchaseTipList, v)
				end
			end
		elseif v.Type == 2 then
			local count = MallModule.GetResidueBuyTimes(v.MallId)

			if count > 0 then
				table.insert(PurchaseTipModule.purchaseTipList, v)
			end
		elseif v.Type == 3 then
			local startSell = MallModule.GetMallIsStartSell(v.MallId)
			local count = MallModule.GetResidueBuyTimes(v.MallId)

			if startSell and count > 0 then
				table.insert(PurchaseTipModule.purchaseTipList, v)
			end
		end
	end

	table.sort(PurchaseTipModule.purchaseTipList, function(a, b)
		return a.Order < b.Order
	end)
end

function PurchaseTipModule.CheckLimitSellMall()
	local now = PlayerModule.GetServerTime()
	local haveTimeEnd = false
	local tempTab = {}

	for i, v in pairs(PlayerModule.PlayerInfo.mallStartSellTime) do
		if now >= v + CfgMallTable[i].SalesTime then
			haveTimeEnd = true
		else
			tempTab[i] = v
		end
	end

	if haveTimeEnd then
		PlayerModule.PlayerInfo.mallStartSellTime = tempTab

		PurchaseTipModule.OnNotifyStartSellTime()
		EventDispatcher.Dispatch(EventID.UpdateMall)
	end
end

function PurchaseTipModule.OnUpdateMall()
	PurchaseTipModule.OnPlayerInfoChanged()
end

function PurchaseTipModule.OnNotifyStartSellTime()
	PurchaseTipModule.OnPlayerInfoChanged()
end

function PurchaseTipModule.OnPlayerInfoChanged()
	PurchaseTipModule.RefreshTips()

	local data = PurchaseTipModule.CheckPurchaseTipMsg()

	EventDispatcher.Dispatch(EventID.PurchaseTipEvent, data)
end

function PurchaseTipModule.OnChangeValue(id, value)
	if id == Constant.ItemID.ENERGY then
		PurchaseTipModule.OnPlayerInfoChanged()
	end
end

function PurchaseTipModule.CheckPurchaseTipMsg()
	local purchaseTipData
	local haveSellMall = false
	local minTime = PlayerModule.GetServerTime()

	for i = 1, #PurchaseTipModule.purchaseTipList do
		local cfg = PurchaseTipModule.purchaseTipList[i]
		local condition = ConditionModule.Check(cfg.Conditions)

		if cfg.Type == 1 and not haveSellMall then
			local cfgExchange

			for i, v in pairsCfg(CfgExchangeTable) do
				if v.GetItem == Constant.ItemID.ENERGY then
					cfgExchange = v

					break
				end
			end

			local count = 0

			if cfgExchange then
				count = ChurchModule.GetExchangeInfo(cfgExchange)
			end

			if count > 0 and condition then
				purchaseTipData = cfg

				break
			end
		elseif cfg.Type == 2 and not haveSellMall then
			local buyCount = MallModule.GetResidueBuyTimes(cfg.MallId)

			if buyCount > 0 and condition then
				purchaseTipData = cfg

				break
			end
		elseif cfg.Type == 3 and condition then
			local endTime = PlayerModule.PlayerInfo.mallStartSellTime[cfg.MallId] + CfgMallTable[cfg.MallId].SalesTime
			local cd = endTime - PlayerModule.GetServerTime()

			if cd > 0 and cd < minTime then
				haveSellMall = true
				minTime = cd
				purchaseTipData = cfg
			end
		end
	end

	return purchaseTipData
end
