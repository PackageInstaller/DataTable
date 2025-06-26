-- chunkname: @IQIGame\\UI\\HomeLandPlant\\HomeLandPlantSeedCell.lua

HomeLandPlantSeedCell = {}

function HomeLandPlantSeedCell:New(itemCellView)
	local itemCell = Clone(HomeLandPlantSeedCell)

	itemCell:Init(itemCellView)

	return itemCell
end

function HomeLandPlantSeedCell:Init(view)
	self.goView = view

	LuaCodeInterface.BindOutlet(self.goView, self)

	self.uiDrag = self.DragImg:GetComponent("UIDrag")
	self.dragImg = self.DragImg:GetComponent("Image")

	function self.delegateOnBeginDrag(eventData)
		self:BeginDrag(eventData)
	end

	function self.delegateOnDrag(eventData)
		self:OnDrag(eventData)
	end

	function self.delegateOnReachTargetSuccess(rect)
		self:ReachTargetSuccess(rect)
	end

	function self.delegateOnReachTargetFailure(eventData)
		self:ReachTargetFailure(eventData)
	end

	self:AddListener()
end

function HomeLandPlantSeedCell:AddListener()
	self.uiDrag.onBeginDrag = self.delegateOnBeginDrag
	self.uiDrag.onDrag = self.delegateOnDrag
	self.uiDrag.onReachTargetSuccess = self.delegateOnReachTargetSuccess
	self.uiDrag.onReachTargetFailure = self.delegateOnReachTargetFailure
end

function HomeLandPlantSeedCell:RemoveListener()
	self.uiDrag.onBeginDrag = nil
	self.uiDrag.onDrag = nil
	self.uiDrag.onReachTargetSuccess = nil
	self.uiDrag.onReachTargetFailure = nil
end

function HomeLandPlantSeedCell:SetDate(data, parent)
	self.parent = parent
	self.cfgPlantData = data

	local color = self.dragImg.color

	self.dragImg.color = Color.New(color.r, color.g, color.b, 0)

	if self.cfgPlantData then
		local itemData = CfgItemTable[self.cfgPlantData.CostItem]
		local num = WarehouseModule.GetItemNumByCfgID(self.cfgPlantData.CostItem)
		local itemCell = ItemCell.PackageOrReuseView(self, self.Slot.transform:GetChild(0).gameObject, false)

		itemCell:SetItem(itemData)
		itemCell:SetNum(num)
		UGUIUtil.SetText(self.TextName, itemData.Name)
		AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(itemData.Icon), self.dragImg)
	end
end

function HomeLandPlantSeedCell:BeginDrag(eventData)
	local color = self.dragImg.color

	self.dragImg.color = Color.New(color.r, color.g, color.b, 1)
	self.lastPos = self.DragImg.transform.position

	self.uiDrag.transform:SetParent(self.parent.UIController.gameObject.transform, false)
end

function HomeLandPlantSeedCell:OnDrag(eventData)
	local isDragInTarget = self.uiDrag.IsDragInTarget
	local scale = Vector3.New(1, 1, 1)

	if isDragInTarget then
		scale = Vector3.New(1.5, 1.5, 1.5)
	end

	self.DragImg.transform.localScale = scale
end

function HomeLandPlantSeedCell:ReachTargetSuccess(rect)
	local decorateId = tonumber(rect.gameObject.name)

	self:OnPlant(decorateId)
	self:SetDefault()
end

function HomeLandPlantSeedCell:ReachTargetFailure(eventData)
	self:SetDefault()
end

function HomeLandPlantSeedCell:SetDefault()
	local color = self.dragImg.color

	self.dragImg.color = Color.New(color.r, color.g, color.b, 0)

	self.uiDrag.transform:SetParent(self.goView.transform, false)

	self.uiDrag.transform.position = self.lastPos
end

function HomeLandPlantSeedCell:OnPlant(decorateId)
	if self.plantCallBack then
		self.plantCallBack(decorateId, self.cfgPlantData)
	end
end

function HomeLandPlantSeedCell:Dispose()
	AssetUtil.UnloadAsset(self)

	self.plantCallBack = nil

	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.goView, self)

	self.goView = nil
end

return HomeLandPlantSeedCell
