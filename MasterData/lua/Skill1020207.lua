-- 紧急治疗
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1020207 = oo.class(SkillBase)
function Skill1020207:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill1020207:DoSkill(caster, target, data)
	-- 1020207
	self.order = self.order + 1
	self:Cure(SkillEffect[1020207], caster, target, data, 2,0.42)
end
