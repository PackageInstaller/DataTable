-- chunkname: @IQIGame\\UI\\Activity\\Food\\ActivityFoodItem.lua

local m = {
	CurrentState = 0
}

function m.New(view, index)
	local obj = Clone(m)

	obj:Init(view, index)

	return obj
end

function m:Init(view, index)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickFreeClaimBtn()
		self:OnClickFreeClaimBtn()
	end

	function self.DelegateOnClickCostClaimBtn()
		self:OnClickCostClaimBtn()
	end

	self.Bg1:SetActive(index == 1)
	self.Bg2:SetActive(index == 2)
	UGUIUtil.SetTextInChildren(self.StateView1, ActivityUIApi:GetString("FoodItemNotTimeText"))
	UGUIUtil.SetTextInChildren(self.StateView2, ActivityUIApi:GetString("FoodItemClaimedText"))
	UGUIUtil.SetTextInChildren(self.FreeClaimBtn, ActivityUIApi:GetString("FoodItemFreeClaimBtnText"))
	UGUIUtil.SetTextInChildren(self.CostClaimBtn, ActivityUIApi:GetString("FoodItemCostClaimBtnText"))
	UGUIUtil.SetText(self.CostLabel, ActivityUIApi:GetString("FoodItemCostLabel"))
	self:AddListeners()
end

function m:SetData(cfgDailySupplyData)
	self.CfgDailySupplyData = cfgDailySupplyData
	self.StartTimeData = {}

	local hm = string.split(cfgDailySupplyData.OpenTime, ":")

	self.StartTimeData.hour = tonumber(hm[1])
	self.StartTimeData.min = tonumber(hm[2])
	self.EndTimeData = {}
	hm = string.split(cfgDailySupplyData.EndTime, ":")
	self.EndTimeData.hour = tonumber(hm[1])
	self.EndTimeData.min = tonumber(hm[2])
	self.DailyRefreshData = {}
	self.DailyRefreshData.hour = Constant.Player.DailyResetTimeHour
	self.DailyRefreshData.min = Constant.Player.DailyResetTimeMin

	UGUIUtil.SetText(self.TitleText, ActivityUIApi:GetString("FoodItemTitleText", cfgDailySupplyData.Name))

	local isH12 = MiscApi:GetString("IsHour12")
	local openTimeHour = self.StartTimeData.hour
	local isOpenTimePm = false

	if isH12 and openTimeHour > 12 then
		openTimeHour = openTimeHour - 12
		isOpenTimePm = true
	end

	local endTimeHour = self.EndTimeData.hour
	local isEndTimePm = false

	if isH12 and endTimeHour > 12 then
		endTimeHour = endTimeHour - 12
		isEndTimePm = true
	end

	UGUIUtil.SetText(self.TimeText, ActivityUIApi:GetString("FoodItemTimeText", openTimeHour, self.StartTimeData.min, endTimeHour, self.EndTimeData.min, isH12, isOpenTimePm, isEndTimePm))
	UGUIUtil.SetText(self.ContentText, ActivityUIApi:GetString("FoodItemContentText", cfgDailySupplyData.Supply))

	local timeSecond = PlayerModule.GetServerTime()

	AssetUtil.LoadImage(self, ActivityUIApi:GetString("FoodItemIcon", getWeekText(timeSecond), getOnlyDateText(timeSecond), self.CfgDailySupplyData.Id), self.Icon:GetComponent("Image"))

	self.CurrentState = self:GetState()

	for i = 1, 4 do
		self["StateView" .. i]:SetActive(i == self.CurrentState)
	end

	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(CfgItemTable[cfgDailySupplyData.Price[1]].Icon), self.CostItemIcon:GetComponent("Image"))
	UGUIUtil.SetText(self.CostItemNumText, cfgDailySupplyData.Price[2])
end

function m:GetState()
	return PlayerModule.GetSupplyState(self.StartTimeData, self.EndTimeData, self.DailyRefreshData, self.CfgDailySupplyData.Id)
end

function m:AddListeners()
	self.FreeClaimBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickFreeClaimBtn)
	self.CostClaimBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCostClaimBtn)
end

function m:RemoveListeners()
	self.FreeClaimBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickFreeClaimBtn)
	self.CostClaimBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCostClaimBtn)
end

function m:OnClickFreeClaimBtn()
	self:Validate(function()
		net_active.reciveFood(self.CfgDailySupplyData.Id, true)
	end)
end

function m:OnClickCostClaimBtn()
	self:Validate(function()
		local itemCid = self.CfgDailySupplyData.Price[1]
		local itemNum = self.CfgDailySupplyData.Price[2]

		if itemNum > WarehouseModule.GetItemNumByCfgID(itemCid) then
			NoticeModule.ShowNotice(21054002)

			return
		end

		NoticeModule.ShowNoticeBuyConfirm(21054001, function()
			net_active.reciveFood(self.CfgDailySupplyData.Id, false)
		end, nil, nil, {
			itemCid
		}, {
			itemNum
		})
	end)
end

function m:Validate(onConfirm)
	local currentEnergy = PlayerModule.GetNumAttrValue(Constant.ItemID.ENERGY)

	if currentEnergy + self.CfgDailySupplyData.Supply > MiscApi:GetString("DailySupplyEnergyTopLimit") then
		NoticeModule.ShowNotice(21054004)
	else
		onConfirm()
	end
end

function m:Update(elapseSeconds, realElapseSeconds)
	local state = self:GetState()

	if state ~= self.CurrentState then
		self.CurrentState = state

		for i = 1, 4 do
			self["StateView" .. i]:SetActive(i == self.CurrentState)
		end
	end
end

function m:Dispose()
	self:RemoveListeners()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.CfgDailySupplyData = nil
end

return m
