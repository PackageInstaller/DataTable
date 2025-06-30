-- chunkname: @IQIGame\\UI\\Bag\\BagItemCell.lua

local m = {}

function m.PackageOrReuseView(ui, cellGo, clickHandler)
	if ui == nil or cellGo == nil then
		return nil
	end

	if ui.__SUB_UI_MAP_BagItemCell == nil then
		ui.__SUB_UI_MAP_BagItemCell = {}
	end

	local subUIMap = ui.__SUB_UI_MAP_BagItemCell
	local itemCell

	if subUIMap[cellGo:GetInstanceID()] == nil then
		itemCell = m.__New(cellGo, clickHandler)
		subUIMap[cellGo:GetInstanceID()] = itemCell
	else
		itemCell = subUIMap[cellGo:GetInstanceID()]
	end

	return itemCell
end

function m.GetIn(ui, instanceID)
	if ui.__SUB_UI_MAP_BagItemCell == nil then
		return
	end

	return ui.__SUB_UI_MAP_BagItemCell[instanceID]
end

function m.ForeachAll(ui, handler)
	if ui.__SUB_UI_MAP_BagItemCell == nil then
		return
	end

	for insId, itemCell in pairs(ui.__SUB_UI_MAP_BagItemCell) do
		if handler(itemCell) then
			return
		end
	end
end

function m.DisposeIn(ui)
	if ui.__SUB_UI_MAP_BagItemCell == nil then
		return
	end

	for i, itemCell in pairs(ui.__SUB_UI_MAP_BagItemCell) do
		itemCell:Dispose()
	end

	ui.__SUB_UI_MAP_BagItemCell = nil
end

function m:Dispose()
	self.View:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClick)
	self.ItemCell:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function m.__New(view, clickHandler)
	local obj = Clone(m)

	obj:Init(view, clickHandler)

	return obj
end

function m:Init(view, clickHandler)
	self.View = view
	self.clickHandler = clickHandler

	LuaCodeInterface.BindOutlet(view, self)
	self.newTag:SetActive(false)

	function self.DelegateOnClick()
		if self.clickHandler ~= nil then
			self.clickHandler(self)
		end
	end

	self.ItemCell = ItemCell.New(self.CommonSlotUI, true, false)

	self.ItemCell:SetClickHandler(self.DelegateOnClick, self)
end

function m:SetItem(itemData)
	local cfgItemData = itemData:GetCfg()

	self.ItemCell:SetItem(itemData)

	self.itemData = itemData

	self.newTag:SetActive(itemData.flag)
	self.lockImg:SetActive(false)

	if itemData.Type == Constant.ItemType.Equip then
		self.ItemCell:SetLockVisable(itemData.equipData.isLock)
	elseif itemData.Type == Constant.ItemType.Skill then
		self.ItemCell:SetLockVisable(itemData.skillData.lock)
	else
		self.ItemCell:SetLockVisable(false)
	end

	if self.RedDot ~= nil then
		if cfgItemData.ItemTypes == Constant.ItemType.HeroDebris and cfgItemData.ItemSubTypes == 1 then
			self.RedDot:SetActive(RedDotModule.CanShowRedDot_CharacterFragItem(cfgItemData))
		else
			self.RedDot:SetActive(false)
		end
	end
end

function m:SetSelectItemId(selectId)
	self.ItemCell:SetSelectFrame(self.ItemCell.ItemCfgOrData.id == selectId)
end

function m:SetSelectState(state)
	self.ItemCell:SetSelectFrame(state)
end

return m
