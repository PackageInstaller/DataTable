-- 漆黑_Schwarz
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill802400101 = oo.class(SkillBase)
function Skill802400101:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill802400101:DoSkill(caster, target, data)
	-- 11002
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11002], caster, target, data, 0.5,2)
	-- 80003
	self.order = self.order + 1
	self:AddSp(SkillEffect[80003], caster, caster, data, 20)
end
