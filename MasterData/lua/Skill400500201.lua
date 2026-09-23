-- 枪火
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill400500201 = oo.class(SkillBase)
function Skill400500201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill400500201:DoSkill(caster, target, data)
	-- 11061
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11061], caster, target, data, 0.25,2)
	-- 11062
	self.order = self.order + 1
	self:DamageLight(SkillEffect[11062], caster, target, data, 0.5,1)
end
