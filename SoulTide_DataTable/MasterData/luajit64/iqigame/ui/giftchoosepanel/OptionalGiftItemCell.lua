-- chunkname: @IQIGame\\UI\\GiftChoosePanel\\OptionalGiftItemCell.lua

local m = {
	IsSelect = false,
	TYPE_SOUL = 3,
	TYPE_EQUIP = 2,
	TYPE_NORMAL = 1
}

function m.New(view, onClick)
	local obj = Clone(m)

	obj:Init(view, onClick)

	return obj
end

function m:Init(view, onClick)
	self.View = view
	self.OnClickCallback = onClick

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickSelf()
		self:OnClickSelf()
	end

	function self.DelegateOnClickItemIcon()
		self:OnClickItemIcon()
	end

	self.EquipCell = EquipCell.New(self.EquipGo)

	UGUIUtil.SetText(self.OnSelectLabel, GiftChoosePanelUIApi:GetString("CellSelectLabel", true))
	UGUIUtil.SetText(self.OffSelectLabel, GiftChoosePanelUIApi:GetString("CellSelectLabel", false))
	self:AddListeners()
end

function m:AddListeners()
	self.View:GetComponent("Button").onClick:AddListener(self.DelegateOnClickSelf)
	self.ItemIcon:GetComponent("Button").onClick:AddListener(self.DelegateOnClickItemIcon)
end

function m:RemoveListeners()
	self.View:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickSelf)
	self.ItemIcon:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickItemIcon)
end

function m:SetData(itemCid, num, soulIdResMap)
	self.CfgItemData = CfgItemTable[itemCid]

	local type = m.TYPE_NORMAL
	local soulCid = 0

	if self.CfgItemData.Type == Constant.ItemType.Equip then
		type = m.TYPE_EQUIP
	else
		local isSoulItem, cid = ItemModule.IsSoulItem(self.CfgItemData)

		if isSoulItem then
			soulCid = cid
			type = m.TYPE_SOUL
		end
	end

	for i = 1, 3 do
		self["ViewType" .. i]:SetActive(i == type)
	end

	if type == m.TYPE_NORMAL then
		AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(self.CfgItemData.Icon), self.ItemIcon:GetComponent("Image"))
		UGUIUtil.SetText(self.ItemNumText, GiftChoosePanelUIApi:GetString("CellItemNumText", num))
	elseif type == m.TYPE_EQUIP then
		self.EquipCell:RefreshByCID(itemCid, nil, true)
	else
		local soulResCid = soulIdResMap[soulCid]
		local cfgSoulResData = CfgSoulResTable[soulResCid]

		AssetUtil.LoadImage(self, UIGlobalApi.GetHarmoniousImagePath(cfgSoulResData.SoulSitImage), self.SoulImage:GetComponent("Image"))
	end

	UGUIUtil.SetText(self.OnNameText, self.CfgItemData.Name)
	UGUIUtil.SetText(self.OffNameText, self.CfgItemData.Name)
	self:SetSelect(false)
end

function m:OnClickSelf()
	self.OnClickCallback(self)
end

function m:SetSelect(value)
	self.IsSelect = value

	self.OnView:SetActive(value)
	self.OffView:SetActive(not value)
end

function m:OnClickItemIcon()
	ItemModule.OpenTipByData(self.CfgItemData, true, true)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListeners()
	self.EquipCell:OnDestroy()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
