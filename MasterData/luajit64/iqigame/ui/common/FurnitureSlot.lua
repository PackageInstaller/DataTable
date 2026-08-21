-- chunkname: @IQIGame\\UI\\Common\\FurnitureSlot.lua

local FurnitureSlot = {
	isSelected = false
}

function FurnitureSlot.PackageOrReuseView(ui, mouldPrefab)
	if ui == nil or mouldPrefab == nil then
		return nil
	end

	if ui.__SUB_UI_MAP_MailMouldCell == nil then
		ui.__SUB_UI_MAP_MailMouldCell = {}
	end

	local subUIMap = ui.__SUB_UI_MAP_MailMouldCell
	local furnitureSlot

	if subUIMap[mouldPrefab:GetInstanceID()] == nil then
		furnitureSlot = FurnitureSlot:__New(mouldPrefab)
		subUIMap[mouldPrefab:GetInstanceID()] = furnitureSlot
	else
		furnitureSlot = subUIMap[mouldPrefab:GetInstanceID()]
	end

	return furnitureSlot
end

function FurnitureSlot:__New(itemCellView)
	local itemCell = Clone(self)

	itemCell.tabComponent = {}
	itemCell.goView = itemCellView

	LuaCodeInterface.BindOutlet(itemCell.goView, itemCell.tabComponent)

	return itemCell
end

function FurnitureSlot.DisposeIn(ui)
	if ui.__SUB_UI_MAP_MailMouldCell == nil then
		return
	end

	for i, itemCell in pairs(ui.__SUB_UI_MAP_MailMouldCell) do
		itemCell:OnDestroy()

		itemCell.tabComponent = nil
		itemCell.goView = nil
	end

	ui.__SUB_UI_MAP_MailMouldCell = nil
end

function FurnitureSlot:SetItem(cfgItemID, isOpen, decorateID)
	self.cfgItemID = cfgItemID
	self.isOpen = isOpen
	self.cfgDecorateID = decorateID

	if self.cfgItemID == nil then
		self:Clear()
	else
		self:Update()
	end
end

function FurnitureSlot:Update()
	if self.cfgItemID ~= nil then
		local cfgItem = CfgItemTable[self.cfgItemID]

		if cfgItem == nil then
			logError("Error 装饰配置错误 " .. self.data.cfgID)

			return
		end

		local iconPath = UIGlobalApi.GetIconPath(cfgItem.Icon)

		AssetUtil.LoadImage(self, iconPath, self.tabComponent.ImageIcon:GetComponent("Image"))
		self.tabComponent.Bg1:SetActive(self.isOpen)

		local bgPath = CommonSlotUIApi:GetString("QualityBackgroundPath", cfgItem.Quality)

		AssetUtil.LoadImage(self, bgPath, self.tabComponent.Bg1:GetComponent("Image"))
		self.goView:GetComponent("ImageGroupGrayComponent"):EnableGray(not self.isOpen)
		self:SetSelected(false)
	end
end

function FurnitureSlot:SetNum(num, isShow)
	self.tabComponent.TextNum:SetActive(isShow)

	self.tabComponent.TextNum:GetComponent("Text").text = num .. ""
end

function FurnitureSlot:SetSelected(top)
	self.isSelected = top
end

function FurnitureSlot:Clear()
	self.goView:SetActive(false)
end

function FurnitureSlot:OnDestroy()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.goView, self.tabComponent)

	self.goView = nil
	self.tabComponent = nil
end

return FurnitureSlot
