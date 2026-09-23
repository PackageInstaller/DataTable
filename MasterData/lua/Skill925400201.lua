-- 聚变储能
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill925400201 = oo.class(SkillBase)
function Skill925400201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill925400201:DoSkill(caster, target, data)
	-- 11002
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11002], caster, target, data, 0.5,2)
	-- 925400201
	self.order = self.order + 1
	self:AddProgress(SkillEffect[925400201], caster, target, data, -1000)
end
