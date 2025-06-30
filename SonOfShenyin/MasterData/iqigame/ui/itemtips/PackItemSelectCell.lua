-- chunkname: @IQIGame\\UI\\ItemTips\\PackItemSelectCell.lua

local m = {}

function m.PackageOrReuseView(ui, view)
	if ui == nil or view == nil then
		return nil
	end

	if ui.__SUB_UI_MAP_SelectItemCell == nil then
		ui.__SUB_UI_MAP_SelectItemCell = {}
	end

	local subUIMap = ui.__SUB_UI_MAP_SelectItemCell
	local itemCell

	if subUIMap[view:GetInstanceID()] == nil then
		itemCell = m.New(view)
		subUIMap[view:GetInstanceID()] = itemCell
	else
		itemCell = subUIMap[view:GetInstanceID()]
	end

	return itemCell
end

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.itemCell = ItemCell.New(self.goSlotParent.transform:GetChild(0).gameObject, false, true)

	self.itemCell:SetMouseEnabled(false)
	self:AddListeners()
end

function m:AddListeners()
	return
end

function m:RemoveListeners()
	return
end

function m:SetData(data)
	self.itemData = data

	self:RefreshDatum()
	self:RefreshMisc()
end

function m:RefreshDatum()
	if self.itemData.classType ~= "ItemData" then
		self.itemData = ItemData.CreateByCIDAndNumber(self.itemData.cid, self.itemData.num)
	end

	self.cfgItemData = self.itemData:GetCfg()
end

function m:RefreshMisc()
	self.goName:GetComponent("Text").text = self.cfgItemData.Name
	self.goNumText:GetComponent("Text").text = "X" .. self.itemData.num

	local path = ItemTipsApi:GetQualityBottomImg(self.cfgItemData.Quality)

	AssetUtil.LoadImage(self, path, self.QualityImg:GetComponent("Image"))
	self.goSlotParent:SetActive(self.cfgItemData.ItemTypes == Constant.ItemType.Skill)
	self.ItemImg:SetActive(self.cfgItemData.ItemTypes ~= Constant.ItemType.Skill)

	path = UIGlobalApi.GetIconPath(self.cfgItemData.Icon)

	AssetUtil.LoadImage(self, path, self.ItemImg:GetComponent("Image"))
	self.itemCell:SetItem(self.itemData, 1)

	local starComp = self.goStar:GetComponent("SimpleStarComponent")

	starComp:UpdateView(self.cfgItemData.Quality, 0)
end

function m:OnClickCell()
	self:OnSelected()
end

function m:OnSelected()
	self.SelectImg:SetActive(true)
end

function m:OnUnselected()
	self.SelectImg:SetActive(false)
end

function m:Dispose()
	self:RemoveListeners()
	self.itemCell:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
