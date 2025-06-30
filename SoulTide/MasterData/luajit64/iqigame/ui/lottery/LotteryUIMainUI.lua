-- chunkname: @IQIGame\\UI\\Lottery\\LotteryUIMainUI.lua

local m = {
	MultiPickUpCellViewNum = 0,
	PoolType = 0,
	TabIndex = 0,
	CurrencyCells = {},
	MultiPickUpCellBtns = {},
	DelegateOnClickMultiPickCellBtns = {}
}
local LotteryTabGroupController = require("IQIGame.UI.Lottery.LotteryTabGroupController")
local LotteryDrawBtnController = require("IQIGame.UI.Lottery.LotteryDrawBtnController")
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local LotteryShowSoulClickController = require("IQIGame.UI.Lottery.LotteryShowSoulClickController")

function m.New(view, host)
	local obj = Clone(m)

	obj:Init(view, host)

	return obj
end

function m:Init(view, host)
	self.View = view
	self.Host = host

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnClickRewardListBtn()
		self:OnClickRewardListBtn()
	end

	function self.DelegateOnClickRuleBtn()
		self:OnClickRuleBtn()
	end

	function self.DelegateOnClickHistoryBtn()
		self:OnClickHistoryBtn()
	end

	function self.DelegateOnClickPickUpBtn()
		self:OnClickPickUpBtn()
	end

	function self.DelegateOnClickMultiPickButton()
		self:OnClickMultiPickButton()
	end

	function self.DelegateOnClickShopBtn()
		self:OnClickShopBtn()
	end

	self.TabGroupControllers = {}

	local toggleGroup = self.ToggleGroup:GetComponent("ToggleGroup")

	self.TabGroupControllers[Constant.LotteryType.Lottery_Soul] = LotteryTabGroupController.New(self.LotteryTabGroup1, function(index)
		self:ShowTab(Constant.LotteryType.Lottery_Soul, index)
	end, self.TogglePrefab, toggleGroup, self.Host)
	self.TabGroupControllers[Constant.LotteryType.Lottery_Equip] = LotteryTabGroupController.New(self.LotteryTabGroup2, function(index)
		self:ShowTab(Constant.LotteryType.Lottery_Equip, index)
	end, self.TogglePrefab, toggleGroup, self.Host)
	self.SingleDrawBtn = LotteryDrawBtnController.New(self.SingleDrawBtnModule)
	self.MultiDrawBtn = LotteryDrawBtnController.New(self.MultiDrawBtnModule)
	self.SpecialDrawBtn = LotteryDrawBtnController.New(self.SpecialDrawBtnModule)
	self.CurrencyPool = UIObjectPool.New(3, function()
		local moneyCellGO = UnityEngine.Object.Instantiate(self.Host.UIController:GetPreloadedAsset(UIGlobalApi.GetMoneyCellAssetPath()))

		return CurrencyCell.New(moneyCellGO)
	end, function(currencyCell)
		local viewGo = currencyCell.ViewGo

		currencyCell:Dispose()
		UnityEngine.Object.Destroy(viewGo)
	end)
	self.MultiPickUpCellViewNum = 0

	for i = 1, Constant.Number.IntMaxValue do
		local imageGo = self["MultiPickIcon" .. i]

		if imageGo == nil then
			break
		end

		table.insert(self.MultiPickUpCellBtns, imageGo:GetComponent(typeof(UnityEngine.UI.Button)))
		table.insert(self.DelegateOnClickMultiPickCellBtns, function()
			self:OnClickMultiPickUpCellBtn(i)
		end)

		self.MultiPickUpCellViewNum = i
	end

	UGUIUtil.SetText(self.TitleText, LotteryUIApi:GetString("TitleText"))
	UGUIUtil.SetTextInChildren(self.RewardListBtn, LotteryUIApi:GetString("RewardListBtnText"))
	UGUIUtil.SetTextInChildren(self.RuleBtn, LotteryUIApi:GetString("RuleBtnText"))
	UGUIUtil.SetTextInChildren(self.ShopBtn, LotteryUIApi:GetString("ShopBtnText"))
	UGUIUtil.SetTextInChildren(self.HistoryBtn, LotteryUIApi:GetString("HistoryBtnText"))
	UGUIUtil.SetTextInChildren(self.MultiPickButton, LotteryUIApi:GetString("MultiPickButtonText"))
end

function m:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.RewardListBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickRewardListBtn)
	self.RuleBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickRuleBtn)
	self.HistoryBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickHistoryBtn)
	self.PickUpBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickPickUpBtn)
	self.MultiPickButton:GetComponent("Button").onClick:AddListener(self.DelegateOnClickMultiPickButton)
	self.ShopBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickShopBtn)
	self.SingleDrawBtn:AddEventListeners()
	self.MultiDrawBtn:AddEventListeners()
	self.SpecialDrawBtn:AddEventListeners()

	for i = 1, #self.MultiPickUpCellBtns do
		self.MultiPickUpCellBtns[i].onClick:AddListener(self.DelegateOnClickMultiPickCellBtns[i])
	end
end

function m:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.RewardListBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickRewardListBtn)
	self.RuleBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickRuleBtn)
	self.HistoryBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickHistoryBtn)
	self.PickUpBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickPickUpBtn)
	self.MultiPickButton:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickMultiPickButton)
	self.ShopBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickShopBtn)
	self.SingleDrawBtn:RemoveEventListeners()
	self.MultiDrawBtn:RemoveEventListeners()
	self.SpecialDrawBtn:RemoveEventListeners()

	for i = 1, #self.MultiPickUpCellBtns do
		self.MultiPickUpCellBtns[i].onClick:RemoveListener(self.DelegateOnClickMultiPickCellBtns[i])
	end
end

function m:OnUpdate(elapseSeconds, realElapseSeconds)
	self.SingleDrawBtn:OnUpdate(elapseSeconds, realElapseSeconds)

	for type, group in pairs(self.TabGroupControllers) do
		group:OnUpdate(elapseSeconds, realElapseSeconds)
	end
end

function m:Show(userData)
	self.View:SetActive(true)

	self.CfgLotteryShowDataList = {}

	local leftTimeSecs = {}

	self.CfgLotteryShowDataList[Constant.LotteryType.Lottery_Soul] = {}
	self.CfgLotteryShowDataList[Constant.LotteryType.Lottery_Equip] = {}
	leftTimeSecs[Constant.LotteryType.Lottery_Soul] = {}
	leftTimeSecs[Constant.LotteryType.Lottery_Equip] = {}

	for cid, cfgLotteryShowData in pairsCfg(CfgLotteryShowTable) do
		if cfgLotteryShowData.LotteryType == Constant.LotteryType.Lottery_Soul or cfgLotteryShowData.LotteryType == Constant.LotteryType.Lottery_Equip then
			local isInOpenTime, leftTimeSec = LotteryModule.CheckInOpenTime(cfgLotteryShowData)
			local lotteryShowPOD = LotteryModule.GetLotteryShowPOD(cid)

			if isInOpenTime and ConditionModule.Check(cfgLotteryShowData.OpenCondition) and (cfgLotteryShowData.Limit == 0 or lotteryShowPOD.drawCount < cfgLotteryShowData.Limit) then
				table.insert(self.CfgLotteryShowDataList[cfgLotteryShowData.LotteryType], cfgLotteryShowData)
			end

			leftTimeSecs[cfgLotteryShowData.LotteryType][cfgLotteryShowData.Id] = leftTimeSec
		end
	end

	for type, dataList in pairs(self.CfgLotteryShowDataList) do
		table.sort(dataList, function(cfgLotteryShowData1, cfgLotteryShowData2)
			return cfgLotteryShowData1.Sort < cfgLotteryShowData2.Sort
		end)
	end

	for type, group in pairs(self.TabGroupControllers) do
		group:SetData(self.CfgLotteryShowDataList[type], type, leftTimeSecs[type])
	end

	local defaultType = Constant.LotteryType.Lottery_Soul

	if userData ~= nil and userData.type ~= nil then
		defaultType = userData.type
	elseif self.PoolType ~= 0 then
		defaultType = self.PoolType
	end

	local defaultTabIndex = 1

	if userData ~= nil and userData.tab ~= nil then
		defaultTabIndex = userData.tab
	elseif self.TabIndex ~= 0 then
		defaultTabIndex = self.TabIndex
	end

	self.PoolType = 0
	self.TabIndex = 0

	self.TabGroupControllers[defaultType]:SetSelectToggle(defaultTabIndex)
	self:ShowTab(defaultType, defaultTabIndex)
end

function m:Hide()
	self.View:SetActive(false)
end

function m:OnClickCloseBtn()
	UIModule.Close(Constant.UIControllerName.LotteryUI)
end

function m:ShowTab(type, index)
	if self.PoolType == type and self.TabIndex == index then
		return
	end

	self.PoolType = type
	self.TabIndex = index

	local cfgLotteryShowData = self.CfgLotteryShowDataList[type][index]

	self.CfgLotteryShowData = cfgLotteryShowData

	local poolMap = {}

	for i, poolCid in pairs(cfgLotteryShowData.Pool) do
		local cfgLotteryData = CfgLotteryTable[poolCid]

		poolMap[cfgLotteryData.Type] = cfgLotteryData
	end

	self.SingleDrawBtn:SetData(poolMap[Constant.Lottery.PoolTypeSingle], cfgLotteryShowData)
	self.MultiDrawBtn:SetData(poolMap[Constant.Lottery.PoolTypeTen], cfgLotteryShowData)
	self.SpecialDrawBtn:SetData(poolMap[Constant.Lottery.PoolTypeMust], cfgLotteryShowData, true)
	self:ClearCurrencyCells()

	local currencyCids = {}

	for i = 1, #cfgLotteryShowData.Pool do
		local cfgLotteryData = CfgLotteryTable[cfgLotteryShowData.Pool[i]]

		if #cfgLotteryData.ItemCost > 0 then
			local itemCid = cfgLotteryData.ItemCost[1]
			local needItemNum = cfgLotteryData.ItemCost[2]

			if self:NeedShow(i, itemCid, needItemNum) and table.indexOf(currencyCids, itemCid) == -1 then
				table.insert(currencyCids, itemCid)
			end
		end
	end

	if table.indexOf(currencyCids, Constant.ItemID.TREASURE) == -1 then
		table.insert(currencyCids, Constant.ItemID.TREASURE)
	end

	if table.indexOf(currencyCids, Constant.ItemID.ID_PAYPOINT_SHOW) == -1 then
		table.insert(currencyCids, Constant.ItemID.ID_PAYPOINT_SHOW)
	end

	for i = 1, #currencyCids do
		local itemCid = currencyCids[i]
		local currencyCell = self.CurrencyPool:Obtain()

		currencyCell.ViewGo:SetActive(true)
		currencyCell.ViewGo.transform:SetParent(self.MoneyGrid.transform, false)
		currencyCell:SetData(itemCid)
		table.insert(self.CurrencyCells, currencyCell)
	end

	local lotteryShowPOD = LotteryModule.GetLotteryShowPOD(self.CfgLotteryShowData.Id)

	UGUIUtil.SetText(self.InsureRewardTipText, LotteryUIApi:GetString("InsureRewardTipText", lotteryShowPOD.leftInsureTime))
	UGUIUtil.SetText(self.HiddenInsureRewardTipText, LotteryUIApi:GetString("HiddenInsureRewardTipText", lotteryShowPOD.leftHiddenInsureTime, GameEntry.Base.DevMode, LuaCodeInterface.IsDebugBuild))

	local availablePickUpList = LotteryModule.GetAvailablePickUps(self.CfgLotteryShowData)
	local selectedPickUps = {}

	if #availablePickUpList > 0 then
		selectedPickUps = LotteryModule.GetSelectedPickUps(self.CfgLotteryShowData, availablePickUpList)
	end

	self:UpdateBackground(selectedPickUps[1])
	self.PickUpBtn:SetActive(#availablePickUpList > 1 and self.CfgLotteryShowData.ChoiceNum == 1)

	if #availablePickUpList > 1 and self.CfgLotteryShowData.ChoiceNum == 1 then
		self:RefreshPickUpView(selectedPickUps[1])
	end

	self.MultiPickUpView:SetActive(#availablePickUpList > 1 and self.CfgLotteryShowData.ChoiceNum > 1)

	if #availablePickUpList > 1 and self.CfgLotteryShowData.ChoiceNum > 1 then
		self:RefreshMultiPickUpView(selectedPickUps)
	end

	local count, maxCount = LotteryModule.GetTodayLeftDrawCount()

	self.TodayLeftDrawCountText:SetActive(maxCount > 0 and count <= 999)
	UGUIUtil.SetText(self.TodayLeftDrawCountText, LotteryUIApi:GetString("TodayLeftDrawCountText", count))
end

function m:RefreshPickUpView(cfgLotteryPackUpData)
	AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(cfgLotteryPackUpData.Icon), self.PickUpTypeIcon:GetComponent("Image"))
	UGUIUtil.SetTextInChildren(self.PickUpBtn, cfgLotteryPackUpData.Name)
end

function m:RefreshMultiPickUpView(selectedPickUps)
	for i = 1, self.MultiPickUpCellViewNum do
		local imageGo = self["MultiPickIcon" .. i]
		local cfgLotteryPackUpData = selectedPickUps[i]

		imageGo:SetActive(cfgLotteryPackUpData ~= nil)

		if cfgLotteryPackUpData ~= nil then
			AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(cfgLotteryPackUpData.Icon), imageGo:GetComponent("Image"))
		end
	end
end

function m:OnClickMultiPickUpCellBtn(index)
	local availablePickUpList = LotteryModule.GetAvailablePickUps(self.CfgLotteryShowData)
	local selectedPickUps = {}

	if #availablePickUpList > 0 then
		selectedPickUps = LotteryModule.GetSelectedPickUps(self.CfgLotteryShowData, availablePickUpList)
	end

	local cfgData = selectedPickUps[index]

	if cfgData.UpType == 2 then
		local itemCid = cfgData.UpList[1]
		local cfgItemData = CfgItemTable[itemCid]

		UIModule.Open(Constant.UIControllerName.EquipUI, Constant.UILayer.UI, {
			forShow = true,
			data = {
				cfgItemData
			}
		})
	else
		logError("不支持的类型")
	end
end

function m:UpdateBackground(cfgLotteryPackUpData)
	local bgUri

	if cfgLotteryPackUpData == nil then
		bgUri = self.CfgLotteryShowData.ShowImage
	else
		bgUri = cfgLotteryPackUpData.BackGround
	end

	if self.LastBgUri ~= nil and bgUri == self.LastBgUri then
		return
	end

	self.LastBgUri = bgUri

	AssetUtil.LoadAsset(self, UIGlobalApi.GetUIPrefab(bgUri), self.OnLoadSucceed)
end

function m:NeedShow(poolIndex, itemCid, itemNum)
	if poolIndex ~= 3 then
		return true
	end

	local hasItemNum = WarehouseModule.GetItemNumByCfgID(itemCid)

	return itemNum <= hasItemNum
end

function m:OnLoadSucceed(assetName, asset, duration, userData)
	if self.ShowSoulClickController ~= nil then
		self.ShowSoulClickController:Destroy()

		self.ShowSoulClickController = nil
	end

	local go = UnityEngine.Object.Instantiate(asset)

	UIUtil.InitSortedComponents(self.Host.UIController:GetComponent("Canvas"), go)

	self.ShowSoulClickController = LotteryShowSoulClickController.New(go)

	self.ShowSoulClickController.View.transform:SetParent(self.PoolViewContainer.transform, false)
end

function m:ClearCurrencyCells(isDestroy)
	for i = 1, #self.CurrencyCells do
		local currencyCell = self.CurrencyCells[i]

		if not isDestroy then
			currencyCell.ViewGo.transform:SetParent(self.Host.UIController.transform, false)
		end

		currencyCell.ViewGo:SetActive(false)
		self.CurrencyPool:Release(currencyCell)
	end

	self.CurrencyCells = {}
end

function m:OnClickRewardListBtn()
	UIModule.Open(Constant.UIControllerName.LotteryRewardListUI, Constant.UILayer.UI, self.CfgLotteryShowData)
end

function m:OnClickRuleBtn()
	UIModule.Open(Constant.UIControllerName.LotteryIntroduceTipsUI, Constant.UILayer.UI)
end

function m:OnClickHistoryBtn()
	LotteryModule.GetHistory(function(historyList)
		UIModule.Open(Constant.UIControllerName.LotteryHistoryUI, Constant.UILayer.UI, {
			historyList = historyList
		})
	end)
end

function m:OnClickPickUpBtn()
	local cfgLotteryShowData = self.CfgLotteryShowDataList[self.PoolType][self.TabIndex]

	UIModule.Open(Constant.UIControllerName.LotteryPickUpUI, Constant.UILayer.UI, {
		cfgLotteryShowData = cfgLotteryShowData,
		onChange = function(cfgLotteryPackUpData)
			self:RefreshPickUpView(cfgLotteryPackUpData)
			self:UpdateBackground(cfgLotteryPackUpData)
		end
	})
end

function m:OnClickMultiPickButton()
	local cfgLotteryShowData = self.CfgLotteryShowDataList[self.PoolType][self.TabIndex]

	UIModule.Open(Constant.UIControllerName.LotteryMultiPickUpUI, Constant.UILayer.UI, {
		cfgLotteryShowData = cfgLotteryShowData,
		onChange = function(selectedPickUps)
			self:RefreshMultiPickUpView(selectedPickUps)
			self:UpdateBackground(selectedPickUps[1])
		end
	})
end

function m:OnClickShopBtn()
	if self.CfgLotteryShowData.LotteryType == Constant.LotteryType.Lottery_Soul then
		JumpModule.Jump(10202024)
	elseif self.CfgLotteryShowData.LotteryType == Constant.LotteryType.Lottery_Equip then
		JumpModule.Jump(10202025)
	end
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)

	for type, group in pairs(self.TabGroupControllers) do
		group:Dispose()
	end

	self.SingleDrawBtn:Dispose()
	self.MultiDrawBtn:Dispose()
	self.SpecialDrawBtn:Dispose()
	self:ClearCurrencyCells(true)
	self.CurrencyPool:Dispose()

	if self.ShowSoulClickController ~= nil then
		self.ShowSoulClickController:Destroy()

		self.ShowSoulClickController = nil
	end

	for i = 1, #self.MultiPickUpCellBtns do
		self.MultiPickUpCellBtns[i] = nil
	end

	self.MultiPickUpCellBtns = nil

	for i = 1, #self.DelegateOnClickMultiPickCellBtns do
		self.DelegateOnClickMultiPickCellBtns[i] = nil
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.Host = nil
end

return m
