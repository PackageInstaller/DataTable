-- 天赋效果13
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill8513 = oo.class(SkillBase)
function Skill8513:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害后
function Skill8513:OnAfterHurt(caster, target, data)
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
	-- 8513
	if self:Rand(4000) then
		self:LimitDamage(SkillEffect[8513], caster, target, data, 0.1,0.5)
	end
end
