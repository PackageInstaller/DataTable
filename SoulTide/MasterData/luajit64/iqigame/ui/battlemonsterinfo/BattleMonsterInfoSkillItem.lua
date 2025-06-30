-- chunkname: @IQIGame\\UI\\BattleMonsterInfo\\BattleMonsterInfoSkillItem.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickKeywordTipBtn()
		self:OnClickKeywordTipBtn()
	end

	self.KeywordTipBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickKeywordTipBtn)
end

function m:SetData(cfgSkillData, isTheLastOne)
	self.CfgSkillData = cfgSkillData

	UGUIUtil.SetText(self.NameText, BattleMonsterInfoUIApi:GetString("SkillNameText", cfgSkillData.Name, cfgSkillData.ShowType, cfgSkillData.ReleaseType))
	UGUIUtil.SetText(self.DescText, UIGlobalApi.GetTextWithoutKeywordTag(BattleMonsterInfoUIApi:GetString("SkillEffectText", cfgSkillData.EffectText)))
	self.LineView:SetActive(not isTheLastOne)
end

function m:OnClickKeywordTipBtn()
	if UIGlobalApi.CheckExistKeywordTag(self.CfgSkillData.EffectText) then
		UIModule.Open(Constant.UIControllerName.LinkTipUI, Constant.UILayer.UI, {
			self.CfgSkillData.EffectText,
			self.KeywordTipPoint,
			UGUISide.TopLeft,
			UGUISide.TopRight
		})
	end
end

function m:Dispose()
	self.KeywordTipBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickKeywordTipBtn)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.CfgSkillData = nil
end

return m
