-- 破星怒号
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill802500301 = oo.class(SkillBase)
function Skill802500301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill802500301:DoSkill(caster, target, data)
	-- 11065
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11065], caster, target, data, 0.1,4)
	-- 11066
	self.order = self.order + 1
	self:DamageLight(SkillEffect[11066], caster, target, data, 0.1,2)
	-- 11067
	self.order = self.order + 1
	self:DamageLight(SkillEffect[11067], caster, target, data, 0.4,1)
end
