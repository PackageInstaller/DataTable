-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill300500210 = oo.class(SkillBase)
function Skill300500210:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill300500210:DoSkill(caster, target, data)
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11004], caster, target, data, 0.25,4)
end
-- 伤害后
function Skill300500210:OnAfterHurt(caster, target, data)
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	if SkillJudger:CasterIsSelf(self, caster, target, true) and SkillJudger:TargetIsEnemy(self, caster, target, true) then
		self:Cure(SkillEffect[31005], caster, self.card, data, 5,0.5)
	end
end
