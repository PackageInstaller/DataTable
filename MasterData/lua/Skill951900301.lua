-- 嘲讽巨盾
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill951900301 = oo.class(SkillBase)
function Skill951900301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill951900301:DoSkill(caster, target, data)
	-- 11001
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11001], caster, target, data, 1,1)
	-- 60004
	self.order = self.order + 1
	self:HitAddBuff(SkillEffect[60004], caster, target, data, 3000,3004)
end
