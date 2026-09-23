-- 乘风急行
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill701100302 = oo.class(SkillBase)
function Skill701100302:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill701100302:DoSkill(caster, target, data)
	-- 701100301
	self.order = self.order + 1
	self:AddProgress(SkillEffect[701100301], caster, target, data, 150)
	-- 701100312
	self.order = self.order + 1
	self:Cure(SkillEffect[701100312], caster, target, data, 1,0.08)
end
