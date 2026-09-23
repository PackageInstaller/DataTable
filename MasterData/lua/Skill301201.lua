-- 天赋效果301201
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill301201 = oo.class(SkillBase)
function Skill301201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害后
function Skill301201:OnAfterHurt(caster, target, data)
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
	-- 8213
	if SkillJudger:IsCrit(self, caster, target, true) then
	else
		return
	end
	-- 301201
	if self:Rand(4000) then
		self:LimitDamage(SkillEffect[301201], caster, target, data, 0.02,0.24)
	end
end
