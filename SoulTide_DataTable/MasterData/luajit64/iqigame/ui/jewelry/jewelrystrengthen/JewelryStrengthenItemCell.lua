-- chunkname: @IQIGame\\UI\\Jewelry\\JewelryStrengthen\\JewelryStrengthenItemCell.lua

local m = {
	jewelryAttrCells = {}
}
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local JewelryAttrCell = require("IQIGame.UI.Jewelry.JewelryAttrCell")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.itemCell = ItemCell.New(self.CommonSlot, false)

	self.AttrMould:SetActive(false)

	self.jewelryAttrCellPool = UIObjectPool.New(4, function()
		return JewelryAttrCell.New(UnityEngine.Object.Instantiate(self.AttrMould))
	end, function(cell)
		cell:Dispose()
	end)

	self.StarNode:SetActive(true)
	self:AddListener()
end

function m:AddListener()
	return
end

function m:RemoveListener()
	return
end

function m:SetData(data, star, Quality)
	self.itemData = data
	self.star = star
	self.quality = Quality

	self:UpdateView()
end

function m:UpdateView()
	if self.itemData then
		self.itemCell:SetItem(self.itemData)
		self.itemCell.View.goStar:SetActive(false)
		self.itemCell:ShowWearJewelryQuality(self.quality)

		for i, v in pairs(self.jewelryAttrCells) do
			v.View.transform:SetParent(self.View:GetComponentInParent(typeof(UIController)).transform, false)
			v.View:SetActive(false)
			self.jewelryAttrCellPool:Release(v)
		end

		self.jewelryAttrCells = {}

		if self.itemData:GetCfg().JewelryPabilityID > 0 then
			local cell = self.jewelryAttrCellPool:Obtain()

			cell.View:SetActive(true)
			cell.View.transform:SetParent(self.AttrGrid.transform, false)
			cell:SetData(self.itemData:GetCfg().JewelryPabilityID)
			table.insert(self.jewelryAttrCells, cell)
		end

		self:ShowStar(JewelryModule.JewelryMaxStarLv, self.star)
	end
end

function m:ShowStar(maxStar, star)
	local starComp = self.StarNode:GetComponent("SimpleStarComponent")

	starComp:UpdateView(maxStar, star)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	self.itemCell:Dispose()

	self.itemCell = nil

	for i, v in pairs(self.jewelryAttrCells) do
		self.jewelryAttrCellPool:Release(v)
	end

	self.jewelryAttrCells = {}

	self.jewelryAttrCellPool:Dispose()

	self.jewelryAttrCellPool = nil

	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
