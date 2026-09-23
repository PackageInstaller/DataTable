-- 乘风急行（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill701101305 = oo.class(SkillBase)
function Skill701101305:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill701101305:DoSkill(caster, target, data)
	-- 701100306
	self.order = self.order + 1
	self:AddProgress(SkillEffect[701100306], caster, target, data, 400)
	-- 701100316
	self.order = self.order + 1
	self:Cure(SkillEffect[701100316], caster, target, data, 1,0.2)
end
