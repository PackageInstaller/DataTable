-- chunkname: @IQIGame\\UI\\JewelryDecomposeUI.lua

local JewelryDecomposeUI = {
	isEnough = true,
	jewelryAttrCells = {},
	itemCells = {}
}

JewelryDecomposeUI = Base:Extend("JewelryDecomposeUI", "IQIGame.Onigao.UI.JewelryDecomposeUI", JewelryDecomposeUI)

local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local JewelryAttrCell = require("IQIGame.UI.Jewelry.JewelryAttrCell")

function JewelryDecomposeUI:OnInit()
	function self.DelegateOnBtnSure()
		self:OnBtnSure()
	end

	function self.DelegateOnBtnCancel()
		self:OnBtnCancel()
	end

	function self.DelegateOnUpdateItem()
		self:OnUpdateItem()
	end

	self.jewelryItemCell = ItemCell.New(self.SelectItem, false)

	self.AttrMould:SetActive(false)

	self.jewelryAttrCellPool = UIObjectPool.New(4, function()
		return JewelryAttrCell.New(UnityEngine.Object.Instantiate(self.AttrMould))
	end, function(cell)
		cell:Dispose()
	end)

	self.CommonSlotMould:SetActive(false)

	self.itemCellPool = UIObjectPool.New(3, function()
		return ItemCell.New(UnityEngine.Object.Instantiate(self.CommonSlotMould))
	end, function(cell)
		local view = cell.ViewGo

		cell:Dispose()
		UnityEngine.Object.Destroy(view)
	end)
end

function JewelryDecomposeUI:GetPreloadAssetPaths()
	return nil
end

function JewelryDecomposeUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function JewelryDecomposeUI:IsManualShowOnOpen(userData)
	return false
end

function JewelryDecomposeUI:GetBGM(userData)
	return nil
end

function JewelryDecomposeUI:OnOpen(userData)
	self.itemData = userData.ItemData

	self:UpdateView()
end

function JewelryDecomposeUI:OnClose(userData)
	return
end

function JewelryDecomposeUI:OnAddListeners()
	self.goBtnSure:GetComponent("Button").onClick:AddListener(self.DelegateOnBtnSure)
	self.goBtnCancel:GetComponent("Button").onClick:AddListener(self.DelegateOnBtnCancel)
	EventDispatcher.AddEventListener(EventID.UpdateItem, self.DelegateOnUpdateItem)
end

function JewelryDecomposeUI:OnRemoveListeners()
	self.goBtnSure:GetComponent("Button").onClick:RemoveListener(self.DelegateOnBtnSure)
	self.goBtnCancel:GetComponent("Button").onClick:RemoveListener(self.DelegateOnBtnCancel)
	EventDispatcher.RemoveEventListener(EventID.UpdateItem, self.DelegateOnUpdateItem)
end

function JewelryDecomposeUI:OnPause()
	return
end

function JewelryDecomposeUI:OnResume()
	return
end

function JewelryDecomposeUI:OnCover()
	return
end

function JewelryDecomposeUI:OnReveal()
	return
end

function JewelryDecomposeUI:OnRefocus(userData)
	return
end

function JewelryDecomposeUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function JewelryDecomposeUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function JewelryDecomposeUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function JewelryDecomposeUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function JewelryDecomposeUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for i, v in pairs(self.jewelryAttrCells) do
		self.jewelryAttrCellPool:Release(v)
	end

	self.jewelryAttrCells = {}

	self.jewelryAttrCellPool:Dispose()

	self.jewelryAttrCellPool = nil

	for i, v in pairs(self.itemCells) do
		self.itemCellPool:Release(v)
	end

	self.itemCells = {}

	self.itemCellPool:Dispose()

	self.itemCellPool = nil
end

function JewelryDecomposeUI:OnUpdateItem()
	if self.itemData then
		self:UpdateView()
	end
end

function JewelryDecomposeUI:UpdateView()
	if self.itemData then
		local jewelryPabilityID = 0
		local Recycling = {}
		local RecyclingCost = {}
		local num = 1

		if self.itemData:GetCfg().Type == Constant.ItemType.Jewelry then
			num = WarehouseModule.GetItemNumByCfgID(self.itemData.cid)

			if num > 99 then
				num = 99
			end

			jewelryPabilityID = self.itemData:GetCfg().JewelryPabilityID
			Recycling = self.itemData:GetCfg().Recycling
			RecyclingCost = self.itemData:GetCfg().RecyclingCost

			self.jewelryItemCell:SetItemByCID(self.itemData.cid, num)
		elseif self.itemData:GetCfg().Type == Constant.ItemType.JewelryEquip then
			self.jewelryItemCell:SetItem(self.itemData)

			local cfgJewelryQualityData = self.itemData.jewelryData:GetJewelryQualityData()

			if cfgJewelryQualityData then
				jewelryPabilityID = cfgJewelryQualityData.JewelryPabilityID
				Recycling = cfgJewelryQualityData.Recycling
				RecyclingCost = cfgJewelryQualityData.RecyclingCost
			end
		end

		UGUIUtil.SetText(self.TextItemName, self.itemData:GetCfg().Name)

		for i, v in pairs(self.jewelryAttrCells) do
			v.View.transform:SetParent(self.UIController.transform, false)
			v.View:SetActive(false)
			self.jewelryAttrCellPool:Release(v)
		end

		self.jewelryAttrCells = {}

		if jewelryPabilityID > 0 then
			local cell = self.jewelryAttrCellPool:Obtain()

			cell.View:SetActive(true)
			cell.View.transform:SetParent(self.AttrGrid.transform, false)
			cell:SetData(jewelryPabilityID)
			table.insert(self.jewelryAttrCells, cell)
		end

		for i, v in pairs(self.itemCells) do
			v.ViewGo.transform:SetParent(self.UIController.transform, false)
			v.ViewGo:SetActive(false)
			self.itemCellPool:Release(v)
		end

		self.itemCells = {}

		for i = 1, #Recycling, 2 do
			local cid = Recycling[i]
			local num = Recycling[i + 1] * num
			local cell = self.itemCellPool:Obtain()

			cell.ViewGo:SetActive(true)
			cell.ViewGo.transform:SetParent(self.goGridParent.transform, false)
			cell:SetItemByCID(cid, num)
			table.insert(self.itemCells, cell)
		end

		self.isEnough = true

		self.MoneyNode:SetActive(false)

		if #RecyclingCost > 0 then
			self.MoneyNode:SetActive(true)

			local needCid = RecyclingCost[1]
			local needNum = RecyclingCost[2]
			local haveNum = WarehouseModule.GetItemNumByCfgID(needCid)

			self.isEnough = needNum <= haveNum

			local iconPath = MoneyGridApi:GetString("MoneyCellIconPath", needCid)

			if iconPath == "" then
				iconPath = UIGlobalApi.GetIconPath(CfgItemTable[needCid].Icon)
			end

			AssetUtil.LoadImage(self, iconPath, self.NeedItemIcon:GetComponent("Image"))
			UGUIUtil.SetText(self.NeedItemNum, needNum)
		end
	end
end

function JewelryDecomposeUI:OnBtnSure()
	if not self.isEnough then
		NoticeModule.ShowNotice(21040015)

		return
	end

	if self.itemData:GetCfg().Type == Constant.ItemType.JewelryEquip then
		JewelryModule.NewRecycle(self.itemData.id)
	elseif self.itemData:GetCfg().Type == Constant.ItemType.Jewelry then
		local num = WarehouseModule.GetItemNumByCfgID(self.itemData.cid)

		if num > 99 then
			num = 99
		end

		JewelryModule.Recycle(self.itemData.cid, num)
	end

	self:OnBtnCancel()
end

function JewelryDecomposeUI:OnBtnCancel()
	UIModule.CloseSelf(self)
end

return JewelryDecomposeUI
