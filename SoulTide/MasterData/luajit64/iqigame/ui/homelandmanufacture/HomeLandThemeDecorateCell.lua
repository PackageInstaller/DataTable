-- chunkname: @IQIGame\\UI\\HomeLandManufacture\\HomeLandThemeDecorateCell.lua

HomeLandThemeDecorateCell = {}

local FurnitureSlot = require("IQIGame.UI.Common.FurnitureSlot")

function HomeLandThemeDecorateCell:New(itemCellView)
	local itemCell = Clone(HomeLandThemeDecorateCell)

	itemCell:Init(itemCellView)

	return itemCell
end

function HomeLandThemeDecorateCell:Init(view)
	self.goView = view

	LuaCodeInterface.BindOutlet(self.goView, self)

	self.GrayComponent = self.FurnitureSlot:GetComponent("ImageGroupGrayComponent")

	self:AddListener()
end

function HomeLandThemeDecorateCell:AddListener()
	return
end

function HomeLandThemeDecorateCell:RemoveListener()
	return
end

function HomeLandThemeDecorateCell:SetDate(data)
	self.manufactureItemData = data

	if self.manufactureItemData then
		local furnitureCell = FurnitureSlot.PackageOrReuseView(self, self.FurnitureSlot)

		furnitureCell:SetItem(self.manufactureItemData.cfgManufactureItem.GetItem, true)

		local cfgItem = CfgItemTable[self.manufactureItemData.cfgManufactureItem.GetItem]

		UGUIUtil.SetText(self.TextName, FurnitureSlotApi:GetString("TextColorName", cfgItem.Name, cfgItem.Quality))
		UGUIUtil.SetText(self.TextHave, HomeLandManufactureListUIApi:GetString("TextHave", self.manufactureItemData:HaveNumber()))
		UGUIUtil.SetText(self.TextTag1, self.manufactureItemData.cfgManufactureItem.Score)
		self.Tag2:SetActive(self.manufactureItemData:IsCanMake())
		self.Tag1:SetActive(self.manufactureItemData.cfgManufactureItem.Score > 0)
		self.Tag3:SetActive(not self.manufactureItemData.isLock)
		self.GrayComponent:EnableGray(not self.manufactureItemData.isLock)
	end
end

function HomeLandThemeDecorateCell:SetSelect(select)
	self.ImgCheck:SetActive(select)
end

function HomeLandThemeDecorateCell:Dispose()
	self:RemoveListener()
	FurnitureSlot.DisposeIn(self)
	LuaCodeInterface.ClearOutlet(self.goView, self)
	UnityEngine.GameObject.Destroy(self.goView)

	self.goView = nil
end

return HomeLandThemeDecorateCell
