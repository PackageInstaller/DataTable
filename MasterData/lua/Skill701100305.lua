-- 乘风急行
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill701100305 = oo.class(SkillBase)
function Skill701100305:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill701100305:DoSkill(caster, target, data)
	-- 701100303
	self.order = self.order + 1
	self:AddProgress(SkillEffect[701100303], caster, target, data, 250)
	-- 701100313
	self.order = self.order + 1
	self:Cure(SkillEffect[701100313], caster, target, data, 1,0.1)
end
