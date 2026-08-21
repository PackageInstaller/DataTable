-- chunkname: @IQIGame\\UI\\FormationUI\\FormationSkillGroupItem.lua

local m = {
	SkillGroupCid = 0,
	IsSelected = false,
	IsUnlock = false,
	Index = 0,
	SkillCells = {},
	ClassTags = {},
	TypeTags = {}
}
local FormationSkillCell = require("IQIGame.UI.FormationUI.FormationSkillCell")

function m.New(view, index, onSwitchSingleSkill)
	local obj = Clone(m)

	obj:Init(view, index, onSwitchSingleSkill)

	return obj
end

function m:Init(view, index, onSwitchSingleSkill)
	self.View = view
	self.Index = index
	self.SwitchSingleSkillCallback = onSwitchSingleSkill

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnToggleValueChanged(isOn)
		self:OnToggleValueChanged(isOn)
	end

	function self.DelegateOnClickUnlockView()
		self:OnClickUnlockView()
	end

	function self.DelegateOnSwitchSingleSkill(skillIndex)
		self:OnSwitchSingleSkill(skillIndex)
	end

	for i = 1, 2 do
		local tagGo = UnityEngine.Object.Instantiate(self.TagPrefab)

		tagGo.transform:SetParent(self.TagGrid.transform, false)

		self.ClassTags[i] = tagGo
	end

	for i = 1, 2 do
		local tagGo = UnityEngine.Object.Instantiate(self.TagPrefab)

		tagGo.transform:SetParent(self.TagGrid.transform, false)

		self.TypeTags[i] = tagGo
	end

	self.SkillCellPrefab:SetActive(false)

	for i = 1, 4 do
		local cell = FormationSkillCell.New(UnityEngine.Object.Instantiate(self.SkillCellPrefab), index, i, self.DelegateOnSwitchSingleSkill)

		cell.View.transform:SetParent(self.SkillGrid.transform, false)
		cell.View:SetActive(true)

		self.SkillCells[i] = cell
	end

	local toggleHelperComponent = self.SelectToggleGo:GetComponent("ToggleHelperComponent")

	toggleHelperComponent.text = FormationUIApi:GetString("SkillGroupIndexText", index)

	UGUIUtil.SetTextInChildren(self.SwitchSkillBottomPanel, FormationUIApi:GetString("SwitchSkillLabel"))
end

function m:AddListeners()
	self.SelectToggleGo:GetComponent("Toggle").onValueChanged:AddListener(self.DelegateOnToggleValueChanged)
	self.LockView:GetComponent("Button").onClick:AddListener(self.DelegateOnClickUnlockView)
end

function m:RemoveListeners()
	self.SelectToggleGo:GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateOnToggleValueChanged)
	self.LockView:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickUnlockView)
end

function m:SetData(soulData, skillGroupCid, customSkills)
	self.SoulData = soulData
	self.SkillGroupCid = skillGroupCid

	local isUnlock = table.indexOf(soulData.unlockSkillGroups, skillGroupCid) ~= -1

	self.SwitchSkillBottomPanel:SetActive(isUnlock and self.Index == 3 and self.IsSelected)
	self:UpdateMisc(isUnlock, soulData.soulCid, skillGroupCid, customSkills, soulData.activationSkillStrengthen)
end

function m:SetShowData(soulCid, skillGroupCid, customSkills, skillStrengthens)
	self.SwitchSkillBottomPanel:SetActive(false)
	self:UpdateMisc(true, soulCid, skillGroupCid, customSkills, skillStrengthens)
end

function m:UpdateMisc(isUnlock, soulCid, skillGroupCid, customSkills, skillStrengthens)
	local cfgSoulData = CfgSoulTable[soulCid]
	local cfgSkillGroupData = CfgSkillGroupTable[skillGroupCid]

	self.IsUnlock = isUnlock

	self.ToggleOffGroupIndexView:SetActive(self.IsUnlock)
	self.NormalView:SetActive(self.IsUnlock)
	self.LockView:SetActive(not self.IsUnlock)

	if not self.IsUnlock then
		UGUIUtil.SetTextInChildren(self.LockView, FormationChooseSoulUIApi:GetString("SkillGroupUnlockText", cfgSkillGroupData.UnlockLv))

		return
	end

	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(cfgSkillGroupData.Icon), self.SkillGroupIcon:GetComponent("Image"))
	UGUIUtil.SetText(self.SkillGroupNameText, cfgSkillGroupData.GroupName)

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

	if self.Index ~= 3 then
		groupSkillCids = cfgSkillGroupData.GroupSkills
	elseif customSkills == nil or #customSkills == 0 then
		local defaultSkillGroups = cfgSoulData.DefaultSkill
		local defaultThirdSkillGroupCid = defaultSkillGroups[1]
		local defaultThirdCfgSkillGroupData = CfgSkillGroupTable[defaultThirdSkillGroupCid]

		groupSkillCids = defaultThirdCfgSkillGroupData.GroupSkills
	else
		groupSkillCids = customSkills
	end

	self:SetSkills(groupSkillCids, skillStrengthens)
end

function m:SetToggleOn(value, forceRefresh)
	local toggle = self.SelectToggleGo:GetComponent("Toggle")

	if toggle.isOn == value and forceRefresh then
		self:OnToggleValueChanged(value)
	else
		toggle.isOn = value
	end
end

function m:OnToggleValueChanged(isOn)
	self.IsSelected = isOn

	local toggleHelperComponent = self.SelectToggleGo:GetComponent("ToggleHelperComponent")
	local onInfoRootTrans = toggleHelperComponent.goShowByOn.transform:Find("InfoRoot")
	local offInfoRootTrans = toggleHelperComponent.goShowByOff.transform:Find("InfoRoot")
	local infoRootTrans

	if isOn then
		infoRootTrans = onInfoRootTrans
	else
		infoRootTrans = offInfoRootTrans
	end

	self.NormalView.transform:SetParent(infoRootTrans, false)

	for i = 1, #self.SkillCells do
		local cell = self.SkillCells[i]

		cell:OnGroupSelect(self.IsSelected)
	end

	self.SwitchSkillBottomPanel:SetActive(self.IsUnlock and self.Index == 3 and self.IsSelected)
end

function m:OnClickUnlockView()
	NoticeModule.ShowNotice(21046007)
end

function m:OnSwitchSingleSkill(skillIndex)
	local currentSkillCids = self:GetSkills()
	local skillGroups = self.SoulData:GetCfgSoul().DefaultSkill
	local targetSkillCid

	for i = 1, 2 do
		local skillGroupCid = skillGroups[i]
		local cfgSkillGroupData = CfgSkillGroupTable[skillGroupCid]
		local skillCid = cfgSkillGroupData.GroupSkills[skillIndex]
		local currentSkillCid = currentSkillCids[skillIndex]
		local cfgSkillData = CfgSkillTable[skillCid]
		local currentCfgSkillData = CfgSkillTable[currentSkillCid]

		if currentCfgSkillData.ShowType == cfgSkillData.ShowType and currentCfgSkillData.Id ~= skillCid then
			targetSkillCid = skillCid

			break
		end
	end

	currentSkillCids[skillIndex] = targetSkillCid

	self.SwitchSingleSkillCallback(self.SkillGroupCid, currentSkillCids, self.SoulData)
end

function m:SetSkills(skillCids, skillStrengths)
	for i = 1, #self.SkillCells do
		local cell = self.SkillCells[i]

		cell:SetData(skillCids[i], skillStrengths)
	end
end

function m:GetSkills()
	local currentSkillCids = {}

	for i = 1, #self.SkillCells do
		local cell = self.SkillCells[i]

		currentSkillCids[i] = cell.CfgSkillData.Id
	end

	return currentSkillCids
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)

	for i = 1, #self.SkillCells do
		local cell = self.SkillCells[i]

		cell:Dispose()
	end

	for i = 1, #self.ClassTags do
		self.ClassTags[i] = nil
	end

	for i = 1, #self.TypeTags do
		self.TypeTags[i] = nil
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
