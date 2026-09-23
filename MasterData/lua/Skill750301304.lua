-- 超级索尼子（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill750301304 = oo.class(SkillBase)
function Skill750301304:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill750301304:DoSkill(caster, target, data)
	-- 750301309
	self.order = self.order + 1
	self:Cure(SkillEffect[750301309], caster, target, data, 1,0.35)
	-- 750301304
	self.order = self.order + 1
	self:DelBuffQuality(SkillEffect[750301304], caster, target, data, 2,2)
end
