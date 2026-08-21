-- chunkname: @IQIGame\\UI\\DualTeamExplore\\ActivityUI\\DualTeamExploreBagUIController.lua

require("IQIGame.UIExternalApi.DualTeamExploreBagUIApi")

local BagItemCell = require("IQIGame.UI.Bag.BagItemCell")
local DualTeamExploreBagUIController = {
	ItemCells = {}
}

function DualTeamExploreBagUIController.New(uiController)
	local obj = Clone(DualTeamExploreBagUIController)

	obj:__Init(uiController)

	return obj
end

function DualTeamExploreBagUIController:__Init(uiController)
	self.UIController = uiController
end

function DualTeamExploreBagUIController:InitView(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
end

function DualTeamExploreBagUIController:OnInit()
	function self.DelegateOnClickClose()
		self:OnClickClose()
	end

	function self.DelegateOnUpdateItem()
		self:OnUpdateItem()
	end

	local scrollAreaList = self.BagGroup:GetComponent("ScrollAreaList")

	function scrollAreaList.onRenderCell(cell)
		self:OnRenderItemCell(cell)
	end

	function scrollAreaList.onSelectedCell(cell)
		self:OnSelectItemCell(cell)
	end

	self.TitleText:GetComponent("Text").text = DualTeamExploreBagUIApi:GetString("TitleText")

	UGUIUtil.SetTextInChildren(self.EmptyView, DualTeamExploreBagUIApi:GetString("EmptyViewText"))
end

function DualTeamExploreBagUIController:GetPreloadAssetPaths()
	return nil
end

function DualTeamExploreBagUIController:GetOpenPreloadAssetPaths(userData)
	return nil
end

function DualTeamExploreBagUIController:IsManualShowOnOpen(userData)
	return false
end

function DualTeamExploreBagUIController:GetBGM(userData)
	return nil
end

function DualTeamExploreBagUIController:OnOpen(userData)
	self:UpdateView()
end

function DualTeamExploreBagUIController:OnClose(userData)
	return
end

function DualTeamExploreBagUIController:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickClose)
	self.CloseBtn1:GetComponent("Button").onClick:AddListener(self.DelegateOnClickClose)
	EventDispatcher.AddEventListener(EventID.UpdateItem, self.DelegateOnUpdateItem)
end

function DualTeamExploreBagUIController:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickClose)
	self.CloseBtn1:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickClose)
	EventDispatcher.RemoveEventListener(EventID.UpdateItem, self.DelegateOnUpdateItem)
end

function DualTeamExploreBagUIController:OnPause()
	return
end

function DualTeamExploreBagUIController:OnResume()
	return
end

function DualTeamExploreBagUIController:OnCover()
	return
end

function DualTeamExploreBagUIController:OnReveal()
	return
end

function DualTeamExploreBagUIController:OnRefocus(userData)
	return
end

function DualTeamExploreBagUIController:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function DualTeamExploreBagUIController:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function DualTeamExploreBagUIController:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function DualTeamExploreBagUIController:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function DualTeamExploreBagUIController:OnDestroy()
	for gameObject, itemCell in pairs(self.ItemCells) do
		itemCell:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.UIController = nil
end

function DualTeamExploreBagUIController:OnUpdateItem()
	self:UpdateView()
end

function DualTeamExploreBagUIController:UpdateView()
	self.ItemDataList = WarehouseModule.GetItemsByTab(Constant.ItemTab.DUAL_TEAM_EXPLORE, false)

	table.sort(self.ItemDataList, function(itemData1, itemData2)
		return itemData1:GetCfg().Id < itemData2:GetCfg().Id
	end)

	local wrapContent = self.BagGroup:GetComponent("ScrollAreaList")

	wrapContent:Refresh(#self.ItemDataList)
	self.EmptyView:SetActive(#self.ItemDataList == 0)
end

function DualTeamExploreBagUIController:OnRenderItemCell(cell)
	local itemData = self.ItemDataList[cell.index + 1]
	local itemCell = self.ItemCells[cell.gameObject]

	if itemCell == nil then
		itemCell = BagItemCell.New(cell.gameObject)
		self.ItemCells[cell.gameObject] = itemCell
	end

	itemCell:SetItem(itemData)
end

function DualTeamExploreBagUIController:OnSelectItemCell(cell)
	local itemData = self.ItemDataList[cell.index + 1]

	ItemModule.OpenTipByData(itemData, false, false)
end

function DualTeamExploreBagUIController:OnClickClose()
	UIModule.CloseSelf(self)
end

return DualTeamExploreBagUIController
