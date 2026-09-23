-- 超级索尼子（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill750301302 = oo.class(SkillBase)
function Skill750301302:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill750301302:DoSkill(caster, target, data)
	-- 750301307
	self.order = self.order + 1
	self:Cure(SkillEffect[750301307], caster, target, data, 1,0.33)
	-- 750301302
	self.order = self.order + 1
	self:DelBuffQuality(SkillEffect[750301302], caster, target, data, 2,1)
end
