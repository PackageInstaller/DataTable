-- 重创迅劈
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill940210201 = oo.class(SkillBase)
function Skill940210201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill940210201:DoSkill(caster, target, data)
	-- 11002
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11002], caster, target, data, 0.5,2)
	-- 1003
	self.order = self.order + 1
	self:HitAddBuff(SkillEffect[1003], caster, target, data, 10000,1003)
end
