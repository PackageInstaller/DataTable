-- chunkname: @IQIGame\\UI\\EvilErosion\\EvilErosionSkillCell.lua

local m = {
	Index = 0,
	SkillCid = 0
}

function m.New(view, index, onChange, forShow)
	local obj = Clone(m)

	obj:Init(view, index, onChange, forShow)

	return obj
end

function m:Init(view, index, onChange, forShow)
	self.View = view
	self.Index = index
	self.OnChangeCallback = onChange

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickSelf()
		self:OnClickSelf()
	end

	function self.DelegateOnClickSwitchBtn()
		self:OnClickSwitchBtn()
	end

	self.SwitchBtn:SetActive(not forShow)
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

function m:SetData(skillCid, activeSkillStrengthen)
	self.SkillCid = skillCid
	self.ActiveSkillStrengthen = activeSkillStrengthen

	local cfgSkillData = CfgSkillTable[skillCid]

	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(cfgSkillData.Icon), self.Icon:GetComponent("Image"))

	local skillLv, isMax = self:GetSkillLv(cfgSkillData)

	UGUIUtil.SetText(self.LevelText, EvilErosionLevelDetailUIApi:GetString("SoulInfoView_SkillCell_Lv", skillLv, isMax))
end

function m:GetSkillLv(cfgSkillData)
	local cfgSkillStrengthenDataList = SkillModule.GetStrengthen(cfgSkillData.Id)
	local lv = 0

	for i = 1, #cfgSkillStrengthenDataList do
		local cfgSkillStrengthenData = cfgSkillStrengthenDataList[i]

		if self.ActiveSkillStrengthen ~= nil and table.indexOf(self.ActiveSkillStrengthen, cfgSkillStrengthenData.Id) ~= -1 then
			lv = lv + 1
		end
	end

	return lv, lv >= #cfgSkillStrengthenDataList
end

function m:OnClickSelf()
	local cfgSkillData = CfgSkillTable[self.SkillCid]

	UIModule.Open(Constant.UIControllerName.SkillTipsUI, Constant.UILayer.Tooltip, {
		disableSpiritShow = true,
		cfgSkillData = cfgSkillData,
		allSkillStrengths = self.ActiveSkillStrengthen
	})
end

function m:OnClickSwitchBtn()
	self.OnChangeCallback(self.Index)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.ActiveSkillStrengthen = nil
	self.OnChangeCallback = nil
end

return m
