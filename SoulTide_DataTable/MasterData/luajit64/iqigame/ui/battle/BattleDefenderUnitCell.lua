-- chunkname: @IQIGame\\UI\\Battle\\BattleDefenderUnitCell.lua

local BattleDefenderUnitCell = {
	IsBoss = false,
	_battleUnitShield = 0,
	TargetHpRatio = 0,
	_battleUnitHP = 0,
	_battleUnitMaxHP = 0,
	StartFillHp = false,
	_isDead = false,
	Active = false,
	HpRatioDifference = 0,
	StartHpAnimationHp = 0,
	BattleUnitID = 0
}
local BattleBuffGroupController = require("IQIGame.UI.Battle.BattleBuffGroupController")
local BattleEnergyShieldBar = require("IQIGame.UI.Battle.BattleEnergyShieldBar")

function BattleDefenderUnitCell.New(view, battleUI, isBoss)
	local obj = Clone(BattleDefenderUnitCell)

	obj:Init(view, battleUI, isBoss)

	return obj
end

function BattleDefenderUnitCell:Init(view, battleUI, isBoss)
	self.View = view
	self.IsBoss = isBoss == true

	LuaCodeInterface.BindOutlet(view, self)

	self.BuffGroupController = BattleBuffGroupController.New(self.BuffView)
	self.HpReduceFollowBarImage = self.HpReduceFollowBar:GetComponent("ImageFillHelper")
	self.EnergyShieldCom = BattleEnergyShieldBar.New(self.EnergyShieldBar, battleUI)
end

function BattleDefenderUnitCell:SetItem(argTable)
	if self.BattleUnitID ~= nil and self.BattleUnitID ~= 0 then
		logError("初始化敌人血条错误。该血条已有数据，检查是否没有Close。self.BattleUnitID " .. tostring(self.BattleUnitID))

		return
	end

	self._isDead = false
	self.StartFillHp = false
	self.BattleUnitID = argTable.UnitID
	self._battleUnitHP = argTable.BattleUnitHp
	self._battleUnitMaxHP = argTable.BattleUnitMaxHp
	self._battleUnitShield = argTable.BattleUnitShield

	if self.IsBoss then
		local cfgMonsterData = CfgMonsterTable[argTable.MonsterCfgId]

		self.NameText:GetComponent("Text").text = cfgMonsterData.Name
	else
		self.View.transform.position = argTable.UnitPosition
	end

	self.BuffGroupController:ResetBattleUnit(self.BattleUnitID)
	self.BuffGroupController:Refresh()
	self.EnergyShieldCom:OnOpen(self.BattleUnitID)
end

function BattleDefenderUnitCell:PlayHpAnimation()
	if self.IsBoss then
		self.BattleUnitHpText:SetActive(true)
	else
		self.View:SetActive(true)
	end

	self.Active = true
	self.StartFillHp = true
end

function BattleDefenderUnitCell:SetHpAndShield(unitHp, unitMaxHp, unitShield, removeShield)
	self._battleUnitHP = unitHp
	self._battleUnitMaxHP = unitMaxHp
	self._battleUnitShield = unitShield

	self:UpdateHpAndShield(removeShield)
end

function BattleDefenderUnitCell:UpdateHpAndShield(isConsumeShield)
	self:SetHp(self._battleUnitHP, nil, isConsumeShield)
end

function BattleDefenderUnitCell:SetHp(value, maxValue, removeShield)
	maxValue = maxValue or self._battleUnitMaxHP

	if self.BattleUnitHpText ~= nil then
		self.BattleUnitHpText:GetComponent("Text").text = BattleUIApi:GetString("HpText", value, self._battleUnitShield, maxValue)
	end

	local hpShield = value + self._battleUnitShield
	local maxHpShield = maxValue + self._battleUnitShield

	if hpShield < maxValue then
		maxHpShield = maxValue
	end

	self.TargetHpRatio = (value + self._battleUnitShield) / maxHpShield

	if removeShield then
		self.HpReduceFollowBarImage.fillAmount = self.TargetHpRatio
	end

	self.HpRatioDifference = self.TargetHpRatio - self.HpReduceFollowBarImage.fillAmount
	self.HpBar:GetComponent("ImageFillHelper").fillAmount = value / maxHpShield
	self.ShieldBar:GetComponent("ImageFillHelper").fillAmount = self.TargetHpRatio
end

function BattleDefenderUnitCell:AddBuff(buffDatas)
	self.BuffGroupController:OnAddBuff(buffDatas)
end

function BattleDefenderUnitCell:RemoveBuff(buffIDs)
	self.BuffGroupController:OnRemoveBuff(buffIDs)
end

function BattleDefenderUnitCell:Update(elapseSeconds, realElapseSeconds)
	if not self.Active then
		return
	end

	if self.StartFillHp then
		self.StartHpAnimationHp = self.StartHpAnimationHp + math.round(self._battleUnitHP / 30)

		if self.StartHpAnimationHp >= self._battleUnitHP or self.StartHpAnimationHp == 0 then
			self.StartHpAnimationHp = self._battleUnitHP
			self.StartFillHp = false
		end

		self:SetHp(self.StartHpAnimationHp)
	end

	if self.TargetHpRatio ~= self.HpReduceFollowBarImage.fillAmount then
		self.HpReduceFollowBarImage.fillAmount = self.HpReduceFollowBarImage.fillAmount + self.HpRatioDifference * elapseSeconds * 2

		if (self.TargetHpRatio - self.HpReduceFollowBarImage.fillAmount) * self.HpRatioDifference <= 0 then
			self.HpReduceFollowBarImage.fillAmount = self.TargetHpRatio
		end
	end
end

function BattleDefenderUnitCell:DoUnitDead()
	self.BuffGroupController:Clear()
	self.EnergyShieldCom:Clear()

	self._isDead = true
end

function BattleDefenderUnitCell:LoadAsset(path, imageGo)
	imageGo:SetActive(true)
	AssetUtil.LoadImage(self, path, imageGo:GetComponent("Image"))
end

function BattleDefenderUnitCell:IsUnitDead()
	return self._isDead
end

function BattleDefenderUnitCell:Reset()
	if self.IsBoss then
		self.BattleUnitHpText:SetActive(false)
	else
		self.View:SetActive(false)
	end

	self.StartHpAnimationHp = 0
	self.HpReduceFollowBarImage.fillAmount = 0
end

function BattleDefenderUnitCell:OnClose()
	self.BuffGroupController:OnClose()
	self.EnergyShieldCom:OnClose()

	self.Active = false
	self.BattleUnitID = 0
end

function BattleDefenderUnitCell:Dispose()
	AssetUtil.UnloadAsset(self)
	self.BuffGroupController:Dispose()
	self.EnergyShieldCom:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return BattleDefenderUnitCell
