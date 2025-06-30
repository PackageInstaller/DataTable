-- chunkname: @IQIGame\\Module\\Battle\\Skill\\BattleSkillHit_MainMultiple.lua

local BattleSkillHitBase = require("IQIGame/Module/Battle/Skill/BattleSkillHitBase")
local BattleSkillHit_MainMultiple = Clone(BattleSkillHitBase)

function BattleSkillHit_MainMultiple.New(mainSkill, subSkillQueue, timelineCfg)
	local obj = Clone(BattleSkillHit_MainMultiple)

	obj:__Init(mainSkill, subSkillQueue, timelineCfg)

	return obj
end

function BattleSkillHit_MainMultiple:__Init(mainSkill, subSkillQueue, timelineCfg)
	self:_Init(mainSkill, subSkillQueue, timelineCfg)

	if self.subSkillQueue ~= nil and self.subSkillQueue.Size > 0 then
		logError("技能 {0}，有子技能，检查Timeline 配置表 HitType 是否配置正确", self.mainSkill.SkillID)
	end
end

function BattleSkillHit_MainMultiple:OnHit(hitEventArgs)
	self.hitIndex = self.hitIndex + 1

	local skillHit = self.mainSkill.SkillHits[self.hitIndex]

	if skillHit == nil then
		logError("技能 {0}，打击点配置比技能伤害段数高", self.mainSkill.SkillID)

		return
	end

	self:__DoHitWithBattleSkillHitPOD(hitEventArgs, self.mainSkill.CasterID, skillHit)
end

return BattleSkillHit_MainMultiple
