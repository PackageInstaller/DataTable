-- 冥渊审判
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill703201001 = oo.class(SkillBase)
function Skill703201001:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill703201001:DoSkill(caster, target, data)
	-- 12001
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12001], caster, target, data, 1,1)
	-- 703201001
	self.order = self.order + 1
	self:AddBuff(SkillEffect[703201001], caster, target, data, 703200101)
end
