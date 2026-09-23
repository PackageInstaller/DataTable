-- 挑衅连击
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill930100201 = oo.class(SkillBase)
function Skill930100201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill930100201:DoSkill(caster, target, data)
	-- 11002
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11002], caster, target, data, 0.5,2)
	-- 3001
	self.order = self.order + 1
	self:HitAddBuff(SkillEffect[3001], caster, target, data, 10000,3001)
end
