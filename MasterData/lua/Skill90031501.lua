-- 技能15
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill90031501 = oo.class(SkillBase)
function Skill90031501:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill90031501:DoSkill(caster, target, data)
	-- 11003
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11003], caster, target, data, 0.333,3)
	-- 3004
	self.order = self.order + 1
	self:HitAddBuff(SkillEffect[3004], caster, target, data, 10000,3004)
end
