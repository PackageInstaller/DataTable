-- chunkname: @IQIGame\\UI\\HomeLandManufacture\\HomeLandManufactureItemView.lua

local HomeLandManufactureItemView = {
	isHaveItem = false,
	decorateThemeTab = {},
	decorateTab = {},
	ItemCells = {}
}
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local HomeLandItemTitleCell = require("IQIGame.UI.HomeLandManufacture.HomeLandItemTitleCell")
local HomeLandItemDecorateCell = require("IQIGame.UI.HomeLandManufacture.HomeLandItemDecorateCell")

function HomeLandManufactureItemView.New(view, parent)
	local obj = Clone(HomeLandManufactureItemView)

	obj:Init(view, parent)

	return obj
end

function HomeLandManufactureItemView:Init(view, parent)
	self.View = view
	self.parent = parent

	LuaCodeInterface.BindOutlet(self.View, self)
	UGUIUtil.SetText(self.TextBtnMake, HomeLandManufactureListUIApi:GetString("TextBtnMake"))

	self.scrollTitle = self.ScrollTitle:GetComponent("ScrollAreaList")

	function self.scrollTitle.onRenderCell(cell)
		self:OnRenderTitleCell(cell)
	end

	function self.scrollTitle.onSelectedCell(cell)
		self:OnSelectedTitleCell(cell)
	end

	self.scrollTheme = self.Scroll:GetComponent("ScrollAreaList")

	function self.scrollTheme.onRenderCell(cell)
		self:OnRenderThemeCell(cell)
	end

	function self.scrollTheme.onSelectedCell(cell)
		self:OnSelectedThemeCell(cell)
	end

	self.btnMake = self.BtnMake:GetComponent("Button")

	function self.delegateBtnMake()
		self:OnBtnMake()
	end

	self.ItemCellPool = UIObjectPool.New(10, function()
		return ItemCell.New(UnityEngine.Object.Instantiate(self.parent.UIController:GetPreloadedAsset(UIGlobalApi.GetItemCellAssetPath())))
	end, function(cell)
		local view = cell.ViewGo

		cell:Dispose()
		UnityEngine.Object.Destroy(view)
	end)

	self:AddListener()
end

function HomeLandManufactureItemView:AddListener()
	self.btnMake.onClick:AddListener(self.delegateBtnMake)
end

function HomeLandManufactureItemView:RemoveListener()
	self.btnMake.onClick:RemoveListener(self.delegateBtnMake)
end

function HomeLandManufactureItemView:OnRenderTitleCell(cell)
	local themeData = self.decorateThemeTab[cell.index + 1]

	if themeData == nil then
		cell.gameObject:SetActive(false)

		return
	end

	local goObj = cell.gameObject

	goObj:SetActive(true)

	local themeObj = HomeLandItemTitleCell.PackageOrReuseView(self, goObj)

	themeObj:SetDate(themeData)

	if self.selectThemeData == nil then
		themeObj:SetSelect(true)

		self.selectThemeData = themeData
		self.selectTitleObj = themeObj
	elseif self.selectThemeData.Id == themeData.Id then
		themeObj:SetSelect(true)

		self.selectThemeData = themeData
		self.selectTitleObj = themeObj
	else
		themeObj:SetSelect(false)
	end
end

function HomeLandManufactureItemView:OnSelectedTitleCell(cell)
	local themeData = self.decorateThemeTab[cell.index + 1]

	if self.selectThemeData and self.selectThemeData.Id == themeData.Id then
		return
	end

	local themeObj = HomeLandItemTitleCell.PackageOrReuseView(self, cell.gameObject)

	themeObj:SetDate(themeData)
	themeObj:SetSelect(true)

	if self.selectTitleObj then
		self.selectTitleObj:SetSelect(false)
	end

	self.selectTitleObj = themeObj
	self.selectThemeData = themeData

	self:UpDateDecorateList()
end

function HomeLandManufactureItemView:OnRenderThemeCell(cell)
	local decorateData = self.decorateTab[cell.index + 1]

	if decorateData == nil then
		cell.gameObject:SetActive(false)

		return
	end

	local goObj = cell.gameObject

	goObj:SetActive(true)

	local decorateObj = HomeLandItemDecorateCell.PackageOrReuseView(self, goObj)

	decorateObj:SetDate(decorateData)

	if self.selectDecorateDate == nil then
		decorateObj:SetSelect(true)

		self.selectDecorateDate = decorateData
		self.selectDecorateObj = decorateObj
	elseif self.selectDecorateDate.cid == decorateData.cid then
		decorateObj:SetSelect(true)

		self.selectDecorateDate = decorateData
		self.selectDecorateObj = decorateObj
	else
		decorateObj:SetSelect(false)
	end
end

function HomeLandManufactureItemView:OnSelectedThemeCell(cell)
	local decorateData = self.decorateTab[cell.index + 1]

	if self.selectDecorateDate and self.selectDecorateDate.cid == decorateData.cid then
		return
	end

	local decorateObj = HomeLandItemDecorateCell.PackageOrReuseView(self, cell.gameObject)

	decorateObj:SetDate(decorateData)
	decorateObj:SetSelect(true)

	if self.selectDecorateObj then
		self.selectDecorateObj:SetSelect(false)
	end

	self.selectDecorateObj = decorateObj
	self.selectDecorateDate = decorateData

	self:ShowDecorateMsg()
end

function HomeLandManufactureItemView:ShowDecorateMsg()
	local itemId = self.selectDecorateDate.cfgManufactureItem.GetItem

	UGUIUtil.SetText(self.TextDes, CfgItemTable[itemId].Describe)
	UGUIUtil.SetText(self.TextTimer, GetFormatTime(self.selectDecorateDate.cfgManufactureItem.ShowNeedTime))
	UGUIUtil.SetText(self.TextBuff, "")

	self.isHaveItem = true

	for i, v in pairs(self.ItemCells) do
		self.ItemCellPool:Release(v)
	end

	self.ItemCells = {}

	if self.selectDecorateDate.cfgManufactureItem.NeedItem then
		for i = 1, #self.selectDecorateDate.cfgManufactureItem.NeedItem, 2 do
			local id = self.selectDecorateDate.cfgManufactureItem.NeedItem[i]
			local needNum = self.selectDecorateDate.cfgManufactureItem.NeedItem[i + 1]
			local haveNum = WarehouseModule.GetItemNumByCfgID(id)
			local itemCell = self.ItemCellPool:Obtain()

			itemCell.ViewGo:SetActive(true)
			itemCell.ViewGo.transform:SetParent(self.ItemGrid.transform, false)
			itemCell:SetItemByCID(id)
			itemCell:SetCustomNum(haveNum, needNum)
			table.insert(self.ItemCells, itemCell)

			if self.isHaveItem then
				self.isHaveItem = needNum <= haveNum
			end
		end
	end
end

function HomeLandManufactureItemView:UpDateDecorateList()
	self.selectDecorateDate = nil
	self.decorateTab = HomeLandManufactureMould.GetManufactureItemsThemeID(self.selectThemeData.Id)

	self.scrollTheme:Refresh(#self.decorateTab)
	self:ShowDecorateMsg()
	UGUIUtil.SetText(self.TextBig, self.selectThemeData.Name)
end

function HomeLandManufactureItemView:UpDateView()
	self.decorateThemeTab = HomeLandManufactureMould.GetManufactureDecorateThemeByType(2)

	self.scrollTitle:Refresh(#self.decorateThemeTab)
	self:UpDateDecorateList()
end

function HomeLandManufactureItemView:OnBtnMake()
	EventDispatcher.Dispatch(EventID.HomeLandManufactureStart, self.isHaveItem, self.selectDecorateDate)
end

function HomeLandManufactureItemView:Open()
	self.selectThemeData = nil

	self.View:SetActive(true)
	self:UpDateView()
end

function HomeLandManufactureItemView:Close()
	self.View:SetActive(false)
end

function HomeLandManufactureItemView:Dispose()
	self:RemoveListener()

	for i, v in pairs(self.ItemCells) do
		self.ItemCellPool:Release(v)
	end

	self.ItemCells = {}

	self.ItemCellPool:Dispose()
	HomeLandItemTitleCell.DisposeIn(self)
	HomeLandItemDecorateCell.DisposeIn(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return HomeLandManufactureItemView
