-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill100200310 = oo.class(SkillBase)
function Skill100200310:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill100200310:DoSkill(caster, target, data)
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11051], caster, target, data, 0.5,4)
	self.order = self.order + 1
	self:DamageLight(SkillEffect[11052], caster, target, data, 0.5,2)
end
