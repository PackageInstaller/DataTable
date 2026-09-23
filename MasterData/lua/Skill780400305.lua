-- 万华3
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill780400305 = oo.class(SkillBase)
function Skill780400305:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill780400305:DoSkill(caster, target, data)
	-- 11008
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11008], caster, target, data, 0.125,8)
end
