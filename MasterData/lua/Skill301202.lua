-- 天赋效果301202
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill301202 = oo.class(SkillBase)
function Skill301202:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害后
function Skill301202:OnAfterHurt(caster, target, data)
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
	-- 301202
	if self:Rand(4000) then
		self:LimitDamage(SkillEffect[301202], caster, target, data, 0.03,0.36)
	end
end
