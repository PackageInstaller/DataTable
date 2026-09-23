-- 三段斩
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill601900101 = oo.class(SkillBase)
function Skill601900101:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill601900101:DoSkill(caster, target, data)
	-- 11003
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11003], caster, target, data, 0.333,3)
	-- 601900101
	self.order = self.order + 1
	self:HitAddBuff(SkillEffect[601900101], caster, target, data, 5000,1003)
end
