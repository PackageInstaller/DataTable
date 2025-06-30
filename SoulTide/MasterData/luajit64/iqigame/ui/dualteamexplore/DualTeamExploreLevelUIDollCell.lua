-- chunkname: @IQIGame\\UI\\DualTeamExplore\\DualTeamExploreLevelUIDollCell.lua

local m = {
	CellIndex = 0,
	LOW_HP_RATIO_THRESHOLD = 0.3,
	TeamIndex = 0
}

function m.New(view, teamIndex, cellIndex)
	local obj = Clone(m)

	obj:Init(view, teamIndex, cellIndex)

	return obj
end

function m:Init(view, teamIndex, cellIndex)
	self.View = view
	self.TeamIndex = teamIndex
	self.CellIndex = cellIndex

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnUpdateDoll()
		self:OnUpdateDoll()
	end

	self.GrayComponent = self.View:GetComponent("ImageGroupGrayComponent")

	self:AddEventListeners()
end

function m:AddEventListeners()
	EventDispatcher.AddEventListener(EventID.DualTeamExploreUpdateDollPOD, self.DelegateOnUpdateDoll)
	EventDispatcher.AddEventListener(EventID.DualTeamExploreUpdateTeam, self.DelegateOnUpdateDoll)
end

function m:RemoveEventListeners()
	EventDispatcher.RemoveEventListener(EventID.DualTeamExploreUpdateDollPOD, self.DelegateOnUpdateDoll)
	EventDispatcher.RemoveEventListener(EventID.DualTeamExploreUpdateTeam, self.DelegateOnUpdateDoll)
end

function m:SetData(soulPrefabPOD)
	self.SoulPrefabPOD = soulPrefabPOD

	self.ActiveView:SetActive(soulPrefabPOD ~= nil)
	self.EmptyView:SetActive(soulPrefabPOD == nil)

	if soulPrefabPOD == nil then
		return
	end

	local cfgDressData = CfgDressTable[soulPrefabPOD.dress2DCid]
	local cfgSoulResData = CfgSoulResTable[cfgDressData.SoulResID]

	AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(cfgSoulResData.HeadIcon02), self.Icon:GetComponent("Image"))
	self:SetHp(soulPrefabPOD.attr[Constant.Attribute.TYPE_HP])
	self:SetSkillEnergy(soulPrefabPOD.attr[Constant.Attribute.TYPE_SKILL_ENERGY])
	UGUIUtil.SetText(self.LevelText, DualTeamExploreUICommonApi:GetString("DollCell_LevelText", soulPrefabPOD.lv))
end

function m:SetHp(value)
	local hpRatio = value / self.SoulPrefabPOD.attr[Constant.Attribute.TYPE_HP_MAX]

	self.NormalHpBar:GetComponent("Image").fillAmount = hpRatio > m.LOW_HP_RATIO_THRESHOLD and hpRatio or 0
	self.LowHpBar:GetComponent("Image").fillAmount = hpRatio <= m.LOW_HP_RATIO_THRESHOLD and hpRatio or 0

	self.GrayComponent:EnableGray(value == 0)
end

function m:SetSkillEnergy(value)
	self.SkillEnergyBar:GetComponent("Image").fillAmount = value / CfgDiscreteDataTable[6506027].Data[1]
end

function m:OnUpdateDoll()
	local teamPOD = DualTeamExploreModule.GetTeam(self.TeamIndex)
	local soulPrefabPOD = teamPOD.formationInfo.soulPrefabs[self.CellIndex]

	self:SetData(soulPrefabPOD)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveEventListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.GrayComponent = nil
end

return m
