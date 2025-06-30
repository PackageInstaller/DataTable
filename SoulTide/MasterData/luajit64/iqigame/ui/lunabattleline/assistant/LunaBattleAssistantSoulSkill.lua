-- chunkname: @IQIGame\\UI\\LunaBattleLine\\Assistant\\LunaBattleAssistantSoulSkill.lua

local LunaBattleAssistantSkillCell = require("IQIGame.UI.LunaBattleLine.Assistant.LunaBattleAssistantSkillCell")
local m = {
	ClassTags = {},
	TypeTags = {},
	SkillCells = {}
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	for i = 1, 2 do
		local tagGo = UnityEngine.Object.Instantiate(self.SkillTagPrefab)

		tagGo.transform:SetParent(self.SkillTagGrid.transform, false)

		self.ClassTags[i] = tagGo
	end

	for i = 1, 2 do
		local tagGo = UnityEngine.Object.Instantiate(self.SkillTagPrefab)

		tagGo.transform:SetParent(self.SkillTagGrid.transform, false)

		self.TypeTags[i] = tagGo
	end

	for i = 1, 4 do
		local cell = LunaBattleAssistantSkillCell.New(UnityEngine.Object.Instantiate(self.SkillCellPrefab))

		cell.View.transform:SetParent(self.SkillCellGrid.transform, false)

		self.SkillCells[i] = cell
	end

	self:AddListeners()
end

function m:AddListeners()
	return
end

function m:RemoveListeners()
	return
end

function m:SetData(soulPrefab)
	local cfgSoulData = CfgSoulTable[soulPrefab.soulCid]
	local defaultSkillGroups = cfgSoulData.DefaultSkill
	local skillGroupIndex = table.indexOf(defaultSkillGroups, soulPrefab.skillGroupId)
	local customSkills

	if skillGroupIndex == 3 then
		customSkills = soulPrefab.customSkills
	end

	if self.GroupNumText ~= nil then
		UGUIUtil.SetText(self.GroupNumText, LunaBattleLineAssistantUIApi:GetString("SkillGroupIndexText", skillGroupIndex))
	end

	local cfgSkillGroupData = CfgSkillGroupTable[soulPrefab.skillGroupId]

	if self.GroupIcon ~= nil then
		AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(cfgSkillGroupData.Icon), self.GroupIcon:GetComponent("Image"))
	end

	UGUIUtil.SetText(self.GroupNameText, cfgSkillGroupData.GroupName)

	for i = 1, #self.ClassTags do
		local tagGo = self.ClassTags[i]
		local isActive = i <= #cfgSkillGroupData.SoulClass

		tagGo:SetActive(isActive)

		if isActive then
			UGUIUtil.SetTextInChildren(tagGo, MiscApi:GetString("SoulClass", cfgSkillGroupData.SoulClass[i]))
			AssetUtil.LoadImage(self, MiscApi:GetString("SoulClassBgImage", cfgSkillGroupData.SoulClass[i]), tagGo:GetComponentInChildren(typeof(UnityEngine.UI.Image)))
		end
	end

	for i = 1, #self.TypeTags do
		local tagGo = self.TypeTags[i]
		local isActive = i <= #cfgSkillGroupData.SkillTag

		tagGo:SetActive(isActive)

		if isActive then
			UGUIUtil.SetTextInChildren(tagGo, MiscApi:GetString("SkillTag", cfgSkillGroupData.SkillTag[i]))
			AssetUtil.LoadImage(self, MiscApi:GetString("SkillTagBgImage", cfgSkillGroupData.SkillTag[i]), tagGo:GetComponentInChildren(typeof(UnityEngine.UI.Image)))
		end
	end

	local groupSkillCids

	if skillGroupIndex ~= 3 then
		groupSkillCids = cfgSkillGroupData.GroupSkills
	elseif customSkills == nil or #customSkills == 0 then
		local defaultThirdSkillGroupCid = defaultSkillGroups[1]
		local defaultThirdCfgSkillGroupData = CfgSkillGroupTable[defaultThirdSkillGroupCid]

		groupSkillCids = defaultThirdCfgSkillGroupData.GroupSkills
	else
		groupSkillCids = customSkills
	end

	for i = 1, #self.SkillCells do
		local cell = self.SkillCells[i]

		cell:SetData(groupSkillCids[i], soulPrefab)
	end
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListeners()

	for i = 1, #self.ClassTags do
		self.ClassTags[i] = nil
	end

	for i = 1, #self.TypeTags do
		self.TypeTags[i] = nil
	end

	for i = 1, #self.SkillCells do
		local cell = self.SkillCells[i]

		cell:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
