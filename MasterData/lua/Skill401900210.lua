-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill401900210 = oo.class(SkillBase)
function Skill401900210:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill401900210:DoSkill(caster, target, data)
	self.order = self.order + 1
	self:AddBuff(SkillEffect[4204], caster, target, data, 4204)
	self.order = self.order + 1
	self:AddBuff(SkillEffect[1010310], caster, target, data, 1010310)
end
