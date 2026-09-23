-- 初春协奏
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill200800204 = oo.class(SkillBase)
function Skill200800204:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill200800204:DoSkill(caster, target, data)
	-- 200800204
	self.order = self.order + 1
	self:Cure(SkillEffect[200800204], caster, target, data, 1,0.11)
	-- 200800213
	self.order = self.order + 1
	self:AddBuff(SkillEffect[200800213], caster, target, data, 200800203,2)
end
