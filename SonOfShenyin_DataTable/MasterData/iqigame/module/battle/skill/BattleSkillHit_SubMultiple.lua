-- chunkname: @IQIGame\\Module\\Battle\\Skill\\BattleSkillHit_SubMultiple.lua

local BattleSkillHitBase = require("IQIGame/Module/Battle/Skill/BattleSkillHitBase")
local BattleSkillHit_SubMultiple = Clone(BattleSkillHitBase)

BattleSkillHit_SubMultiple.totalDamage = {}
BattleSkillHit_SubMultiple.needShowTotalDamage = false

function BattleSkillHit_SubMultiple.New(mainSkill, subSkillQueue, timelineCfg)
	local obj = Clone(BattleSkillHit_SubMultiple)

	obj:__Init(mainSkill, subSkillQueue, timelineCfg)

	return obj
end

function BattleSkillHit_SubMultiple:__Init(mainSkill, subSkillQueue, timelineCfg)
	self:_Init(mainSkill, subSkillQueue, timelineCfg)

	self.totalDamage = {}

	local skillConfig = CfgSkillTable[mainSkill.SkillID]

	self.needShowTotalDamage = skillConfig.SkillType == Constant.SkillType.TYPE_LORE or Constant.SkillType.TYPE_ULTIMATE

	if self.subSkillQueue == nil then
		logError("技能 {0}，打击点配置错误，没有子技能", self.mainSkill.SkillID)
	end
end

function BattleSkillHit_SubMultiple:OnHit(hitEventArgs)
	self.hitIndex = self.hitIndex + 1

	if self.hitIndex == 1 then
		for i = 1, #self.mainSkill.SkillHits do
			self:__DoHitWithBattleSkillHitPOD(hitEventArgs, self.mainSkill.CasterID, self.mainSkill.SkillHits[i])
		end

		BattleModule.UpdateBattleUnitsData(BattleConstant.BattleUpdatePoint.SkillEnd, self.mainSkill.AfterUpdateUnits, nil, function()
			return
		end)
	end

	if self.subSkillQueue == nil then
		return
	end

	if self.subSkillQueue.Size == 0 then
		logError("技能 {0}，打击点配置比技能伤害段数高", self.mainSkill.SkillID)

		return
	end

	local subSkill = self.subSkillQueue:Dequeue()

	BattleModule.UpdateBattleUnitsData(BattleConstant.BattleUpdatePoint.SkillStart, subSkill.BeforeUpdateUnits, nil, function()
		return
	end)

	for j = 1, #subSkill.SkillHits do
		local skillHitPOD = subSkill.SkillHits[j]

		self:__RecordTotalDamage(skillHitPOD)
		self:__DoHitWithBattleSkillHitPOD(hitEventArgs, subSkill.CasterID, skillHitPOD)
	end

	BattleModule.UpdateBattleUnitsData(BattleConstant.BattleUpdatePoint.SkillEnd, subSkill.AfterUpdateUnits, nil, function()
		return
	end)
end

function BattleSkillHit_SubMultiple:__RecordTotalDamage(skillHitPOD)
	if not self.needShowTotalDamage then
		return
	end

	local tempDamage = self.totalDamage[skillHitPOD.UnitID]

	if tempDamage == nil then
		self.totalDamage[skillHitPOD.UnitID] = skillHitPOD.ActualDmg
	else
		self.totalDamage[skillHitPOD.UnitID] = tempDamage + skillHitPOD.ActualDmg
	end
end

function BattleSkillHit_SubMultiple:OnSkillEnd(callback)
	EventDispatcher.Dispatch(EventID.ShowTotalDamageNumber, self.totalDamage)
	BattleModule.WaitAllBattleUnitReady(function()
		if callback ~= nil then
			callback()
		end
	end)
end

return BattleSkillHit_SubMultiple
