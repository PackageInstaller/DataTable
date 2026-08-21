-- chunkname: @IQIGame\\UI\\Common\\EquipSuitCell.lua

local EquipSuitCell = {}

function EquipSuitCell.New(view)
	local obj = Clone(EquipSuitCell)

	obj:Init(view)

	return obj
end

function EquipSuitCell:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.tfIndex = self.goIndex:GetComponent("Text")
	self.tfName = self.goName:GetComponent("Text")
	self.tfDesc = self.goDesc:GetComponent("Text")
end

function EquipSuitCell:Refresh(index, itemData)
	self:SetActive(true)

	local cfgSoulPaintingData = itemData:GetCfg()
	local cfgSuitData = CfgSoulPaintingSuitTable[cfgSoulPaintingData.SoulPaintingSuitId]
	local cfgPabilityData = CfgPabilityTable[cfgSuitData.PabilityID[index]]
	local needCount = cfgSuitData.Num[index]
	local woreCount = 0

	if itemData.equipData.isWore then
		woreCount = EquipModule.GetWoreSuitEquipCount(itemData.id, cfgSuitData, itemData.equipData.soulPrefabIds[1])
	end

	self.tfIndex.text = EquipUIApi:GetString("suitCellAttIndex", index)
	self.tfName.text = EquipUIApi:GetString("suitCellAttName", cfgPabilityData.Name, woreCount, needCount)
	self.tfDesc.text = EquipUIApi:GetString("suitCellAttDesc", cfgPabilityData.Describe)
end

function EquipSuitCell:OnDestroy()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function EquipSuitCell:SetActive(vs)
	self.View:SetActive(vs)
end

return EquipSuitCell
