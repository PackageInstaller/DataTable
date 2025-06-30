-- chunkname: @IQIGame\\UI\\FormationUI\\FormationEquipSmallCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
end

function m:SetData(itemData)
	self.NormalView:SetActive(itemData ~= nil)
	self.EmptyView:SetActive(itemData == nil)

	if itemData == nil then
		return
	end

	local cfgItemData = itemData:GetCfg()
	local equipShowInfo, isUsingSkin = EquipModule.GetEquipShowInfo(cfgItemData.Id)

	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(equipShowInfo.Icon), self.Icon:GetComponent("Image"))
	self.SkinFrame:SetActive(isUsingSkin)

	if isUsingSkin then
		AssetUtil.LoadImage(self, CommonSlotUIApi:GetString("QualityFramePath", cfgItemData.Quality, isUsingSkin), self.SkinFrame:GetComponentInChildren(typeof(UnityEngine.UI.Image)))
	end

	local simpleStarComponent = self.Star:GetComponent("SimpleStarComponent")

	simpleStarComponent:UpdateView(cfgItemData.StarLimit, itemData.equipData.star)
	AssetUtil.LoadImage(self, FormationUIApi:GetString("SmallEquipCellQualityIconPath", cfgItemData.Quality), self.QualityIcon:GetComponent("Image"))
	UGUIUtil.SetText(self.LevelText, FormationUIApi:GetString("SmallEquipCellLevelText", itemData.equipData.lv))
	AssetUtil.LoadImage(self, MiscApi:GetString("equipClassIcon", cfgItemData.SubType), self.TypeIcon:GetComponent("Image"))
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
