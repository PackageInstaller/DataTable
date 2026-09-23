-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill700300108 = oo.class(SkillBase)
function Skill700300108:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill700300108:DoSkill(caster, target, data)
	self.order = self.order + 1
	self:DamageSpecial(SkillEffect[13001], caster, target, data, 1,1)
end
