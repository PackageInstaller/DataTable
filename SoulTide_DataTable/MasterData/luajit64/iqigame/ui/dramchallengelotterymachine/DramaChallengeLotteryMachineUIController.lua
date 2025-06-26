-- chunkname: @IQIGame\\UI\\DramChallengeLotteryMachine\\DramaChallengeLotteryMachineUIController.lua

local DramaChallengeLotteryMachineUIController = {
	Timer = 0,
	NationMoney = 0,
	CurrentPrizeDrawPoolNum = 0,
	PrizeDrawPoolNum = 0,
	NpcActionGroupId = 0,
	CV_SHOW_DURATION = 1,
	DrawsNum = 10,
	PrizeDrawPoolId = 0,
	randomTextCid = 0,
	PrizeDrawToggles = {},
	ItemCells = {},
	CurrentPrizeDrawPoolList = {},
	randomTextCidList = {},
	CurrencyControllers = {},
	PlotChallengeTable = {}
}
local RewardItem = require("IQIGame.UI.DramChallengeLotteryMachine.PrizeDrawRewardCell")
local TextHelper = require("IQIGame.UI.Dialog.DialogTextPerformance")

function DramaChallengeLotteryMachineUIController.New(uiController)
	local obj = Clone(DramaChallengeLotteryMachineUIController)

	obj:__Init(uiController)

	return obj
end

function DramaChallengeLotteryMachineUIController:__Init(uiController)
	self.UIController = uiController
end

function DramaChallengeLotteryMachineUIController:InitView(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
end

function DramaChallengeLotteryMachineUIController:OnInit()
	self.PlotChallengeTable = PlotChallengeModule.GetPlotChallengeTable()

	self:InitCurrencyModule()

	self.NumText = self.TotalityAndRemainder:GetComponent("Text")
	self.txtHelperComp = TextHelper.New()
	self.PrizeDrawOnePriceText = self.PrizeDrawOnePrice:GetComponent("Text")
	self.PrizeDrawMorePriceText = self.PrizeDrawMorePrice:GetComponent("Text")
	self.PrizeDrawMoreText = self.PrizeDrawMore:GetComponent("Text")

	function self.delegateCloseBtn()
		self:OnBtnClose()
	end

	function self.delegatePrizeDrawOneBtn()
		self:OnBtnPrizeDrawOne()
	end

	function self.delegatePrizeDrawMoreBtn()
		self:OnBtnPrizeDrawMore()
	end

	function self.delegatePrizeDrawPoolRefresh()
		self:Refresh()
	end

	function self.delegateNextPrizeDrawPool()
		self:UpdateToggleValue(self.PrizeDrawPoolId + 1)
	end

	for i = 1, #CfgPlotChallengeActivityRewardPoolTable do
		local PrizeDrawToggle = UnityEngine.Object.Instantiate(self.PrizeDrawToggle)

		PrizeDrawToggle.transform:SetParent(self.PanelLise.transform, false)

		self.PrizeDrawToggles[i] = PrizeDrawToggle
		self["DelegateOnToggleValueChanged" .. i] = function()
			self:OnToggleValueChanged(i)
		end
	end

	self.scrollAreaList = self.ScrollArea:GetComponent("ScrollAreaList")
	self.TotalityAndRemainderText = self.TotalityAndRemainder:GetComponent("Text")

	function self.scrollAreaList.onRenderCell(cell)
		self:OnRenderItemCell(cell)
	end

	function self.scrollAreaList.onSelectedCell(cell)
		self:OnSelectedItemCell(cell)
	end

	self.NpcActionGroupId = self.PlotChallengeTable.NPCActionGroupID

	for i, v in pairs(CfgNPCActionTable) do
		if v.GroupId == 6 then
			table.insert(self.randomTextCidList, v.CVid)
		end
	end
end

function DramaChallengeLotteryMachineUIController:GetPreloadAssetPaths()
	return nil
end

function DramaChallengeLotteryMachineUIController:GetOpenPreloadAssetPaths(userData)
	return nil
end

function DramaChallengeLotteryMachineUIController:IsManualShowOnOpen(userData)
	return false
end

function DramaChallengeLotteryMachineUIController:GetBGM(userData)
	return nil
end

function DramaChallengeLotteryMachineUIController:OnOpen(userData)
	self.PrizeDrawPoolId = PlotChallengeModule.GetCurrentPrizeDrawPoolId()
	self.CurrentRewardCfg = PlotChallengeModule.GetCurrentItemsNumByToggle(self.PrizeDrawPoolId)
	self.PrizeDrawToggles[self.PrizeDrawPoolId]:GetComponent("Toggle").isOn = true
	self.randomTextCid = self.randomTextCidList[math.random(#self.randomTextCidList)]

	self:ShowCV(self.randomTextCid)
	self:Refresh()
end

function DramaChallengeLotteryMachineUIController:OnClose(userData)
	return
end

function DramaChallengeLotteryMachineUIController:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.delegateCloseBtn)
	self.PrizeDrawOneBtn:GetComponent("Button").onClick:AddListener(self.delegatePrizeDrawOneBtn)
	self.PrizeDrawMoreBtn:GetComponent("Button").onClick:AddListener(self.delegatePrizeDrawMoreBtn)
	EventDispatcher.AddEventListener(EventID.APUpdateCurrentPrizeDrawPool, self.delegatePrizeDrawPoolRefresh)
	EventDispatcher.AddEventListener(EventID.NextPrizeDrawPool, self.delegateNextPrizeDrawPool)

	for i = 1, #self.PrizeDrawToggles do
		self.PrizeDrawToggles[i]:GetComponent("Toggle").onValueChanged:AddListener(self["DelegateOnToggleValueChanged" .. i])
	end
end

function DramaChallengeLotteryMachineUIController:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.delegateCloseBtn)
	self.PrizeDrawOneBtn:GetComponent("Button").onClick:RemoveListener(self.delegatePrizeDrawOneBtn)
	self.PrizeDrawMoreBtn:GetComponent("Button").onClick:RemoveListener(self.delegatePrizeDrawMoreBtn)
	EventDispatcher.RemoveEventListener(EventID.APUpdateCurrentPrizeDrawPool, self.delegatePrizeDrawPoolRefresh)
	EventDispatcher.RemoveEventListener(EventID.NextPrizeDrawPool, self.delegateNextPrizeDrawPool)

	for i = 1, #self.PrizeDrawToggles do
		self.PrizeDrawToggles[i]:GetComponent("Toggle").onValueChanged:RemoveListener(self["DelegateOnToggleValueChanged" .. i])
	end
end

function DramaChallengeLotteryMachineUIController:OnPause()
	return
end

function DramaChallengeLotteryMachineUIController:OnResume()
	return
end

function DramaChallengeLotteryMachineUIController:OnCover()
	return
end

function DramaChallengeLotteryMachineUIController:OnReveal()
	return
end

function DramaChallengeLotteryMachineUIController:OnRefocus(userData)
	return
end

function DramaChallengeLotteryMachineUIController:OnUpdate(elapseSeconds, realElapseSeconds)
	self.txtHelperComp:Update(elapseSeconds, realElapseSeconds)

	if self.enableCVTimer then
		if self.txtHelperComp:IsTypeFinished() then
			self.cvTimer = self.cvTimer + elapseSeconds
		end

		if self.cvTimer >= self.CV_SHOW_DURATION then
			self:HideCv()

			self.cvTimer = 0
		end
	end

	if self.enableCVTimer == false then
		self.Timer = self.Timer + elapseSeconds

		if self.Timer >= 30 then
			self.randomTextCid = self.randomTextCidList[math.random(#self.randomTextCidList)]

			self:ShowCV(self.randomTextCid)

			self.Timer = 0
		end
	end
end

function DramaChallengeLotteryMachineUIController:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function DramaChallengeLotteryMachineUIController:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function DramaChallengeLotteryMachineUIController:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function DramaChallengeLotteryMachineUIController:InitCurrencyModule()
	self.CurrencyControllers = {}

	self:AddCurrencyModule(self.PlotChallengeTable.ScoreID)
end

function DramaChallengeLotteryMachineUIController:AddCurrencyModule(currencyCid)
	local container = self.MoneyGrid.transform
	local currencyModule = UnityEngine.Object.Instantiate(self.MoneyGridItem)

	currencyModule.transform:SetParent(container, false)

	self.CurrencyControllers[#self.CurrencyControllers + 1] = CurrencyCell.New(currencyModule, currencyCid)
end

function DramaChallengeLotteryMachineUIController:Refresh()
	self.CurrentPrizeDrawPoolList = {}

	for i = 1, #PlotChallengeModule.PrizeDrawPoolRewardList do
		if PlotChallengeModule.PrizeDrawPoolRewardList[i].PrizeDrawPoolId == self.PrizeDrawPoolId then
			table.insert(self.CurrentPrizeDrawPoolList, PlotChallengeModule.PrizeDrawPoolRewardList[i])
		end
	end

	table.sort(self.CurrentPrizeDrawPoolList, function(a, b)
		if a.CurrentItemTime == b.CurrentItemTime then
			if a.ItemQuality == b.ItemQuality then
				return a.Id > b.Id
			end

			return a.ItemQuality > b.ItemQuality
		end

		return a.CurrentItemTime > b.CurrentItemTime
	end)
	self.scrollAreaList:Refresh(#self.CurrentPrizeDrawPoolList)
	self:RefreshTotalityAndRemainder(self.PrizeDrawPoolId)

	self.PrizeDrawOnePriceText.text = DramChallengeLotteryUIApi:GetString("PeizeDrawPriceText", self.PlotChallengeTable.TicketNeedPower)
	self.DrawsNum = 10
	self.NationMoney = WarehouseModule.GetItemNumByCfgID(Constant.ItemID.NATION_MONEY, true)

	if self.CurrentPrizeDrawPoolNum < 10 and self.NationMoney > self.CurrentPrizeDrawPoolNum * self.PlotChallengeTable.TicketNeedPower then
		self.DrawsNum = self.CurrentPrizeDrawPoolNum
	elseif self.NationMoney < self.PlotChallengeTable.TicketNeedPower * 10 then
		self.DrawsNum = math.floor(self.NationMoney / self.PlotChallengeTable.TicketNeedPower)
	end

	self.PrizeDrawMorePriceText.text = DramChallengeLotteryUIApi:GetString("PeizeDrawPriceText", self.DrawsNum * self.PlotChallengeTable.TicketNeedPower)
	self.PrizeDrawMoreText.text = DramChallengeLotteryUIApi:GetString("PeizeDrawMoreBtnText", self.DrawsNum)

	self.PrizeDrawOneBtn.gameObject:SetActive(self.PrizeDrawPoolId == PlotChallengeModule.GetCurrentPrizeDrawPoolId())
	self.PrizeDrawMoreBtn.gameObject:SetActive(self.PrizeDrawPoolId == PlotChallengeModule.GetCurrentPrizeDrawPoolId() and self.NationMoney >= 50 and self.CurrentPrizeDrawPoolNum > 0)
end

function DramaChallengeLotteryMachineUIController:RefreshTotalityAndRemainder(PoolId)
	self.PrizeDrawPoolNum = PlotChallengeModule.GetItemsNum(PoolId)
	self.CurrentPrizeDrawPoolNum = PlotChallengeModule.GetItemsNum(PoolId) - PlotChallengeModule.GetCurrentItemsNum(PoolId)
	self.TotalityAndRemainderText.text = DramChallengeLotteryUIApi:GetString("TotalityAndRemainderText", self.CurrentPrizeDrawPoolNum, self.PrizeDrawPoolNum)
end

function DramaChallengeLotteryMachineUIController:OnBtnPrizeDrawOne()
	self.PrizeDrawPoolId = PlotChallengeModule.GetCurrentPrizeDrawPoolId()

	PlotChallengeModule.Draw(self.PrizeDrawPoolId, 1)
end

function DramaChallengeLotteryMachineUIController:OnBtnPrizeDrawMore()
	self.PrizeDrawPoolId = PlotChallengeModule.GetCurrentPrizeDrawPoolId()

	PlotChallengeModule.Draw(self.PrizeDrawPoolId, self.DrawsNum)
end

function DramaChallengeLotteryMachineUIController:UpdateToggleValue(index)
	if index > 4 then
		index = 4
	end

	self.PrizeDrawToggles[index]:GetComponent("Toggle").isOn = true

	self:OnToggleValueChanged(index)
end

function DramaChallengeLotteryMachineUIController:OnToggleValueChanged(index)
	self.CurrentRewardCfg = PlotChallengeModule.GetCurrentItemsNumByToggle(index)
	self.PrizeDrawPoolId = index

	self:Refresh()
end

function DramaChallengeLotteryMachineUIController:OnBtnClose()
	UIModule.Close(Constant.UIControllerName.DramaChallengeLotteryMachineUI)
end

function DramaChallengeLotteryMachineUIController:OnRenderItemCell(cell)
	local itemData = self.CurrentPrizeDrawPoolList[cell.index + 1]
	local insID = cell.gameObject:GetInstanceID()
	local itemCell = self.ItemCells[insID]

	if itemCell == nil then
		itemCell = RewardItem.New(cell.gameObject)
		self.ItemCells[insID] = itemCell
	end

	cell.gameObject.name = cell.index + 1

	cell.gameObject:SetActive(true)
	itemCell:SetItem(itemData)
end

function DramaChallengeLotteryMachineUIController:OnSelectedItemCell(cell)
	return
end

function DramaChallengeLotteryMachineUIController:ShowCV(id)
	self.cvTimer = 0
	self.enableCVTimer = true
	self.enableCheckAnimEnd = false

	self.LinesBlack:SetActive(true)
	self.txtHelperComp:ResetGameObject(self.LinesText)

	local cfgCVData = CfgCVTable[id]

	self.CV_SHOW_DURATION = cfgCVData.TextTime

	if cfgCVData.Text ~= "" then
		local str = string.gsub(cfgCVData.Text, "{PlayerName}", PlayerModule.PlayerInfo.baseInfo.pName)

		self.txtHelperComp:Perform(self.LinesText, str)
	end
end

function DramaChallengeLotteryMachineUIController:HideCv()
	self.LinesBlack:SetActive(false)

	self.enableCVTimer = false
end

function DramaChallengeLotteryMachineUIController:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for i = 1, #self.CurrencyControllers do
		self.CurrencyControllers[i]:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.UIController = nil
end

return DramaChallengeLotteryMachineUIController
