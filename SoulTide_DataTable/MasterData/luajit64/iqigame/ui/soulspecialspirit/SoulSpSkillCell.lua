-- chunkname: @IQIGame\\UI\\SoulSpecialSpirit\\SoulSpSkillCell.lua

local SoulSpSkillCell = {
	SkillIndex = 0
}

function SoulSpSkillCell.New(view)
	local obj = Clone(SoulSpSkillCell)

	obj:Init(view)

	return obj
end

function SoulSpSkillCell:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.tfName = self.goName:GetComponent("Text")
	self.imgIcon = self.goIcon:GetComponent("Image")
	self.starComp = self.goStarComp:GetComponent("SimpleStarComponent")
	self.btnSelf = self.goBtnSelf:GetComponent("Button")

	function self.onClickBtnSelfDelegate()
		self:OnClickBtnSelf()
	end
end

function SoulSpSkillCell:Refresh(skillIndex, cfgSkillData, soulData)
	self.SkillIndex = skillIndex
	self.cfgSkillData = cfgSkillData
	self.soulData = soulData
	self.cfgSoulSpDataSkill = self.soulData.CfgSoulSpecialSpirits[skillIndex]
	self.totalLv = self.soulData:GetSpSkillTotalLv(skillIndex)

	local optionalSkillIndex = SoulSpecialSpiritModule.GetOptionalSkillIndexBySpSkillIndex(skillIndex)

	self.UltimateSkillBg:SetActive(optionalSkillIndex == -1)
	self.OptionalSkillBg:SetActive(optionalSkillIndex ~= -1)
	self:RefreshMisc()
	self:OnAddListener()
end

function SoulSpSkillCell:OnHide()
	self:OnRemoveListener()
	AssetUtil.UnloadAsset(self)
end

function SoulSpSkillCell:OnDestroy()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.imgIcon = nil
	self.tfName = nil
	self.starComp = nil
	self.btnSelf = nil
end

function SoulSpSkillCell:OnAddListener()
	self:OnRemoveListener()
	self.btnSelf.onClick:AddListener(self.onClickBtnSelfDelegate)
end

function SoulSpSkillCell:OnRemoveListener()
	self.btnSelf.onClick:RemoveListener(self.onClickBtnSelfDelegate)
end

function SoulSpSkillCell:OnClickBtnSelf()
	local skillStrengthens = self.soulData:GetSpSkillStrengthen(self.SkillIndex)

	UIModule.Open(Constant.UIControllerName.SkillTipsUI, Constant.UILayer.Tooltip, {
		showStrengthBlock = false,
		cfgSkillData = self.cfgSkillData,
		soulData = self.soulData,
		allSkillStrengths = skillStrengthens
	})
end

function SoulSpSkillCell:RefreshMisc()
	self.goLock:SetActive(self.cfgSkillData == nil)
	self.imgIcon.gameObject:SetActive(self.cfgSkillData ~= nil)

	if self.cfgSkillData ~= nil then
		AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(self.cfgSkillData.Icon), self.imgIcon)
	end

	self.tfName.text = SoulSpecialSpiritUIApi:GetString("cellSkillName", self.cfgSkillData ~= nil and self.cfgSkillData.Name or "")

	local curLv = 0

	if self.cfgSoulSpDataSkill ~= nil then
		curLv = self.cfgSoulSpDataSkill.Level
	end

	self.starComp:UpdateView(self.totalLv, curLv)
end

function SoulSpSkillCell:SetActive(vs)
	self.View:SetActive(vs)
end

return SoulSpSkillCell
