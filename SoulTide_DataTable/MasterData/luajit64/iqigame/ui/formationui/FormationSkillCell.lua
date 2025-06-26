-- chunkname: @IQIGame\\UI\\FormationUI\\FormationSkillCell.lua

local m = {
	Index = 0,
	GroupIndex = 0
}

function m.New(view, groupIndex, index, onSwitchSkill)
	local obj = Clone(m)

	obj:Init(view, groupIndex, index, onSwitchSkill)

	return obj
end

function m:Init(view, groupIndex, index, onSwitchSkill)
	self.View = view
	self.GroupIndex = groupIndex
	self.Index = index
	self.SwitchSkillCallback = onSwitchSkill

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickSelf()
		self:OnClickSelf()
	end

	function self.DelegateOnClickSwitchBtn()
		self:OnClickSwitchBtn()
	end

	self.SwitchBtn:SetActive(self.GroupIndex == 3)
	self:AddListeners()
end

function m:AddListeners()
	self.View:GetComponent("Button").onClick:AddListener(self.DelegateOnClickSelf)
	self.SwitchBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickSwitchBtn)
end

function m:RemoveListeners()
	self.View:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickSelf)
	self.SwitchBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickSwitchBtn)
end

function m:SetData(skillCid, skillStrengths)
	self.CfgSkillData = CfgSkillTable[skillCid]
	self.SkillStrengths = skillStrengths

	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(self.CfgSkillData.Icon), self.Icon:GetComponent("Image"))
	UGUIUtil.SetText(self.LevelText, FormationChooseSoulUIApi:GetString("SkillLevelText", SkillModule.GetSkillLv(skillCid, nil, skillStrengths)))

	if self.SpTag ~= nil then
		self.SpTag:SetActive(SoulSpecialSpiritModule.CheckSpAllActive(self.CfgSkillData.Id))
	end
end

function m:OnClickSelf()
	UIModule.Open(Constant.UIControllerName.SkillTipsUI, Constant.UILayer.Tooltip, {
		cfgSkillData = self.CfgSkillData,
		allSkillStrengths = self.SkillStrengths
	})
end

function m:OnClickSwitchBtn()
	self.SwitchSkillCallback(self.Index)
end

function m:OnGroupSelect(isSelect)
	self.SwitchBtn:SetActive(isSelect and self.GroupIndex == 3)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.SkillStrengths = nil
end

return m
