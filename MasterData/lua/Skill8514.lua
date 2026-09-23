-- 天赋效果14
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill8514 = oo.class(SkillBase)
function Skill8514:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害后
function Skill8514:OnAfterHurt(caster, target, data)
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
	-- 8514
	if self:Rand(4000) then
		self:LimitDamage(SkillEffect[8514], caster, target, data, 0.15,0.75)
	end
end
