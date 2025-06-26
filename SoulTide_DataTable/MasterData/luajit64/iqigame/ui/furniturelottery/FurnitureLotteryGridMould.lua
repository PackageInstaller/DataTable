-- chunkname: @IQIGame\\UI\\FurnitureLottery\\FurnitureLotteryGridMould.lua

local FurnitureLotteryGridMould = {}
local FurnitureSlot = require("IQIGame.UI.Common.FurnitureSlot")

function FurnitureLotteryGridMould.PackageOrReuseView(ui, cellGo)
	if ui == nil or cellGo == nil then
		return nil
	end

	if ui.__SUB_UI_MAP_LotteryGridMouldCell == nil then
		ui.__SUB_UI_MAP_LotteryGridMouldCell = {}
	end

	local subUIMap = ui.__SUB_UI_MAP_LotteryGridMouldCell
	local itemCell

	if subUIMap[cellGo:GetInstanceID()] == nil then
		itemCell = FurnitureLotteryGridMould.__New(cellGo)
		subUIMap[cellGo:GetInstanceID()] = itemCell
	else
		itemCell = subUIMap[cellGo:GetInstanceID()]
	end

	return itemCell
end

function FurnitureLotteryGridMould.DisposeIn(ui)
	if ui.__SUB_UI_MAP_LotteryGridMouldCell == nil then
		return
	end

	for i, itemCell in pairs(ui.__SUB_UI_MAP_LotteryGridMouldCell) do
		itemCell:Dispose()
	end

	ui.__SUB_UI_MAP_LotteryGridMouldCell = nil
end

function FurnitureLotteryGridMould.__New(view)
	local obj = Clone(FurnitureLotteryGridMould)

	obj:Init(view)

	return obj
end

function FurnitureLotteryGridMould:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
end

function FurnitureLotteryGridMould:SetData(cid, value)
	self.cfgItemID = cid
	self.value = value

	self.View:SetActive(cid ~= nil)
	self.Tag:SetActive(value ~= nil)

	local cfgItem = CfgItemTable[self.cfgItemID]

	if cfgItem ~= nil then
		self.TextName:GetComponent("Text").text = FurnitureSlotApi:GetString("TextColorName", cfgItem.Name, cfgItem.Quality)
		self.TextValue:GetComponent("Text").text = tostring(value)

		local item = self.Slot.transform:GetChild(0).gameObject
		local furnitureCell = FurnitureSlot.PackageOrReuseView(self, item)

		furnitureCell:SetItem(cid, true)
	end
end

function FurnitureLotteryGridMould:Dispose()
	FurnitureSlot.DisposeIn(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.Stars = nil
end

return FurnitureLotteryGridMould
