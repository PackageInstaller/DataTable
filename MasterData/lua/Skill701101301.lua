-- 乘风急行（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill701101301 = oo.class(SkillBase)
function Skill701101301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill701101301:DoSkill(caster, target, data)
	-- 701100304
	self.order = self.order + 1
	self:AddProgress(SkillEffect[701100304], caster, target, data, 300)
	-- 701100314
	self.order = self.order + 1
	self:Cure(SkillEffect[701100314], caster, target, data, 1,0.12)
end
