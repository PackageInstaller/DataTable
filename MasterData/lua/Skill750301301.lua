-- 超级索尼子（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill750301301 = oo.class(SkillBase)
function Skill750301301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill750301301:DoSkill(caster, target, data)
	-- 750301306
	self.order = self.order + 1
	self:Cure(SkillEffect[750301306], caster, target, data, 1,0.31)
	-- 750301301
	self.order = self.order + 1
	self:DelBuffQuality(SkillEffect[750301301], caster, target, data, 2,1)
end
