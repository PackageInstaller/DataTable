-- 剑刃回旋
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill904200301 = oo.class(SkillBase)
function Skill904200301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill904200301:DoSkill(caster, target, data)
	-- 11004
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11004], caster, target, data, 0.25,4)
	-- 904200301
	self.order = self.order + 1
	self:HitAddBuff(SkillEffect[904200301], caster, target, data, 10000,1003)
end
