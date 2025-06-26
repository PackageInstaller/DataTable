-- chunkname: @IQIGame\\UI\\HomeLandPlant\\HomeLandPlantItemCell.lua

HomeLandPlantItemCell = {}

function HomeLandPlantItemCell:__New(itemCellView)
	local itemCell = Clone(HomeLandPlantItemCell)

	itemCell:Init(itemCellView)

	return itemCell
end

function HomeLandPlantItemCell:Init(view)
	self.goView = view

	LuaCodeInterface.BindOutlet(self.goView, self)
	self:AddListener()
end

function HomeLandPlantItemCell:AddListener()
	return
end

function HomeLandPlantItemCell:RemoveListener()
	return
end

function HomeLandPlantItemCell:SetDate(itemId, tag)
	local itemCell = ItemCell.PackageOrReuseView(self, self.ItemSlot.transform:GetChild(0).gameObject)
	local cfgItem = CfgItemTable[itemId]

	itemCell:SetItem(cfgItem)
	self.Tag1:SetActive(false)
	self.Tag2:SetActive(false)

	if tag == 1 then
		self.Tag2:SetActive(true)
	elseif tag == 2 then
		self.Tag1:SetActive(true)
	end

	UGUIUtil.SetText(self.TextTag1, HomeLandPlantUIApi:GetString("TextTag1"))
	UGUIUtil.SetText(self.TextTag2, HomeLandPlantUIApi:GetString("TextTag2"))
end

function HomeLandPlantItemCell:Dispose()
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.goView, self)
	UnityEngine.GameObject.DestroyImmediate(self.goView)

	self.goView = nil
end

return HomeLandPlantItemCell
