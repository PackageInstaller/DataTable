-- chunkname: @IQIGame\\UI\\HorizontalRPGMazeBagUI.lua

local HorizontalRPGMazeBagUI = {
	ItemCells = {}
}

HorizontalRPGMazeBagUI = Base:Extend("HorizontalRPGMazeBagUI", "IQIGame.Onigao.UI.HorizontalRPGMazeBagUI", HorizontalRPGMazeBagUI)

require("IQIGame.UIExternalApi.HorizontalRPGMazeBagUIApi")

local BagItemCell = require("IQIGame.UI.Bag.BagItemCell")

function HorizontalRPGMazeBagUI:OnInit()
	function self.DelegateOnClickClose()
		self:OnClickClose()
	end

	function self.DelegateOnUpdateItem(arg)
		self:OnUpdateItem(arg)
	end

	local scrollAreaList = self.BagGroup:GetComponent("ScrollAreaList")

	function scrollAreaList.onRenderCell(cell)
		self:OnRenderItemCell(cell)
	end

	function scrollAreaList.onSelectedCell(cell)
		self:OnSelectItemCell(cell)
	end

	self.TitleText:GetComponent("Text").text = HorizontalRPGMazeBagUIApi:GetString("TitleText")

	UGUIUtil.SetTextInChildren(self.EmptyView, HorizontalRPGMazeBagUIApi:GetString("EmptyViewText"))
end

function HorizontalRPGMazeBagUI:GetPreloadAssetPaths()
	return nil
end

function HorizontalRPGMazeBagUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function HorizontalRPGMazeBagUI:IsManualShowOnOpen(userData)
	return false
end

function HorizontalRPGMazeBagUI:GetBGM(userData)
	return nil
end

function HorizontalRPGMazeBagUI:OnOpen(userData)
	self:UpdateView()
end

function HorizontalRPGMazeBagUI:OnClose(userData)
	return
end

function HorizontalRPGMazeBagUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickClose)
	self.CloseBtn1:GetComponent("Button").onClick:AddListener(self.DelegateOnClickClose)
	EventDispatcher.AddEventListener(EventID.UpdateItem, self.DelegateOnUpdateItem)
end

function HorizontalRPGMazeBagUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickClose)
	self.CloseBtn1:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickClose)
	EventDispatcher.RemoveEventListener(EventID.UpdateItem, self.DelegateOnUpdateItem)
end

function HorizontalRPGMazeBagUI:OnPause()
	return
end

function HorizontalRPGMazeBagUI:OnResume()
	return
end

function HorizontalRPGMazeBagUI:OnCover()
	return
end

function HorizontalRPGMazeBagUI:OnReveal()
	return
end

function HorizontalRPGMazeBagUI:OnRefocus(userData)
	return
end

function HorizontalRPGMazeBagUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function HorizontalRPGMazeBagUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function HorizontalRPGMazeBagUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function HorizontalRPGMazeBagUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function HorizontalRPGMazeBagUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for gameObject, itemCell in pairs(self.ItemCells) do
		itemCell:Dispose()
	end

	self.ItemCells = nil
end

function HorizontalRPGMazeBagUI:OnUpdateItem(arg)
	self:UpdateView()
end

function HorizontalRPGMazeBagUI:UpdateView()
	self.ItemDataList = self:FilterNotShow(WarehouseModule.GetItemsByTypeAndSubType(Constant.ItemType.Item, 102))

	table.sort(self.ItemDataList, function(itemData1, itemData2)
		return itemData1:GetCfg().Sort < itemData2:GetCfg().Sort
	end)

	local wrapContent = self.BagGroup:GetComponent("ScrollAreaList")

	wrapContent:Refresh(#self.ItemDataList)
	self.EmptyView:SetActive(#self.ItemDataList == 0)
end

function HorizontalRPGMazeBagUI:FilterNotShow(items)
	local result = {}

	for i = 1, #items do
		local itemData = items[i]
		local cfgItemData = itemData:GetCfg()

		if cfgItemData.IsBagShow then
			table.insert(result, itemData)
		end
	end

	return result
end

function HorizontalRPGMazeBagUI:OnRenderItemCell(cell)
	local itemData = self.ItemDataList[cell.index + 1]
	local itemCell = self.ItemCells[cell.gameObject]

	if itemCell == nil then
		itemCell = BagItemCell.New(cell.gameObject)
		self.ItemCells[cell.gameObject] = itemCell
	end

	itemCell:SetItem(itemData)
end

function HorizontalRPGMazeBagUI:OnSelectItemCell(cell)
	local itemData = self.ItemDataList[cell.index + 1]

	ItemModule.OpenTipByData(itemData, false, false)
end

function HorizontalRPGMazeBagUI:OnClickClose()
	UIModule.CloseSelf(self)
end

return HorizontalRPGMazeBagUI
