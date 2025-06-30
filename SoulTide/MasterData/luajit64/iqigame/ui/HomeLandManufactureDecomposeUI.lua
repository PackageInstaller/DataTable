-- chunkname: @IQIGame\\UI\\HomeLandManufactureDecomposeUI.lua

local HomeLandManufactureDecomposeUI = {
	subTypeIndex = 1,
	selectNum = 1,
	decomposeItemCellPool = {},
	items = {}
}

HomeLandManufactureDecomposeUI = Base:Extend("HomeLandManufactureDecomposeUI", "IQIGame.Onigao.UI.HomeLandManufactureDecomposeUI", HomeLandManufactureDecomposeUI)

require("IQIGame.UIExternalApi.HomeLandManufactureDecomposeUIApi")

local ManufactureDecomposeItemData = require("IQIGame.Module.HomeLandManufacture.ManufactureDecomposeItemData")
local HomeLandManufactureDecomposeMaskView = require("IQIGame.UI.HomeLandManufactureDecompose.HomeLandManufactureDecomposeMaskView")
local HomeLandDecomposeItemCell = require("IQIGame.UI.HomeLandManufactureDecompose.HomeLandDecomposeItemCell")
local toggleTitles = HomeLandManufactureDecomposeUIApi:GetString("ToggleTitle")

function HomeLandManufactureDecomposeUI:OnInit()
	self:InitTog()

	self.tabs = {}

	for i, v in pairsCfg(CfgHomeLandDecorateThemeTable) do
		if v.Tpye == 1 then
			table.insert(self.tabs, {
				v.Id,
				v.Name
			})
		end
	end

	table.sort(self.tabs, function(a, b)
		return a[1] < b[1]
	end)
	table.insert(self.tabs, 1, {
		0,
		HomeLandManufactureDecomposeUIApi:GetString("TextLabel")
	})
	UGUIUtil.SetText(self.TitleText, HomeLandManufactureDecomposeUIApi:GetString("TitleText"))
	UGUIUtil.SetTextInChildren(self.BtnDecompose, HomeLandManufactureDecomposeUIApi:GetString("BtnDecomposeLabel"))
	UGUIUtil.SetText(self.EmptyText, HomeLandManufactureDecomposeUIApi:GetString("EmptyText"))

	self.toggleStyle = self.ToggleStyle:GetComponent("Toggle")

	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.delegateToggleStyleChange(isOn)
		self:OnToggleStyleChange(isOn)
	end

	function self.delegateToggleManufacture(isOn)
		self:OnTogManufacture(isOn)
	end

	function self.delegateUIContentWrapUpdateItem(cell)
		self:UIContentWrapUpdateItem(cell)
	end

	function self.delegateSelectedItem(cell)
		self:SelectedItemCell(cell)
	end

	function self.DelegateOnBtnDecompose()
		self:OnBtnDecompose()
	end

	function self.DelegateUpdateItem()
		self:OnUpdateItem()
	end

	function self.DelegateBtnReduce()
		self:OnBtnReduce()
	end

	function self.DelegateBtnAdd()
		self:OnBtnAdd()
	end

	function self.DelegateBtnMin()
		self:OnBtnMin()
	end

	function self.DelegateBtnMax()
		self:OnBtnMax()
	end

	self.selectItemCell = HomeLandDecomposeItemCell.New(self.SelectModule)

	self.selectItemCell.View:SetActive(false)

	self.getItemCell = ItemCell.New(self.GetItemModule)

	self.getItemCell.ViewGo:SetActive(false)

	self.homeLandDecomposeMaskView = HomeLandManufactureDecomposeMaskView.New(self.TabMask)

	self.homeLandDecomposeMaskView:CreateButtons(self.tabs)

	function self.homeLandDecomposeMaskView.selectChangeFun(selectIndex)
		self:OnSelectIndex(selectIndex)
	end

	self.homeLandDecomposeMaskView:Close()
end

function HomeLandManufactureDecomposeUI:GetPreloadAssetPaths()
	return nil
end

function HomeLandManufactureDecomposeUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function HomeLandManufactureDecomposeUI:IsManualShowOnOpen(userData)
	return false
end

function HomeLandManufactureDecomposeUI:GetBGM(userData)
	return nil
end

function HomeLandManufactureDecomposeUI:OnOpen(userData)
	self.toggleStyle.isOn = false
	self.toggleManufactures[self.subTypeIndex].isOn = true

	self:ShowTab(true)
end

function HomeLandManufactureDecomposeUI:OnClose(userData)
	return
end

function HomeLandManufactureDecomposeUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.BtnDecompose:GetComponent("Button").onClick:AddListener(self.DelegateOnBtnDecompose)
	self.BtnReduce:GetComponent("Button").onClick:AddListener(self.DelegateBtnReduce)
	self.BtnAdd:GetComponent("Button").onClick:AddListener(self.DelegateBtnAdd)
	self.BtnMin:GetComponent("Button").onClick:AddListener(self.DelegateBtnMin)
	self.BtnMax:GetComponent("Button").onClick:AddListener(self.DelegateBtnMax)
	self.ToggleStyle:GetComponent("Toggle").onValueChanged:AddListener(self.delegateToggleStyleChange)

	for i, v in pairs(self.toggleManufactures) do
		v.onValueChanged:AddListener(self.delegateToggleManufacture)
	end

	EventDispatcher.AddEventListener(EventID.UpdateItem, self.DelegateUpdateItem)
end

function HomeLandManufactureDecomposeUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.BtnDecompose:GetComponent("Button").onClick:RemoveListener(self.DelegateOnBtnDecompose)
	self.BtnReduce:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnReduce)
	self.BtnAdd:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnAdd)
	self.BtnMin:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnMin)
	self.BtnMax:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnMax)
	self.ToggleStyle:GetComponent("Toggle").onValueChanged:RemoveListener(self.delegateToggleStyleChange)

	for i, v in pairs(self.toggleManufactures) do
		v.onValueChanged:RemoveListener(self.delegateToggleManufacture)
	end

	EventDispatcher.RemoveEventListener(EventID.UpdateItem, self.DelegateUpdateItem)
end

function HomeLandManufactureDecomposeUI:OnPause()
	return
end

function HomeLandManufactureDecomposeUI:OnResume()
	return
end

function HomeLandManufactureDecomposeUI:OnCover()
	return
end

function HomeLandManufactureDecomposeUI:OnReveal()
	return
end

function HomeLandManufactureDecomposeUI:OnRefocus(userData)
	return
end

function HomeLandManufactureDecomposeUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function HomeLandManufactureDecomposeUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function HomeLandManufactureDecomposeUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function HomeLandManufactureDecomposeUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function HomeLandManufactureDecomposeUI:OnDestroy()
	self.getItemCell:Dispose()
	self.selectItemCell:Dispose()
end

function HomeLandManufactureDecomposeUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function HomeLandManufactureDecomposeUI:InitTog()
	self.toggleManufactures = {}

	local toggle

	self.ToggleMould:SetActive(false)

	for i = 1, #toggleTitles do
		local obj = UnityEngine.Object.Instantiate(self.ToggleMould)

		obj.transform:SetParent(self.TogGroup.transform, false)
		obj:SetActive(true)

		obj:GetComponent("ToggleHelperComponent").text = toggleTitles[i][2]

		if i == 1 then
			obj:GetComponent("CanvasGroup").alpha = 0
		end

		toggle = obj:GetComponent("Toggle")
		toggle.isOn = false
		toggle.group = self.TogGroup:GetComponent("ToggleGroup")
		self.toggleManufactures[i] = toggle
	end
end

function HomeLandManufactureDecomposeUI:OnToggleStyleChange(isOn)
	if isOn then
		self.homeLandDecomposeMaskView:Open()
	else
		self.homeLandDecomposeMaskView:Close()
	end
end

function HomeLandManufactureDecomposeUI:OnTogManufacture(isOn)
	if isOn then
		for i = 1, #self.toggleManufactures do
			local toggle = self.toggleManufactures[i]

			if toggle.isOn == true and self.subTypeIndex ~= i then
				self.subTypeIndex = i

				self:ShowTab(true)

				break
			end
		end
	end
end

function HomeLandManufactureDecomposeUI:OnUpdateItem()
	self:ShowTab(false)
end

function HomeLandManufactureDecomposeUI:OnSelectIndex(selectIndex)
	self.toggleStyle.isOn = false

	if self.selectIndex ~= selectIndex then
		self.selectIndex = selectIndex
		self.toggleManufactures[1].isOn = true

		self:ShowTab(true)
	end
end

function HomeLandManufactureDecomposeUI:OnSelectIndex(selectIndex)
	self.toggleStyle.isOn = false

	if self.selectIndex ~= selectIndex then
		self.selectIndex = selectIndex
		self.toggleManufactures[1].isOn = true

		self:ShowTab(true)
	end
end

function HomeLandManufactureDecomposeUI:ShowTab(freshFirst)
	self.ToggleStyle:GetComponent("ToggleHelperComponent").text = self.tabs[self.selectIndex][2]

	local type = self.tabs[self.selectIndex][1]
	local subType = toggleTitles[self.subTypeIndex][1]

	self.items = self:GetItemsByType(type, subType)

	local wrapContent = self.BagGrid:GetComponent("ScrollAreaList")

	wrapContent.onRenderCell = self.delegateUIContentWrapUpdateItem
	wrapContent.onSelectedCell = self.delegateSelectedItem

	if freshFirst then
		wrapContent:Refresh(#self.items)
	else
		wrapContent:RenderCellsDynamic(#self.items)
	end

	if self.selectItemData == nil then
		self.selectItemData = self.items[1]
	else
		local have = WarehouseModule.GetItemNumByCfgID(self.selectItemData.cfgItemCid)

		if have <= 0 then
			self.selectItemData = self.items[1]
		end
	end

	self.EmptyView:SetActive(#self.items == 0)
	self.TipContent:SetActive(#self.items > 0)
	self:ShowSelect()
end

function HomeLandManufactureDecomposeUI:UIContentWrapUpdateItem(cell)
	local itemData = self.items[cell.index + 1]
	local itemGo = cell.gameObject

	if itemData == nil then
		itemGo:SetActive(false)

		return
	end

	local decomposeItemCell = self.decomposeItemCellPool[cell.gameObject:GetInstanceID()]

	if decomposeItemCell == nil then
		decomposeItemCell = HomeLandDecomposeItemCell.New(itemGo)
		self.decomposeItemCellPool[cell.gameObject:GetInstanceID()] = decomposeItemCell
	end

	decomposeItemCell:SetData(itemData)

	if self.selectItemData == nil then
		self.selectItemData = itemData
	elseif self.selectItemData.cfgItemCid == itemData.cfgItemCid then
		self.selectItemData = itemData
	end
end

function HomeLandManufactureDecomposeUI:SelectedItemCell(cell)
	self.selectItemData = self.items[cell.index + 1]

	self:ShowSelect()
end

function HomeLandManufactureDecomposeUI:ShowSelect()
	for i, v in pairs(self.decomposeItemCellPool) do
		if self.selectItemData and v.decomposeItemData and v.decomposeItemData.cfgItemCid == self.selectItemData.cfgItemCid then
			v:SetSelect(true)
		else
			v:SetSelect(false)
		end
	end

	self:RefreshSelectMsg()
end

function HomeLandManufactureDecomposeUI:RefreshSelectMsg()
	self.selectItemCell.View:SetActive(self.selectItemData ~= nil)
	self.getItemCell.ViewGo:SetActive(self.selectItemData ~= nil)
	UGUIUtil.SetText(self.TextResult, "")

	if self.selectItemData then
		self:RefreshSelectNum()
	end
end

function HomeLandManufactureDecomposeUI:RefreshSelectNum()
	local getAllNum = 0

	if self.selectItemData then
		local cfgHomeLandDecorate = CfgHomeLandDecorateTable[self.selectItemData.cfgDecorateID]
		local have = WarehouseModule.GetItemNumByCfgID(cfgHomeLandDecorate.Item)

		if have < self.selectNum then
			self.selectNum = have
		end

		if self.selectNum < 1 then
			self.selectNum = 1
		end

		self.selectItemCell:SetData(self.selectItemData, self.selectNum)

		local itemID = cfgHomeLandDecorate.ExchangeItem[1]
		local itemNum = cfgHomeLandDecorate.ExchangeItem[2]

		self.getItemCell:SetItemByCID(itemID, itemNum * self.selectNum)

		getAllNum = itemNum * self.selectNum

		UGUIUtil.SetText(self.TextResult, HomeLandManufactureDecomposeUIApi:GetString("TextResult", CfgItemTable[itemID].Name, getAllNum))
		self.selectItemCell:SetData(self.selectItemData, self.selectNum)
		UGUIUtil.SetText(self.TextSelectNum, self.selectNum)
	end
end

function HomeLandManufactureDecomposeUI:GetItemsByType(themeID, type)
	local allItems = {}
	local itemData, cfgItemData

	for i = 1, #WarehouseModule.AllItems do
		itemData = WarehouseModule.AllItems[i]
		cfgItemData = itemData:GetCfg()

		if cfgItemData ~= nil and cfgItemData.Type == Constant.ItemType.HomeDecoration and table.indexOf(allItems, itemData.cid) == -1 then
			table.insert(allItems, itemData.cid)
		end
	end

	local tab = {}

	for i, v in pairs(allItems) do
		for k, v1 in pairsCfg(CfgHomeLandDecorateTable) do
			if v1.IsShowInRoom and v == v1.Item and #v1.ExchangeItem > 0 then
				local decorateData = ManufactureDecomposeItemData.New(v)

				if themeID == 0 then
					decorateData.cfgDecorateID = v1.Id
					decorateData.themeID = v1.ThemeID
					decorateData.Sort = v1.Sort

					if type == 0 then
						tab[#tab + 1] = decorateData

						break
					end

					if v1.LevelType == type then
						tab[#tab + 1] = decorateData
					end

					break
				end

				if v1.ThemeID == themeID then
					decorateData.cfgDecorateID = v1.Id
					decorateData.themeID = v1.ThemeID
					decorateData.Sort = v1.Sort

					if type == 0 then
						tab[#tab + 1] = decorateData

						break
					end

					if v1.LevelType == type then
						tab[#tab + 1] = decorateData
					end
				end

				break
			end
		end
	end

	table.sort(tab, function(a, b)
		return a.Sort < b.Sort
	end)

	return tab
end

function HomeLandManufactureDecomposeUI:OnBtnDecompose()
	if self.selectItemData then
		local cfgHomeLandDecorate = CfgHomeLandDecorateTable[self.selectItemData.cfgDecorateID]
		local have = WarehouseModule.GetItemNumByCfgID(cfgHomeLandDecorate.Item)

		if self.selectNum > 0 and have >= self.selectNum then
			HomeLandLuaModule.DecomposeDecorate(self.selectItemData.cfgDecorateID, self.selectNum)
		end
	end
end

function HomeLandManufactureDecomposeUI:OnBtnReduce()
	if self.selectNum > 1 then
		self.selectNum = self.selectNum - 1
	end

	self:RefreshSelectNum()
end

function HomeLandManufactureDecomposeUI:OnBtnAdd()
	self.selectNum = self.selectNum + 1

	self:RefreshSelectNum()
end

function HomeLandManufactureDecomposeUI:OnBtnMin()
	self.selectNum = 1

	self:RefreshSelectNum()
end

function HomeLandManufactureDecomposeUI:OnBtnMax()
	if self.selectItemData then
		local cfgHomeLandDecorate = CfgHomeLandDecorateTable[self.selectItemData.cfgDecorateID]
		local have = WarehouseModule.GetItemNumByCfgID(cfgHomeLandDecorate.Item)

		self.selectNum = have

		self:RefreshSelectNum()
	end
end

return HomeLandManufactureDecomposeUI
