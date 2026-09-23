-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill500600308 = oo.class(SkillBase)
function Skill500600308:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill500600308:DoSkill(caster, target, data)
	self.order = self.order + 1
	self:Cure(SkillEffect[33008], caster, target, data, 7,5.6)
end
