-- 星云共鸣
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4403103 = oo.class(SkillBase)
function Skill4403103:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 死亡时
function Skill4403103:OnDeath(caster, target, data)
	-- 8166
	if SkillJudger:CasterIsOwnSummon(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 4403103
	self:AddProgress(SkillEffect[4403103], caster, self.card, data, 600)
	-- 4403106
	self:AddBuff(SkillEffect[4403106], caster, self.card, data, 4006,1)
end
