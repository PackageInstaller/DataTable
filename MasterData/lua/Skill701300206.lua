-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill701300206 = oo.class(SkillBase)
function Skill701300206:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill701300206:DoSkill(caster, target, data)
	self.order = self.order + 1
	self:Cure(SkillEffect[33016], caster, target, data, 1,0.204)
end
