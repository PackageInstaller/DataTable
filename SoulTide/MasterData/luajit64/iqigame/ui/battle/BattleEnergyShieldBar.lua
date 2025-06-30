-- chunkname: @IQIGame\\UI\\Battle\\BattleEnergyShieldBar.lua

local m = {
	BeHitEffectPlayId = 0,
	WeakNum = 0,
	ShieldDots = {}
}
local BattleEnergyShieldBarDot = require("IQIGame.UI.Battle.BattleEnergyShieldBarDot")

function m.New(view, battleUI)
	local obj = Clone(m)

	obj:Init(view, battleUI)

	return obj
end

function m:Init(view, battleUI)
	self.View = view
	self.BattleUI = battleUI

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnUpdateWeakInfo(sender, args)
		self:OnUpdateWeakInfo(sender, args)
	end

	function self.DelegateOnChangeSkillSelectTargets(skillCid, selectableUnits)
		self:OnChangeSkillSelectTargets(skillCid, selectableUnits)
	end

	function self.DelegateOnClickDotAreaButton()
		self:OnClickDotAreaButton()
	end

	function self.DelegateOnClickShieldAreaButton()
		self:OnClickShieldAreaButton()
	end

	for i = 1, Constant.BattleDamageType.ElementTypeNum do
		local dotGo = UnityEngine.Object.Instantiate(self.ShieldDotPrefab)

		dotGo.transform:SetParent(self.ShieldDotGrid.transform, false)

		local cell = BattleEnergyShieldBarDot.New(dotGo, i, self.BattleUI)

		self.ShieldDots[i] = cell
	end

	self.View:SetActive(false)
end

function m:OnOpen(battleUnitId)
	self.View:SetActive(true)

	self.BattleUnitId = battleUnitId

	self:AddListeners()
	self:Refresh()
end

function m:OnClose()
	self.View:SetActive(false)
	self:RemoveListeners()
	self:Clear()
end

function m:AddListeners()
	self.DotAreaButton:GetComponent("Button").onClick:AddListener(self.DelegateOnClickDotAreaButton)
	self.ShieldAreaButton:GetComponent("Button").onClick:AddListener(self.DelegateOnClickShieldAreaButton)
	GameEntry.LuaEvent:Subscribe(BattleUpdateUnitWeakInfoEventArgs.EventId, self.DelegateOnUpdateWeakInfo)
	EventDispatcher.AddEventListener(EventID.BattleChangeSkillSelectTargets, self.DelegateOnChangeSkillSelectTargets)
end

function m:RemoveListeners()
	self.DotAreaButton:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickDotAreaButton)
	self.ShieldAreaButton:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickShieldAreaButton)
	GameEntry.LuaEvent:Unsubscribe(BattleUpdateUnitWeakInfoEventArgs.EventId, self.DelegateOnUpdateWeakInfo)
	EventDispatcher.RemoveEventListener(EventID.BattleChangeSkillSelectTargets, self.DelegateOnChangeSkillSelectTargets)
end

function m:Refresh()
	local battleUnitData = BattleModule.GetBattleUnitData(self.BattleUnitId)

	self.WeakNum = battleUnitData.WeakNum

	self:__Refresh(battleUnitData)
end

function m:__Refresh(battleUnitData)
	local shieldTypes = {}

	for i = 0, battleUnitData.WeakTypes.Length - 1 do
		shieldTypes[i + 1] = battleUnitData.WeakTypes[i]
	end

	for i = 1, #self.ShieldDots do
		local cell = self.ShieldDots[i]

		cell:SetEnabled(table.indexOf(shieldTypes, i) ~= -1)
	end

	local isWeak = battleUnitData.WeakNum <= 0

	self.BrokenShieldView:SetActive(isWeak)
	self.NormalShieldView:SetActive(not isWeak)
	UGUIUtil.SetTextInChildren(self.NormalShieldView, battleUnitData.WeakNum)
end

function m:OnUpdateWeakInfo(sender, args)
	local battleUnitData = BattleModule.GetBattleUnitData(self.BattleUnitId)

	self:__Refresh(battleUnitData)

	local oldWeakNum = self.WeakNum

	self.WeakNum = battleUnitData.WeakNum

	self:PlayWeakChangeEffect(self.WeakNum - oldWeakNum, oldWeakNum > 0 and self.WeakNum <= 0)
end

function m:PlayWeakChangeEffect(deltaWeakNum, isBreakPoint)
	if deltaWeakNum < 0 and not isBreakPoint then
		if self.BeHitEffectPlayId ~= 0 then
			BattleModule.CSBattleModule.StopEffect(self.BeHitEffectPlayId)
		end

		self.BeHitEffectPlayId = BattleModule.CSBattleModule.PlayMountPointEffect(BattleUIApi:GetString("EnergyShieldBeHitEffect", self.ElementType), Constant.MountPoint.PointHead, 0, self.View, 0, 0, self:GetEffectLayer(), 0, self:GetEffectSortingOrder())
	end

	if isBreakPoint then
		BattleModule.CSBattleModule.PlayMountPointEffect(BattleUIApi:GetString("EnergyShieldBreakEffect", self.ElementType), Constant.MountPoint.PointHead, 0, self.View, 0, 0, self:GetEffectLayer(), 0, self:GetEffectSortingOrder())
	end
end

function m:GetEffectLayer()
	if self.BattleUI ~= nil then
		return UnityEngine.LayerMask.NameToLayer("UI")
	else
		return UnityEngine.LayerMask.NameToLayer("BattleEffect")
	end
end

function m:GetEffectSortingOrder()
	if self.BattleUI ~= nil then
		return self.BattleUI.UIController:GetComponent("Canvas").sortingOrder + 1
	else
		return 0
	end
end

function m:OnChangeSkillSelectTargets(skillCid, selectableUnits)
	local elementTypes = {}

	if skillCid ~= nil then
		local skillCidList = {
			skillCid
		}
		local cfgSkillData = CfgSkillTable[skillCid]

		for i = 1, #cfgSkillData.SubSkills do
			table.insert(skillCidList, cfgSkillData.SubSkills[i])
		end

		for i = 1, #skillCidList do
			local cid = skillCidList[i]
			local lCfgSkillData = CfgSkillTable[cid]
			local cfgSkillDetailData = CfgSkillDetailTable[lCfgSkillData.SkillDetail]

			if not cfgSkillDetailData.IsNotBreakWeak and cfgSkillDetailData.Element ~= 0 and table.indexOf(elementTypes, cfgSkillDetailData.Element) == -1 then
				table.insert(elementTypes, cfgSkillDetailData.Element)
			end
		end
	end

	for i = 1, #self.ShieldDots do
		local cell = self.ShieldDots[i]

		cell:PlayEffect(elementTypes, selectableUnits ~= nil and #selectableUnits > 0 and table.indexOf(selectableUnits, self.BattleUnitId) ~= -1, self:GetEffectLayer(), self:GetEffectSortingOrder())
	end
end

function m:OnClickDotAreaButton()
	self:ShowEnergyShieldTip()
end

function m:OnClickShieldAreaButton()
	self:ShowEnergyShieldTip()
end

function m:ShowEnergyShieldTip()
	UIModule.Open(Constant.UIControllerName.BattleWeakShieldTipsUI, Constant.UILayer.Tooltip, {
		unitId = self.BattleUnitId
	})
end

function m:Clear()
	return
end

function m:Dispose()
	for i = 1, #self.ShieldDots do
		local cell = self.ShieldDots[i]

		cell:Dispose()
	end

	self.ShieldDots = nil

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.BattleUI = nil
end

return m
