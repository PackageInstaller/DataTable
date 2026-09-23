-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill10010102 = oo.class(SkillBase)
function Skill10010102:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill10010102:DoSkill(caster, target, data)
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11002], caster, target, data, 0.5,2)
	self.order = self.order + 1
	self:AddNp(SkillEffect[70001], caster, caster, data, 5)
end
