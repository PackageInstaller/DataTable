-- chunkname: @IQIGame\\UI\\GetPanel\\GetPanelItemCell.lua

local m = {}

function m.PackageOrReuseView(ui, cellGo)
	if ui == nil or cellGo == nil then
		return nil
	end

	if ui.__SUB_UI_MAP_GetPanelItemCell == nil then
		ui.__SUB_UI_MAP_GetPanelItemCell = {}
	end

	local subUIMap = ui.__SUB_UI_MAP_GetPanelItemCell
	local itemCell

	if subUIMap[cellGo:GetInstanceID()] == nil then
		itemCell = m.New(cellGo)
		subUIMap[cellGo:GetInstanceID()] = itemCell
	else
		itemCell = subUIMap[cellGo:GetInstanceID()]
	end

	return itemCell
end

function m.DisposeIn(ui)
	if ui.__SUB_UI_MAP_GetPanelItemCell == nil then
		return
	end

	for i, itemCell in pairs(ui.__SUB_UI_MAP_GetPanelItemCell) do
		itemCell:Dispose()
	end

	ui.__SUB_UI_MAP_GetPanelItemCell = nil
end

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(view, self)

	local itemCellGO = self.ItemCellParent.transform:GetChild(0).gameObject

	self.ItemCell = ItemCell.New(itemCellGO, true, true, true)
end

function m:SetItem(itemData, tag)
	if itemData == nil then
		self:Hide()

		return
	end

	self.ItemCell:SetItem(itemData)
	self.ItemCell:SetNum(itemData.num)

	self.ItemNameText:GetComponent("Text").text = ""
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:PlayInAnim()
	LuaUtility.RePlayAnimationWithName(self.View, "GetPanelUI_04_In")
end

function m:PlayOutAnim()
	LuaUtility.RePlayAnimationWithName(self.View, "GetPanelUI_05_Out")
end

function m:EnableEffect()
	LuaUtility.SetGameObjectShow(self.Effect, true)
end

function m:DisableEffect()
	LuaUtility.SetGameObjectShow(self.Effect, false)
end

function m:Dispose()
	self.ItemCell:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View.gameObject)

	self.View = nil
end

return m
