-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill701300209 = oo.class(SkillBase)
function Skill701300209:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill701300209:DoSkill(caster, target, data)
	self.order = self.order + 1
	self:Cure(SkillEffect[33019], caster, target, data, 1,0.216)
end
