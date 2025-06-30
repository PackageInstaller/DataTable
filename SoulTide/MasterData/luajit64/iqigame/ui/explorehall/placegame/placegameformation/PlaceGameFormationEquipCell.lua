-- chunkname: @IQIGame\\UI\\ExploreHall\\PlaceGame\\PlaceGameFormation\\PlaceGameFormationEquipCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	self:AddListener()
end

function m:AddListener()
	return
end

function m:RemoveListener()
	return
end

function m:SetData(itemData)
	self.NormalView:SetActive(itemData ~= nil)
	self.EmptyView:SetActive(itemData == nil)

	if itemData == nil then
		return
	end

	local isUsingSkin = false

	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(itemData:GetCfg().Icon), self.Icon:GetComponent("Image"))
	self.SkinFrame:SetActive(isUsingSkin)

	if isUsingSkin then
		AssetUtil.LoadImage(self, CommonSlotUIApi:GetString("QualityFramePath", itemData:GetCfg().Quality, isUsingSkin), self.SkinFrame:GetComponentInChildren(typeof(UnityEngine.UI.Image)))
	end

	local simpleStarComponent = self.Star:GetComponent("SimpleStarComponent")

	simpleStarComponent:UpdateView(itemData:GetCfg().StarLimit, 1)
	self.Star:SetActive(false)
	AssetUtil.LoadImage(self, FormationUIApi:GetString("SmallEquipCellQualityIconPath", itemData:GetCfg().Quality), self.QualityIcon:GetComponent("Image"))
	UGUIUtil.SetText(self.LevelText, FormationUIApi:GetString("SmallEquipCellLevelText", itemData.placeGameEquipData.placeGameEquipPOD.level))
	AssetUtil.LoadImage(self, MiscApi:GetString("equipClassIcon", itemData:GetCfg().SubType), self.TypeIcon:GetComponent("Image"))
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
