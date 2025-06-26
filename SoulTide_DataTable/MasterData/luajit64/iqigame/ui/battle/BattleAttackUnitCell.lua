-- chunkname: @IQIGame\\UI\\Battle\\BattleAttackUnitCell.lua

local BattleAttackUnitCell = {
	_ultimateSkillID = 0,
	_battleUnitShield = 0,
	TargetHpRatio = 0,
	_battleUnitHP = 0,
	_isSkillCanCast = false,
	_battleUnitSkillMaxEnergy = 0,
	_battleUnitMaxHP = 0,
	CurrentActionCid = 0,
	HpRatioDifference = 0,
	EnergyIsFull = false,
	Index = 0,
	BattleUnitID = 0,
	EnergyFullLoopEffectPlayId = 0
}
local BattleBuffGroupController = require("IQIGame.UI.Battle.BattleBuffGroupController")

function BattleAttackUnitCell.New(view, canvas, index)
	local itemCell = Clone(BattleAttackUnitCell)

	itemCell:Init(view, canvas, index)

	return itemCell
end

function BattleAttackUnitCell:Init(view, canvas, index)
	self.View = view
	self.Canvas = canvas
	self.Index = index

	LuaCodeInterface.BindOutlet(view, self)

	function self.DelegateOnEntityMove(sender, args)
		self:OnEntityMove(sender, args)
	end

	function self.DelegateOnClickSelectBtn()
		self:OnClickSelectBtn()
	end

	function self.DelegateOnUpdateSkillEnergy(unitId, skillEnergy)
		self:OnUpdateSkillEnergy(unitId, skillEnergy)
	end

	function self.DelegateOnUpdateSkillCostEnergy(unitId, skillCid)
		self:OnUpdateSkillCostEnergy(unitId, skillCid)
	end

	function self.DelegateOnModifySkill(unitId, oldSkillCid, newSkillCid)
		self:OnModifySkill(unitId, oldSkillCid, newSkillCid)
	end

	self.BuffGroupController = BattleBuffGroupController.New(self.BuffView)
	self.GrayComponent = self.View:GetComponent("ImageGroupGrayComponent")

	self.GrayComponent:EnableGray(false)

	self.HpReduceFollowBarImage = self.HpReduceFollowBar:GetComponent("Image")

	self:AddEventListeners()
end

function BattleAttackUnitCell:AddEventListeners()
	self.SelectBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickSelectBtn)
	GameEntry.LuaEvent:Subscribe(BattleUnitMoveEventArgs.EventId, self.DelegateOnEntityMove)
	EventDispatcher.AddEventListener(EventID.BattleUpdateSkillCostEnergy, self.DelegateOnUpdateSkillCostEnergy)
	EventDispatcher.AddEventListener(EventID.BattleUpdateUnitSkillEnergy, self.DelegateOnUpdateSkillEnergy)
	EventDispatcher.AddEventListener(EventID.BattleModifySkill, self.DelegateOnModifySkill)
end

function BattleAttackUnitCell:RemoveEventListeners()
	self.SelectBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickSelectBtn)
	GameEntry.LuaEvent:Unsubscribe(BattleUnitMoveEventArgs.EventId, self.DelegateOnEntityMove)
	EventDispatcher.RemoveEventListener(EventID.BattleUpdateSkillCostEnergy, self.DelegateOnUpdateSkillCostEnergy)
	EventDispatcher.RemoveEventListener(EventID.BattleUpdateUnitSkillEnergy, self.DelegateOnUpdateSkillEnergy)
	EventDispatcher.RemoveEventListener(EventID.BattleModifySkill, self.DelegateOnModifySkill)
end

function BattleAttackUnitCell:OnEntityMove(sender, args)
	if self.BattleUnitID ~= 0 and args.UnitID == self.BattleUnitID or self.Index == args.Index + 1 then
		local pos = args.Position - args.CameraPosition

		pos.z = self.View.transform.position.z
		self.View.transform.position = pos
	end
end

function BattleAttackUnitCell:RefreshPosition()
	if not LuaCodeInterface.GameObjIsDestroy(self.HeroRoot) and not LuaCodeInterface.GameObjIsDestroy(BattleModule.BattleCamera) then
		local pos = self.HeroRoot.transform.position - BattleModule.BattleCamera.transform.position

		pos.z = self.View.transform.position.z
		self.View.transform.position = pos
	end
end

function BattleAttackUnitCell:SetItem(attackUnitPOD, heroRoot)
	self.View.name = "BattlePuppetUI_" .. attackUnitPOD.MonsterCfgId
	self.BattleUnitID = attackUnitPOD.ID
	self.HeroRoot = heroRoot

	self.ActiveView:SetActive(true)
	self.InActiveView:SetActive(false)

	for i = 1, #attackUnitPOD.Skills do
		local skillCid = attackUnitPOD.Skills[i]
		local SkillCfgData = CfgSkillTable[skillCid]

		if SkillCfgData.Type == Constant.Skill.TYPE_ULTIMATE then
			self._ultimateSkillID = skillCid

			break
		end
	end

	self._battleUnitSkillMaxEnergy = attackUnitPOD.SkillEnergyMax
	self._battleUnitHP = attackUnitPOD.HP
	self._battleUnitMaxHP = attackUnitPOD.MaxHP
	self._battleUnitShield = attackUnitPOD.Shield

	self:UpdateHpAndShield()
	self:UpdateEnergy(attackUnitPOD.SkillEnergy)
	self.BuffGroupController:ResetBattleUnit(self.BattleUnitID)
	self.BuffGroupController:Refresh()
	self.GrayComponent:EnableGray(false)
	self:RefreshPosition()
end

function BattleAttackUnitCell:Clear()
	self.ActiveView:SetActive(false)
	self.InActiveView:SetActive(true)

	self.BattleUnitID = 0
	self.View.name = "BattlePuppetUI_0"
end

function BattleAttackUnitCell:SetHpAndShield(unitHp, unitMaxHp, unitShield, removeShield)
	self._battleUnitHP = unitHp
	self._battleUnitMaxHP = unitMaxHp
	self._battleUnitShield = unitShield

	self:UpdateHpAndShield(removeShield)
end

function BattleAttackUnitCell:UpdateHpAndShield(removeShield)
	self.AttackUnitHpTxt:GetComponent("Text").text = BattleUIApi:GetString("HpText", self._battleUnitHP, self._battleUnitShield, self._battleUnitMaxHP)

	local hpShield = self._battleUnitHP + self._battleUnitShield
	local maxHpShield = self._battleUnitMaxHP + self._battleUnitShield

	if hpShield < self._battleUnitMaxHP then
		maxHpShield = self._battleUnitMaxHP
	end

	self.TargetHpRatio = (self._battleUnitHP + self._battleUnitShield) / maxHpShield

	if removeShield then
		self.HpReduceFollowBarImage.fillAmount = self.TargetHpRatio
	end

	self.HpRatioDifference = self.TargetHpRatio - self.HpReduceFollowBarImage.fillAmount
	self.HpBar:GetComponent("Image").fillAmount = self._battleUnitHP / maxHpShield
	self.ShieldBar:GetComponent("Image").fillAmount = self.TargetHpRatio
end

function BattleAttackUnitCell:GetBattleUnitCurrentHp()
	return self._battleUnitHP
end

function BattleAttackUnitCell:AddBuff(buffDatas)
	self.BuffGroupController:OnAddBuff(buffDatas)
end

function BattleAttackUnitCell:RemoveBuff(buffCid)
	self.BuffGroupController:OnRemoveBuff(buffCid)
end

function BattleAttackUnitCell:UpdateEnergy(energy)
	UGUIUtil.SetText(self.EnergyText, energy)
	self:UpdateCanCastUltimate(energy)
end

function BattleAttackUnitCell:UpdateCanCastUltimate(energy)
	local ultimateCostEnergy = BattleModule.GetSkillCostEnergy(self.BattleUnitID, self._ultimateSkillID)

	self:SetEnergyCanCastUltimate(ultimateCostEnergy <= energy)
end

function BattleAttackUnitCell:OnClose()
	self:StopAllEffect()
	self.BuffGroupController:OnClose()
end

function BattleAttackUnitCell:StopAllEffect()
	self:SetEnergyCanCastUltimate(false)
end

function BattleAttackUnitCell:DoUnitDead()
	self.BuffGroupController:Clear()
	self.GrayComponent:EnableGray(true)
end

function BattleAttackUnitCell:OnClickSelectBtn()
	GameEntry.LuaEvent:FireNow(nil, BattleGestureOnElementEventArgs():Fill(self.BattleUnitID, Constant.GestureType.Tap))
end

function BattleAttackUnitCell:Update(elapseSeconds, realElapseSeconds)
	if self.TargetHpRatio ~= self.HpReduceFollowBarImage.fillAmount then
		self.HpReduceFollowBarImage.fillAmount = self.HpReduceFollowBarImage.fillAmount + self.HpRatioDifference * elapseSeconds * 2

		if (self.TargetHpRatio - self.HpReduceFollowBarImage.fillAmount) * self.HpRatioDifference <= 0 then
			self.HpReduceFollowBarImage.fillAmount = self.TargetHpRatio
		end
	end
end

function BattleAttackUnitCell:ItsMyTurn()
	return
end

function BattleAttackUnitCell:OnUpdateSkillEnergy(unitId, skillEnergy)
	if unitId == self.BattleUnitID then
		self:UpdateEnergy(skillEnergy)
	end
end

function BattleAttackUnitCell:OnUpdateSkillCostEnergy(unitId, skillCid)
	if unitId == self.BattleUnitID and skillCid == self._ultimateSkillID then
		self:UpdateCanCastUltimate(BattleModule.GetUnitSkillEnergy(self.BattleUnitID))
	end
end

function BattleAttackUnitCell:SetEnergyCanCastUltimate(isFull)
	if self.EnergyIsFull == isFull then
		return
	end

	self.EnergyIsFull = isFull

	if isFull then
		self:PlayEffect(4000004, 1)

		self.EnergyFullStartEffectTimer = Timer.New(function()
			self.EnergyFullStartEffectTimer = nil
			self.EnergyFullLoopEffectPlayId = self:PlayEffect(4000005, 1)
		end, 0.5)

		self.EnergyFullStartEffectTimer:Start()
	else
		if self.EnergyFullStartEffectTimer ~= nil then
			self.EnergyFullStartEffectTimer:Stop()

			self.EnergyFullStartEffectTimer = nil
		end

		if self.EnergyFullLoopEffectPlayId ~= 0 then
			GameEntry.Effect:StopEffect(self.EnergyFullLoopEffectPlayId)

			self.EnergyFullLoopEffectPlayId = 0
		end
	end
end

function BattleAttackUnitCell:PlayEffect(effectCid, orderOffset)
	return GameEntry.Effect:PlayUIMountPointEffect(effectCid, 50000, 0, self.View, self.Canvas.sortingOrder + orderOffset)
end

function BattleAttackUnitCell:OnModifySkill(unitId, oldSkillCid, newSkillCid)
	if self.BattleUnitID == unitId and self._ultimateSkillID == oldSkillCid then
		self._ultimateSkillID = newSkillCid

		self:UpdateCanCastUltimate(BattleModule.GetUnitSkillEnergy(self.BattleUnitID))
	end
end

function BattleAttackUnitCell:Dispose()
	self:RemoveEventListeners()
	self.BuffGroupController:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
	self.HeroRoot = nil
end

return BattleAttackUnitCell
