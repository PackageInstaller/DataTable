-- chunkname: @IQIGame\\UI\\HomeLandManufacture\\HomeLandMakeItemCell.lua

HomeLandMakeItemCell = {}

function HomeLandMakeItemCell:__New(itemCellView)
	local itemCell = Clone(HomeLandMakeItemCell)

	itemCell:Init(itemCellView)

	return itemCell
end

function HomeLandMakeItemCell:Init(view)
	self.goView = view

	LuaCodeInterface.BindOutlet(self.goView, self)
	self:AddListener()
end

function HomeLandMakeItemCell:AddListener()
	return
end

function HomeLandMakeItemCell:RemoveListener()
	return
end

function HomeLandMakeItemCell:SetDate(itemId, needNum)
	local itemCell = ItemCell.PackageOrReuseView(self, self.Slot)
	local cfgItem = CfgItemTable[itemId]

	itemCell:SetItem(cfgItem)
	itemCell:SetNum(needNum)
end

function HomeLandMakeItemCell:Dispose()
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.goView, self)
	UnityEngine.GameObject.DestroyImmediate(self.goView)

	self.goView = nil
end

return HomeLandMakeItemCell
