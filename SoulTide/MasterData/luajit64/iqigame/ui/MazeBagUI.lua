-- chunkname: @IQIGame\\UI\\MazeBagUI.lua

local MazeBagUI = Base:Extend("MazeBagUI", "IQIGame.Onigao.UI.MazeBagUI", {
	ItemCells = {}
})
local BagItemCell = require("IQIGame.UI.Bag.BagItemCell")

function MazeBagUI:OnInit()
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

	self.TitleText:GetComponent("Text").text = MazeBagUIApi:GetString("TitleText")

	UGUIUtil.SetTextInChildren(self.EmptyView, MazeBagUIApi:GetString("EmptyViewText"))
end

function MazeBagUI:GetPreloadAssetPaths()
	return nil
end

function MazeBagUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function MazeBagUI:OnOpen(userData)
	self:UpdateView()
end

function MazeBagUI:OnClose(userData)
	return
end

function MazeBagUI:OnPause()
	return
end

function MazeBagUI:OnResume()
	return
end

function MazeBagUI:OnCover()
	return
end

function MazeBagUI:OnReveal()
	return
end

function MazeBagUI:OnRefocus(userData)
	return
end

function MazeBagUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function MazeBagUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MazeBagUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MazeBagUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MazeBagUI:OnDestroy()
	for gameObject, itemCell in pairs(self.ItemCells) do
		itemCell:Dispose()
	end

	self.ItemCells = nil
end

function MazeBagUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickClose)
	self.CloseBtn1:GetComponent("Button").onClick:AddListener(self.DelegateOnClickClose)
	EventDispatcher.AddEventListener(EventID.MazeUpdateItem, self.DelegateOnUpdateItem)
end

function MazeBagUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickClose)
	self.CloseBtn1:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickClose)
	EventDispatcher.RemoveEventListener(EventID.MazeUpdateItem, self.DelegateOnUpdateItem)
end

function MazeBagUI:OnUpdateItem(arg)
	self:UpdateView()
end

function MazeBagUI:UpdateView()
	self.ItemDataList = self:FilterNotShow(MazeDataModule.GetAllItems(0))

	table.sort(self.ItemDataList, function(itemData1, itemData2)
		return itemData1:GetCfg().Sort < itemData2:GetCfg().Sort
	end)

	local wrapContent = self.BagGroup:GetComponent("ScrollAreaList")

	wrapContent:Refresh(#self.ItemDataList)
	self.EmptyView:SetActive(#self.ItemDataList == 0)
end

function MazeBagUI:FilterNotShow(items)
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

function MazeBagUI:OnRenderItemCell(cell)
	local itemData = self.ItemDataList[cell.index + 1]
	local itemCell = self.ItemCells[cell.gameObject]

	if itemCell == nil then
		itemCell = BagItemCell.New(cell.gameObject)
		self.ItemCells[cell.gameObject] = itemCell
	end

	itemCell:SetItem(itemData)
end

function MazeBagUI:OnSelectItemCell(cell)
	local itemData = self.ItemDataList[cell.index + 1]

	ItemModule.OpenTipByData(itemData, false, false)
end

function MazeBagUI:OnClickClose()
	UIModule.CloseSelf(self)
end

return MazeBagUI
