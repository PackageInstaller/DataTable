-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill60010301 = oo.class(SkillBase)
function Skill60010301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害后
function Skill60010301:OnAfterHurt(caster, target, data)
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	self:HitAddBuff(SkillEffect[3109], caster, target, data, 800,3005)
end
-- 执行技能
function Skill60010301:DoSkill(caster, target, data)
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12004], caster, target, data, 0.25,4)
end
