-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill90010201 = oo.class(SkillBase)
function Skill90010201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill90010201:DoSkill(caster, target, data)
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[12101], caster, target, data, 0.2,3)
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12102], caster, target, data, 0.4,1)
end
