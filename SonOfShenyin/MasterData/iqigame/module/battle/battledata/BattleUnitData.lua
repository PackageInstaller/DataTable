-- chunkname: @IQIGame\\Module\\Battle\\BattleData\\BattleUnitData.lua

local BattleUnitDataBase = require("IQIGame.Module.Battle.BattleData.BattleUnitDataBase")
local BattleUnitData = Clone(BattleUnitDataBase)

BattleUnitData.isUnitFlip = false
BattleUnitData.hudOffset = nil
BattleUnitData.hudScale = nil
BattleUnitData.monsterType = 0
BattleUnitData.StateTimeLine = {}

function BattleUnitData.New(battleUnitPOD)
	local obj = Clone(BattleUnitData)

	obj:__Init(battleUnitPOD)

	return obj
end

function BattleUnitData:__Init(battleUnitPOD)
	self.joinBattle = false
	self.isTroopData = false

	self:__InitUnitDataByPOD(battleUnitPOD)

	self.specialStatus = {}

	if battleUnitPOD.SPStatus then
		for spStatusIndex, isOn in pairs(battleUnitPOD.SPStatus) do
			self:ChangeSpecialStatus(spStatusIndex, isOn)
		end
	end

	self.fightStatus = {}

	if battleUnitPOD.Status then
		ForArrayTable(battleUnitPOD.Status, function(_index, _isOn)
			local _statusIndex = _index - 1

			if _statusIndex == Constant.BattleFightStatus.NONE then
				return
			end

			self:UpdateFightStatus(_statusIndex, _isOn)
		end)
	end

	self:__InitSkinData()

	self.monsterConfigID = battleUnitPOD.MonsterCfgId

	local monsterConfig = CfgMonsterTable[self.monsterConfigID]

	self.monsterType = monsterConfig.MonsterType
	self.name = monsterConfig ~= nil and monsterConfig.Name or ""
	self.canHandleByPlayer = monsterConfig ~= nil and monsterConfig.IsHandle == 1 or false
	self.profession = monsterConfig ~= nil and monsterConfig.Profession or nil
	self.attackRange = self.profession ~= nil and CfgProfessionTable[self.profession].Att - 1 or 0
	self.level = battleUnitPOD.Level
	self.hp = battleUnitPOD.HP
	self.maxHp = battleUnitPOD.MaxHP
	self.shield = battleUnitPOD.Shield
	self.energy = battleUnitPOD.SkillEnergy
	self.maxEnergy = battleUnitPOD.MaxEnergy
	self.staticImageSkinCid = battleUnitPOD.IconId ~= nil and battleUnitPOD.IconId or 0
	self.skillSkinId = battleUnitPOD.SkillSkinId

	if self:IsDead() then
		self.joinBattle = true
	end
end

function BattleUnitData:Dispose()
	return
end

function BattleUnitData:IsBoss()
	return self.monsterType == 4
end

function BattleUnitData:UpdateFightStatus(fightStatusID, isIn)
	self.fightStatus[fightStatusID] = isIn

	EventDispatcher.Dispatch(EventID.BattleUnitStatusChange, self.battleUnitID, fightStatusID, isIn)
end

function BattleUnitData:IsInFightStatus(fightStatusID)
	return self.fightStatus[fightStatusID] ~= nil and self.fightStatus[fightStatusID] or false
end

function BattleUnitData:ChangeSpecialStatus(spStatusIndex, isOn)
	self.specialStatus[spStatusIndex] = isOn
end

function BattleUnitData:HasSpecialStatus(statusIndex)
	return self.specialStatus[statusIndex] == true
end

function BattleUnitData:CanBeAttackMove()
	return true
end

function BattleUnitData:IsDead()
	return self:HasSpecialStatus(Constant.BattleSPStatus.Dead)
end

function BattleUnitData:IsUltimateReady()
	local result = false

	ForPairs(self.skillsData, function(_skillCid, _skillData)
		if _skillData.isUltimate and _skillData.valid then
			result = self.energy >= _skillData.energyCost

			return true
		end
	end)

	return result
end

function BattleUnitData:GetBuffStack(buffConfigID)
	local buffData = self.buffsData[buffConfigID]

	if buffData == nil then
		return 0
	end

	return buffData.stack
end

function BattleUnitData:IsProfessionPO()
	return self.profession == Constant.BattleProfession.PO
end

function BattleUnitData:IsProfessionYU()
	return self.profession == Constant.BattleProfession.YU
end

function BattleUnitData:GetEnergy2()
	return self:IsProfessionPO() and self:GetBuffStack(Constant.BuffConfigIDToEnergy2) or 0
end

function BattleUnitData:GetEnergy2Max()
	return self:IsProfessionPO() and CfgBuffTable[Constant.BuffConfigIDToEnergy2].StackMaxNumber or 0
end

function BattleUnitData:CanSetTurnOrder()
	if self:IsDead() then
		return false
	end

	if self:IsInFightStatus(Constant.BattleFightStatus.DIZZY) then
		return false
	end

	if self:IsInFightStatus(Constant.BattleFightStatus.SLEEP) then
		return false
	end

	if self:HasSpecialStatus(Constant.BattleSPStatus.SellOut) then
		return false
	end

	return true
end

function BattleUnitData:GetSkillTimelineCid(skillCid)
	return self.PODData.SkillSkinId[skillCid]
end

function BattleUnitData:HasWake()
	local result = false

	ForPairs(self.PODData.WeakStatus, function(k, v)
		result = true
	end)

	return result
end

function BattleUnitData:GetWakeStatus(wakeCid)
	return self.PODData.WeakStatus[wakeCid]
end

function BattleUnitData:AddWake(wakeCid, status)
	self.PODData.WeakStatus[wakeCid] = status

	EventDispatcher.Dispatch(EventID.BattleUnitAddWake, self.battleUnitID, wakeCid)
end

function BattleUnitData:UpdateWakeStatus(wakeCid, status)
	self.PODData.WeakStatus[wakeCid] = status

	EventDispatcher.Dispatch(EventID.BattleUnitUpdateWakeStatus, self.battleUnitID, wakeCid)
end

function BattleUnitData:RemoveWake(wakeCid)
	self.PODData.WeakStatus[wakeCid] = nil

	EventDispatcher.Dispatch(EventID.BattleUnitRemoveWake, self.battleUnitID, wakeCid)
end

function BattleUnitData:UpdateWakeNum(num)
	self.PODData.WeakNum = num

	EventDispatcher.Dispatch(EventID.BattleUnitWakeNumChange, self.battleUnitID)
end

function BattleUnitData:UpdateWakeMaxNum(maxNum)
	self.PODData.WeakMaxNum = maxNum

	EventDispatcher.Dispatch(EventID.BattleUnitWakeNumChange, self.battleUnitID)
end

function BattleUnitData:OnHpChange(hp, battleDamageData)
	self.hp = hp

	EventDispatcher.Dispatch(EventID.BattleUnitHPChange, self.battleUnitID)

	if battleDamageData ~= nil then
		if not battleDamageData.showHitTips then
			return
		end

		EventDispatcher.Dispatch(EventID.ShowUnitDamageNumber, self.battleUnitID, battleDamageData)
	end
end

function BattleUnitData:OnShieldChange(shield, battleDamageData)
	self.shield = shield

	EventDispatcher.Dispatch(EventID.BattleUnitHPChange, self.battleUnitID)

	if battleDamageData ~= nil then
		EventDispatcher.Dispatch(EventID.ShowUnitDamageNumber, self.battleUnitID, battleDamageData)
	end
end

function BattleUnitData:OnMaxHPChange(maxHp)
	self.maxHp = maxHp

	EventDispatcher.Dispatch(EventID.BattleUnitHPChange, self.battleUnitID)
end

function BattleUnitData:OnEnergyChange(energy, addEnergy)
	self.energy = energy
	self.PODData.SkillEnergy = energy

	EventDispatcher.Dispatch(EventID.BattleUnitEnergyChange, self.battleUnitID)
end

function BattleUnitData:OnMaxEnergyChange(maxEnergy)
	self.maxEnergy = maxEnergy
	self.PODData.MaxEnergy = maxEnergy

	EventDispatcher.Dispatch(EventID.BattleUnitEnergyChange, self.battleUnitID)
end

function BattleUnitData:__InitSkinData()
	local elementEntityConfig = BattleModule.GetHeroBattleElementEntityCfgBySkinCid(self.PODData.HeroSkinId)

	self.entityConfigID = elementEntityConfig.Id

	if elementEntityConfig.IsPrefabFaceToRight then
		self.isUnitFlip = self.troopType ~= BattleModule.playerBattleTroop
	else
		self.isUnitFlip = self.troopType == BattleModule.playerBattleTroop
	end

	if self.isUnitFlip and elementEntityConfig.HpPosition ~= nil then
		local _x = elementEntityConfig.HpPosition[1]
		local _y = elementEntityConfig.HpPosition[2]

		self.hudOffset = Vector3.New(_x == nil and 0 or _x, _y == nil and 0 or _y, 0)
	else
		self.hudOffset = Vector3.New(0, 0, 0)
	end

	local _scale = 1

	if elementEntityConfig.HpScale ~= nil then
		_scale = elementEntityConfig.HpScale

		if _scale == 0 then
			_scale = 1
		end
	end

	self.hudScale = Vector3.New(_scale, _scale, _scale)
	self.StateTimeLine = {}
	self.StateTimeLine[BattleConstant.BattleStateTimelineType.Born] = elementEntityConfig.BornTimelineId
	self.StateTimeLine[BattleConstant.BattleStateTimelineType.Die] = elementEntityConfig.DieTimelineId
end

function BattleUnitData:ChangeSkin(skinId)
	self.PODData.HeroSkinId = skinId

	self:__InitSkinData()
	BattleModule.battleScene:AddBattleUnitSkinView(self.battleUnitID)
	EventDispatcher.Dispatch(EventID.BattleUnitSkinChange, self.battleUnitID)
end

return BattleUnitData
