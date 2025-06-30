-- chunkname: @IQIGame\\UI\\MazeSubmitItemUI.lua

local MazeSubmitItemUI = Base:Extend("MazeSubmitItemUI", "IQIGame.Onigao.UI.MazeSubmitItemUI", {
	RequireItemCells = {},
	OptionItemCells = {}
})
local MazeSubmitItemRequireCell = require("IQIGame.UI.MazeSubmitItem.MazeSubmitItemRequireCell")
local MazeSubmitItemOptionCell = require("IQIGame.UI.MazeSubmitItem.MazeSubmitItemOptionCell")

function MazeSubmitItemUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnClickSubmitBtn()
		self:OnClickSubmitBtn()
	end

	function self.DelegateOnClickSelectBtn()
		self:OnClickSelectBtn()
	end

	for i = 1, 3 do
		local view = UnityEngine.Object.Instantiate(self.RequireItemPrefab)

		view.transform:SetParent(self.RequireItemGroup.transform, false)

		local cell = MazeSubmitItemRequireCell.New(view, function(cell)
			self:OnClickRequireItem(cell)
		end)

		table.insert(self.RequireItemCells, cell)
	end

	local scrollAreaList = self.OptionListGrid:GetComponent("ScrollAreaList")

	function scrollAreaList.onRenderCell(cell)
		self:OnRenderCell(cell)
	end

	function scrollAreaList.onSelectedCell(cell)
		self:OnSelectCell(cell)
	end

	self.OptionListPanel:SetActive(false)
	UGUIUtil.SetTextInChildren(self.CloseBtn, MazeSubmitItemUIApi:GetString("CloseBtnText"))
	UGUIUtil.SetText(self.SubmitBtnTipText, MazeSubmitItemUIApi:GetString("SubmitBtnTipText"))
	UGUIUtil.SetText(self.SubmitBtnText, MazeSubmitItemUIApi:GetString("SubmitBtnText"))
	UGUIUtil.SetText(self.SelectBtnTipText, MazeSubmitItemUIApi:GetString("SelectBtnTipText"))
	UGUIUtil.SetText(self.SelectBtnText, MazeSubmitItemUIApi:GetString("SelectBtnText"))
end

function MazeSubmitItemUI:GetPreloadAssetPaths()
	return nil
end

function MazeSubmitItemUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function MazeSubmitItemUI:IsManualShowOnOpen(userData)
	return false
end

function MazeSubmitItemUI:GetBGM(userData)
	return nil
end

function MazeSubmitItemUI:OnOpen(userData)
	self:UpdateView(userData)
end

function MazeSubmitItemUI:OnClose(userData)
	self.OptionListPanel:SetActive(false)
end

function MazeSubmitItemUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.SubmitBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickSubmitBtn)
	self.SelectBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickSelectBtn)
end

function MazeSubmitItemUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.SubmitBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickSubmitBtn)
	self.SelectBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickSelectBtn)
end

function MazeSubmitItemUI:OnPause()
	return
end

function MazeSubmitItemUI:OnResume()
	return
end

function MazeSubmitItemUI:OnCover()
	return
end

function MazeSubmitItemUI:OnReveal()
	return
end

function MazeSubmitItemUI:OnRefocus(userData)
	return
end

function MazeSubmitItemUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function MazeSubmitItemUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MazeSubmitItemUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MazeSubmitItemUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MazeSubmitItemUI:OnDestroy()
	for i = 1, #self.RequireItemCells do
		local cell = self.RequireItemCells[i]

		cell:Dispose()
	end

	self.RequireItemCells = nil

	for gameObject, cell in pairs(self.OptionItemCells) do
		cell:Dispose()
	end

	self.OptionItemCells = nil
end

function MazeSubmitItemUI:UpdateView(cid)
	self.CfgSubmitItemData = CfgSubmitItemTable[cid]

	UGUIUtil.SetText(self.TipText, self.CfgSubmitItemData.PromptDescribe)

	for i = 1, #self.RequireItemCells do
		local cell = self.RequireItemCells[i]

		cell:SetEnabled(i <= self.CfgSubmitItemData.ItemSlots)
		cell:SetData(nil)
	end

	self:RefreshOptionList()
	self.OptionListPanel:SetActive(true)
	self.SelectBtn:SetActive(true)
	self.SubmitBtn:SetActive(false)
end

function MazeSubmitItemUI:RefreshOptionList()
	self.OptionItemDataList = {}

	for i = 1, #MazeDataModule.Items do
		local itemData = MazeDataModule.Items[i]

		if table.indexOf(self.CfgSubmitItemData.AllowItem, itemData.cid) ~= -1 then
			local newItemData = Clone(itemData)

			for j = 1, #self.RequireItemCells do
				local cell = self.RequireItemCells[j]
				local requireItemData = cell.ItemCell.ItemCfgOrData

				if requireItemData ~= nil and requireItemData.id == newItemData.id then
					newItemData.num = newItemData.num - 1
				end
			end

			if newItemData.num > 0 then
				table.insert(self.OptionItemDataList, newItemData)
			end
		end
	end

	local scrollAreaList = self.OptionListGrid:GetComponent("ScrollAreaList")

	scrollAreaList:Refresh(#self.OptionItemDataList)
	UGUIUtil.SetText(self.ItemNameText, "")
	UGUIUtil.SetText(self.ItemDescText, "")

	self.SelectedItemCell = nil
end

function MazeSubmitItemUI:OnRenderCell(cell)
	local itemCell = self.OptionItemCells[cell.gameObject]

	if itemCell == nil then
		itemCell = MazeSubmitItemOptionCell.New(cell.gameObject)
		self.OptionItemCells[cell.gameObject] = itemCell
	end

	itemCell:SetData(self.OptionItemDataList[cell.index + 1])
end

function MazeSubmitItemUI:OnSelectCell(cell)
	local itemCell = self.OptionItemCells[cell.gameObject]

	self.SelectedItemCell = itemCell

	local itemData = itemCell.ItemCell.ItemCfgOrData
	local cfgItemData = itemData:GetCfg()

	UGUIUtil.SetText(self.ItemNameText, cfgItemData.Name)
	UGUIUtil.SetText(self.ItemDescText, cfgItemData.Describe)
end

function MazeSubmitItemUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
	MazeLogicAdapter.Instance:AddMazeOrderFromLua(MazeLogicAdapter.ORDER_SUBMIT_ITEM, {
		ItemIds = {}
	})
end

function MazeSubmitItemUI:OnClickSubmitBtn()
	UIModule.CloseSelf(self)

	local ids = {}

	for i = 1, #self.RequireItemCells do
		local cell = self.RequireItemCells[i]

		if cell.Enabled then
			table.insert(ids, cell.ItemCell.ItemCfgOrData.id)
			table.insert(ids, 1)
		end
	end

	MazeLogicAdapter.Instance:AddMazeOrderFromLua(MazeLogicAdapter.ORDER_SUBMIT_ITEM, {
		ItemIds = ids
	})
end

function MazeSubmitItemUI:OnClickSelectBtn()
	if self.SelectedItemCell == nil then
		NoticeModule.ShowNotice(50000003)

		return
	end

	local itemData = self.SelectedItemCell.ItemCell.ItemCfgOrData

	for i = 1, #self.RequireItemCells do
		local cell = self.RequireItemCells[i]

		if cell.ItemCell.ItemCfgOrData == nil then
			cell:SetData(itemData)

			break
		end
	end

	itemData.num = itemData.num - 1

	if itemData.num > 0 then
		self.SelectedItemCell:SetData(itemData)
	else
		self:RefreshOptionList()
	end

	local isAllSet = self:IsAllSet()

	self.SubmitBtn:SetActive(isAllSet)
	self.SelectBtn:SetActive(not isAllSet)
end

function MazeSubmitItemUI:IsAllSet()
	local isNotFull = false

	for i = 1, #self.RequireItemCells do
		local cell = self.RequireItemCells[i]

		if cell.Enabled and cell.ItemCell.ItemCfgOrData == nil then
			isNotFull = true

			break
		end
	end

	return not isNotFull
end

function MazeSubmitItemUI:OnClickRequireItem(cell)
	local itemData = cell.ItemCell.ItemCfgOrData

	if itemData == nil then
		return
	end

	cell:SetData(nil)

	local found = false

	for i = 1, #self.OptionItemDataList do
		local optionItemData = self.OptionItemDataList[i]

		if optionItemData.id == itemData.id then
			optionItemData.num = optionItemData.num + 1

			for gameObject, lCell in pairs(self.OptionItemCells) do
				if lCell.ItemCell.ItemCfgOrData ~= nil and lCell.ItemCell.ItemCfgOrData.id == optionItemData.id then
					lCell:SetData(optionItemData)

					break
				end
			end

			found = true

			break
		end
	end

	if not found then
		self:RefreshOptionList()
	end

	self.SelectBtn:SetActive(true)
	self.SubmitBtn:SetActive(false)
end

return MazeSubmitItemUI
