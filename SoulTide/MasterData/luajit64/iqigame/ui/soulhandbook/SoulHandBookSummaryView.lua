-- chunkname: @IQIGame\\UI\\SoulHandbook\\SoulHandBookSummaryView.lua

local SoulHandBookSummaryView = {
	toggles = {}
}
local SoulHandBookToggle = require("IQIGame.UI.SoulHandbook.SoulHandBookToggle")
local SoulHandBookCell = require("IQIGame.UI.SoulHandbook.SoulHandBookCell")

function SoulHandBookSummaryView.New(view, parent)
	local obj = Clone(SoulHandBookSummaryView)

	obj:Init(view, parent)

	return obj
end

function SoulHandBookSummaryView:Init(view, parent)
	self.parent = parent
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.btnClose = self.BtnBack:GetComponent("Button")

	function self.delegateBtnClose()
		self:OnBtnClose()
	end

	function self.delegateToggleValueChange(isOn)
		self:OnClickToggle(isOn)
	end

	self.scrollList = self.scrollArea:GetComponent("ScrollAreaList")

	function self.scrollList.onRenderCell(renderCell)
		self:OnRenderGridCell(renderCell)
	end
end

function SoulHandBookSummaryView:AddEventListener()
	self.btnClose.onClick:AddListener(self.delegateBtnClose)
end

function SoulHandBookSummaryView:RemoveEventListener()
	self.btnClose.onClick:RemoveListener(self.delegateBtnClose)

	for i, v in pairs(self.toggles) do
		v.toggle.onValueChanged:RemoveListener(self.delegateToggleValueChange)
	end
end

function SoulHandBookSummaryView:UpDateView()
	if self.bookType then
		self:SetDate(self.bookType)
	end
end

function SoulHandBookSummaryView:SetDate(type)
	self.bookType = type
	self.toggleTab, self.getWayTypeBooks = self:GetWayTypes()

	self:CreateToggles()
end

function SoulHandBookSummaryView:CreateToggles()
	for i, v in pairs(self.toggles) do
		v:Dispose()
	end

	self.toggles = {}

	for i = 1, #self.toggleTab do
		local type = self.toggleTab[i]
		local togObj = UnityEngine.GameObject.Instantiate(self.Tog)

		togObj:SetActive(true)

		togObj.name = type

		togObj.transform:SetParent(self.Toggles.transform, false)

		local toggleCell = SoulHandBookToggle.New(togObj)

		toggleCell.toggle.onValueChanged:AddListener(self.delegateToggleValueChange)

		toggleCell.toggle.group = self.Toggles:GetComponent("ToggleGroup")

		local num, maxNum = self:GetWayTypePerCent(type)

		toggleCell:SetDate(type, num, maxNum)
		table.insert(self.toggles, toggleCell)
	end

	self.currentType = self.toggleTab[1]

	if self.toggles[1].toggle.isOn then
		self:ShowCurrentType()
	else
		self.toggles[1].toggle.isOn = true
	end
end

function SoulHandBookSummaryView:OnClickToggle(isOn)
	if isOn then
		for i = 0, self.Toggles.transform.childCount - 1 do
			local obj = self.Toggles.transform:GetChild(i).gameObject
			local toggle = obj:GetComponent("Toggle")

			if toggle.isOn == true then
				self.currentType = tonumber(obj.name)

				break
			end
		end

		self:ShowCurrentType()
	end
end

function SoulHandBookSummaryView:ShowCurrentType()
	self.getWayTypeScrollData = self.getWayTypeBooks[self.currentType]

	table.sort(self.getWayTypeScrollData, function(a, b)
		return a.cfgInfo.Sort < b.cfgInfo.Sort
	end)
	self.scrollList:Refresh(#self.getWayTypeScrollData)
end

function SoulHandBookSummaryView:OnRenderGridCell(cell)
	local bookData = self.getWayTypeScrollData[cell.index + 1]

	if bookData == nil then
		cell.gameObject:SetActive(false)

		return
	end

	cell.gameObject:SetActive(true)

	local handbookCell = SoulHandBookCell.PackageOrReuseView(self, cell.gameObject)

	handbookCell:SetData(bookData)
end

function SoulHandBookSummaryView:GetWayTypes()
	local handBooks, isNew = self.parent:GetHandBookDataByType(self.bookType)
	local toggleTab = {}
	local getWayTypeTab = {}

	for i = 1, #handBooks do
		local handBookData = handBooks[i]

		if table.indexOf(toggleTab, handBookData.cfgInfo.GetWayType) == -1 then
			table.insert(toggleTab, handBookData.cfgInfo.GetWayType)
		end

		if getWayTypeTab[handBookData.cfgInfo.GetWayType] == nil then
			getWayTypeTab[handBookData.cfgInfo.GetWayType] = {}
		end

		table.insert(getWayTypeTab[handBookData.cfgInfo.GetWayType], handBookData)
	end

	table.sort(toggleTab, function(tb1, tb2)
		return tonumber(tb1) < tonumber(tb2)
	end)

	return toggleTab, getWayTypeTab
end

function SoulHandBookSummaryView:GetWayTypePerCent(type)
	local dates = self.getWayTypeBooks[type]
	local num = 0
	local maxNum = #dates

	for i, v in pairs(dates) do
		if v.open then
			num = num + 1
		end
	end

	return num, maxNum
end

function SoulHandBookSummaryView:OnBtnClose()
	self:Close()
end

function SoulHandBookSummaryView:Open()
	self.View:SetActive(true)
	self.parent:ShowRightPanelVisible(false)
	self:AddEventListener()
end

function SoulHandBookSummaryView:Close()
	self.View:SetActive(false)
	self.parent:ShowRightPanelVisible(true)
	self:RemoveEventListener()
end

function SoulHandBookSummaryView:Dispose()
	SoulHandBookCell.DisposeIn(self)

	for i, v in pairs(self.toggles) do
		v:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return SoulHandBookSummaryView
