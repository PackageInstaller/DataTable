-- chunkname: @IQIGame\\UI\\ExploreHall\\PlaceGame\\PlaceGameFormationChooseSoul\\PlaceGameFormationSkillGroupItem.lua

local m = {
	classTags = {},
	typeTags = {},
	skillCells = {}
}
local PlaceGameFormationSkillCell = require("IQIGame.UI.ExploreHall.PlaceGame.PlaceGameFormationChooseSoul.PlaceGameFormationSkillCell")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.classTags = {}

	for i = 1, 2 do
		local tagGo = UnityEngine.Object.Instantiate(self.TagPrefab)

		tagGo.transform:SetParent(self.TagGrid.transform, false)

		self.classTags[i] = tagGo
	end

	self.typeTags = {}

	for i = 1, 2 do
		local tagGo = UnityEngine.Object.Instantiate(self.TagPrefab)

		tagGo.transform:SetParent(self.TagGrid.transform, false)

		self.typeTags[i] = tagGo
	end

	self.skillCells = {}

	for i = 1, 4 do
		local cell = PlaceGameFormationSkillCell.New(UnityEngine.Object.Instantiate(self.SkillCellPrefab))

		cell.View.transform:SetParent(self.SkillGrid.transform, false)

		self.skillCells[i] = cell
	end

	self:AddListener()
end

function m:AddListener()
	return
end

function m:RemoveListener()
	return
end

function m:SetData(placeGameSoulData)
	self.soulData = placeGameSoulData

	self:UpdateView()
end

function m:UpdateView()
	self.SwitchSkillBottomPanel:SetActive(false)
	self.LockView:SetActive(false)
	self.NormalView:SetActive(true)
	self.ToggleOffGroupIndexView:SetActive(true)

	if self.soulData then
		local cfgSkillGroupData = CfgSkillGroupTable[self.soulData:GetCfgPlaceGameSoulData().DefaultSkill]

		AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(cfgSkillGroupData.Icon), self.SkillGroupIcon:GetComponent("Image"))
		UGUIUtil.SetText(self.SkillGroupNameText, cfgSkillGroupData.GroupName)

		for i = 1, #self.classTags do
			local tagGo = self.classTags[i]
			local isActive = i <= #cfgSkillGroupData.SoulClass

			tagGo:SetActive(isActive)

			if isActive then
				UGUIUtil.SetTextInChildren(tagGo, MiscApi:GetString("SoulClass", cfgSkillGroupData.SoulClass[i]))
				AssetUtil.LoadImage(self, MiscApi:GetString("SoulClassBgImage", cfgSkillGroupData.SoulClass[i]), tagGo:GetComponentInChildren(typeof(UnityEngine.UI.Image)))
			end
		end

		for i = 1, #self.typeTags do
			local tagGo = self.typeTags[i]
			local isActive = i <= #cfgSkillGroupData.SkillTag

			tagGo:SetActive(isActive)

			if isActive then
				UGUIUtil.SetTextInChildren(tagGo, MiscApi:GetString("SkillTag", cfgSkillGroupData.SkillTag[i]))
				AssetUtil.LoadImage(self, MiscApi:GetString("SkillTagBgImage", cfgSkillGroupData.SkillTag[i]), tagGo:GetComponentInChildren(typeof(UnityEngine.UI.Image)))
			end
		end

		self:SetSkills(cfgSkillGroupData.GroupSkills)
	end
end

function m:SetSkills(skillCids)
	local skillStrengthens, skillLv = self.soulData:GetSkillStrengthenLevel()

	for i = 1, #self.skillCells do
		local cell = self.skillCells[i]

		cell:SetData(skillCids[i], skillStrengthens, skillLv)
	end
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()

	for i = 1, #self.classTags do
		self.classTags[i] = nil
	end

	for i = 1, #self.typeTags do
		self.typeTags[i] = nil
	end

	for i, v in pairs(self.skillCells) do
		v:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
