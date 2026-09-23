-- 超级索尼子（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill750301303 = oo.class(SkillBase)
function Skill750301303:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill750301303:DoSkill(caster, target, data)
	-- 750301308
	self.order = self.order + 1
	self:Cure(SkillEffect[750301308], caster, target, data, 1,0.33)
	-- 750301303
	self.order = self.order + 1
	self:DelBuffQuality(SkillEffect[750301303], caster, target, data, 2,2)
end
