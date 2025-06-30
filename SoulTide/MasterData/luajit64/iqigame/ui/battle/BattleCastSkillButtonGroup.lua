-- chunkname: @IQIGame\\UI\\Battle\\BattleCastSkillButtonGroup.lua

local m = {
	SelectingSkill = false,
	IsFold = false,
	EnergyBarEffectPlayId = 0,
	UnitId = 0
}
local BattleCastSkillButton = require("IQIGame.UI.Battle.BattleCastSkillButton")
local BattleOptionalSpSkillCell = require("IQIGame.UI.Battle.BattleOptionalSpSkillCell")

function m.New(view, onClickSkill)
	local obj = Clone(m)

	obj:Init(view, onClickSkill)

	return obj
end

function m:Init(view, onClickSkill)
	self.View = view
	self.OnClickSkillCallback = onClickSkill

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickSkillButton(button, cfgSkillData, isStandby)
		self:OnClickSkillButton(button, cfgSkillData, isStandby)
	end

	function self.DelegateOnClickSwitchBtn()
		self:OnClickSwitchBtn()
	end

	function self.DelegateOnUpdateSkillEnergy(unitId, skillEnergy)
		self:OnUpdateSkillEnergy(unitId, skillEnergy)
	end

	function self.DelegateOnUpdateMaxSkillEnergy(unitId, skillMaxEnergy)
		self:OnUpdateMaxSkillEnergy(unitId, skillMaxEnergy)
	end

	function self.DelegateOnUpdateSkillCostEnergy(unitId, skillCid)
		self:OnUpdateSkillCostEnergy(unitId, skillCid)
	end

	function self.DelegateOnModifySkill(unitId, oldSkillCid, newSkillCid)
		self:OnModifySkill(unitId, oldSkillCid, newSkillCid)
	end

	self.NormalSkillButton = BattleCastSkillButton.New(self.NormalSkillBtn, self.DelegateOnClickSkillButton)
	self.CoreSkillButton = BattleCastSkillButton.New(self.CoreSkillBtn, self.DelegateOnClickSkillButton)
	self.CoreSkillButton2 = BattleCastSkillButton.New(self.CoreSkillBtn2, self.DelegateOnClickSkillButton)
	self.UltimateSkillButton = BattleCastSkillButton.New(self.UltimateSkillBtn, self.DelegateOnClickSkillButton)
	self.StandbyButton = BattleCastSkillButton.New(self.StandBySkillBtn, self.DelegateOnClickSkillButton, true)
	self.OptionalSpSkillCell = BattleOptionalSpSkillCell.New(self.OptionalSpSkillView)
end

function m:Show(unitId)
	self.UnitId = unitId

	self.View:SetActive(true)
	self:AddListeners()
	self:RefreshSkills(unitId)
	self:RefreshSkillEnergyBar()
	self:UnfoldSkills(true)
end

function m:Hide(instantly)
	if not self.View.activeSelf then
		return
	end

	self:RemoveListeners()
	self:ClearSelectSkill()

	self.UnitId = 0

	self:StopAllTimer(true)

	if instantly then
		self.View:SetActive(false)
	elseif self.IsFold then
		self:DisableAfterReverseAnim(self.SwitchButton, 0.2, 0.2, function()
			self.View:SetActive(false)
		end)
	else
		self:DisableAfterReverseAnim(self.SkillRoot, 1, 0.5, function()
			self.View:SetActive(false)
		end)
	end

	self.UltimateSkillButton:StopLoopEffects()
	self:StopEnergyBarEffect()
end

function m:RefreshSkills(unitId, specifiedSkillCid)
	local battleUnitPOD = BattleModule.GetBattleUnitPOD(unitId)
	local hasCore2 = false

	for i = 0, battleUnitPOD.Skills.Count - 1 do
		local skillCid = battleUnitPOD.Skills[i]

		if specifiedSkillCid == nil or skillCid == specifiedSkillCid then
			local cfgSkillData = CfgSkillTable[skillCid]

			if cfgSkillData.ShowType == Constant.Skill.SHOW_TYPE_NORMAL then
				self.NormalSkillButton:SetSkill(cfgSkillData, unitId)
			elseif cfgSkillData.ShowType == Constant.Skill.SHOW_TYPE_CORE then
				self.CoreSkillButton:SetSkill(cfgSkillData, unitId)
			elseif cfgSkillData.ShowType == Constant.Skill.SHOW_TYPE_CORE2 then
				hasCore2 = true

				self.CoreSkillButton2:SetSkill(cfgSkillData, unitId)
			elseif cfgSkillData.ShowType == Constant.Skill.SHOW_TYPE_ULTIMATE then
				self.UltimateSkillButton:SetSkill(cfgSkillData, unitId)
				self.UltimateSkillButton:CheckSkillEnergyEffect()
			end
		end
	end

	self.CoreSkillButton2.View:SetActive(hasCore2)
	self:RefreshOptionalSpSkill()
end

function m:IsHiding()
	return self.UnitId == 0 and self.View.activeSelf
end

function m:FinishHideImmediately()
	self:StopAllTimer(true)
	self.View:SetActive(false)
end

function m:ClearSelectSkill()
	if self.SelectingButton ~= nil then
		self.SelectingButton:SetSelect(false)

		self.SelectingButton = nil
	end
end

function m:RefreshSkillEnergyBar()
	local energy = BattleModule.GetUnitSkillEnergy(self.UnitId)
	local maxEnergy = BattleModule.GetUnitMaxSkillEnergy(self.UnitId)
	local energyProgress = energy / maxEnergy

	self.EnergyBar:GetComponent("Image").fillAmount = energyProgress

	if energyProgress >= 1 then
		if self.EnergyBarEffectPlayId == 0 then
			self.EnergyBarEffectPlayId = GameEntry.Effect:PlayUIMountPointEffect(9005113, 50000, 0, self.EnergyBar, Constant.Unity.SortingOrderMaxValue - 1)
		end
	else
		self:StopEnergyBarEffect()
	end

	UGUIUtil.SetText(self.EnergyText, BattleUIApi:GetString("SkillGroupEnergyText", energy, maxEnergy))
end

function m:OnUpdateSkillEnergy(unitId, skillEnergy)
	if unitId == self.UnitId then
		self:RefreshSkillEnergy()
	end
end

function m:OnUpdateMaxSkillEnergy(unitId, skillEnergy)
	if unitId == self.UnitId then
		self:RefreshSkillEnergy()
	end
end

function m:RefreshSkillEnergy()
	self:RefreshSkillEnergyBar()
	self.NormalSkillButton:RefreshSkillEnergy()
	self.CoreSkillButton:RefreshSkillEnergy()
	self.CoreSkillButton2:RefreshSkillEnergy()
	self.UltimateSkillButton:RefreshSkillEnergy()
	self.UltimateSkillButton:CheckSkillEnergyEffect()
end

function m:OnUpdateSkillCostEnergy(unitId, skillCid)
	if unitId == self.UnitId then
		if self.NormalSkillButton.CfgSkillData.Id == skillCid then
			self.NormalSkillButton:RefreshSkillEnergy()
		end

		if self.CoreSkillButton.CfgSkillData.Id == skillCid then
			self.CoreSkillButton:RefreshSkillEnergy()
		end

		if self.CoreSkillButton2.CfgSkillData.Id == skillCid then
			self.CoreSkillButton2:RefreshSkillEnergy()
		end

		if self.UltimateSkillButton.CfgSkillData.Id == skillCid then
			self.UltimateSkillButton:RefreshSkillEnergy()
			self.UltimateSkillButton:CheckSkillEnergyEffect()
		end
	end
end

function m:StopEnergyBarEffect()
	if self.EnergyBarEffectPlayId ~= 0 then
		GameEntry.Effect:StopEffect(self.EnergyBarEffectPlayId)

		self.EnergyBarEffectPlayId = 0
	end
end

function m:AddListeners()
	self.SwitchButton:GetComponentInChildren(typeof(UnityEngine.UI.Button)).onClick:AddListener(self.DelegateOnClickSwitchBtn)
	EventDispatcher.AddEventListener(EventID.BattleUpdateSkillCostEnergy, self.DelegateOnUpdateSkillCostEnergy)
	EventDispatcher.AddEventListener(EventID.BattleUpdateUnitSkillEnergy, self.DelegateOnUpdateSkillEnergy)
	EventDispatcher.AddEventListener(EventID.BattleUpdateUnitMaxSkillEnergy, self.DelegateOnUpdateMaxSkillEnergy)
	EventDispatcher.AddEventListener(EventID.BattleModifySkill, self.DelegateOnModifySkill)
end

function m:RemoveListeners()
	self.SwitchButton:GetComponentInChildren(typeof(UnityEngine.UI.Button)).onClick:RemoveListener(self.DelegateOnClickSwitchBtn)
	EventDispatcher.RemoveEventListener(EventID.BattleUpdateSkillCostEnergy, self.DelegateOnUpdateSkillCostEnergy)
	EventDispatcher.RemoveEventListener(EventID.BattleUpdateUnitSkillEnergy, self.DelegateOnUpdateSkillEnergy)
	EventDispatcher.RemoveEventListener(EventID.BattleUpdateUnitMaxSkillEnergy, self.DelegateOnUpdateMaxSkillEnergy)
	EventDispatcher.RemoveEventListener(EventID.BattleModifySkill, self.DelegateOnModifySkill)
end

function m:OnClickSkillButton(button, cfgSkillData, isStandby)
	if self.SelectingSkill then
		return
	end

	self.SelectingSkill = true

	self:ClearSelectSkill()

	self.SelectingButton = button

	self.SelectingButton:SetSelect(true)
	self.OnClickSkillCallback(cfgSkillData, isStandby)

	if not isStandby then
		self:FoldSkills()
	end
end

function m:FoldSkills()
	self.IsFold = true

	self:DisableAfterReverseAnim(self.SkillRoot, 0.77, 0.5, function()
		self.SwitchButton:SetActive(true)
		UIUtil.PlayOrRewindDefaultAnim(self.SwitchButton)
	end)
	self.UltimateSkillButton:StopLoopEffects()
end

function m:UnfoldSkills(isTurnStart)
	self.SelectingSkill = false
	self.IsFold = false

	if not isTurnStart then
		BattleModule.SetUnitsSelectable({})
		self:ClearSelectSkill()
		self:DisableAfterReverseAnim(self.SwitchButton, 0.2)
	else
		self.SwitchButton:SetActive(false)
	end

	self.SkillRoot:SetActive(true)
	UIUtil.PlayOrRewindDefaultAnim(self.SkillRoot)
end

function m:DisableAfterReverseAnim(animRoot, duration, callbackDelay, onComplete)
	self:StopAllTimer(true)
	UIUtil.PlayOrRewindDefaultAnim(animRoot, true)

	self.LastDelayAnimRoot = animRoot
	self.LastDelayAnimOnComplete = onComplete

	local timer = ModuleTimerUtil.NewTimer(Constant.ModuleTimerName.BattleCastSkillButtonGroup, function()
		self.LastDelayAnimRoot = nil

		animRoot:SetActive(false)
	end, duration)

	timer:Start()

	if onComplete ~= nil then
		timer = ModuleTimerUtil.NewTimer(Constant.ModuleTimerName.BattleCastSkillButtonGroup, function()
			self.LastDelayAnimOnComplete = nil

			onComplete()
		end, callbackDelay)

		timer:Start()
	end
end

function m:GetCurrentSkill()
	if self.SelectingButton == nil then
		return nil
	end

	if self.UnitId == 0 then
		return nil
	end

	if self.UnitId == nil then
		logError("BattleCastSkillButtonGroup.UnitId == nil")

		return nil
	end

	return self.SelectingButton.CfgSkillData
end

function m:OnClickSwitchBtn()
	self:UnfoldSkills()
end

function m:StopAllTimer(invokeCallback)
	ModuleTimerUtil.Stop(Constant.ModuleTimerName.BattleCastSkillButtonGroup)

	if invokeCallback then
		if self.LastDelayAnimRoot ~= nil then
			self.LastDelayAnimRoot:SetActive(false)

			self.LastDelayAnimRoot = nil
		end

		if self.LastDelayAnimOnComplete ~= nil then
			self.LastDelayAnimOnComplete()

			self.LastDelayAnimOnComplete = nil
		end
	end
end

function m:RefreshOptionalSpSkill()
	self.OptionalSpSkillCell:SetData(self.UnitId)
end

function m:OnModifySkill(unitId, oldSkillCid, newSkillCid)
	if self.UnitId ~= 0 and self.UnitId == unitId then
		self:RefreshSkills(unitId, newSkillCid)
	end
end

function m:Dispose()
	self:RemoveListeners()
	self:StopEnergyBarEffect()
	self.NormalSkillButton:Dispose()
	self.CoreSkillButton:Dispose()
	self.UltimateSkillButton:Dispose()
	self.StandbyButton:Dispose()
	self.OptionalSpSkillCell:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.OnClickSkillCallback = nil
	self.LastDelayAnimRoot = nil
	self.LastDelayAnimOnComplete = nil
end

return m
