-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill500600310 = oo.class(SkillBase)
function Skill500600310:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill500600310:DoSkill(caster, target, data)
	self.order = self.order + 1
	self:Cure(SkillEffect[33010], caster, target, data, 7,6)
end
