-- chunkname: @IQIGame\\UI\\HomeLandManufacture\\HomeLandManufactureThemeView.lua

local HomeLandManufactureThemeView = {
	curManufacture = 1,
	isHaveItem = false,
	decorateThemeTab = {},
	decorateTab = {},
	NeedItemCell = {},
	themeTitleCellPool = {},
	themeDecorateCellPool = {}
}
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local HomeLandNeedItemCell = require("IQIGame.UI.HomeLandManufacture.HomeLandNeedItemCell")
local HomeLandThemeTitleCell = require("IQIGame.UI.HomeLandManufacture.HomeLandThemeTitleCell")
local HomeLandThemeDecorateCell = require("IQIGame.UI.HomeLandManufacture.HomeLandThemeDecorateCell")
local toggleTitles = HomeLandManufactureUIApi:GetString("ToggleTitle")

function HomeLandManufactureThemeView.New(view, parent)
	local obj = Clone(HomeLandManufactureThemeView)

	obj:Init(view, parent)

	return obj
end

function HomeLandManufactureThemeView:Init(view, parent)
	self.View = view
	self.parent = parent

	LuaCodeInterface.BindOutlet(self.View, self)
	self:InitTog()
	UGUIUtil.SetText(self.TextBtnMake, HomeLandManufactureListUIApi:GetString("TextBtnMake"))
	UGUIUtil.SetText(self.TextSpendTitle, HomeLandManufactureListUIApi:GetString("TextSpendTitle"))
	UGUIUtil.SetText(self.TextLock1, HomeLandManufactureListUIApi:GetString("TextLock1"))
	UGUIUtil.SetText(self.TextLock2, HomeLandManufactureListUIApi:GetString("TextLock2"))

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

	function self.delegateToggleManufacture(isOn)
		self:OnTogManufacture(isOn)
	end

	self.btnBig = self.BtnBig:GetComponent("Button")
	self.btnMake = self.BtnMake:GetComponent("Button")

	function self.delegateBtnBig()
		self:OnBtnBig()
	end

	function self.delegateBtnMake()
		self:OnBtnMake()
	end

	self.ItemCellPool = UIObjectPool.New(10, function()
		return HomeLandNeedItemCell.New(UnityEngine.Object.Instantiate(self.NeedItem))
	end, function(cell)
		cell:Dispose()
	end)

	self:AddListener()
end

function HomeLandManufactureThemeView:AddListener()
	self.btnBig.onClick:AddListener(self.delegateBtnBig)
	self.btnMake.onClick:AddListener(self.delegateBtnMake)

	for i, v in pairs(self.toggleManufactures) do
		v.onValueChanged:AddListener(self.delegateToggleManufacture)
	end
end

function HomeLandManufactureThemeView:RemoveListener()
	self.btnBig.onClick:RemoveListener(self.delegateBtnBig)
	self.btnMake.onClick:RemoveListener(self.delegateBtnMake)

	for i, v in pairs(self.toggleManufactures) do
		v.onValueChanged:RemoveListener(self.delegateToggleManufacture)
	end
end

function HomeLandManufactureThemeView:InitTog()
	self.toggleManufactures = {}

	local toggle

	for i = 1, #toggleTitles do
		local obj = UnityEngine.Object.Instantiate(self.ToggleMould)

		obj.transform:SetParent(self.ToggleGroup.transform, false)
		obj:SetActive(true)

		obj:GetComponent("ToggleHelperComponent").text = toggleTitles[i][2]
		toggle = obj:GetComponent("Toggle")
		toggle.isOn = false
		toggle.group = self.ToggleGroup:GetComponent("ToggleGroup")
		self.toggleManufactures[i] = toggle
	end
end

function HomeLandManufactureThemeView:OnTogManufacture(isOn)
	if isOn then
		for i = 1, #self.toggleManufactures do
			local toggle = self.toggleManufactures[i]

			if toggle.isOn == true and self.curManufacture ~= i then
				self.curManufacture = i

				self:UpDateDecorateList()

				break
			end
		end
	end
end

function HomeLandManufactureThemeView:OnRenderTitleCell(cell)
	local themeData = self.decorateThemeTab[cell.index + 1]

	if themeData == nil then
		cell.gameObject:SetActive(false)

		return
	end

	local goObj = cell.gameObject

	goObj:SetActive(true)

	local instanceID = cell.gameObject:GetInstanceID()
	local themeObj = self.themeTitleCellPool[instanceID]

	if themeObj == nil then
		themeObj = HomeLandThemeTitleCell:New(goObj)
		self.themeTitleCellPool[instanceID] = themeObj
	end

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

function HomeLandManufactureThemeView:OnSelectedTitleCell(cell)
	local themeData = self.decorateThemeTab[cell.index + 1]

	if self.selectThemeData and self.selectThemeData.Id == themeData.Id then
		return
	end

	local themeObj = self.themeTitleCellPool[cell.gameObject:GetInstanceID()]

	themeObj:SetDate(themeData)
	themeObj:SetSelect(true)

	if self.selectTitleObj then
		self.selectTitleObj:SetSelect(false)
	end

	self.selectTitleObj = themeObj
	self.selectThemeData = themeData

	self:UpDateDecorateList()
end

function HomeLandManufactureThemeView:OnRenderThemeCell(cell)
	local decorateData = self.decorateTab[cell.index + 1]

	if decorateData == nil then
		cell.gameObject:SetActive(false)

		return
	end

	local goObj = cell.gameObject

	goObj:SetActive(true)

	local instanceID = cell.gameObject:GetInstanceID()
	local decorateObj = self.themeDecorateCellPool[instanceID]

	if decorateObj == nil then
		decorateObj = HomeLandThemeDecorateCell:New(goObj)
		self.themeDecorateCellPool[instanceID] = decorateObj
	end

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

function HomeLandManufactureThemeView:OnSelectedThemeCell(cell)
	local decorateData = self.decorateTab[cell.index + 1]

	if self.selectDecorateDate and self.selectDecorateDate.cid == decorateData.cid then
		return
	end

	local decorateObj = self.themeDecorateCellPool[cell.gameObject:GetInstanceID()]

	decorateObj:SetDate(decorateData)
	decorateObj:SetSelect(true)

	if self.selectDecorateObj then
		self.selectDecorateObj:SetSelect(false)
	end

	self.selectDecorateObj = decorateObj
	self.selectDecorateDate = decorateData

	self:ShowDecorateMsg()
end

function HomeLandManufactureThemeView:ShowDecorateMsg()
	self.UnLock:SetActive(self.selectDecorateDate.isLock)
	self.Lock:SetActive(not self.selectDecorateDate.isLock)

	local itemId = self.selectDecorateDate.cfgManufactureItem.GetItem

	UGUIUtil.SetText(self.TextDes, CfgItemTable[itemId].Describe)
	UGUIUtil.SetText(self.TextTimer, GetFormatTime(self.selectDecorateDate.cfgManufactureItem.ShowNeedTime))
	UGUIUtil.SetText(self.TextBuff, "")

	self.isHaveItem = true

	for i, v in pairs(self.NeedItemCell) do
		self.ItemCellPool:Release(v)
	end

	self.NeedItemCell = {}

	if self.selectDecorateDate.cfgManufactureItem.NeedItem then
		for i = 1, #self.selectDecorateDate.cfgManufactureItem.NeedItem, 2 do
			local id = self.selectDecorateDate.cfgManufactureItem.NeedItem[i]
			local needNum = self.selectDecorateDate.cfgManufactureItem.NeedItem[i + 1]
			local haveNum = WarehouseModule.GetItemNumByCfgID(id)
			local itemCell = self.ItemCellPool:Obtain()

			itemCell.View:SetActive(true)
			itemCell.View.transform:SetParent(self.ItemGrid.transform, false)
			itemCell:SetItemByCID(id)
			itemCell:SetCustomNum(haveNum, needNum)
			table.insert(self.NeedItemCell, itemCell)

			if self.isHaveItem then
				self.isHaveItem = needNum <= haveNum
			end
		end
	end
end

function HomeLandManufactureThemeView:UpDateDecorateList()
	self.selectDecorateDate = nil

	local type = toggleTitles[self.curManufacture][1]

	self.decorateTab = self:GetDecorateByType(type)

	self.scrollTheme:Refresh(#self.decorateTab)
	self:ShowDecorateMsg()
	UGUIUtil.SetText(self.TextBig, self.selectThemeData.Name)
end

function HomeLandManufactureThemeView:GetDecorateByType(type)
	local decorateTab = HomeLandManufactureMould.GetManufactureItemsThemeID(self.selectThemeData.Id)
	local tab = {}

	if type > 0 then
		for i = 1, #decorateTab do
			local data = decorateTab[i]

			if data.cfgManufactureItem.Type == type then
				table.insert(tab, data)
			end
		end
	else
		return decorateTab
	end

	return tab
end

function HomeLandManufactureThemeView:UpDateView()
	self.decorateThemeTab = HomeLandManufactureMould.GetManufactureDecorateThemeByType(1)

	self.scrollTitle:Refresh(#self.decorateThemeTab)
	self:UpDateDecorateList()
end

function HomeLandManufactureThemeView:OnBtnBig()
	local path = UIGlobalApi.GetImagePath(self.selectThemeData.Preview)

	UIModule.Open(Constant.UIControllerName.HomeLandCgShowUI, Constant.UILayer.UI, {
		path,
		Vector3.New(0, 0, 0)
	})
end

function HomeLandManufactureThemeView:OnBtnMake()
	if not self.selectDecorateDate.isLock then
		NoticeModule.ShowNoticeByType(1, HomeLandManufactureUIApi:GetString("UnLockErrorMsg", self.selectDecorateDate.cfgManufactureItem.Name))

		return
	end

	EventDispatcher.Dispatch(EventID.HomeLandManufactureStart, self.isHaveItem, self.selectDecorateDate, self.parent.queueId)
end

function HomeLandManufactureThemeView:Open()
	self.selectThemeData = nil

	self.View:SetActive(true)

	self.toggleManufactures[self.curManufacture].isOn = true

	self:UpDateView()
end

function HomeLandManufactureThemeView:Close()
	self.View:SetActive(false)
end

function HomeLandManufactureThemeView:Dispose()
	self:RemoveListener()

	for i, v in pairs(self.NeedItemCell) do
		self.ItemCellPool:Release(v)
	end

	self.NeedItemCell = {}

	self.ItemCellPool:Dispose()

	for i, v in pairs(self.themeTitleCellPool) do
		v:Dispose()
	end

	for i, v in pairs(self.themeDecorateCellPool) do
		v:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return HomeLandManufactureThemeView
