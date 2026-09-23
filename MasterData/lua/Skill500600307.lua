-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill500600307 = oo.class(SkillBase)
function Skill500600307:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill500600307:DoSkill(caster, target, data)
	self.order = self.order + 1
	self:Cure(SkillEffect[33007], caster, target, data, 7,5.4)
end
