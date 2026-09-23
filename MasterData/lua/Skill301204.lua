-- 天赋效果301204
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill301204 = oo.class(SkillBase)
function Skill301204:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害后
function Skill301204:OnAfterHurt(caster, target, data)
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
	-- 301204
	if self:Rand(4000) then
		self:LimitDamage(SkillEffect[301204], caster, target, data, 0.05,0.60)
	end
end
