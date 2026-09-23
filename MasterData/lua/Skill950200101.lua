-- 单体2段
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill950200101 = oo.class(SkillBase)
function Skill950200101:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill950200101:DoSkill(caster, target, data)
	-- 11002
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11002], caster, target, data, 0.5,2)
	-- 950200101
	self.order = self.order + 1
	self:HitAddBuff(SkillEffect[950200101], caster, target, data, 2400,3009,2)
end
