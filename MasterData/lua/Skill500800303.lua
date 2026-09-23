-- 同步治愈
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill500800303 = oo.class(SkillBase)
function Skill500800303:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill500800303:DoSkill(caster, target, data)
	-- 500800303
	self.order = self.order + 1
	self:Cure(SkillEffect[500800303], caster, target, data, 1,0.13)
	-- 500800313
	self.order = self.order + 1
	self:DelBuffQuality(SkillEffect[500800313], caster, target, data, 2,2)
end
