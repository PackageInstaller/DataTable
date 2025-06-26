-- chunkname: @IQIGame\\UI\\ExploreHall\\Survival\\SurvivalChallengeFormation\\SurvivalPlayerAttrCell.lua

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

function m:SetData(attrID, value, showMaxLv, nextLvValue)
	UGUIUtil.SetText(self.AttrTitle, CfgSurvivalChallengeAttributeTable[attrID].AttName)

	if attrID == FlyGameConstant.Attribute.FlyGame_Weapon_Level then
		UGUIUtil.SetText(self.AttrValue, ExploreHallUIApi:GetString("SurvivalAttrWeaponLevel", value))

		if nextLvValue and self.NextAttrValue then
			UGUIUtil.SetText(self.NextAttrValue, ExploreHallUIApi:GetString("SurvivalAttrWeaponLevel", nextLvValue))
		end
	else
		UGUIUtil.SetText(self.AttrValue, string.format("%.2f", value))

		if nextLvValue and self.NextAttrValue then
			UGUIUtil.SetText(self.NextAttrValue, string.format("%.2f", nextLvValue))
		end
	end

	local path = UIGlobalApi.GetImagePath(CfgSurvivalChallengeAttributeTable[attrID].ImageIcon)

	AssetUtil.LoadImage(self, path, self.ImgIcon:GetComponent("Image"))

	if self.MaxLv then
		self.MaxLv:SetActive(not showMaxLv)
	end
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
