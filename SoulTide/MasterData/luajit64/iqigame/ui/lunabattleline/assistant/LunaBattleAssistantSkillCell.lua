-- chunkname: @IQIGame\\UI\\LunaBattleLine\\Assistant\\LunaBattleAssistantSkillCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickSelf()
		self:OnClickSelf()
	end

	self:AddListeners()
end

function m:AddListeners()
	self.View:GetComponent("Button").onClick:AddListener(self.DelegateOnClickSelf)
end

function m:RemoveListeners()
	self.View:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickSelf)
end

function m:SetData(skillCid, soulPrefab)
	self.CfgSkillData = CfgSkillTable[skillCid]
	self.SoulPrefab = soulPrefab

	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(self.CfgSkillData.Icon), self.Icon:GetComponent("Image"))
	UGUIUtil.SetText(self.LevelText, LunaBattleLineAssistantUIApi:GetString("SkillLevelText", SkillModule.GetSkillLv(skillCid, nil, soulPrefab.allSkillStrengths)))
end

function m:OnClickSelf()
	UIModule.Open(Constant.UIControllerName.SkillTipsUI, Constant.UILayer.Tooltip, {
		cfgSkillData = self.CfgSkillData,
		allSkillStrengths = self.SoulPrefab.allSkillStrengths
	})
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.CfgSkillData = nil
	self.SoulPrefab = nil
end

return m
