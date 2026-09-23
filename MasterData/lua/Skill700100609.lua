-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill700100609 = oo.class(SkillBase)
function Skill700100609:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill700100609:DoSkill(caster, target, data)
	self.order = self.order + 1
	self:DamageSpecial(SkillEffect[13001], caster, target, data, 1,1)
end
