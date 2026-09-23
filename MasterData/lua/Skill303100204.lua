-- 神圣审判
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill303100204 = oo.class(SkillBase)
function Skill303100204:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill303100204:DoSkill(caster, target, data)
	-- 12703
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12703], caster, target, data, 0.75,1)
	-- 12704
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[12704], caster, target, data, 0.25,1)
end
