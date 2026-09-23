-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill100100210 = oo.class(SkillBase)
function Skill100100210:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill100100210:DoSkill(caster, target, data)
	self.order = self.order + 1
	self:AddBuff(SkillEffect[2140], caster, target, data, 2140)
end
