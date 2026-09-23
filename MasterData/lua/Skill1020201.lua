-- 危急修复
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1020201 = oo.class(SkillBase)
function Skill1020201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill1020201:DoSkill(caster, target, data)
	-- 1020201
	self.order = self.order + 1
	self:Cure(SkillEffect[1020201], caster, target, data, 2,0.30)
end
