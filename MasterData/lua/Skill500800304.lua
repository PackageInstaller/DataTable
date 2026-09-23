-- 同步治愈
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill500800304 = oo.class(SkillBase)
function Skill500800304:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill500800304:DoSkill(caster, target, data)
	-- 500800304
	self.order = self.order + 1
	self:Cure(SkillEffect[500800304], caster, target, data, 1,0.14)
	-- 500800314
	self.order = self.order + 1
	self:DelBuffQuality(SkillEffect[500800314], caster, target, data, 2,2)
end
