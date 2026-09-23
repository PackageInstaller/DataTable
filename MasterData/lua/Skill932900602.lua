-- 杀意
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill932900602 = oo.class(SkillBase)
function Skill932900602:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 死亡时
function Skill932900602:OnDeath(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 932900603
	self:ExtraRound(SkillEffect[932900603], caster, self.card, data, nil)
end
