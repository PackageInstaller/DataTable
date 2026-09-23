-- 信风3
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill400200301 = oo.class(SkillBase)
function Skill400200301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill400200301:DoSkill(caster, target, data)
	-- 12026
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12026], caster, target, data, 0.2,4)
	-- 12027
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[12027], caster, target, data, 0.2,1)
end
