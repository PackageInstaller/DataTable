-- chunkname: @IQIGame\\UI\\Battle\\BattleOptionalSpSkillCell.lua

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

	function self.DelegateOnLongPressSelf()
		self:OnLongPressSelf()
	end

	local mountPointTrans = getMountPoint(self.View.transform, 50000)

	if mountPointTrans ~= nil and mountPointTrans.gameObject.activeSelf then
		self.MountPointTrans = mountPointTrans
	end

	self:AddListeners()
end

function m:AddListeners()
	self.View:GetComponent(typeof(LongButton)).onClick:AddListener(self.DelegateOnClickSelf)
	self.View:GetComponent(typeof(LongButton)).onLongDownClick:AddListener(self.DelegateOnLongPressSelf)
end

function m:RemoveListeners()
	self.View:GetComponent(typeof(LongButton)).onClick:RemoveListener(self.DelegateOnClickSelf)
	self.View:GetComponent(typeof(LongButton)).onLongDownClick:RemoveListener(self.DelegateOnLongPressSelf)
end

function m:SetData(battleUnitId)
	self.BattleUnitPOD = BattleModule.GetBattleUnitPOD(battleUnitId)

	local optionalSkills = SkillModule.FilterSkillsByShowTypeForList(self.BattleUnitPOD.Skills, Constant.Skill.SHOW_TYPE_OPTIONAL_SP_SKILL, false)

	self.View:SetActive(#optionalSkills > 0)

	if #optionalSkills == 0 then
		return
	end

	self.CfgSkillData = CfgSkillTable[optionalSkills[1]]

	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(self.CfgSkillData.Icon), self.SkillIcon:GetComponent(typeof(UnityEngine.UI.Image)))
end

function m:OnClickSelf()
	if self.MountPointTrans ~= nil then
		GameEntry.Effect:PlayUIMountPointEffect(9005003, 50000, 0, self.View, self.View:GetComponentInParent(typeof(UnityEngine.Canvas)).sortingOrder + 1)
	else
		self:ShowTip()
	end
end

function m:OnLongPressSelf()
	if self.MountPointTrans == nil then
		return
	end

	self:ShowTip()
end

function m:ShowTip()
	if self.CfgSkillData == nil then
		return
	end

	local skillStrengths = {}

	for i = 0, self.BattleUnitPOD.SkillStrengths.Count - 1 do
		skillStrengths[i + 1] = self.BattleUnitPOD.SkillStrengths[i]
	end

	EventDispatcher.Dispatch(EventID.BattleShowSkillTip, self.CfgSkillData ~= nil and self.CfgSkillData.Id or -1, skillStrengths)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.BattleUnitPOD = nil
	self.CfgSkillData = nil
	self.MountPointTrans = nil
end

return m
