-- 多重轰炸
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill801500301 = oo.class(SkillBase)
function Skill801500301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill801500301:DoSkill(caster, target, data)
	-- 11087
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11087], caster, target, data, 0.05,10)
	-- 11088
	self.order = self.order + 1
	self:DamageLight(SkillEffect[11088], caster, target, data, 0.25,2)
end
