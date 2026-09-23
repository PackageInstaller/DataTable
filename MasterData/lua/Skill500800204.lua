-- 紧急修复
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill500800204 = oo.class(SkillBase)
function Skill500800204:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill500800204:DoSkill(caster, target, data)
	-- 500800204
	self.order = self.order + 1
	self:SpillCure(SkillEffect[500800204], caster, target, data, 1,0.28,1)
end
