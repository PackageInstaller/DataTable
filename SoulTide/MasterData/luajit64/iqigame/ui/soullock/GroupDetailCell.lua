-- chunkname: @IQIGame\\UI\\SoulLock\\GroupDetailCell.lua

local GroupDetailCell = {
	skillCellPool = {}
}

function GroupDetailCell.New(view)
	local obj = Clone(GroupDetailCell)

	obj:Init(view)

	return obj
end

function GroupDetailCell:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.tfGroupDesc = self.goGroupDesc:GetComponent("Text")
	self.imgGroupIcon = self.goGroupIcon:GetComponent("Image")

	for i = 1, 4 do
		local go = self.goSkillCellParent.transform:Find("Mould_0" .. i):GetChild(0).gameObject

		self.skillCellPool[i] = SkillCell.PackageOrReuseView(self, go, true)
	end

	self.tgSelf = self.goTgSelf:GetComponent("Toggle")

	function self.onClickTgSelfDelegate(isOn)
		self:OnClickSelf(isOn)
	end

	self:OnAddListener()
end

function GroupDetailCell:Refresh(index, soulData, cfgSkillGroupData)
	self.index = index
	self.soulData = soulData
	self.cfgSkillGroupData = cfgSkillGroupData

	self:RefreshMisc()
	self:RefreshSkillBlock()

	if self.index == 1 then
		self.tgSelf.isOn = true
	end
end

function GroupDetailCell:OnHide()
	return
end

function GroupDetailCell:OnDestroy()
	self:OnRemoveListener()

	for i, v in pairs(self.skillCellPool) do
		v:Dispose()
	end

	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function GroupDetailCell:OnAddListener()
	self.tgSelf.onValueChanged:AddListener(self.onClickTgSelfDelegate)
end

function GroupDetailCell:OnRemoveListener()
	self.tgSelf.onValueChanged:RemoveListener(self.onClickTgSelfDelegate)
end

function GroupDetailCell:OnClickSelf(isOn)
	if isOn then
		self.View.transform.sizeDelta = Vector2.New(self.View.transform.sizeDelta.x, 275)
	else
		self.View.transform.sizeDelta = Vector2.New(self.View.transform.sizeDelta.x, 85)
	end
end

function GroupDetailCell:RefreshMisc()
	self.tgSelf:GetComponent("ToggleHelperComponent").text = SoulLockUIApi:GetString("goToggle", self.index)
	self.goTgSelf.transform:Find("goDown/Text_Group"):GetComponent("Text").text = SoulLockUIApi:GetString("goPrefabName", self.cfgSkillGroupData.GroupName)
	self.goTgSelf.transform:Find("goUp/Text_Group"):GetComponent("Text").text = SoulLockUIApi:GetString("goPrefabName", self.cfgSkillGroupData.GroupName)
	self.tfGroupDesc.text = SoulLockUIApi:GetString("goPrefabDesc", self.cfgSkillGroupData.GroupDesc)

	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(self.cfgSkillGroupData.Icon), self.imgGroupIcon)
end

function GroupDetailCell:RefreshSkillBlock()
	local allSkills = {}
	local typeSort = SoulLockUIApi:GetString("typeSort")

	for i, v in pairs(typeSort) do
		for m, n in pairs(self.cfgSkillGroupData.GroupSkills) do
			if v == CfgSkillTable[n].ShowType then
				allSkills[#allSkills + 1] = n
			end
		end
	end

	for i, v in ipairs(allSkills) do
		local cell = self.skillCellPool[i]

		cell:SetSkill(v, self.soulData)
	end
end

return GroupDetailCell
