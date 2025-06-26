-- chunkname: @IQIGame\\UI\\ExploreHall\\PlaceGame\\PlaceGamePlayerSkill\\PlaceGamePlayerSkillGroupCell.lua

local m = {
	classTypeCellPool = {},
	tagTypeCellPool = {}
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	for i = 1, 4 do
		if i <= 2 then
			self.classTypeCellPool[#self.classTypeCellPool + 1] = self.goTypeParent.transform:Find("type_" .. i).gameObject
		else
			self.tagTypeCellPool[#self.tagTypeCellPool + 1] = self.goTypeParent.transform:Find("type_" .. i).gameObject
		end
	end

	self:AddListener()
end

function m:AddListener()
	return
end

function m:RemoveListener()
	return
end

function m:SetData(data)
	self.placeGameSoulData = data

	self:UpdateView()
end

function m:UpdateView()
	if self.placeGameSoulData then
		local cfgGroupData = CfgSkillGroupTable[self.placeGameSoulData:GetCfgPlaceGameSoulData().DefaultSkill]

		UGUIUtil.SetText(self.goName, cfgGroupData.GroupName)
		AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(cfgGroupData.Icon), self.goIcon:GetComponent("Image"))

		for i = 1, 2 do
			local typeCell = self.classTypeCellPool[i]

			if i <= #cfgGroupData.SoulClass then
				UGUIUtil.SetTextInChildren(typeCell, PlaceGamePlayerSkillUIApi:GetString("SoulClassTxt", cfgGroupData.SoulClass[i]))

				local bg = typeCell.transform:Find("Image"):GetComponent("Image")

				AssetUtil.LoadImage(self, PlaceGamePlayerSkillUIApi:GetString("SoulClassBgImage", cfgGroupData.SoulClass[i]), bg)
				typeCell:SetActive(true)
			else
				typeCell:SetActive(false)
			end
		end

		for i = 1, 2 do
			local typeCell = self.tagTypeCellPool[i]

			if i <= #cfgGroupData.SkillTag then
				UGUIUtil.SetTextInChildren(typeCell, PlaceGamePlayerSkillUIApi:GetString("SkillTag", cfgGroupData.SkillTag[i]))
				typeCell:SetActive(true)
			else
				typeCell:SetActive(false)
			end
		end
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
