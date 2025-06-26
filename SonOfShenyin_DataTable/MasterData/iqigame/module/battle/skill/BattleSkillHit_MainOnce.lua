-- chunkname: @IQIGame\\Module\\Battle\\Skill\\BattleSkillHit_MainOnce.lua

local BattleSkillHitBase = require("IQIGame/Module/Battle/Skill/BattleSkillHitBase")
local BattleSkillHit_MainOnce = Clone(BattleSkillHitBase)

function BattleSkillHit_MainOnce.New(mainSkill, subSkillQueue, timelineCfg)
	local obj = Clone(BattleSkillHit_MainOnce)

	obj:__Init(mainSkill, subSkillQueue, timelineCfg)

	return obj
end

function BattleSkillHit_MainOnce:__Init(mainSkill, subSkillQueue, timelineCfg)
	self:_Init(mainSkill, subSkillQueue, timelineCfg)

	if self.subSkillQueue ~= nil and self.subSkillQueue.Size > 0 then
		logError("技能 {0}，有子技能，检查Timeline 配置表 HitType 是否配置正确", self.mainSkill.SkillID)
	end
end

function BattleSkillHit_MainOnce:OnHit(hitEventArgs)
	self.hitIndex = self.hitIndex + 1

	if self.hitIndex > 1 then
		logError("Skill {0} Timeline 有多个打击点，和配置不符合", self.mainSkill.SkillID)

		return
	end

	for i = 1, #self.mainSkill.SkillHits do
		self:__DoHitWithBattleSkillHitPOD(hitEventArgs, self.mainSkill.CasterID, self.mainSkill.SkillHits[i])
	end
end

return BattleSkillHit_MainOnce
