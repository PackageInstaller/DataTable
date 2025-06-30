-- chunkname: @IQIGame\\UI\\ExploreHall\\RestaurantOperation\\RestaurantGetPanelCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.ItemCell = ItemCell.New(self.ItemCellMould)

	self:AddListeners()
end

function m:AddListeners()
	return
end

function m:RemoveListeners()
	return
end

function m:SetItem(itemData, tag)
	self.View:SetActive(itemData ~= nil)

	if itemData == nil then
		return
	end

	self.ItemCell:SetItem(itemData)

	self.ItemNameText:GetComponent("Text").text = RestaurantOperationGetPanelUIApi:GetString("ItemNameText", itemData:GetCfg().Name)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListeners()
	self.ItemCell:Dispose()

	self.ItemCell = nil

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
