-- chunkname: @IQIGame\\UI\\MonsterAcademyBagUI.lua

local MonsterAcademyBagUI = {
	ItemCells = {},
	monsterAcademyMoneyTicketPool = {}
}

MonsterAcademyBagUI = Base:Extend("MonsterAcademyBagUI", "IQIGame.Onigao.UI.MonsterAcademyBagUI", MonsterAcademyBagUI)

require("IQIGame.UIExternalApi.MonsterAcademyBagUIApi")

local MonsterAcademyMoneyTicketCell = require("IQIGame.UI.ExploreHall.MonsterAcademy.MonsterAcademyBag.MonsterAcademyMoneyTicketCell")
local MonsterAcademyBagItemCell = require("IQIGame.UI.ExploreHall.MonsterAcademy.MonsterAcademyBag.MonsterAcademyBagItemCell")

function MonsterAcademyBagUI:OnInit()
	UGUIUtil.SetText(self.TitleText, MonsterAcademyBagUIApi:GetString("TitleText"))
	UGUIUtil.SetTextInChildren(self.EmptyView, MonsterAcademyBagUIApi:GetString("EmptyViewText"))
	UGUIUtil.SetTextInChildren(self.BtnUse, MonsterAcademyBagUIApi:GetString("BtnUseLabel"))

	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnUpdateItemEvent()
		self:OnUpdateItemEvent()
	end

	function self.DelegateBtnUse()
		self:OnBtnUse()
	end

	self:InitCurrencyModule()

	local scrollAreaList = self.BagGrid:GetComponent("ScrollAreaList")

	function scrollAreaList.onRenderCell(cell)
		self:OnRenderItemCell(cell)
	end

	function scrollAreaList.onSelectedCell(cell)
		self:OnSelectedItemCell(cell)
	end
end

function MonsterAcademyBagUI:GetPreloadAssetPaths()
	return {
		AssetPath.Get(GlobalKey.UIPrefabPath, "Common/MoneyGrid_Mould")
	}
end

function MonsterAcademyBagUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function MonsterAcademyBagUI:IsManualShowOnOpen(userData)
	return false
end

function MonsterAcademyBagUI:GetBGM(userData)
	return nil
end

function MonsterAcademyBagUI:OnOpen(userData)
	self:UpdateView()
end

function MonsterAcademyBagUI:OnClose(userData)
	return
end

function MonsterAcademyBagUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.BtnUse:GetComponent("Button").onClick:AddListener(self.DelegateBtnUse)
	EventDispatcher.AddEventListener(EventID.MonsterAcademyUpdateItemEvent, self.DelegateOnUpdateItemEvent)
end

function MonsterAcademyBagUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.BtnUse:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnUse)
	EventDispatcher.RemoveEventListener(EventID.MonsterAcademyUpdateItemEvent, self.DelegateOnUpdateItemEvent)
end

function MonsterAcademyBagUI:OnPause()
	return
end

function MonsterAcademyBagUI:OnResume()
	return
end

function MonsterAcademyBagUI:OnCover()
	return
end

function MonsterAcademyBagUI:OnReveal()
	return
end

function MonsterAcademyBagUI:OnRefocus(userData)
	return
end

function MonsterAcademyBagUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function MonsterAcademyBagUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MonsterAcademyBagUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MonsterAcademyBagUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MonsterAcademyBagUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for gameObject, itemCell in pairs(self.ItemCells) do
		itemCell:Dispose()
	end

	self.ItemCells = {}

	for i, v in pairs(self.monsterAcademyMoneyTicketPool) do
		v:Dispose()
	end
end

function MonsterAcademyBagUI:InitCurrencyModule()
	self.TicketGo:SetActive(false)

	self.monsterAcademyMoneyTicketPool = {}

	local cfgGalGameMonsterGlobalData = CfgGalgameMonsterActivityGlobalTable[MonsterAcademyModule.GlobalCid]

	if cfgGalGameMonsterGlobalData.Money > 0 then
		local cell1 = MonsterAcademyMoneyTicketCell.New(UnityEngine.Object.Instantiate(self.TicketGo))

		cell1:SetData(cfgGalGameMonsterGlobalData.Money)
		cell1.View.transform:SetParent(self.MoneyTicketRoot.transform, false)
		cell1.View:SetActive(true)

		self.monsterAcademyMoneyTicketPool[cfgGalGameMonsterGlobalData.Money] = cell1
	end

	if cfgGalGameMonsterGlobalData.Power > 0 then
		local cell2 = MonsterAcademyMoneyTicketCell.New(UnityEngine.Object.Instantiate(self.TicketGo))

		cell2:SetData(cfgGalGameMonsterGlobalData.Power)
		cell2.View.transform:SetParent(self.MoneyTicketRoot.transform, false)
		cell2.View:SetActive(true)

		self.monsterAcademyMoneyTicketPool[cfgGalGameMonsterGlobalData.Power] = cell2
	end
end

function MonsterAcademyBagUI:UpdateView(onlyUpdateData)
	self.ItemDataList = {}

	local allItems = MonsterAcademyModule.GetAllItems()

	for i, v in pairs(allItems) do
		if v.cfgInfo.Type ~= MonsterAcademyConstant.ItemType.ItemType_currency then
			table.insert(self.ItemDataList, v)

			if self.selectItemData and self.selectItemData.cfgID == v.cfgID then
				self.selectItemData = v
			end
		end
	end

	table.sort(self.ItemDataList, function(a, b)
		return a.cfgInfo.Id < b.cfgInfo.Id
	end)

	local dataLength = #self.ItemDataList
	local scrollAreaList = self.BagGrid:GetComponent("ScrollAreaList")

	if onlyUpdateData then
		local selectIndex = -1

		if dataLength > 0 and self.selectItemData then
			for i = 1, dataLength do
				local itemData = self.ItemDataList[i]

				if itemData.cfgID == self.selectItemData.cfgID then
					selectIndex = i
				end
			end
		end

		local finalSelectIndex = selectIndex

		if finalSelectIndex == -1 then
			finalSelectIndex = 1
		end

		scrollAreaList.defaultSelectedToggle = finalSelectIndex - 1

		scrollAreaList:RenderCellsDynamic(dataLength)
	else
		scrollAreaList.defaultSelectedToggle = 0

		scrollAreaList:Refresh(dataLength)
	end

	self.EmptyView:SetActive(dataLength == 0)
	self.Content:SetActive(dataLength > 0)

	if self.selectItemData == nil and dataLength > 0 then
		self.selectItemData = self.ItemDataList[1]
	end

	if self.selectItemData then
		UGUIUtil.SetText(self.ItemNum, MonsterAcademyBagUIApi:GetString("ItemNum", self.selectItemData.num))
	end
end

function MonsterAcademyBagUI:OnRenderItemCell(cell)
	local itemData = self.ItemDataList[cell.index + 1]
	local instance = cell.gameObject:GetInstanceID()
	local itemCell = self.ItemCells[instance]

	if itemCell == nil then
		itemCell = MonsterAcademyBagItemCell.New(cell.gameObject)
		self.ItemCells[instance] = itemCell
	end

	itemCell:SetData(itemData)
end

function MonsterAcademyBagUI:OnSelectedItemCell(cell)
	self:ShowTipView(cell.index + 1)
end

function MonsterAcademyBagUI:ShowTipView(itemIndex)
	self.Content:SetActive(true)

	self.selectItemData = self.ItemDataList[itemIndex]

	local path = UIGlobalApi.GetImagePath(self.selectItemData.cfgInfo.Icon)

	AssetUtil.LoadImage(self, path, self.ItemIcon:GetComponent("Image"))
	UGUIUtil.SetText(self.TextName, self.selectItemData.cfgInfo.Name)
	UGUIUtil.SetText(self.ItemDes, self.selectItemData.cfgInfo.Describe)
	UGUIUtil.SetText(self.ItemNum, MonsterAcademyBagUIApi:GetString("ItemNum", self.selectItemData.num))
end

function MonsterAcademyBagUI:OnBtnUse()
	if self.selectItemData == nil then
		return
	end

	MonsterAcademyModule.ItemUse(self.selectItemData.cfgID, 1)
end

function MonsterAcademyBagUI:OnUpdateItemEvent()
	self:UpdateView(true)
end

function MonsterAcademyBagUI:OnClickCloseBtn()
	UIModule.Close(Constant.UIControllerName.MonsterAcademyBagUI)
end

return MonsterAcademyBagUI
