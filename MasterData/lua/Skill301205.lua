-- 天赋效果301205
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill301205 = oo.class(SkillBase)
function Skill301205:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害后
function Skill301205:OnAfterHurt(caster, target, data)
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
	-- 301205
	if self:Rand(4000) then
		self:LimitDamage(SkillEffect[301205], caster, target, data, 0.06,0.72)
	end
end
