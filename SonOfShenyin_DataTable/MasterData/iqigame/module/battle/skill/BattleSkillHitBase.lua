-- chunkname: @IQIGame\\Module\\Battle\\Skill\\BattleSkillHitBase.lua

local BattleSkillHitBase = {
	hitShowType = 0,
	hitIndex = 0
}

function BattleSkillHitBase:_Init(mainSkill, subSkillQueue, timelineCfg)
	self.mainSkill = mainSkill
	self.subSkillQueue = subSkillQueue
	self.hitIndex = 0
	self.hitShowType = timelineCfg.HitShowType
end

function BattleSkillHitBase:OnSkillPrepare(callback)
	local battleUnitData = BattleModule.GetBattleUnitDataByUnitID(self.mainSkill.CasterID)

	if battleUnitData.troopType == BattleModule.attackBattleTroopType then
		self:__DoSkillPrepare(callback)

		return
	end

	BattleSkillModule.ShowSkillAreaWarning(self.mainSkill.CasterID, self.mainSkill.SkillID, function()
		self:__DoSkillPrepare(callback)
	end)
end

function BattleSkillHitBase:__DoSkillPrepare(callback)
	BattleModule.UpdateBattleUnitsData(BattleConstant.BattleUpdatePoint.SkillStart, self.mainSkill.BeforeUpdateUnits, nil, function()
		BattleModule.WaitAllBattleUnitReady(function()
			if callback ~= nil then
				callback()
			end
		end)
	end)
end

function BattleSkillHitBase:OnHit(hitEventArgs)
	logError("OnHit 方法未实现")
end

function BattleSkillHitBase:OnSkillEnd(callback)
	self:__DoSkillEnd(callback)
end

function BattleSkillHitBase:__DoSkillEnd(callback)
	BattleModule.UpdateBattleUnitsData(BattleConstant.BattleUpdatePoint.SkillEnd, self.mainSkill.AfterUpdateUnits, nil, function()
		BattleModule.WaitAllBattleUnitReady(function()
			if callback ~= nil then
				callback()
			end
		end)
	end)
end

function BattleSkillHitBase:__DoHitWithBattleSkillHitPOD(hitEventArgs, casterID, skillHitPOD)
	local casterUnitData = BattleModule.GetBattleUnitDataByUnitID(casterID)

	if skillHitPOD.Scope ~= Constant.UpdateScope.BattleUnit then
		return
	end

	local hitUnitView = BattleModule.GetBattleUnitViewByUnitID(skillHitPOD.UnitID)
	local hitUnitData = BattleModule.GetBattleUnitDataByUnitID(skillHitPOD.UnitID)

	if hitUnitView ~= nil then
		if self.hitShowType == 0 then
			hitUnitView:SetVisible(true)
			hitUnitView:SetHeroPropertyActive(true)
		end

		if casterUnitData.troopType ~= hitUnitData.troopType and skillHitPOD.ActualDmg > 0 then
			local hitData = {}

			hitData.hitAnimType = hitEventArgs.HitAnimType
			hitData.hitElementType = skillHitPOD.ElementType
			hitData.hitEffectCid = hitEventArgs.HitEffectCid
			hitData.hitEffectHangingPoint = hitEventArgs.ParentName

			hitUnitView:BeHit(hitData)
		end
	end

	if skillHitPOD.Immunity then
		EventDispatcher.Dispatch(EventID.ShowCommonDamageNumber, skillHitPOD.UnitID, BattleUIApi:GetDamageImmunityText())
	end

	if not skillHitPOD.Hit then
		EventDispatcher.Dispatch(EventID.ShowCommonDamageNumber, skillHitPOD.UnitID, BattleUIApi:GetDamageDodgeText())
	end

	local userData = {}

	userData.isCritical = skillHitPOD.Crit
	userData.damageType = skillHitPOD.DamageType
	userData.isSerialHit = hitEventArgs.IsSerialHit
	userData.isTimelineHitTrigger = true
	userData.showHitTips = true
	userData.advantage = skillHitPOD.Advantage

	BattleModule.UpdateBattleUnitsData(BattleConstant.BattleUpdatePoint.SkillHit, skillHitPOD.UpdateUnits, userData, function()
		return
	end)

	if not userData.showHitTips then
		local battleDamageData = {}

		battleDamageData.battleUnitID = skillHitPOD.UnitID
		battleDamageData.elementType = skillHitPOD.ElementType
		battleDamageData.damage = skillHitPOD.ActualDmg * -1
		battleDamageData.isCritical = skillHitPOD.Crit
		battleDamageData.damageType = skillHitPOD.DamageType
		battleDamageData.isSerialHit = hitEventArgs.IsSerialHit
		battleDamageData.isTimelineHitTrigger = true
		battleDamageData.isShield = false
		battleDamageData.advantage = skillHitPOD.Advantage

		EventDispatcher.Dispatch(EventID.ShowUnitDamageNumber, skillHitPOD.UnitID, battleDamageData)
	end
end

return BattleSkillHitBase
