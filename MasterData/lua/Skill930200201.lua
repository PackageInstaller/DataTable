-- 重创迅劈
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill930200201 = oo.class(SkillBase)
function Skill930200201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill930200201:DoSkill(caster, target, data)
	-- 11002
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11002], caster, target, data, 0.5,2)
	-- 904200301
	self.order = self.order + 1
	self:HitAddBuff(SkillEffect[904200301], caster, target, data, 10000,1003)
end
