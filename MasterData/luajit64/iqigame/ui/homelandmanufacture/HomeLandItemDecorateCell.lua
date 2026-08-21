-- chunkname: @IQIGame\\UI\\HomeLandManufacture\\HomeLandItemDecorateCell.lua

HomeLandItemDecorateCell = {}

local FurnitureSlot = require("IQIGame.UI.Common.FurnitureSlot")

function HomeLandItemDecorateCell.PackageOrReuseView(ui, mouldPrefab)
	if ui == nil or mouldPrefab == nil then
		return nil
	end

	if ui.__SUB_UI_MAP_ItemDecorateCell == nil then
		ui.__SUB_UI_MAP_ItemDecorateCell = {}
	end

	local subUIMap = ui.__SUB_UI_MAP_ItemDecorateCell
	local queueRender

	if subUIMap[mouldPrefab:GetInstanceID()] == nil then
		queueRender = HomeLandItemDecorateCell:__New(mouldPrefab)
		subUIMap[mouldPrefab:GetInstanceID()] = queueRender
	else
		queueRender = subUIMap[mouldPrefab:GetInstanceID()]
	end

	return queueRender
end

function HomeLandItemDecorateCell:__New(itemCellView)
	local itemCell = Clone(HomeLandItemDecorateCell)

	itemCell:Init(itemCellView)

	return itemCell
end

function HomeLandItemDecorateCell:Init(view)
	self.goView = view

	LuaCodeInterface.BindOutlet(self.goView, self)
	self:AddListener()
end

function HomeLandItemDecorateCell.DisposeIn(ui)
	if ui.__SUB_UI_MAP_ItemDecorateCell == nil then
		return
	end

	for i, itemCell in pairs(ui.__SUB_UI_MAP_ItemDecorateCell) do
		itemCell:Dispose()
	end

	ui.__SUB_UI_MAP_ItemDecorateCell = nil
end

function HomeLandItemDecorateCell:AddListener()
	return
end

function HomeLandItemDecorateCell:RemoveListener()
	return
end

function HomeLandItemDecorateCell:SetDate(data)
	self.manufactureItemData = data

	if self.manufactureItemData then
		local furnitureCell = FurnitureSlot.PackageOrReuseView(self, self.FurnitureSlot)

		furnitureCell:SetItem(self.manufactureItemData.cfgManufactureItem.GetItem, true)

		local cfgItem = CfgItemTable[self.manufactureItemData.cfgManufactureItem.GetItem]

		UGUIUtil.SetText(self.TextName, cfgItem.Name)
		UGUIUtil.SetText(self.TextHave, HomeLandManufactureListUIApi:GetString("TextHave", self.manufactureItemData:HaveNumber()))
		UGUIUtil.SetText(self.TextTag1, self.manufactureItemData.cfgManufactureItem.Score)
		self.Tag2:SetActive(self.manufactureItemData:IsCanMake())
		self.Tag1:SetActive(self.manufactureItemData.cfgManufactureItem.Score > 0)
	end
end

function HomeLandItemDecorateCell:SetSelect(select)
	self.ImgCheck:SetActive(select)
end

function HomeLandItemDecorateCell:Dispose()
	self:RemoveListener()
	FurnitureSlot.DisposeIn(self)
	LuaCodeInterface.ClearOutlet(self.goView, self)
	UnityEngine.GameObject.Destroy(self.goView)

	self.goView = nil
end

return HomeLandItemDecorateCell
