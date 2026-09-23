-- 治愈和弦
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill200900201 = oo.class(SkillBase)
function Skill200900201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill200900201:DoSkill(caster, target, data)
	-- 200900201
	self.order = self.order + 1
	self:Cure(SkillEffect[200900201], caster, target, data, 1,0.22)
end
