-- chunkname: @IQIGame\\UI\\UserInfo\\ItemCell\\RoleSkillItemCell.lua

local m = {
	skillIndex = 0,
	isUnlock = true
}

function m.New(view, selectCallBack)
	local obj = Clone(m)

	obj:Init(view, selectCallBack)

	return obj
end

function m:Init(view, selectCallBack)
	self.View = view
	self.selectCallBack = selectCallBack

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickSelectSkill()
		self:SelectSkill()
	end

	self:AddListeners()
end

function m:AddListeners()
	self.View:GetComponent("Button").onClick:AddListener(self.DelegateOnClickSelectSkill)
end

function m:RemoveListeners()
	self.View:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickSelectSkill)
end

function m:SetData(skillData, index)
	local unlockConditionId = CfgItemTable[skillData.itemCid].UnlockConditionId

	self.isUnlock = ConditionModule.Check(unlockConditionId)
	self.skillData = skillData
	self.skillIndex = index

	UGUIUtil.SetText(self.lvNumText, skillData.lv)
	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(CfgItemTable[skillData.itemCid].Icon), self.roleSkillImg:GetComponent("Image"))

	local subSkills = skillData:GetCfg().SubSkills

	self.normalSkillData = self:CreateSkillData(subSkills[1])
	self.otherSkillData = self:CreateSkillData(subSkills[2])

	LuaUtility.SetGameObjectShow(self.levelItem, self.isUnlock)
	LuaUtility.SetGameObjectShow(self.lockItem, not self.isUnlock)
	LuaUtility.SetGameObjectShow(self.lockImg, not self.isUnlock)

	if not self.isUnlock then
		UGUIUtil.SetText(self.lockText, CfgConditionTable[unlockConditionId].Name)
	end
end

function m:CreateSkillData(skillCid)
	local skillData = SkillData.New()
	local skillItemPod = {
		lv = self.skillData.lv,
		skillCid = skillCid
	}

	skillData:UpdateData(skillItemPod)

	return skillData
end

function m:SelectSkill()
	if not self.isUnlock then
		return
	end

	if self.selectCallBack then
		self.selectCallBack({
			mainSkillData = self.skillData,
			normalSkillData = self.normalSkillData,
			otherSkillData = self.otherSkillData
		}, self.skillIndex)
	end
end

function m:Select()
	LuaUtility.SetGameObjectShow(self.selectImg, true)
end

function m:UnSelect()
	LuaUtility.SetGameObjectShow(self.selectImg, false)
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:Dispose()
	self:RemoveListeners()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
