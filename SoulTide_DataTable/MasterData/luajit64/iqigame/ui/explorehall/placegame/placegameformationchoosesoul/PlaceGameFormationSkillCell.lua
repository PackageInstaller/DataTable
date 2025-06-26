-- chunkname: @IQIGame\\UI\\ExploreHall\\PlaceGame\\PlaceGameFormationChooseSoul\\PlaceGameFormationSkillCell.lua

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

	if self.SwitchBtn then
		self.SwitchBtn:SetActive(false)
	end

	self:AddListener()
end

function m:AddListener()
	self.View:GetComponent("Button").onClick:AddListener(self.DelegateOnClickSelf)
end

function m:RemoveListener()
	self.View:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickSelf)
end

function m:SetData(skillCid, skillStrengthens, lv)
	self.cfgSkillData = CfgSkillTable[skillCid]
	self.skillStrengthens = skillStrengthens

	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(self.cfgSkillData.Icon), self.Icon:GetComponent("Image"))
	UGUIUtil.SetText(self.LevelText, FormationChooseSoulUIApi:GetString("SkillLevelText", lv))

	if self.LevelBG then
		self.LevelBG:SetActive(lv > 0)
	end

	if self.SpTag ~= nil then
		self.SpTag:SetActive(false)
	end
end

function m:OnClickSelf()
	UIModule.Open(Constant.UIControllerName.SkillTipsUI, Constant.UILayer.Tooltip, {
		disableSpiritShow = true,
		cfgSkillData = self.cfgSkillData,
		allSkillStrengths = self.skillStrengthens
	})
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
