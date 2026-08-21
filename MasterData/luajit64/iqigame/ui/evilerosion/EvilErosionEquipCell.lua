-- chunkname: @IQIGame\\UI\\EvilErosion\\EvilErosionEquipCell.lua

local m = {
	Index = 0
}

function m.New(view, index, onClick)
	local obj = Clone(m)

	obj:Init(view, index, onClick)

	return obj
end

function m:Init(view, index, onClick)
	self.View = view
	self.Index = index
	self.OnClickCallback = onClick

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickView()
		self:OnClickView()
	end

	self:AddListeners()
end

function m:AddListeners()
	self.View:GetComponent("Button").onClick:AddListener(self.DelegateOnClickView)
end

function m:RemoveListeners()
	self.View:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickView)
end

function m:SetData(itemData)
	self.EmptyView:SetActive(itemData == nil)
	self.NormalView:SetActive(itemData ~= nil)

	if itemData == nil then
		return
	end

	local cfgItemData = itemData:GetCfg()

	UGUIUtil.SetText(self.LevelText, CommonSlotUIApi:GetString("goEquipLv", itemData.equipData.lv, false))
	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(cfgItemData.Icon), self.Icon:GetComponent("Image"))
	AssetUtil.LoadImage(self, EquipUIApi:GetString("qualityIconPath", cfgItemData.Quality), self.QualityIcon:GetComponent("Image"))
	AssetUtil.LoadImage(self, MiscApi:GetString("equipClassIcon", cfgItemData.SubType), self.TypeIcon:GetComponent("Image"))

	local starComponent = self.Star:GetComponent("SimpleStarComponent")

	starComponent:UpdateView(cfgItemData.StarLimit, itemData.equipData.star)
end

function m:OnClickView()
	self.OnClickCallback(self.Index)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.OnClickCallback = nil
end

return m
