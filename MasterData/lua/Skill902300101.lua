-- 伤害强化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill902300101 = oo.class(SkillBase)
function Skill902300101:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill902300101:DoSkill(caster, target, data)
	-- 902300101
	self.order = self.order + 1
	self:AddBuff(SkillEffect[902300101], caster, target, data, 4804)
end
