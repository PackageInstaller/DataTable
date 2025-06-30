-- chunkname: @IQIGame\\UI\\Battle\\BattleSkillTipController.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	self.LinkTipCell = LinkTipCell.New(self.LinTipCellGo)

	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
end

function m:Show(skillCid, skillStrengths)
	self.View:SetActive(true)

	local name, desc

	if skillCid == -1 then
		name, desc = BattleUIApi:GetString("StandbyTipTexts")
	else
		local cfgSkillData = CfgSkillTable[skillCid]

		name = cfgSkillData.Name
		desc = self:GetSkillDesc(cfgSkillData, skillStrengths)
	end

	UGUIUtil.SetText(self.NameText, BattleUIApi:GetString("SkillTipNameText", name))
	UGUIUtil.SetText(self.DescText, BattleUIApi:GetString("SkillTipDescText", UIGlobalApi.GetTextWithoutKeywordTag(desc)))

	local hasKeyword = UIGlobalApi.CheckExistKeywordTag(desc)

	self.LinkTipCell.View:SetActive(hasKeyword)

	if hasKeyword then
		self.LinkTipCell:Open(desc)
	end
end

function m:Hide()
	self.View:SetActive(false)
end

function m:GetSkillDesc(cfgSkillData, skillStrengths)
	local specialSpiritSkillStrengthens = SoulSpecialSpiritModule.GetAllSpStrengthens(cfgSkillData.Id)

	if specialSpiritSkillStrengthens ~= nil then
		for i = #specialSpiritSkillStrengthens, 1, -1 do
			local strengthenCid = specialSpiritSkillStrengthens[i]

			if table.indexOf(skillStrengths, strengthenCid) ~= -1 then
				local cfgSkillStrengthenData = CfgSkillStrengthenTable[strengthenCid]

				return cfgSkillStrengthenData.Describe
			end
		end
	end

	local cfgSkillStrengthenDataList = SkillModule.GetStrengthen(cfgSkillData.Id)

	for i = #cfgSkillStrengthenDataList, 1, -1 do
		local cfgSkillStrengthenData = cfgSkillStrengthenDataList[i]

		if table.indexOf(skillStrengths, cfgSkillStrengthenData.Id) ~= -1 then
			return cfgSkillStrengthenData.Describe
		end
	end

	return cfgSkillData.EffectText
end

function m:OnClickCloseBtn()
	self:Hide()
end

function m:Dispose()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.LinkTipCell:OnDestroy()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
