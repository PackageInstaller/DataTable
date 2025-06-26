-- chunkname: @IQIGame\\UI\\GiftSalesTimePanel\\GiftSalesTimeCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	UGUIUtil.SetText(self.goMoneyUnit, MiscApi:GetString("moneySign"))
	UGUIUtil.SetText(self.limitTimeText, GiftSalesTimePanelUIApi:GetString("limitTimeText"))
	UGUIUtil.SetTextInChildren(self.buyBtn, GiftSalesTimePanelUIApi:GetString("buyBtnLabel"))

	self.timer = Timer.New(function()
		self:ShowCD()
	end, 1, -1)

	self.timer:Start()

	function self.DelegateBuyBtn()
		self:OnBuyBtn()
	end

	function self.DelegateBtnSelf()
		self:OnBtnSelf()
	end

	self:AddListener()
end

function m:AddListener()
	self.buyBtn:GetComponent("Button").onClick:AddListener(self.DelegateBuyBtn)
	self.btnSelf:GetComponent("Button").onClick:AddListener(self.DelegateBtnSelf)
end

function m:RemoveListener()
	self.buyBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateBuyBtn)
	self.btnSelf:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnSelf)
end

function m:SetData(data)
	self.cfgData = data
	self.mallData = CfgMallTable[data.MallId]

	self:UpDateView()
end

function m:UpDateView()
	UGUIUtil.SetText(self.goName, GiftSalesTimePanelUIApi:GetString("goItemName", self.mallData.Name))

	local moneyNumStr = ""

	if self.mallData.SellType == Constant.Mall_SellType.Item then
		moneyNumStr = GiftSalesTimePanelUIApi:GetString("goMoneyCost", self.mallData.Price[2], WarehouseModule.GetItemNumByCfgID(self.mallData.Price[1]), self.mallData.SellType == Constant.Mall_SellType.Free)
	elseif self.mallData.SellType == Constant.Mall_SellType.PayPoint then
		moneyNumStr = GiftSalesTimePanelUIApi:GetString("goMoneyCost", self.mallData.PayPoint, PlayerModule.PlayerInfo.baseInfo.payPoint, self.mallData.SellType == Constant.Mall_SellType.Free)
	elseif self.mallData.SellType == Constant.Mall_SellType.RMB then
		local cost = CfgPayTable[self.mallData.PayMoney].Amount

		moneyNumStr = GiftSalesTimePanelUIApi:GetString("goMoneyCost", cost, 0, true, self.mallData.SellType == Constant.Mall_SellType.Free)
	elseif self.mallData.SellType == Constant.Mall_SellType.Free then
		moneyNumStr = GiftSalesTimePanelUIApi:GetString("goMoneyCost", 0, 0, false, true)
	end

	UGUIUtil.SetText(self.goMoneyNum, moneyNumStr)
	self.goMoneyIcon:SetActive(self.mallData.SellType ~= Constant.Mall_SellType.RMB and self.mallData.SellType ~= Constant.Mall_SellType.Free)
	self.goMoneyUnit:SetActive(self.mallData.SellType == Constant.Mall_SellType.RMB)

	if self.mallData.SellType == Constant.Mall_SellType.Item then
		AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(CfgItemTable[self.mallData.Price[1]].Icon), self.goMoneyIcon:GetComponent("Image"))
	elseif self.mallData.SellType == Constant.Mall_SellType.PayPoint then
		AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(CfgItemTable[Constant.ItemID.ID_PAYPOINT_SHOW].Icon), self.goMoneyIcon:GetComponent("Image"))
	end

	UGUIUtil.SetText(self.goBuyTimes, GiftSalesTimePanelUIApi:GetString("goBuyTimes", self.mallData.LimitType, MallModule.GetResidueBuyTimes(self.mallData.Id), self.mallData.LimitTimes))

	if self.mallData.BG ~= nil and self.mallData.BG ~= "" then
		AssetUtil.LoadImage(self, UIGlobalApi.GetAssetPath(self.mallData.BG), self.goIcon:GetComponent("Image"))
	end

	self.goTime:SetActive(self.mallData.TimeLimitType > Constant.MallTimeLimitType.STAY)
end

function m:ShowCD()
	if self.mallData == nil then
		return
	end

	if self.mallData.TimeLimitType == Constant.MallTimeLimitType.TIME_STAMP then
		UGUIUtil.SetText(self.goTime, GiftSalesTimePanelUIApi:GetString("goTime", cfgDateTimeToTimeStamp(self.mallData.TimeLimitEnd, PlayerModule.TimeZone) - math.floor(PlayerModule.GetServerTime())))
	elseif self.mallData.TimeLimitType == Constant.MallTimeLimitType.LIMIT_SELL_TIME then
		local now = PlayerModule.GetServerTime()
		local startTime = PlayerModule.PlayerInfo.mallStartSellTime[self.mallData.Id]

		if startTime then
			local cfgCD = CfgMallTable[self.mallData.Id].SalesTime
			local cd = startTime + cfgCD - now

			if cd > 0 then
				if cd >= 172800 then
					UGUIUtil.SetText(self.goTime, GiftSalesTimePanelUIApi:GetString("TimeCDText", getTimeDurationText(cd, 1)))
				else
					UGUIUtil.SetText(self.goTime, GiftSalesTimePanelUIApi:GetString("TimeCDText", GetFormatTime(cd)))
				end
			end
		end
	end
end

function m:OnBuyBtn()
	UIModule.Open(Constant.UIControllerName.BuyPanelUI, Constant.UILayer.UI, {
		mallCid = self.mallData.Id
	})
end

function m:OnBtnSelf()
	local rewards = {}

	for i = 1, #self.cfgData.ShowItems, 2 do
		rewards[#rewards + 1] = {
			id = self.cfgData.ShowItems[i],
			num = self.cfgData.ShowItems[i + 1]
		}
	end

	UIModule.Open(Constant.UIControllerName.CheckRewardUI, Constant.UILayer.Mid, {
		ShowBtn = false,
		Rewards = rewards,
		TextTitle = CfgMallTable[self.cfgData.MallId].Name
	})
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	self.timer:Stop()

	self.timer = nil

	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
