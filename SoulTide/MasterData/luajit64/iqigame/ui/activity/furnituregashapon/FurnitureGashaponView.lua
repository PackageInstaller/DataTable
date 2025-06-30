-- chunkname: @IQIGame\\UI\\Activity\\FurnitureGashapon\\FurnitureGashaponView.lua

local FurnitureGashaponView = {}

function FurnitureGashaponView.New(view, eventID)
	local obj = Clone(FurnitureGashaponView)

	obj:Init(view, eventID)

	return obj
end

function FurnitureGashaponView:Init(view, eventID)
	self.View = view
	self.eventID = eventID

	local operationEventDataPOD = ActiveOperationEventModule.GetEventDataPOD(self.eventID)

	self.cfgFurnitureLotteryData = CfgFurnitureActivityLotteryGlobalTable[operationEventDataPOD.dataCfgId]

	LuaCodeInterface.BindOutlet(self.View, self)

	self.tfTime = self.goTime:GetComponent("Text")
	self.tfCostBuy = self.goBtnBuy.transform:Find("Item/Text_01"):GetComponent("Text")
	self.tfCostBatchBuy = self.goBtnBatchBuy.transform:Find("Item/Num/Text_02"):GetComponent("Text")
	self.btnLotteryPool = self.goBtnLotteryPool:GetComponent("Button")
	self.btnTheme_1 = self.goBtnTheme_1:GetComponent("Button")
	self.btnTheme_2 = self.goBtnTheme_2:GetComponent("Button")
	self.btnBuy = self.goBtnBuy:GetComponent("Button")
	self.btnBatchBuy = self.goBtnBatchBuy:GetComponent("Button")

	function self.onClickBtnLotteryPoolDelegate()
		self:OnClickBtnLotteryPool()
	end

	function self.onClickBtnTheme_1Delegate()
		self:OnClickBtnTheme_1()
	end

	function self.onClickBtnTheme_2Delegate()
		self:OnClickBtnTheme_2()
	end

	function self.onClickBtnBuyDelegate()
		self:OnClickBtnBuy()
	end

	function self.onClickBtnBatchBuyDelegate()
		self:OnClickBtnBatchBuy()
	end

	function self.onUpdateOperationsDelegate()
		self:OnUpdateOperations()
	end

	self.goEffectRoot:GetComponent("SortedComponentOrder").UIRootCanvas = self.View:GetComponentInParent(typeof(UnityEngine.Canvas))
	self.goDesc:GetComponent("Text").text = ActivityUIApi:GetString("furGashViewDesc")
	self.goBtnLotteryPool.transform:Find("Text"):GetComponent("Text").text = ActivityUIApi:GetString("furGashViewBtnLotteryPoolTxt")
	self.goBtnTheme_1.transform:Find("Text"):GetComponent("Text").text = ActivityUIApi:GetString("furGashViewBtnTheme_1")
	self.goBtnTheme_2.transform:Find("Text"):GetComponent("Text").text = ActivityUIApi:GetString("furGashViewBtnTheme_2")
	self.goBtnBuy.transform:Find("Text"):GetComponent("Text").text = ActivityUIApi:GetString("furGashViewBtnBuyTxt")
	self.goBtnBatchBuy.transform:Find("Text"):GetComponent("Text").text = ActivityUIApi:GetString("furGashViewBtnBatchBuyTxt")
end

function FurnitureGashaponView:Open()
	self.View:SetActive(true)
	self:OnAddListener()
	self:RefreshMisc()
end

function FurnitureGashaponView:Close()
	self:OnHide()
	self.View:SetActive(false)
end

function FurnitureGashaponView:OnHide()
	self:OnRemoveListener()
end

function FurnitureGashaponView:OnDestroy()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function FurnitureGashaponView:OnAddListener()
	self:OnRemoveListener()
	self.btnLotteryPool.onClick:AddListener(self.onClickBtnLotteryPoolDelegate)
	self.btnBatchBuy.onClick:AddListener(self.onClickBtnBatchBuyDelegate)
	self.btnBuy.onClick:AddListener(self.onClickBtnBuyDelegate)
	self.btnTheme_1.onClick:AddListener(self.onClickBtnTheme_1Delegate)
	self.btnTheme_2.onClick:AddListener(self.onClickBtnTheme_2Delegate)
	EventDispatcher.AddEventListener(EventID.UpdateOperationsEvent, self.onUpdateOperationsDelegate)
end

function FurnitureGashaponView:OnRemoveListener()
	self.btnLotteryPool.onClick:RemoveListener(self.onClickBtnLotteryPoolDelegate)
	self.btnBatchBuy.onClick:RemoveListener(self.onClickBtnBatchBuyDelegate)
	self.btnBuy.onClick:RemoveListener(self.onClickBtnBuyDelegate)
	self.btnTheme_1.onClick:RemoveListener(self.onClickBtnTheme_1Delegate)
	self.btnTheme_2.onClick:RemoveListener(self.onClickBtnTheme_2Delegate)
	EventDispatcher.RemoveEventListener(EventID.UpdateOperationsEvent, self.onUpdateOperationsDelegate)
end

function FurnitureGashaponView:OnClickBtnLotteryPool()
	UIModule.Open(Constant.UIControllerName.GashaponHistoryListUI, Constant.UILayer.UI, self.cfgFurnitureLotteryData.Id)
end

function FurnitureGashaponView:OnClickBtnTheme_1()
	self:ShowTheme(1)
end

function FurnitureGashaponView:OnClickBtnTheme_2()
	self:ShowTheme(2)
end

function FurnitureGashaponView:OnClickBtnBuy()
	if self:CheckCanBuy(1) then
		FurnitureGashaponModule.ReqDraw(self.eventID, 1)
	end
end

function FurnitureGashaponView:OnClickBtnBatchBuy()
	if self:CheckCanBuy(2) then
		FurnitureGashaponModule.ReqDraw(self.eventID, 2)
	end
end

function FurnitureGashaponView:OnUpdateOperations()
	if not ActiveOperationEventModule.CheckIsOpen(self.eventID) then
		self:RefreshMisc()
	end
end

function FurnitureGashaponView:RefreshMisc()
	self.eventPOD = ActiveOperationEventModule.GetActiveOperationData(self.eventID)

	local startTime = getCustomDateTimeText(self.eventPOD.startTime, "MonthToMinuteFormat")
	local endTime = getCustomDateTimeText(self.eventPOD.endTime, "MonthToMinuteFormat")

	UGUIUtil.SetText(self.goTime, ActivityUIApi:GetString("furGashView", startTime, endTime))

	self.tfCostBuy.text = ActivityUIApi:GetString("furGashViewBuyCount", 1, WarehouseModule.GetItemNumByCfgID(self.cfgFurnitureLotteryData.Cost1[1]))
	self.tfCostBatchBuy.text = ActivityUIApi:GetString("furGashViewBatchBuyCount", 10, WarehouseModule.GetItemNumByCfgID(self.cfgFurnitureLotteryData.Cost10[1]))
end

function FurnitureGashaponView:ShowTheme(index)
	local cfgTheme = CfgHomeLandDecorateThemeTable[ActivityUIApi:GetString("furGashViewThemeCid", index)]
	local path = UIGlobalApi.GetImagePath(cfgTheme.Preview)

	UIModule.Open(Constant.UIControllerName.HomeLandCgShowUI, Constant.UILayer.UI, {
		path,
		Vector3.New(0, 0, 0)
	})
end

function FurnitureGashaponView:CheckCanBuy(type)
	if FurnitureGashaponModule.gachaCount > self.cfgFurnitureLotteryData.MaxTimes then
		NoticeModule.ShowNotice(21045035)

		return false
	end

	local maxFurnitureCount = 0

	for i, v in pairsCfg(CfgFurnitureRewardListTable) do
		if v.Team == self.cfgFurnitureLotteryData.Id then
			maxFurnitureCount = maxFurnitureCount + 1
		end
	end

	if type == 1 then
		if maxFurnitureCount < #FurnitureGashaponModule.gachaIdList + 1 then
			NoticeModule.ShowNotice(21045035)

			return false
		end
	elseif type == 2 and maxFurnitureCount < #FurnitureGashaponModule.gachaIdList + 10 then
		NoticeModule.ShowNotice(21045035)

		return false
	end

	if type == 1 and WarehouseModule.GetItemNumByCfgID(self.cfgFurnitureLotteryData.Cost1[1]) < self.cfgFurnitureLotteryData.Cost1[2] then
		for i, v in pairsCfg(CfgMallTable) do
			if #v.Item == 1 and v.Item[1] == self.cfgFurnitureLotteryData.Cost1[1] then
				UIModule.Open(Constant.UIControllerName.BuyPanelUI, Constant.UILayer.UI, {
					type = 1,
					mallCid = v.Id,
					num = self.cfgFurnitureLotteryData.Cost1[2] - WarehouseModule.GetItemNumByCfgID(self.cfgFurnitureLotteryData.Cost1[1])
				})

				break
			end
		end

		return false
	end

	if type == 2 and WarehouseModule.GetItemNumByCfgID(self.cfgFurnitureLotteryData.Cost10[1]) < self.cfgFurnitureLotteryData.Cost10[2] then
		for i, v in pairsCfg(CfgMallTable) do
			if #v.Item == 1 and v.Item[1] == self.cfgFurnitureLotteryData.Cost10[1] then
				UIModule.Open(Constant.UIControllerName.BuyPanelUI, Constant.UILayer.UI, {
					type = 1,
					mallCid = v.Id,
					num = self.cfgFurnitureLotteryData.Cost10[2] - WarehouseModule.GetItemNumByCfgID(self.cfgFurnitureLotteryData.Cost10[1])
				})

				break
			end
		end

		return false
	end

	return true
end

return FurnitureGashaponView
