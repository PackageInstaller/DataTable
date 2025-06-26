-- chunkname: @IQIGame\\UI\\BuyPassCheckLevelUI.lua

local BuyPassCheckLevelUI = Base:Extend("BuyPassCheckLevelUI", "IQIGame.Onigao.UI.BuyPassCheckLevelUI", {
	itemCellPool = {}
})

function BuyPassCheckLevelUI:OnInit()
	self:Initialize()
end

function BuyPassCheckLevelUI:GetPreloadAssetPaths()
	return nil
end

function BuyPassCheckLevelUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function BuyPassCheckLevelUI:IsManualShowOnOpen(userData)
	return false
end

function BuyPassCheckLevelUI:GetBGM(userData)
	return nil
end

function BuyPassCheckLevelUI:OnOpen(userData)
	self:Refresh(userData)
end

function BuyPassCheckLevelUI:OnClose(userData)
	self:OnHide()
end

function BuyPassCheckLevelUI:OnPause()
	return
end

function BuyPassCheckLevelUI:OnResume()
	return
end

function BuyPassCheckLevelUI:OnCover()
	return
end

function BuyPassCheckLevelUI:OnReveal()
	return
end

function BuyPassCheckLevelUI:OnRefocus(userData)
	return
end

function BuyPassCheckLevelUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function BuyPassCheckLevelUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function BuyPassCheckLevelUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function BuyPassCheckLevelUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function BuyPassCheckLevelUI:Initialize()
	self.rewardList = self.goRewardList:GetComponent("ScrollAreaList")

	function self.rewardList.onRenderCell(cell)
		self:OnRenderRewardCell(cell)
	end

	self.bar = self.goBar:GetComponent("Slider")
	self.tfLvCur = self.goLvCur:GetComponent("Text")
	self.tfLvTarget = self.goLvTarget:GetComponent("Text")
	self.tfCost = self.goBtnBuy.transform:Find("Text_Num"):GetComponent("Text")
	self.btnClose = self.goBtnClose:GetComponent("Button")
	self.btnClose2 = self.goBtnClose2:GetComponent("Button")
	self.btnMin = self.goBtnMin:GetComponent("Button")
	self.btnMax = self.goBtnMax:GetComponent("Button")
	self.btnAdd = self.goBtnAdd:GetComponent("Button")
	self.btnReduce = self.goBtnReduce:GetComponent("Button")
	self.btnBuy = self.goBtnBuy:GetComponent("Button")

	function self.onClickBtnCloseDelegate()
		self:OnClickBtnClose()
	end

	function self.onClickBtnMaxDelegate()
		self:OnClickBtnMax()
	end

	function self.onClickBtnMinDelegate()
		self:OnClickBtnMin()
	end

	function self.onClickBtnReduceDelegate()
		self:OnClickBtnReduce()
	end

	function self.onClickBtnAddDelegate()
		self:OnClickBtnAdd()
	end

	function self.onClickBtnBuyDelegate()
		self:OnClickBtnBuy()
	end

	function self.onValueChangedDelegate(value)
		self:OnProgressChange(value)
	end

	self.goTitle:GetComponent("Text").text = BuyPassCheckLevelUIApi:GetString("title")
	self.goDesc:GetComponent("Text").text = BuyPassCheckLevelUIApi:GetString("goDesc")
	self.goBtnBuy.transform:Find("Text_01"):GetComponent("Text").text = BuyPassCheckLevelUIApi:GetString("btnBuyTxt")
end

function BuyPassCheckLevelUI:Refresh(userData)
	self.cfgMallData = CfgMallTable[userData]
	self.minLv = PassCheckModule.lv + 1
	self.maxLv = PassCheckModule.maxLv
	self.selectLv = self.minLv
	self.bar.value = self.selectLv

	self:RefreshMisc()
	self:RefreshOnLv()
end

function BuyPassCheckLevelUI:OnHide()
	return
end

function BuyPassCheckLevelUI:OnDestroy()
	for i, v in pairs(self.itemCellPool) do
		v:Dispose()
	end
end

function BuyPassCheckLevelUI:OnAddListeners()
	self.btnClose.onClick:AddListener(self.onClickBtnCloseDelegate)
	self.btnClose2.onClick:AddListener(self.onClickBtnCloseDelegate)
	self.btnAdd.onClick:AddListener(self.onClickBtnAddDelegate)
	self.btnReduce.onClick:AddListener(self.onClickBtnReduceDelegate)
	self.btnMin.onClick:AddListener(self.onClickBtnMinDelegate)
	self.btnMax.onClick:AddListener(self.onClickBtnMaxDelegate)
	self.btnBuy.onClick:AddListener(self.onClickBtnBuyDelegate)
	self.bar.onValueChanged:AddListener(self.onValueChangedDelegate)
end

function BuyPassCheckLevelUI:OnRemoveListeners()
	self.btnClose.onClick:RemoveListener(self.onClickBtnCloseDelegate)
	self.btnClose2.onClick:RemoveListener(self.onClickBtnCloseDelegate)
	self.btnAdd.onClick:RemoveListener(self.onClickBtnAddDelegate)
	self.btnReduce.onClick:RemoveListener(self.onClickBtnReduceDelegate)
	self.btnMin.onClick:RemoveListener(self.onClickBtnMinDelegate)
	self.btnMax.onClick:RemoveListener(self.onClickBtnMaxDelegate)
	self.btnBuy.onClick:RemoveListener(self.onClickBtnBuyDelegate)
	self.bar.onValueChanged:RemoveListener(self.onValueChangedDelegate)
end

function BuyPassCheckLevelUI:OnClickBtnClose()
	UIModule.CloseSelf(self)
end

function BuyPassCheckLevelUI:OnClickBtnBuy()
	local costCount = self.selectLv - PassCheckModule.lv

	if self.cfgMallData.Price[2] * costCount > WarehouseModule.GetItemNumByCfgID(self.cfgMallData.Price[1]) then
		NoticeModule.MoneyDeficitTip(1, self.cfgMallData.Price[2] * costCount - WarehouseModule.GetItemNumByCfgID(self.cfgMallData.Price[1]))

		return
	end

	MallModule.BuyGoods(self.cfgMallData.Id, costCount)
	self:OnClickBtnClose()
end

function BuyPassCheckLevelUI:OnClickBtnMin()
	self.selectLv = self.minLv
	self.bar.value = self.selectLv

	self:RefreshOnLv()
end

function BuyPassCheckLevelUI:OnClickBtnMax()
	self.selectLv = self.maxLv
	self.bar.value = self.selectLv

	self:RefreshOnLv()
end

function BuyPassCheckLevelUI:OnClickBtnAdd()
	self.selectLv = self.selectLv + 1
	self.selectLv = math.min(self.selectLv, self.maxLv)
	self.bar.value = self.selectLv

	self:RefreshOnLv()
end

function BuyPassCheckLevelUI:OnClickBtnReduce()
	self.selectLv = self.selectLv - 1
	self.selectLv = math.max(self.selectLv, self.minLv)
	self.bar.value = self.selectLv

	self:RefreshOnLv()
end

function BuyPassCheckLevelUI:OnProgressChange(value)
	self.selectLv = value

	self:RefreshOnLv()
end

function BuyPassCheckLevelUI:OnRenderRewardCell(cell)
	local luaIndex = cell.index + 1
	local insID = cell.gameObject:GetInstanceID()
	local data = self.rewardDatum[luaIndex]
	local itemCell = self.itemCellPool[insID]

	if itemCell == nil then
		itemCell = ItemCell.PackageOrReuseView(self, cell.gameObject.transform:Find("Slot/CommonSlotUI").gameObject, true, true)
		self.itemCellPool[insID] = itemCell
	end

	itemCell:SetItemByCID(data[1], data[2])
end

function BuyPassCheckLevelUI:RefreshMisc()
	self.tfLvCur.text = BuyPassCheckLevelUIApi:GetString("goLvCur", PassCheckModule.lv)
	self.bar.minValue = self.minLv
	self.bar.maxValue = self.maxLv
end

function BuyPassCheckLevelUI:RefreshOnLv()
	local costCount = self.selectLv - PassCheckModule.lv

	self.tfLvTarget.text = BuyPassCheckLevelUIApi:GetString("goLvTarget", self.selectLv)
	self.tfCost.text = BuyPassCheckLevelUIApi:GetString("cost", WarehouseModule.GetItemNumByCfgID(self.cfgMallData.Price[1]), self.cfgMallData.Price[2] * costCount)

	if PassCheckModule.CheckGotSuperPass() then
		self.rewardDatum = PassCheckModule.GetRewardDatum(3, self.minLv, self.selectLv)
	else
		self.rewardDatum = PassCheckModule.GetRewardDatum(1, self.minLv, self.selectLv)
	end

	self.rewardList:Refresh(#self.rewardDatum)
end

return BuyPassCheckLevelUI
