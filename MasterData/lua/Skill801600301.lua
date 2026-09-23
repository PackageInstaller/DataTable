-- 原子轰击
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill801600301 = oo.class(SkillBase)
function Skill801600301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill801600301:DoSkill(caster, target, data)
	-- 11063
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11063], caster, target, data, 0.25,2)
	-- 11064
	self.order = self.order + 1
	self:DamageLight(SkillEffect[11064], caster, target, data, 0.17,3)
end
