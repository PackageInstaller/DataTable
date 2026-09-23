-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill500600306 = oo.class(SkillBase)
function Skill500600306:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill500600306:DoSkill(caster, target, data)
	self.order = self.order + 1
	self:Cure(SkillEffect[33006], caster, target, data, 7,5.2)
end
