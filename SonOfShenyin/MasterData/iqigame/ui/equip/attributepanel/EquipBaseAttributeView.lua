-- chunkname: @IQIGame\\UI\\Equip\\AttributePanel\\EquipBaseAttributeView.lua

local EquipBaseAttributeView = {
	BaseAttributeCellList = {}
}
local EquipBaseAttributeCell = require("IQIGame.UI.Equip.EquipBaseAttributeCell")

function EquipBaseAttributeView.New(go)
	local o = Clone(EquipBaseAttributeView)

	o:Initialize(go)

	return o
end

function EquipBaseAttributeView:Initialize(go)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go

	self.AttributeItemPrefab.gameObject:SetActive(false)

	self.BaseAttributeTitleText:GetComponent("Text").text = EquipApi:GetTextFoldBaseAttribute()

	self:OnInitDelegation()
	self:OnAddListeners()
end

function EquipBaseAttributeView:OnDestroy()
	for i, cell in pairs(self.BaseAttributeCellList) do
		cell:OnDestroy()
	end

	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function EquipBaseAttributeView:OnInitDelegation()
	return
end

function EquipBaseAttributeView:OnAddListeners()
	return
end

function EquipBaseAttributeView:OnRemoveListeners()
	return
end

function EquipBaseAttributeView:Show()
	self.gameObject:SetActive(true)
end

function EquipBaseAttributeView:Hide()
	self.gameObject:SetActive(false)
end

function EquipBaseAttributeView:GetBaseAttributeConfig()
	return self:GetAttributeConfigDict(1)
end

function EquipBaseAttributeView:GetAdvancedAttributeConfig()
	return self:GetAttributeConfigDict(2)
end

function EquipBaseAttributeView:GetAttributeConfigDict(type)
	local attributeDict = {}

	for i, v in pairs(CfgAttributeTable) do
		if v.Type == type then
			attributeDict[v.Id] = v
		end
	end

	return attributeDict
end

function EquipBaseAttributeView:RefreshAttributePanel(WarlockData)
	local baseAttributeConfigDict = self:GetBaseAttributeConfig()
	local heroAttr = EquipModule.EquipAttr2HeroAttrText(WarlockData)
	local attributeList = {}

	for attributeID, attributeValue in pairs(heroAttr.BaseAttributeDict) do
		table.insert(attributeList, {
			Config = baseAttributeConfigDict[attributeID],
			Value = attributeValue
		})
	end

	table.sort(attributeList, function(a, b)
		return a.Config.Sort < b.Config.Sort
	end)
	self:RefreshBaseAttribute(attributeList)
end

function EquipBaseAttributeView:RefreshBaseAttribute(attributeList)
	self:ResetBaseAttributeScrollView()

	for index, attribute in pairs(attributeList) do
		local gameObject = UnityEngine.Object.Instantiate(self.AttributeItemPrefab, self.EquipBaseAttributePanel.transform)
		local cell = EquipBaseAttributeCell.New(gameObject)

		cell:Refresh(attribute)
		self:AddAdditionalAttributeScrollViewItem(cell)
		gameObject:SetActive(true)
	end
end

function EquipBaseAttributeView:ResetBaseAttributeScrollView()
	for _, cell in pairs(self.BaseAttributeCellList) do
		local gameObject = cell.gameObject

		cell:OnDestroy()
		gameObject.transform:SetParent(nil)
		GameObject.Destroy(gameObject)
	end

	self.BaseAttributeCellList = {}
end

function EquipBaseAttributeView:AddAdditionalAttributeScrollViewItem(cell)
	table.insert(self.BaseAttributeCellList, cell)
end

function EquipBaseAttributeView:OnRenderGridCell(gridCellData)
	local index = gridCellData.index + 1
	local attributeData = self.BaseAttributeDataList[index]
	local insID = gridCellData.gameObject:GetInstanceID()

	attributeData.insID = insID

	local cell = self.BaseAttributeCellList[insID]

	if cell == nil then
		cell = EquipBaseAttributeCell.New(gridCellData.gameObject)
		self.BaseAttributeCellList[insID] = cell
	end

	cell:Refresh(attributeData)

	gridCellData.gameObject.name = "Item" .. gridCellData.index + 1
end

return EquipBaseAttributeView
