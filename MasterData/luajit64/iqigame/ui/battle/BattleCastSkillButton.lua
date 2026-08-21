-- chunkname: @IQIGame\\UI\\Battle\\BattleCastSkillButton.lua

local m = {
	Selected = false,
	BtnDownTime = 0,
	EnergyFullEffectPlayId = 0,
	UnitId = 0,
	IsStandby = false
}

function m.New(view, onClick, isStandby)
	local obj = Clone(m)

	obj:Init(view, onClick, isStandby)

	return obj
end

function m:Init(view, onClick, isStandby)
	self.View = view
	self.OnClickCallback = onClick
	self.IsStandby = isStandby

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClick()
		self:OnClick()
	end

	function self.DelegateOnLongClick()
		self:OnLongClick()
	end

	function self.DelegateBattleUnitChangeState(unitId)
		self:OnBattleUnitChangeState(unitId)
	end

	function self.DelegateUpdateUnitSkillCD(unitID)
		self:OnUpdateUnitSkillCD(unitID)
	end

	self.Button:GetComponent("LongButton").repeatCall = false

	self:AddListeners()
end

function m:AddListeners()
	self.Button:GetComponent("LongButton").onClick:AddListener(self.DelegateOnClick)
	self.Button:GetComponent("LongButton").onLongDownClick:AddListener(self.DelegateOnLongClick)
	EventDispatcher.AddEventListener(EventID.BattleUnitChangeState, self.DelegateBattleUnitChangeState)
	EventDispatcher.AddEventListener(EventID.BattleUpdateUnitSkillCD, self.DelegateUpdateUnitSkillCD)
end

function m:RemoveListeners()
	self.Button:GetComponent("LongButton").onClick:RemoveListener(self.DelegateOnClick)
	self.Button:GetComponent("LongButton").onLongDownClick:RemoveListener(self.DelegateOnLongClick)
	EventDispatcher.RemoveEventListener(EventID.BattleUnitChangeState, self.DelegateBattleUnitChangeState)
	EventDispatcher.RemoveEventListener(EventID.BattleUpdateUnitSkillCD, self.DelegateUpdateUnitSkillCD)
end

function m:OnBattleUnitChangeState(unitId)
	if self.UnitId == unitId and self.CfgSkillData then
		local isSeal = false

		if not self.IsStandby then
			isSeal = BattleModule.IsSkillSeal(self.UnitId, self.CfgSkillData)
		end

		if self.SealView ~= nil then
			self.SealView:SetActive(isSeal)
		end
	end
end

function m:OnUpdateUnitSkillCD(unitId)
	if self.UnitId == unitId then
		self:RefreshCD()
	end
end

function m:SetSkill(cfgSkillData, unitId)
	self.CfgSkillData = cfgSkillData
	self.UnitId = unitId

	if self.SpTag ~= nil then
		local topChapterType = MazeDataModule.ChapterType == Constant.Maze.ChapterTypeRpg or MazeDataModule.ChapterType == Constant.Maze.ChapterTypeHorizontalRPG or MazeDataModule.ChapterType == Constant.Maze.ChapterTypeHorizontalChallenge

		self.SpTag:SetActive(not EvilErosionModule.IsEvilErosionBattle and SoulSpecialSpiritModule.CheckSpAllActive(cfgSkillData.Id) and (not PlayerModule.InMaze or not topChapterType))
	end

	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(self.CfgSkillData.Icon), self.Icon:GetComponent("Image"))

	local isSeal = false

	if not self.IsStandby then
		isSeal = BattleModule.IsSkillSeal(self.UnitId, self.CfgSkillData)
	end

	if self.SealView ~= nil then
		self.SealView:SetActive(isSeal)
	end

	if self.EnergyCostView ~= nil then
		if self.CfgSkillData.ReleaseType == Constant.Skill.RELEASE_TYPE_ACTIVE then
			local costEnergy = BattleModule.GetSkillCostEnergy(self.UnitId, self.CfgSkillData.Id)

			self.EnergyCostView:SetActive(costEnergy > 0)

			if costEnergy > 0 then
				UGUIUtil.SetTextInChildren(self.EnergyCostView, costEnergy)
			end
		else
			self.EnergyCostView:SetActive(true)
			UGUIUtil.SetTextInChildren(self.EnergyCostView, BattleUIApi:GetString("SkillReleaseTypePassiveLabel"))
		end
	end

	self:RefreshCD()
	self:RefreshSkillEnergy()
end

function m:RefreshCD()
	if self.CDView == nil or LuaCodeInterface.GameObjIsDestroy(self.CDView) then
		return
	end

	local cd = BattleModule.GetSkillCD(self.UnitId, self.CfgSkillData.Id)
	local needShowCD = cd ~= 0 and self.CfgSkillData.ReleaseType == Constant.Skill.RELEASE_TYPE_ACTIVE

	self.CDView:SetActive(needShowCD)

	if needShowCD then
		UGUIUtil.SetText(self.CDText, cd)

		local cfgSkillDetailData = CfgSkillDetailTable[self.CfgSkillData.SkillDetail]
		local maxCD = cfgSkillDetailData.CoolDown

		if BattleModule.Round == 1 then
			maxCD = cfgSkillDetailData.InitCD
		end

		self.CDBar:GetComponent("Image").fillAmount = cd / maxCD
	end
end

function m:RefreshSkillEnergy()
	if self.EnergyBar == nil and self.EnergyNotEnoughView == nil then
		return
	end

	local costEnergy = BattleModule.GetSkillCostEnergy(self.UnitId, self.CfgSkillData.Id)
	local needCostEnergy = self.CfgSkillData.ReleaseType == Constant.Skill.RELEASE_TYPE_ACTIVE and costEnergy > 0
	local energy = BattleModule.GetUnitSkillEnergy(self.UnitId)

	if self.EnergyBar ~= nil then
		self.EnergyBar:SetActive(needCostEnergy)

		self.EnergyBar:GetComponent("Image").fillAmount = energy / costEnergy
	end

	if self.EnergyNotEnoughView ~= nil then
		self.EnergyNotEnoughView:SetActive(needCostEnergy and energy < costEnergy)
	end
end

function m:CheckSkillEnergyEffect()
	local energy = BattleModule.GetUnitSkillEnergy(self.UnitId)
	local costEnergy = BattleModule.GetSkillCostEnergy(self.UnitId, self.CfgSkillData.Id)

	if costEnergy <= energy then
		if self.EnergyFullEffectPlayId == 0 then
			self.EnergyFullEffectPlayId = GameEntry.Effect:PlayUIMountPointEffect(9005019, 50000, 0, self.View, self.View:GetComponentInParent(typeof(UnityEngine.Canvas)).sortingOrder + 1)
		end
	elseif self.EnergyFullEffectPlayId ~= 0 then
		GameEntry.Effect:StopEffect(self.EnergyFullEffectPlayId)

		self.EnergyFullEffectPlayId = 0
	end
end

function m:StopLoopEffects()
	if self.EnergyFullEffectPlayId ~= 0 then
		GameEntry.Effect:StopEffect(self.EnergyFullEffectPlayId)

		self.EnergyFullEffectPlayId = 0
	end
end

function m:OnClick()
	local effectCid
	local canClick = self:CheckCanClick()

	if canClick then
		self.OnClickCallback(self, self.CfgSkillData, self.IsStandby)

		if self.CfgSkillData ~= nil and self.CfgSkillData.Type == Constant.Skill.TYPE_ULTIMATE then
			effectCid = 9005011
		end
	else
		effectCid = 9005003

		if self.CfgSkillData ~= nil then
			if self.CfgSkillData.Type == Constant.Skill.TYPE_NORMAL then
				effectCid = 9005016
			elseif self.CfgSkillData.Type == Constant.Skill.TYPE_ULTIMATE then
				effectCid = 9005014
			end
		end
	end

	if effectCid ~= nil then
		GameEntry.Effect:PlayUIMountPointEffect(effectCid, 50000, 0, self.View, self.View:GetComponentInParent(typeof(UnityEngine.Canvas)).sortingOrder + 1)
	end
end

function m:OnLongClick()
	local skillStrengths

	if self.CfgSkillData ~= nil then
		skillStrengths = {}

		local battleUnitPOD = BattleModule.GetBattleUnitPOD(self.UnitId)

		for i = 0, battleUnitPOD.SkillStrengths.Count - 1 do
			skillStrengths[i + 1] = battleUnitPOD.SkillStrengths[i]
		end
	end

	EventDispatcher.Dispatch(EventID.BattleShowSkillTip, self.CfgSkillData ~= nil and self.CfgSkillData.Id or -1, skillStrengths)
end

function m:CheckCanClick()
	if not self.IsStandby then
		if self.CfgSkillData == nil then
			logError("未找到对应的技能，请检查配置该按钮对应的技能是否默认解锁。")

			return
		end

		if self.CfgSkillData.ReleaseType == Constant.Skill.RELEASE_TYPE_PASSIVE then
			return
		end

		if BattleModule.IsSkillSeal(self.UnitId, self.CfgSkillData) then
			return false
		end

		local cd = BattleModule.GetSkillCD(self.UnitId, self.CfgSkillData.Id)

		if cd ~= 0 then
			return false
		end

		local costEnergy = BattleModule.GetSkillCostEnergy(self.UnitId, self.CfgSkillData.Id)

		if costEnergy > BattleModule.GetUnitSkillEnergy(self.UnitId) then
			return false
		end
	end

	return true
end

function m:SetSelect(value)
	if self.Selected == value then
		return
	end

	self.Selected = value
end

function m:Dispose()
	self:RemoveListeners()
	self:StopLoopEffects()
	self:SetSelect(false)
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.OnClickCallback = nil
end

return m
