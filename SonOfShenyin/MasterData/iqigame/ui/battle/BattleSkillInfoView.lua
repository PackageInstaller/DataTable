-- chunkname: @IQIGame\\UI\\Battle\\BattleSkillInfoView.lua

local BattleSkillInfoView = {}

function BattleSkillInfoView.New(view)
	local obj = Clone(BattleSkillInfoView)

	obj:Init(view)

	return obj
end

function BattleSkillInfoView:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.delegateOpen(battleUnitID, skillCid)
		self:Open(battleUnitID, skillCid)
	end

	function self.delegateClose()
		self:Close()
	end

	self.IsShowing = false
end

function BattleSkillInfoView:AddListeners()
	EventDispatcher.AddEventListener(EventID.BattleOpenSkillInfoPanel, self.delegateOpen)
	EventDispatcher.AddEventListener(EventID.BattleCloseSkillInfoPanel, self.delegateClose)
end

function BattleSkillInfoView:RemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.BattleOpenSkillInfoPanel, self.delegateOpen)
	EventDispatcher.RemoveEventListener(EventID.BattleCloseSkillInfoPanel, self.delegateClose)
end

function BattleSkillInfoView:SetData()
	self.spr1 = self.rtAreaAttack.GetChild(0).GetComponent("Image").sprite
	self.spr2 = self.rtAreaAttack.GetChild(1).GetComponent("Image").sprite
end

function BattleSkillInfoView:OnDestroy()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function BattleSkillInfoView:OnOpen()
	self.View:SetActive(false)
	self:AddListeners()
end

function BattleSkillInfoView:OnClose()
	self.View:SetActive(false)
	self:RemoveListeners()
end

function BattleSkillInfoView:Open(battleUnitID, skillCid)
	if self.IsShowing then
		return
	end

	self.IsShowing = true

	self.View:SetActive(true)
	self:RefreshSkillInfo(battleUnitID, skillCid)
end

function BattleSkillInfoView:Close()
	self.View:SetActive(false)

	self.IsShowing = false
end

function BattleSkillInfoView:RefreshSkillInfo(battleUnitID, skillCid)
	local battleUnitData = BattleModule.GetBattleUnitDataByUnitID(battleUnitID)
	local battleSkillData = battleUnitData:GetSkillData(skillCid)
	local skillConfig = CfgSkillTable[skillCid]
	local path = UIGlobalApi.GetIconPath(skillConfig.Icon)

	AssetUtil.LoadImage(self, path, self.skillImage:GetComponent(typeof(UnityEngine.UI.Image)), nil, nil, nil, true)
	UGUIUtil.SetText(self.skillTypeText, BattleUIApi:GetSkillTypeTips(battleSkillData.skillType))
	UGUIUtil.SetText(self.coolDownText, battleSkillData.coolDown)
	UGUIUtil.SetText(self.costText, battleSkillData.energyCost)
	UGUIUtil.SetText(self.nameText, skillConfig.Name)
	UGUIUtil.SetText(self.levelText, battleSkillData.level)
	UGUIUtil.SetText(self.descriptionText, self:GetSkillDesc(battleSkillData))
	UGUIUtil.SetText(self.rangeLabel, BattleApi:GetCfgText(6050004))
	UGUIUtil.SetText(self.descriptionLabel, BattleApi:GetCfgText(6050003))
end

function BattleSkillInfoView:GetSkillDesc(skillData)
	if skillData.skillType == Constant.SkillType.TYPE_LORE then
		local skillRefineData = DiySkillModule.GetSkillRefineCfg(skillData.configID, skillData.purifyLv)

		return skillRefineData.SkillTips
	end

	local exist, skillLevelConfig = RoleDevelopmentModule.GetSkillCfgByIDAndLv(skillData.configID, skillData.level)

	return UIGlobalApi.GetDescribeMatchTable(skillLevelConfig.SkillTips, function(_index, _formatType)
		local str = UIGlobalApi.AnalysisDescribeArgsWithWildcard(_formatType, skillLevelConfig.UpGradeOldValue[_index])

		return RoleDevelopmentApi:GetPromoteStrNotIncludNext(str)
	end)
end

return BattleSkillInfoView
