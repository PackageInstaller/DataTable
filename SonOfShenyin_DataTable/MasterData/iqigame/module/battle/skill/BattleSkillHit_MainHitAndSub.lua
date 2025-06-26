-- chunkname: @IQIGame\\Module\\Battle\\Skill\\BattleSkillHit_MainHitAndSub.lua

local BattleSkillHitBase = require("IQIGame/Module/Battle/Skill/BattleSkillHitBase")
local SkillHit = Clone(BattleSkillHitBase)

SkillHit.totalDamage = {}
SkillHit.needShowTotalDamage = false

function SkillHit.New(mainSkill, subSkillQueue, timelineCfg)
	local obj = Clone(SkillHit)

	obj:__Init(mainSkill, subSkillQueue, timelineCfg)

	return obj
end

function SkillHit:__Init(mainSkill, subSkillQueue, timelineCfg)
	self:_Init(mainSkill, subSkillQueue, timelineCfg)

	self.totalDamage = {}

	local skillConfig = CfgSkillTable[mainSkill.SkillID]

	self.needShowTotalDamage = skillConfig.SkillType == Constant.SkillType.TYPE_ULTIMATE
end

function SkillHit:OnHit(hitEventArgs)
	self.hitIndex = self.hitIndex + 1

	if self.hitIndex == 1 then
		for i = 1, #self.mainSkill.SkillHits do
			self:__DoHitWithBattleSkillHitPOD(hitEventArgs, self.mainSkill.CasterID, self.mainSkill.SkillHits[i])
		end

		BattleModule.UpdateBattleUnitsData(BattleConstant.BattleUpdatePoint.SkillEnd, self.mainSkill.AfterUpdateUnits, nil, function()
			return
		end)

		return
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

function SkillHit:__RecordTotalDamage(skillHitPOD)
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

function SkillHit:OnSkillEnd(callback)
	EventDispatcher.Dispatch(EventID.ShowTotalDamageNumber, self.totalDamage)
	BattleModule.WaitAllBattleUnitReady(function()
		if callback ~= nil then
			callback()
		end
	end)
end

return SkillHit
